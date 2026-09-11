using System.Collections.Generic;
using RimWorld;
using UnityEngine;
using Verse;

namespace NeckAccessory
{
    // Every piece in this mod used to be an Apparel subclass driving itself from
    // Tick(). RimWorld 1.6 never ticks worn apparel — Pawn_ApparelTracker only
    // handles wear and tear — so all of it has to be driven from the map.
    public class NeckAccessoryMapComponent : MapComponent
    {
        private static List<int> intervalsCached;

        public NeckAccessoryMapComponent(Map map) : base(map)
        {
        }

        // Every distinct interval our apparel asks for. Walking the pawn list is
        // only worth doing on ticks where at least one of them is due.
        private static List<int> Intervals
        {
            get
            {
                if (intervalsCached == null)
                {
                    intervalsCached = new List<int>();
                    foreach (ThingDef def in DefDatabase<ThingDef>.AllDefsListForReading)
                    {
                        if (!def.IsApparel || def.modExtensions == null)
                        {
                            continue;
                        }

                        foreach (DefModExtension ext in def.modExtensions)
                        {
                            if (ext is NeckExtension neck && neck.intervalTicks > 0 && !intervalsCached.Contains(neck.intervalTicks))
                            {
                                intervalsCached.Add(neck.intervalTicks);
                            }
                        }
                    }
                }

                return intervalsCached;
            }
        }

        public override void MapComponentTick()
        {
            List<int> intervals = Intervals;
            if (intervals.Count == 0)
            {
                return;
            }

            int now = Find.TickManager.TicksGame;
            bool anyDue = false;
            for (int i = 0; i < intervals.Count; i++)
            {
                if (now % intervals[i] == 0)
                {
                    anyDue = true;
                    break;
                }
            }

            if (!anyDue)
            {
                return;
            }

            IReadOnlyList<Pawn> spawned = map.mapPawns.AllPawnsSpawned;
            for (int i = 0; i < spawned.Count; i++)
            {
                Pawn pawn = spawned[i];
                if (pawn.Dead || pawn.apparel == null || pawn.health == null)
                {
                    continue;
                }

                List<Apparel> worn = pawn.apparel.WornApparel;
                for (int j = 0; j < worn.Count; j++)
                {
                    Apparel apparel = worn[j];
                    if (apparel.def.modExtensions == null)
                    {
                        continue;
                    }

                    foreach (DefModExtension ext in apparel.def.modExtensions)
                    {
                        if (!(ext is NeckExtension neck) || neck.intervalTicks <= 0 || now % neck.intervalTicks != 0)
                        {
                            continue;
                        }

                        switch (neck)
                        {
                            case ErosionExtension erosion:
                                Erode(pawn, apparel, erosion);
                                break;
                            case AffinityExtension affinity:
                                Affinity(pawn, affinity);
                                break;
                            case RecoveryExtension recovery:
                                Recover(pawn, apparel, recovery);
                                break;
                            case SunlightExtension _:
                                Shine(pawn, apparel);
                                break;
                            case HediffAuraExtension aura:
                                Pulse(pawn, aura, spawned);
                                break;
                        }
                    }
                }
            }
        }

        private static float QualityFactor(Thing thing, List<float> factors)
        {
            if (factors.NullOrEmpty())
            {
                return 1f;
            }

            if (!thing.TryGetQuality(out QualityCategory quality))
            {
                quality = QualityCategory.Normal;
            }

            int index = Mathf.Clamp((int)quality, 0, factors.Count - 1);
            return factors[index];
        }

        private static void Erode(Pawn wearer, Apparel apparel, ErosionExtension ext)
        {
            if (ext.erodeHediff == null)
            {
                return;
            }

            float amount = ext.severityPerDose * QualityFactor(apparel, ext.qualityFactors);

            Hediff existing = wearer.health.hediffSet.GetFirstHediffOfDef(ext.erodeHediff);
            if (existing != null)
            {
                existing.Severity = Mathf.Min(existing.Severity + amount, 1f);
                return;
            }

            if (ext.bodyParts.NullOrEmpty())
            {
                return;
            }

            List<BodyPartRecord> parts = wearer.def.race.body.AllParts;
            for (int i = 0; i < parts.Count; i++)
            {
                BodyPartRecord part = parts[i];
                if (!ext.bodyParts.Contains(part.def))
                {
                    continue;
                }

                if (wearer.health.hediffSet.PartIsMissing(part) || wearer.health.hediffSet.HasHediff(ext.erodeHediff, part))
                {
                    continue;
                }

                Hediff fresh = HediffMaker.MakeHediff(ext.erodeHediff, wearer, part);
                fresh.Severity = amount;
                wearer.health.AddHediff(fresh, part);
            }
        }

        private static void Affinity(Pawn wearer, AffinityExtension ext)
        {
            if (ext.affinityHediff == null || wearer.story?.traits == null)
            {
                return;
            }

            Hediff hediff = wearer.health.hediffSet.GetFirstHediffOfDef(ext.affinityHediff);

            if (wearer.gender == ext.forGender)
            {
                if (hediff == null)
                {
                    Hediff fresh = HediffMaker.MakeHediff(ext.affinityHediff, wearer);
                    fresh.Severity = ext.severityStep;
                    wearer.health.AddHediff(fresh);
                    return;
                }

                hediff.Severity = Mathf.Min(hediff.Severity + ext.severityStep, 1f);
                if (hediff.Severity >= 1f && !wearer.story.traits.HasTrait(TraitDefOf.Gay))
                {
                    wearer.story.traits.GainTrait(new Trait(TraitDefOf.Gay, PawnGenerator.RandomTraitDegree(TraitDefOf.Gay)));
                }

                return;
            }

            // Worn by the other gender it unwinds instead, and takes the trait
            // back with it once there is nothing left.
            if (hediff == null)
            {
                return;
            }

            hediff.Severity = Mathf.Max(hediff.Severity - ext.severityStep, 0f);
            if (hediff.Severity > 0f)
            {
                return;
            }

            Trait gay = wearer.story.traits.GetTrait(TraitDefOf.Gay);
            if (gay != null)
            {
                wearer.story.traits.RemoveTrait(gay);
            }
        }

        private static void Recover(Pawn wearer, Apparel apparel, RecoveryExtension ext)
        {
            float amount = ext.severityPerDose * QualityFactor(apparel, ext.qualityFactors);
            if (amount <= 0f)
            {
                return;
            }

            if (!ext.recoverHediffs.NullOrEmpty())
            {
                for (int i = 0; i < ext.recoverHediffs.Count; i++)
                {
                    Ease(wearer, ext.recoverHediffs[i], amount);
                }
            }

            Ease(wearer, ext.extraHediff, amount * ext.extraHediffFactor);
        }

        private static void Ease(Pawn pawn, HediffDef def, float amount)
        {
            if (def == null)
            {
                return;
            }

            Hediff hediff = pawn.health.hediffSet.GetFirstHediffOfDef(def);
            if (hediff != null)
            {
                hediff.Severity = Mathf.Max(hediff.Severity - amount, 0f);
            }
        }

        private static void Shine(Pawn wearer, Apparel apparel)
        {
            Map map = wearer.Map;
            if (map == null || !wearer.Position.InBounds(map))
            {
                return;
            }

            if (!apparel.TryGetQuality(out QualityCategory quality))
            {
                quality = QualityCategory.Normal;
            }

            ThingDef lightDef = DefDatabase<ThingDef>.GetNamedSilentFail("HDA_SunLight_" + quality);
            if (lightDef != null)
            {
                GenSpawn.Spawn(lightDef, wearer.Position, map, WipeMode.Vanish);
            }
        }

        private static void Pulse(Pawn wearer, HediffAuraExtension ext, IReadOnlyList<Pawn> spawned)
        {
            if (ext.hediffToAdd == null)
            {
                return;
            }

            if (ext.enableOnlyPlayerFaction && wearer.Faction != Faction.OfPlayer)
            {
                return;
            }

            float rangeSquared = ext.auraDistance * ext.auraDistance;

            for (int i = 0; i < spawned.Count; i++)
            {
                Pawn target = spawned[i];
                if (target == wearer || target.Dead || target.health == null)
                {
                    continue;
                }

                if (target.HostileTo(wearer) != ext.targetsEnemies)
                {
                    continue;
                }

                if ((target.Position - wearer.Position).LengthHorizontalSquared > rangeSquared)
                {
                    continue;
                }

                Hediff existing = target.health.hediffSet.GetFirstHediffOfDef(ext.hediffToAdd);
                if (existing != null)
                {
                    existing.Severity = Mathf.Min(ext.maxHediffSeverity, existing.Severity + ext.addHediffSeverity);
                    continue;
                }

                Hediff fresh = HediffMaker.MakeHediff(ext.hediffToAdd, target);
                fresh.Severity = Mathf.Min(ext.maxHediffSeverity, ext.addHediffSeverity);
                target.health.AddHediff(fresh);
            }
        }
    }
}

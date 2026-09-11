using System.Collections.Generic;
using Verse;

namespace NeckAccessory
{
    // The original mod carried these settings on custom ThingDef subclasses, one
    // assembly each. Mod extensions do the same job without owning the def type.
    public abstract class NeckExtension : DefModExtension
    {
        // How often the effect fires. NeckAccessoryMapComponent collects every
        // distinct value and only walks the pawn list on ticks where one is due.
        public int intervalTicks = 1000;
    }

    // Heavy neck armour: wearing it grinds the shoulders down.
    public class ErosionExtension : NeckExtension
    {
        public HediffDef erodeHediff;
        public List<BodyPartDef> bodyParts;
        public float severityPerDose = 0.001f;

        // Indexed by QualityCategory: shoddy work bites hardest.
        public List<float> qualityFactors = new List<float> { 3f, 2f, 1f, 1f, 1f, 1f, 0.5f };

        public ErosionExtension()
        {
            intervalTicks = 3000;
        }
    }

    // Rose and lily necklaces: worn by the gender they are meant for, they build
    // up an affinity and eventually settle it as a trait; worn by the other, they
    // unwind it again.
    public class AffinityExtension : NeckExtension
    {
        public HediffDef affinityHediff;
        public Gender forGender = Gender.Male;
        public float severityStep = 0.05f;
    }

    // Swindler's necklace: slowly walks back a few chronic conditions.
    public class RecoveryExtension : NeckExtension
    {
        // BadBack, Frail and Cataract left the HediffDefOf class after 1.0, so the
        // def names live in XML now rather than being hardcoded here.
        public List<HediffDef> recoverHediffs;

        public HediffDef extraHediff;
        public float severityPerDose = 0.00001f;
        public float extraHediffFactor = 1000f;

        public List<float> qualityFactors = new List<float> { 0f, 0.5f, 1f, 1.2f, 1.5f, 1.8f, 3f };

        public RecoveryExtension()
        {
            intervalTicks = 6000;
        }
    }

    // Sun necklace: drops a short-lived light on the wearer's cell, over and over.
    public class SunlightExtension : NeckExtension
    {
        public SunlightExtension()
        {
            intervalTicks = 30;
        }
    }

    // Hero's scarf. Same shape as the WA kimono aura, kept in this mod's own
    // namespace so the two ports stay independent of each other.
    public class HediffAuraExtension : NeckExtension
    {
        public bool enableOnlyPlayerFaction = true;
        public float addHediffSeverity = 0.5f;
        public float maxHediffSeverity = 1f;
        public float auraDistance = 15f;
        public HediffDef hediffToAdd;
        public bool targetsEnemies = false;

    }
}

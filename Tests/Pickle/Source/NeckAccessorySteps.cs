using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace NeckAccessory.PickleSteps
{
    /// <summary>
    /// What Pickle's own steps cannot say about Neck Accessory Renew: dressing a colonist in a piece
    /// of a given quality, reading a hediff's severity, a trait, a thought and the glow the sun
    /// necklace leaves behind.
    ///
    /// Every step text starts with "Neck Accessory:". Pickle loads the steps of every active suite
    /// into one namespace, and two suites declaring the same text make healthy scenarios fail with
    /// "Ambiguous step". No text uses parentheses or slashes, which Cucumber expressions read as
    /// optional text and alternatives.
    ///
    /// NOTHING HERE REFERENCES THE MOD'S ASSEMBLY. Defs are found by defName and read through the
    /// vanilla API, so a def the mod fails to define is reported by name instead of stopping the
    /// suite from loading.
    /// </summary>
    [PickleSteps]
    public class NeckAccessorySteps
    {
        private const string SunLightPrefix = "HDA_SunLight_";

        private static Map CurrentMap()
        {
            return Find.CurrentMap;
        }

        /// <summary>A pawn by the nickname Pickle gave it, or its short label.</summary>
        private static Pawn PawnNamed(PickleContext ctx, string name)
        {
            IReadOnlyList<Pawn> spawned = CurrentMap().mapPawns.AllPawnsSpawned;
            Pawn found = spawned.FirstOrDefault(p =>
                (p.Name is NameTriple triple && triple.Nick == name) || p.LabelShort == name);
            if (found == null)
            {
                ctx.Assert(false,
                    $"no spawned pawn named \"{name}\"; the map holds: "
                    + string.Join(", ", spawned.Select(p => p.LabelShort)));
            }

            return found;
        }

        private static T Def<T>(PickleContext ctx, string defName) where T : Def
        {
            T def = DefDatabase<T>.GetNamedSilentFail(defName);
            ctx.Assert(def != null, $"no {typeof(T).Name} named \"{defName}\": the mod did not define it, or the load failed");
            return def;
        }

        private static float SeverityOf(Pawn pawn, string hediffName)
        {
            Hediff hediff = pawn.health.hediffSet.hediffs.FirstOrDefault(h => h.def.defName == hediffName);
            return hediff == null ? 0f : hediff.Severity;
        }

        /// <summary>
        /// Advances the game by a number of ticks in slices. `I wait N ticks` is bound by a five
        /// second step limit; the effects of this mod come every 1000 to 6000 ticks, and 6000 ticks
        /// take about ten seconds of real time in the WSL.
        /// </summary>
        [When("Neck Accessory: I let {int} ticks pass", TimeoutSeconds = 90f)]
        public async Task LetTicksPass(PickleContext ctx, int ticks)
        {
            int left = ticks;
            while (left > 0)
            {
                int slice = left > 500 ? 500 : left;
                await ctx.WaitTicks(slice);
                left -= slice;
            }
        }

        [Given("Neck Accessory: {string} stands near x={int} z={int}")]
        public void StandsNear(PickleContext ctx, string name, int x, int z)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Map map = CurrentMap();
            IntVec3 cell = CellFinder.StandableCellNear(new IntVec3(x, 0, z), map, 6f);
            ctx.Assert(cell.IsValid, $"no standable cell within 6 cells of x={x} z={z}");
            pawn.Position = cell;
            pawn.Notify_Teleported(true, true);
        }

        [Given("Neck Accessory: {string} wears {string} of quality {string}")]
        public void Wears(PickleContext ctx, string name, string defName, string quality)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ThingDef def = Def<ThingDef>(ctx, defName);
            bool parsed = System.Enum.TryParse(quality, out QualityCategory category);
            ctx.Assert(parsed, $"\"{quality}\" is not a QualityCategory");

            Apparel apparel = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def)) as Apparel;
            ctx.Assert(apparel != null, $"{defName} did not make an Apparel");
            apparel.TryGetComp<CompQuality>()?.SetQuality(category, ArtGenerationContext.Outsider);
            pawn.apparel.Wear(apparel, false);
            ctx.Assert(pawn.apparel.WornApparel.Contains(apparel),
                $"{name} is not wearing {defName} after Wear(); worn: "
                + string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName)));
        }

        [When("Neck Accessory: {string} takes off {string}")]
        public void TakesOff(PickleContext ctx, string name, string defName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Apparel worn = pawn.apparel.WornApparel.FirstOrDefault(a => a.def.defName == defName);
            ctx.Assert(worn != null, $"{name} does not wear {defName}");
            pawn.apparel.Remove(worn);
            worn.Destroy();
        }

        [Given("Neck Accessory: {string} is given the hediff {string} at severity {float}")]
        public void GivenHediff(PickleContext ctx, string name, string hediffName, float severity)
        {
            Pawn pawn = PawnNamed(ctx, name);
            HediffDef def = Def<HediffDef>(ctx, hediffName);
            Hediff existing = pawn.health.hediffSet.hediffs.FirstOrDefault(h => h.def == def);
            if (existing != null)
            {
                pawn.health.RemoveHediff(existing);
            }

            Hediff hediff = HediffMaker.MakeHediff(def, pawn);
            hediff.Severity = severity;
            pawn.health.AddHediff(hediff);
        }

        [Then("Neck Accessory: the hediff {string} of {string} has a severity above {float}")]
        public void SeverityAbove(PickleContext ctx, string hediffName, string name, float limit)
        {
            float severity = SeverityOf(PawnNamed(ctx, name), hediffName);
            ctx.Assert(severity > limit, $"{hediffName} on {name} is at {severity:0.#####}, not above {limit}");
        }

        [Then("Neck Accessory: the hediff {string} of {string} has a severity of at most {float}")]
        public void SeverityAtMost(PickleContext ctx, string hediffName, string name, float limit)
        {
            float severity = SeverityOf(PawnNamed(ctx, name), hediffName);
            ctx.Assert(severity <= limit, $"{hediffName} on {name} is at {severity:0.#####}, above {limit}");
        }

        [Then("Neck Accessory: the hediff {string} of {string} has a severity of at least {float}")]
        public void SeverityAtLeast(PickleContext ctx, string hediffName, string name, float limit)
        {
            float severity = SeverityOf(PawnNamed(ctx, name), hediffName);
            ctx.Assert(severity >= limit, $"{hediffName} on {name} is at {severity:0.#####}, below {limit}");
        }

        [Given("Neck Accessory: {string} is given the trait {string}")]
        public void GivenTrait(PickleContext ctx, string name, string traitName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            TraitDef def = Def<TraitDef>(ctx, traitName);
            if (!pawn.story.traits.HasTrait(def))
            {
                pawn.story.traits.GainTrait(new Trait(def, 0, true));
            }
        }

        [Given("Neck Accessory: {string} is stripped of the trait {string}")]
        public void StrippedOfTrait(PickleContext ctx, string name, string traitName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Trait trait = pawn.story.traits.GetTrait(Def<TraitDef>(ctx, traitName));
            if (trait != null)
            {
                pawn.story.traits.RemoveTrait(trait);
            }
        }

        [Then("Neck Accessory: {string} has the trait {string}")]
        public void HasTrait(PickleContext ctx, string name, string traitName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(pawn.story.traits.HasTrait(Def<TraitDef>(ctx, traitName)),
                $"{name} has no trait {traitName}; traits: " + string.Join(", ", pawn.story.traits.allTraits.Select(t => t.def.defName)));
        }

        [Then("Neck Accessory: {string} does not have the trait {string}")]
        public void HasNoTrait(PickleContext ctx, string name, string traitName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            ctx.Assert(!pawn.story.traits.HasTrait(Def<TraitDef>(ctx, traitName)),
                $"{name} still has the trait {traitName}");
        }

        /// <summary>
        /// The sun necklace drops a HDA_SunLight_quality on the wearer's cell every 30 ticks, and
        /// each lives 30 ticks.
        /// </summary>
        [Then("Neck Accessory: a sun light stands on the cell of {string}", TimeoutSeconds = 20f)]
        public async Task SunLightOnCell(PickleContext ctx, string name)
        {
            Pawn pawn = PawnNamed(ctx, name);
            for (int i = 0; i < 6; i++)
            {
                if (CurrentMap().thingGrid.ThingsListAtFast(pawn.Position)
                    .Any(t => t.def.defName.StartsWith(SunLightPrefix)))
                {
                    return;
                }

                await ctx.WaitTicks(15);
            }

            ctx.Assert(false, $"no {SunLightPrefix}* thing on the cell {pawn.Position} of {name} after 90 ticks");
        }

        [Then("Neck Accessory: no sun light remains on the map")]
        public void NoSunLight(PickleContext ctx)
        {
            List<Thing> lights = CurrentMap().listerThings.AllThings
                .Where(t => t.def.defName.StartsWith(SunLightPrefix)).ToList();
            ctx.Assert(lights.Count == 0,
                $"{lights.Count} sun light(s) remain, first at {lights.FirstOrDefault()?.Position}");
        }

        /// <summary>Reads a mood thought the way the mood tab does, situational ones included.</summary>
        [Then("Neck Accessory: {string} feels the mood thought {string} at stage {int}", TimeoutSeconds = 40f)]
        public async Task FeelsMoodThought(PickleContext ctx, string name, string thoughtName, int stage)
        {
            Pawn pawn = PawnNamed(ctx, name);
            string seen = "";
            for (int i = 0; i < 10; i++)
            {
                var thoughts = new List<Thought>();
                pawn.needs.mood.thoughts.GetAllMoodThoughts(thoughts);
                seen = string.Join(", ", thoughts.Select(t => t.def.defName + "@" + t.CurStageIndex));
                if (thoughts.Any(t => t.def.defName == thoughtName && t.CurStageIndex == stage))
                {
                    return;
                }

                await ctx.WaitTicks(100);
            }

            ctx.Assert(false, $"{name} does not feel {thoughtName} at stage {stage}; mood thoughts: {seen}");
        }

        [Then("Neck Accessory: {string} feels no mood thought {string}")]
        public void FeelsNoMoodThought(PickleContext ctx, string name, string thoughtName)
        {
            Pawn pawn = PawnNamed(ctx, name);
            var thoughts = new List<Thought>();
            pawn.needs.mood.thoughts.GetAllMoodThoughts(thoughts);
            ctx.Assert(!thoughts.Any(t => t.def.defName == thoughtName),
                $"{name} feels {thoughtName}; mood thoughts: " + string.Join(", ", thoughts.Select(t => t.def.defName + "@" + t.CurStageIndex)));
        }

        /// <summary>Reads what one pawn thinks of another, situational social thoughts included.</summary>
        [Then("Neck Accessory: {string} holds the opinion thought {string} of {string} at stage {int}", TimeoutSeconds = 40f)]
        public async Task HoldsOpinionThought(PickleContext ctx, string name, string thoughtName, string otherName, int stage)
        {
            Pawn pawn = PawnNamed(ctx, name);
            Pawn other = PawnNamed(ctx, otherName);
            string seen = "";
            for (int i = 0; i < 10; i++)
            {
                var thoughts = new List<ISocialThought>();
                pawn.needs.mood.thoughts.GetSocialThoughts(other, thoughts);
                var list = thoughts.OfType<Thought>().ToList();
                seen = string.Join(", ", list.Select(t => t.def.defName + "@" + t.CurStageIndex));
                if (list.Any(t => t.def.defName == thoughtName && t.CurStageIndex == stage))
                {
                    return;
                }

                await ctx.WaitTicks(100);
            }

            ctx.Assert(false, $"{name} holds no {thoughtName} at stage {stage} of {otherName}; opinion thoughts: {seen}");
        }

        /// <summary>
        /// The one thing the offline suite cannot read: the vanilla Disfigured def as the loaded game
        /// left it, after this mod's patch and every other active mod's.
        /// </summary>
        [Then("Neck Accessory: the thought {string} uses the worker {string} and has {int} stages")]
        public void ThoughtUsesWorker(PickleContext ctx, string thoughtName, string worker, int stages)
        {
            ThoughtDef def = Def<ThoughtDef>(ctx, thoughtName);
            ctx.Assert(def.workerClass != null && def.workerClass.FullName == worker,
                $"{thoughtName} uses {def.workerClass?.FullName ?? "no worker"}, expected {worker}");
            ctx.Assert(def.stages.Count == stages,
                $"{thoughtName} has {def.stages.Count} stages, expected {stages}: " + string.Join(", ", def.stages.Select(s => s.label)));
        }
    }
}

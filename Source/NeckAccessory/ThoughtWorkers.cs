using RimWorld;
using Verse;

namespace NeckAccessory
{
    internal static class WornCheck
    {
        // The original matched apparel by searching its ToString() for a defName.
        // Comparing the def outright is the same test without the string work.
        public static bool Wears(Pawn pawn, string defName)
        {
            if (pawn?.apparel == null)
            {
                return false;
            }

            var worn = pawn.apparel.WornApparel;
            for (int i = 0; i < worn.Count; i++)
            {
                if (worn[i].def.defName == defName)
                {
                    return true;
                }
            }

            return false;
        }
    }

    public class ThoughtWorker_MasochistChoker : ThoughtWorker
    {
        protected override ThoughtState CurrentStateInternal(Pawn p)
        {
            return WornCheck.Wears(p, "HDA_Masochists_Choker");
        }
    }

    public class ThoughtWorker_SunNecklace : ThoughtWorker
    {
        protected override ThoughtState CurrentStateInternal(Pawn p)
        {
            if (!WornCheck.Wears(p, "HDA_SunNecklace"))
            {
                return false;
            }

            // Someone who lives underground minds the glare a good deal more.
            return ThoughtState.ActiveAtStage(p.story?.traits != null && p.story.traits.HasTrait(TraitDefOf.Undergrounder) ? 1 : 0);
        }
    }

    public class ThoughtWorker_RoseNecklace : ThoughtWorker
    {
        protected override ThoughtState CurrentSocialStateInternal(Pawn p, Pawn otherPawn)
        {
            if (!WornCheck.Wears(otherPawn, "HDA_RoseNecklace") || otherPawn.gender == Gender.Female)
            {
                return false;
            }

            return ThoughtState.ActiveAtStage(p.gender == Gender.Male ? 0 : 1);
        }
    }

    public class ThoughtWorker_LilyNecklace : ThoughtWorker
    {
        protected override ThoughtState CurrentSocialStateInternal(Pawn p, Pawn otherPawn)
        {
            if (!WornCheck.Wears(otherPawn, "HDA_LilyNecklace") || otherPawn.gender == Gender.Male)
            {
                return false;
            }

            return ThoughtState.ActiveAtStage(p.gender == Gender.Female ? 0 : 1);
        }
    }

    // Two scarf-wearers in the same faction do not care for each other: there is
    // only room for one hero.
    public class ThoughtWorker_HeroIsOnlyOne : ThoughtWorker
    {
        protected override ThoughtState CurrentSocialStateInternal(Pawn pawn, Pawn other)
        {
            if (pawn.Faction != other.Faction)
            {
                return false;
            }

            return WornCheck.Wears(pawn, "HDA_Heros_scarf") && WornCheck.Wears(other, "HDA_Heros_scarf");
        }
    }

    // Scars read as a hero's record rather than a disfigurement, but only to the
    // people who share their faction.
    public class ThoughtWorker_Disfigured_ProofOfHero : ThoughtWorker_Disfigured
    {
        protected override ThoughtState CurrentSocialStateInternal(Pawn pawn, Pawn other)
        {
            if (!base.CurrentSocialStateInternal(pawn, other).Active)
            {
                return false;
            }

            if (pawn.Faction == other.Faction && WornCheck.Wears(other, "HDA_Heros_scarf"))
            {
                return ThoughtState.ActiveAtStage(1);
            }

            return ThoughtState.ActiveAtStage(0);
        }
    }
}

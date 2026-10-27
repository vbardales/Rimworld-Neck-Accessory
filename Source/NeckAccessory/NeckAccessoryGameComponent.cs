using System.Collections.Generic;
using Verse;

namespace NeckAccessory
{
    // State that must follow a pawn from map to map. A MapComponent is lost with its map
    // (caravan, quest map, abandoned base), so the pawns to whom a necklace gave the Gay
    // trait are kept here, once per game.
    public class NeckAccessoryGameComponent : GameComponent
    {
        // Only these pawns lose the trait again when the affinity unwinds: a trait the pawn
        // had before the mod is never taken away.
        public HashSet<int> GrantedGay = new HashSet<int>();

        public NeckAccessoryGameComponent(Game game)
        {
        }

        public override void ExposeData()
        {
            base.ExposeData();
            Scribe_Collections.Look(ref GrantedGay, "grantedGay", LookMode.Value);
            if (GrantedGay == null)
            {
                GrantedGay = new HashSet<int>();
            }
        }
    }
}

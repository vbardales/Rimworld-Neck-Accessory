using Verse;

namespace NeckAccessory
{
    // A glow that only lives long enough to be replaced by the next one, which is
    // how the sun necklace follows its wearer around. Spawned buildings do still
    // tick in 1.6, so this one can count itself down.
    public class Building_SunLight : Building
    {
        public const int LifespanTicks = 30;

        private int age;

        protected override void Tick()
        {
            base.Tick();

            age++;
            if (age >= LifespanTicks)
            {
                Destroy();
            }
        }

        public override void ExposeData()
        {
            base.ExposeData();
            Scribe_Values.Look(ref age, "age", 0);
        }
    }
}

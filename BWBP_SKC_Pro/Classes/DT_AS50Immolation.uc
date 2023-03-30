//=============================================================================
// AS50 immo
//=============================================================================
class DT_AS50Immolation extends DT_BWFire;

defaultproperties
{
     DeathStrings(0)="Though %o managed to survive %k's massive bullet, the flames still consumed %vm."
     DeathStrings(1)="%k finished off %o despite shooting %vm with a big inciendary bullet."
     DeathStrings(2)="%o might've cleared %k's line of sight, but %ve still burned to a crisp."
     DeathStrings(3)="%k watched as %o tried to do the stop, drop, and roll from a mile away. Only to fail."
     SimpleKillString="FSSG-50 Immolation"
     FlashThreshold=0
     FlashV=(X=750.000000,Y=250.000000)
     FlashF=-0.050000
     InvasionDamageScaling=2.000000
     DamageIdent="Sniper"
     WeaponClass=Class'BWBP_SKC_Pro.AS50Rifle'
     DeathString="%o was immolated by %k."
     FemaleSuicide="%o immolated herself."
     MaleSuicide="%o immolated himself."
     bDelayedDamage=True
     GibPerterbation=0.100000
     KDamageImpulse=200.000000
     VehicleDamageScaling=0.500000
}

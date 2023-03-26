class DT_MARSIceGrenade extends DT_BWExplode;

var() float ArmorDrain;

defaultproperties
{
     DeathStrings(0)="%k's cryo grenade put %o on ice."
     DeathStrings(1)="%o was turned into a snow-cone by %k's cryo grenade."
     SimpleKillString="MARS-3 Cryo Grenade"
     FlashThreshold=25
     FlashV=(X=350.000000,Y=350.000000,Z=700.000000)
     FlashF=0.250000
     DamageIdent="Grenade"
     WeaponClass=Class'BWBP_SKC_Pro.MARSAssaultRifle'
     DeathString="%k's cryo grenade put %o on ice."
     FemaleSuicide="%o stayed out in the cold."
     MaleSuicide="%o stayed out in the cold."
     GibModifier=0.500000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=2.000000
}

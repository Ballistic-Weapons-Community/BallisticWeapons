class DT_CoachBleed extends DT_BWMiscDamage;

var() float ArmorDrain;

defaultproperties
{
     DeathStrings(0)="%o haemorrhaged from %k's coach gun shot."
     SimpleKillString="Redwood Coach Gun Bleed"
     FlashThreshold=0
     FlashV=(X=350.000000)
     FlashF=0.700000
     bDetonatesBombs=False
     InvasionDamageScaling=2.000000
     DamageIdent="Shotgun"
     WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
     DeathString="%o haemorrhaged from %k's coach gun shot."
     FemaleSuicide="%o doesn't know how to aim."
     MaleSuicide="%o can't aim very well."
     bArmorStops=False
     bLocationalHit=False
     bDelayedDamage=True
     bNeverSevers=True
     GibModifier=1.500000
     GibPerterbation=0.400000
     KDamageImpulse=15000.000000
     VehicleDamageScaling=0.000000
}

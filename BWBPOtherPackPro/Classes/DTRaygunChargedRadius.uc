class DTRaygunChargedRadius extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was blown into tiny bits and pieces by %k's raygun bolt."
     DeathStrings(1)="%k totally dismantled %o with a searing ball of plasma."
     DeathStrings(2)="%k's spiralling blast vaporized %o."
     SimpleKillString="Raygun Charged Bolt"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     bIgniteFires=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBPOtherPackPro.Raygun'
     DeathString="%k totally dismantled %o with a searing ball of plasma."
     FemaleSuicide="%o blew herself to bits with a charged bolt."
     MaleSuicide="%o blew himself to bits with a charged bolt."
     bAlwaysGibs=True
     bLocationalHit=False
     bExtraMomentumZ=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=3.000000
}

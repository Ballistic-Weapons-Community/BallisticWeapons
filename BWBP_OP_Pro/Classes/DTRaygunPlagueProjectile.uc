class DTRaygunPlagueProjectile extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was fatally irradiated by %k's raygun."
     DeathStrings(1)="%k's radiation overdose was too much for %o."
     DeathStrings(2)="%o contracted %k's dreaded lurgie."
     SimpleKillString="Raygun Irradiation Bolt"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
	 InvasionDamageScaling=1.250000
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_OP_Pro.Raygun'
     DeathString="%k's radiation overdose was too much for %o."
     FemaleSuicide="%o irradiated herself."
     MaleSuicide="%o irradiated himself."
     bAlwaysGibs=True
     bDetonatesGoop=False
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.200000
}

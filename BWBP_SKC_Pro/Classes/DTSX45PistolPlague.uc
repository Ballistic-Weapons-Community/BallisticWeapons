class DTSX45PistolPlague extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o couldn't withstand %k's irradiation."
     DeathStrings(1)="%k's lingering radiation overcame %o."
     DeathStrings(2)="%k's SX45K made %o a terminal biohazard."
     SimpleKillString="Raygun Irradiation"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_SKC_Pro.SX45Pistol'
     DeathString="%k's radiation overdose was too much for %o."
     FemaleSuicide="%o irradiated herself."
     MaleSuicide="%o irradiated himself."
     bArmorStops=False - balance testing
     bDetonatesGoop=False
	 InvasionDamageScaling=1.250000
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.200000
}

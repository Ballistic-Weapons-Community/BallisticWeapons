class DT_SHADRACHPlague extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o force evolved into a corpse after being exposed to %k's virus."
     DeathStrings(1)="%k took notes while %o succumbed to lethal radiation poisoning."
     DeathStrings(2)="%o ran out of time and became irradiated to death by %k."
     DeathStrings(3)="%k turned %o into a radioactive beacon to guide lost ships home."
     SimpleKillString="SRK-205 Irradiation"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_APC_Pro.SRKSubMachinegun'
     DeathString="%k's radiation overdose was too much for %o."
     FemaleSuicide="%o irradiated herself."
     MaleSuicide="%o irradiated himself."
     bDetonatesGoop=False
	 InvasionDamageScaling=1.250000
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.200000
}

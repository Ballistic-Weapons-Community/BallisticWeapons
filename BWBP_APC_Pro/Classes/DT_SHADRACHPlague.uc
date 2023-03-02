class DT_SHADRACHPlague extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o couldn't withstand %k's irradiation."
     DeathStrings(1)="%k's lingering radiation overcame %o."
     DeathStrings(2)="%k's raygun made %o a terminal biohazard."
     DeathStrings(3)="%o's corpse glows bright and green thanks to %k's raygun."
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

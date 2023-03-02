class DTR9000EPlague extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o couldn't escape being a green goo pile after being tagged by %k's Chimera."
     DeathStrings(1)="%k let their Chimera do all the heavy lifting to irradiate %o to death."
     DeathStrings(2)="%o had a good life before succumbing to %k's radiation."
     DeathStrings(3)="%k watched as %o perished from terminal radiation poisoning."
	 DeathStrings(4)="%o's corpse is a reminder that %k's Chimera can kill even beyond the grave."
	 DeathStrings(5)="%k might've grazed %o with a radioactive bullet, but it's all it takes to kill someone."
     SimpleKillString="Raygun Irradiation"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_APC_Pro.R9000ERifle'
     DeathString="%k's radiation overdose was too much for %o."
     FemaleSuicide="%o irradiated herself."
     MaleSuicide="%o irradiated himself."
     bArmorStops=False
     bDetonatesGoop=False
	 InvasionDamageScaling=1.250000
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=0.200000
     VehicleMomentumScaling=0.200000
}

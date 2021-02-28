class DTRaygunCharged extends DT_BWMiscDamage;

defaultproperties
{
     DeathStrings(0)="%o was blown into tiny bits and pieces by %k's raygun beam."
     DeathStrings(1)="%k totally dismantled %o with a searing beam of plasma."
     DeathStrings(2)="%k's spiralling blast vaporized %o."
     SimpleKillString="Raygun Charged Beam"
     BloodManagerName="BallisticProV55.BloodMan_DarkSlow"
	 InvasionDamageScaling=2
     FlashV=(X=1000.000000,Y=500.000000)
     FlashF=-0.100000
     bIgniteFires=True
     bPowerPush=True
     DamageIdent="Energy"
     DamageDescription=",Plasma,"
     WeaponClass=Class'BWBP_OP_Pro.Raygun'
     DeathString="%k totally dismantled %o with a searing beam of plasma."
     FemaleSuicide="%o blew herself to bits with a charged beam."
     MaleSuicide="%o blew himself to bits with a charged beam."
     bAlwaysGibs=True
     bExtraMomentumZ=True
     GibModifier=2.000000
     GibPerterbation=0.200000
     KDamageImpulse=30000.000000
     VehicleDamageScaling=3.000000
     VehicleMomentumScaling=3.000000
}

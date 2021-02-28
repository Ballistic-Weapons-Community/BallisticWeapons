//============================================================================
//=============================================================================
class DT_M2020LimbPwr extends DT_BWBullet;

defaultproperties
{
     DeathStrings(0)="%k's M2020 shook hands with %o."
     DeathStrings(1)="%k's M2020 kneecapped a fleeing %o."
     DeathStrings(2)="%o got an arm amputated by %k's M2020."
     DeathStrings(3)="%k's EM rifle took %o's leg below the knee."
     AimedString="Scoped"
     DamageIdent="Sniper"
     DisplacementType=DSP_Linear
	 InvasionDamageScaling=2
     WeaponClass=Class'BWBP_SKC_Pro.M2020GaussDMR'
     DeathString="%k's M2020 shook hands with %o."
     FemaleSuicide="%o polarized herself."
     MaleSuicide="%o polarized himself."
     bFastInstantHit=True
     GibPerterbation=0.100000
     KDamageImpulse=3000.000000
     VehicleDamageScaling=0.800000
}

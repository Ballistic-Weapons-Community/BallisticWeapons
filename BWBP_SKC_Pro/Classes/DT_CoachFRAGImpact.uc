//=============================================================================
// CoachFrag Impact damage type.
//
// by Zorbulon
//=============================================================================
class DT_CoachFRAGImpact extends DT_BWBlunt;

defaultproperties
{
     DeathStrings(0)="%o took %k's unarmed FRAG-12 in the gut."
     DeathStrings(1)="%k's unarmed FRAG-12 brought %o along for the ride."
     SimpleKillString="Trenchgun FRAG-12 Impact"
     EffectChance=0.500000
	 InvasionDamageScaling=2
     DamageIdent="Ordnance"
     WeaponClass=Class'BWBP_SKC_Pro.CoachGun'
     DeathString="%o took %k's unarmed FRAG-12 in the gut."
     FemaleSuicide="%o ricochetted a FRAG-12 into her own stupid face."
     MaleSuicide="%o ricochetted a FRAG-12 into his own stupid face."
     bExtraMomentumZ=True
     VehicleDamageScaling=1.000000
}

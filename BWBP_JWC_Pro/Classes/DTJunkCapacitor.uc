//=============================================================================
// DTJunkCapacitor.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkCapacitor extends DTJunkDamage;

//FIXME!!!
static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	class'IM_JunkTazerHit'.static.StartSpawn(HitLocation, -Normal(Momentum), 6/*EST_Flesh*/, Victim);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     DeathStrings(0)="%o was incapacitated by %k."
     DeathStrings(1)="%k burnt a hole through %o with a capacitor."
     DeathStrings(2)="%k smoked %o with a capacitor."
     BloodManagerName="BallisticFix.BloodMan_Lightning"
     DeathString="%o was incapacitated by %k."
     FemaleSuicide="%o incapacitated herself."
     MaleSuicide="%o incapacitated himself."
     bArmorStops=False
     bCauseConvulsions=True
     PawnDamageSounds(0)=SoundGroup'BWBP_JW_Sound.Misc.Electro-Flesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
}

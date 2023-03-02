//=============================================================================
// DTProd.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTprod extends DTJunkDamage;

var float	FlashF1;
var vector	FlashV1;
//FIXME!!!
static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF1, default.FlashV1);
//	class'IM_JunkTazerHit'.static.StartSpawn(HitLocation, -Normal(Momentum), 6/*EST_Flesh*/, Victim);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF1=-0.250000
     FlashV1=(X=800.000000,Y=800.000000,Z=2000.000000)
     DeathStrings(0)="%k played Zeus and zapped the shit out of %o."
     DeathStrings(1)="%k left %o with a scar using his cattle prod."
     DeathStrings(2)="%o had a shocking experience with %k's cattle prod."
     ShieldDamage=15
     DeathString="%o was zapped across the face by %k."
     FemaleSuicide="%o zapped herself."
     MaleSuicide="%o zapped himself."
     bArmorStops=False
     bCauseConvulsions=True
     PawnDamageSounds(0)=SoundGroup'BWBP_JW_Sound.Misc.Electro-Flesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.900000
     GibPerterbation=0.250000
}

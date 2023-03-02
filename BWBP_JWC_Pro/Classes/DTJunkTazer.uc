//=============================================================================
// DTJunkTazer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTJunkTazer extends DTJunkDamage;

var float	FlashF;
var vector	FlashV;
//FIXME!!!
static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF, default.FlashV);
//	class'IM_JunkTazerHit'.static.StartSpawn(HitLocation, -Normal(Momentum), 6/*EST_Flesh*/, Victim);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF=-0.250000
     FlashV=(X=800.000000,Y=800.000000,Z=2000.000000)
     DeathStrings(0)="%o was zapped across the face by %k."
     DeathStrings(1)="%k tazed a burning scar into %o's flesh with a tazer."
     DeathStrings(2)="%k electrified %o with a tazer."
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

//=============================================================================
// Electric Machete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class DTelecmach extends DTJunkDamage;

var float	FlashF1;
var vector	FlashV1;
//FIXME!!!
static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
	if (PlayerController(Victim.Controller) != None)
		PlayerController(Victim.Controller).ClientFlash(default.FlashF1, default.FlashV1);
//	class'IM_Elecmach'.static.StartSpawn(HitLocation, -Normal(Momentum), 6/*EST_Flesh*/, Victim);
	return super.GetPawnDamageEffect(HitLocation, Damage, Momentum, Victim, bLowDetail);
}

defaultproperties
{
     FlashF1=-0.250000
     FlashV1=(X=800.000000,Y=800.000000,Z=2000.000000)
     DeathStrings(0)="%k zapped %o with an electric machete."
     DeathStrings(1)="%k played too much Dead Island and killed %o with an electric machete."
     DeathStrings(2)="%k didn't care about the electricity bill when he sliced up %o."
     DeathStrings(3)="%k shoved his electric machete up %o's skull."
     BloodManagerName="BallisticProV55.BloodMan_Slash"
     ShieldDamage=25
     DamageDescription=",Slash,"
     ImpactManager=Class'BWBP_JWC_Pro.IM_JunkMachete'
     DeathString="%k sliced up %o with an electric machete."
     FemaleSuicide="%o sliced herself with an electric machete."
     MaleSuicide="%o slice himself with an electric machete."
     bArmorStops=False
     bCauseConvulsions=True
     bNeverSevers=False
     PawnDamageSounds(0)=SoundGroup'BWBP_JW_Sound.Misc.Electro-Flesh'
     DamageOverlayMaterial=Shader'XGameShaders.PlayerShaders.LightningHit'
     DamageOverlayTime=0.400000
     GibPerterbation=0.250000
}

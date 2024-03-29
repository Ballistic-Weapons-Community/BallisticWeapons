//=============================================================================
// AS50PrimaryFire.
//
// Accurate, long ranged and powerful bullet fire.
//=============================================================================
class AS50PrimaryFire extends BallisticProInstantFire;

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
     KickForce=1000
     PenetrateForce=450
     bPenetrate=True
     PDamageFactor=0.800000
     WallPDamageFactor=0.850000
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     BrassClass=Class'BWBP_SKC_Pro.Brass_BMGInc'
     BrassBone="breach"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     FireRecoil=450.000000
     FirePushbackForce=255.000000
     FireChaos=1.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="CFire"
     FireEndAnim=
     FireRate=0.8000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50Inc'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.5
     WarnTargetPct=0.4
     aimerror=950.000000
}

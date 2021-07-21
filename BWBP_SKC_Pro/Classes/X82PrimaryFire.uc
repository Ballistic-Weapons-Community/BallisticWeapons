//=============================================================================
// X82PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class X82PrimaryFire extends BallisticProInstantFire;

simulated function PreBeginPlay()
{
	if (X82Rifle_TW(Weapon) != None)
		FireChaos = 0.03;
	super.PreBeginPlay();
}

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=128.000000
     
     Damage=95.000000
     HeadMult=1.5f
     LimbMult=0.9f
     
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_SKC_Pro.DT_X82Torso'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_X82Head'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_X82Torso'
     KickForce=10000
     PenetrateForce=450
     bPenetrate=True
     MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
     BrassClass=Class'BWBP_SKC_Pro.Brass_BMG'
     BrassBone="breach"
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
     FireRecoil=768.000000
     FirePushbackForce=255.000000
     FireChaos=0.700000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire',Volume=10.000000,Radius=1024.000000)
     FireEndAnim=
     FireRate=0.750000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_50BMG'
     ShakeRotMag=(X=450.000000,Y=64.000000)
     ShakeRotRate=(X=12400.000000,Y=12400.000000,Z=12400.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-5.500000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.250000
     BotRefireRate=0.300000
     WarnTargetPct=0.700000
     aimerror=950.000000
}

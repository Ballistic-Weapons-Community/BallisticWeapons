//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningPrimaryFire extends BallisticProInstantFire;

var() BUtil.FullSound			LightningSound;	//Crackling sound to play

simulated function ServerPlayFiring()
{
	super.ServerPlayFiring();
	if (LightningSound.Sound != None)
		Weapon.PlayOwnedSound(LightningSound.Sound,LightningSound.Slot,LightningSound.Volume,LightningSound.bNoOverride,LightningSound.Radius,LightningSound.Pitch,LightningSound.bAtten);
}

simulated function PlayFiring()
{
	super.PlayFiring();
	if (LightningSound.Sound != None)
		Weapon.PlayOwnedSound(LightningSound.Sound,LightningSound.Slot,LightningSound.Volume,LightningSound.bNoOverride,LightningSound.Radius,LightningSound.Pitch,LightningSound.bAtten);
}

defaultproperties
{
	 LightningSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunCrackle',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
     TraceRange=(Min=30000.000000,Max=30000.000000)
     MaxWaterTraceRange=30000
     Damage=80.000000
     HeadMult=1.5f
     LimbMult=0.9f
     
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPOtherPackPro.DT_LightningRifle'
     DamageTypeHead=Class'BWBPOtherPackPro.DT_LightningHead'
     DamageTypeArm=Class'BWBPOtherPackPro.DT_LightningRifle'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     PDamageFactor=0.800000
     MuzzleFlashClass=Class'BWBPOtherPackPro.LightningFlashEmitter'
	 FlashScaleFactor=0.600000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     bBrassOnCock=True
     BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	 FireRecoil=400.000000
	 FirePushbackForce=255.000000
     FireChaos=0.800000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
	 FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_LightningRifle'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.400000
     WarnTargetPct=0.500000
     aimerror=800.000000
}

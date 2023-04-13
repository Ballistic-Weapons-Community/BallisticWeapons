//=============================================================================
// SK410PrimaryFire.
//
// Moderately strong shotgun blast with decent spread and fair range for a shotgun.
// Can do more damage than the M763, but requires more shots normally.
//
// Can fire its shells HE mode, however it's nowhere near as strong as a FRAG.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RCS715PrimaryFire extends BallisticProShotgunFire;

// Even if we hit nothing, this is already taken care of in DoFireEffects()...
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	local Vector V;

	V = Instigator.Location + Instigator.EyePosition() + Dir * TraceRange.Min;
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetModeTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetModeTipLocation(), Rotator(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetModeTipLocation()));
	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);
}

// Spawn the impact effects here for StandAlone and ListenServers cause the attachment won't do it
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

	if (!Other.bWorldGeometry && Mover(Other) == None)
		return false;

	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	if (ImpactManager != None && Weapon.EffectIsRelevant(HitLocation,false))
	{
		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);
		ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
		if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()) > 200 && FRand() < TracerChance)
			Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()));
	}
	Weapon.HurtRadius(1, 128, DamageType, 1, HitLocation);
	return true;
}


simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
	 HipSpreadFactor=2.000000
	 MaxSpreadFactor=2.000000
     TraceCount=6
     TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4000.000000,Max=6000.000000)
     DamageType=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
     DamageTypeHead=Class'BWBP_OP_Pro.DT_RCS715ShotgunHead'
     DamageTypeArm=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
     KickForce=500
     PenetrateForce=100
     bPenetrate=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
     FlashScaleFactor=1.000000
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassBone="EjectorDoor"
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=256.000000
     FirePushbackForce=150.000000
     FireChaos=0.500000
     XInaccuracy=192.000000
     YInaccuracy=192.000000
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.XMV-850.XMV-Fire-3')
     FireEndAnim=
     FireAnimRate=2.50000
     FireRate=0.200000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.500000
}

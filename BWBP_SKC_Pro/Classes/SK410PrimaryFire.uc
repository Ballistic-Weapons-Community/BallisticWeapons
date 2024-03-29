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
class SK410PrimaryFire extends BallisticProShotgunFire;

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
     BW.TargetedHurtRadius(5, 96, DamageType, 1, HitLocation, Pawn(Other));
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
	HipSpreadFactor=1.50000
	TraceCount=7
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
	ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
	TraceRange=(Min=2048.000000,Max=2048.000000)
	DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
	KickForce=1000
	PenetrateForce=0
	bPenetrate=False
	MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
	FlashScaleFactor=0.500000
	BrassClass=Class'BWBP_SKC_Pro.Brass_ShotgunHE'
	BrassOffset=(X=-1.000000,Z=-1.000000)
	AimedFireAnim="SightFire"
	FireRecoil=378.000000
	FirePushbackForce=0.000000
	FireChaos=0.400000
	XInaccuracy=256.000000
	YInaccuracy=256.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
	FireEndAnim=
	FireAnimRate=1.750000
	FireRate=0.225000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_8GaugeHE'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-10.00)
	ShakeOffsetRate=(X=-200.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.900000
	WarnTargetPct=0.500000
}

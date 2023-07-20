//=============================================================================
// D49Attachment.
//
// ThirdPersonActor for to D49Revolver
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class D49Attachment extends HandgunAttachment;

var   byte		RevolverBrass;

replication
{
	reliable if (Role == ROLE_Authority)
		RevolverBrass;
}

simulated event PostNetReceive()
{
	if (RevolverBrass > 0)
	{
		if (RevolverBrass > 127)
			RevolverBrass -= 128;
		RevolverEjectBrass(RevolverBrass);
		RevolverBrass = 0;
	}
	super.PostNetReceive();
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start, X, Y, Z;
	local Material HitMat;

	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
	SpawnTracer(Mode, mHitLocation);
	FlyByEffects(Mode, mHitLocation);
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Mode, Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ImpactManager!= None && bDoWaterSplash)
			DoWaterTrace(Mode, Start, mHitLocation);

		if (mHitActor == None)
			return;
		// Set the hit surface type
		if (Vehicle(mHitActor) != None)
			mHitSurf = 3;
		else if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None)
	{
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
		if (Mode > 0)
		{
			GetAxes(Instigator.GetViewRotation(), X, Y, Z);
			ImpactManager.static.StartSpawn(HitLocation + (Y cross mHitNormal) * (-4 - FRand()*4), mHitNormal, mHitSurf, instigator, 2/*HF_NoSounds*/);
		}
	}
}

simulated function RevolverEjectBrass(byte Num)
{
	local int i;
	local Rotator R;

	if (Role == ROLE_Authority)
	{
		if (RevolverBrass > 127)
			RevolverBrass = Num;
		else
			RevolverBrass = Num + 128;
	}
	if (level.NetMode == NM_DedicatedServer)
		return;
	if (Instigator!=None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	for (i=0;i<Num;i++)
		Spawn(BrassClass, self,, GetEjectorLocation(R)+VRand()*2, R);
}

simulated function EjectBrass(byte Mode);

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode != 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	if (MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
	WeaponClass=class'D49Revolver'
     MuzzleFlashClass=class'D49FlashEmitter'
     AltMuzzleFlashClass=class'D49FlashEmitter'
     ImpactManager=class'IM_BigBullet'
     BrassClass=class'Brass_Magnum'
     BrassBone="MagnumWhole"
     TracerMode=MU_Both
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=class'TraceEmitter_Pistol'
     TracerChance=0.600000
	 ReloadAnimRate=0.450000
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.D49_TPm'
     DrawScale=0.150000
}

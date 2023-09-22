//=============================================================================
// RS04Attachment.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS04Attachment extends HandgunAttachment;

var bool					bHasKnife;	//shank?
var bool					bHasFlash;	//blind?
var bool		bLightsOn, bLightsOnOld;
var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var	  BallisticWeapon		myWeap;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLightsOn, bHasKnife;
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);
	if (RS04Pistol(I) != None && RS04Pistol(I).bHasKnife)
	{
		bHasKnife=true;
	}
	if (RS04Pistol(I) != None && RS04Pistol(I).bHasFlash)
	{
		bHasFlash=true;
	}
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	SwitchFlashLight();
	if (NewbHidden)
	{
		KillProjector();
		if (FlashLightEmitter!=None)
			FlashLightEmitter.Destroy();
	}
	else if (bLightsOn)
	{
		SwitchFlashLight();
	}
}

simulated event PostNetReceive()
{
	super.PostNetReceive();
	if (level.NetMode != NM_Client)
		return;
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
	FlashLightProj.SetRelativeLocation(vect(-32,0,0));
}
simulated function KillProjector()
{
	if (FlashLightProj != None)
	{
		FlashLightProj.Destroy();
		FlashLightProj = None;
	}
}

simulated function SwitchFlashLight ()
{
	if (bLightsOn)
	{
		if (FlashLightEmitter == None)
		{
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
			class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
			AttachToBone(FlashLightEmitter, 'tip2');
			FlashLightEmitter.bHidden = false;
			FlashLightEmitter.bCorona = true;
		}
		if (!Instigator.IsFirstPerson())
			StartProjector();
	}
	else
	{
		FlashLightEmitter.Destroy();
		KillProjector();
	}
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bLightsOn != bLightsOnOld)	
	{
		SwitchFlashLight();
		bLightsOnOld = bLightsOn;	
	}
	if (!bLightsOn)
		return;

	if (Instigator.IsFirstPerson())
	{
		KillProjector();
		if (FlashLightEmitter != None && FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = false;
	}
	else
	{
		if (FlashLightProj == None)
			StartProjector();
		if (FlashLightEmitter != None && !FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = true;
	}
}

simulated function Destroyed()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	super.Destroyed();
}

simulated function InstantFireEffects(byte Mode)
{
	if (FiringMode != 0 && bHasKnife)
		MeleeFireEffects();
	else if (FiringMode != 0 && bHasFlash)
		FlashFireEffects();
	else
		Super.InstantFireEffects(FiringMode);
}

simulated function FlashFireEffects()
{
	local vector L, Dir;

	L = Instigator.Location + Instigator.EyePosition();
	Dir = Normal(mHitLocation - L);

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		Spawn(class'AM67FlashProjector',Instigator,,L+Dir*25,rotator(Dir));
	else
		Spawn(class'AM67FlashProjector',Instigator,,GetTipLocation(),rotator(Dir));
}

// Do trace to find impact info and then spawn the effect
simulated function MeleeFireEffects()
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (mHitLocation == vect(0,0,0))
		return;

	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();
		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		if (mHitActor == None || (!mHitActor.bWorldGeometry))
			return;

		if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
	else
		HitLocation = mHitLocation;
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (!bHasKnife)
		class'IM_GunHit'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
	else 
		class'IM_Knife'.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
}

simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;
	local float DF;

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode != 0 && bHasFlash && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min = (200 + DF*600) * DrawScale * FlashScale;
		Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Max = Emitter(AltMuzzleFlash).Emitters[0].StartSizeRange.X.Min;
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

defaultproperties
{
	WeaponClass=class'RS04Pistol'
	SlavePivot=(Roll=32768)
	MuzzleFlashClass=class'XK2FlashEmitter'
    AltMuzzleFlashClass=class'AM67FlashEmitter'
	ImpactManager=class'IM_Bullet'
	AltFlashBone="tip2"
	BrassClass=class'Brass_Pistol'
	InstantMode=MU_Both
	TrackAnimMode=MU_Secondary
	TracerClass=class'TraceEmitter_Default'
	TracerMix=-3
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	bRapidFire=True
	bAltRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.RS04_TPm'
	RelativeRotation=(Pitch=32768)
	DrawScale=0.210000
	PrePivot=(Z=-2.000000)
}

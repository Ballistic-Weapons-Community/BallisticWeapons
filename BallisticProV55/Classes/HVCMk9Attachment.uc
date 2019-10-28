//=============================================================================
// LightningAttachment.
//
// 3rd person weapon attachment for HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9Attachment extends BallisticAttachment;

var Actor 		Pack;			// The Backpack
var Emitter		FreeZap;
var bool	bStreamOn;
var HVCMk9_TrackingZap StreamEffect;

var bool		bDischarge, bDischargeOld;
var byte		ChargePower;						// Power of secondary zap sent from server
var HVCMk9LightningGun	LG;							// Access to the lightning gun itself (only available to owner)

var Actor	Arc1;			// Decorative arc effects
var Actor	Arc2;
var Actor	Arc3;

var class<BCImpactManager> ImpactManagerAlt;

var() Sound DischargeSound;			// Sound of water discharge

replication
{
	reliable if (Role==ROLE_Authority)
		bDischarge, ChargePower, StreamEffect;
	reliable if (Role==ROLE_Authority && bNetOwner && bNetInitial)
		LG;
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	Pack = Spawn(class'HVCMk9Pack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
	if (level.DetailMode>DM_High)
	{
		if (Arc1 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc1, class'HVCMk9_SideArc', DrawScale, self, 'Arc1');
		if (Arc2 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc2, class'HVCMk9_TopArc',  DrawScale, self, 'Arc2');
		if (Arc3 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc3, class'HVCMk9_TopArc',  DrawScale, self, 'Arc3');
	}
}

//===========================================================================
// StartStream
// Called by primary firemode
//===========================================================================
function StartStream()
{
	bStreamOn = True;
	//AmbientSound = StreamAmbientSound;
	Instigator.bAlwaysRelevant=True;
	bAlwaysRelevant=True;
	
	if (StreamEffect == None)
	{
		StreamEffect = spawn(class'HvCMk9_TrackingZap', self);
		StreamEffect.SetLocation(GetBoneCoords('tip').Origin);
		StreamEffect.SetBase(self);
		if (HvCMk9LightningGun(Instigator.Weapon) != None)
			HvCMk9LightningGun(Instigator.Weapon).StreamEffect = StreamEffect;
		StreamEffect.Instigator = Instigator;
		StreamEffect.GunAttachment = self;
		StreamEffect.UpdateEndpoint();
		
		StartMuzzleZap();
	}
}

//===========================================================================
// EndStream
//
// Called by primary firemode StopFiring()
//===========================================================================
function EndStream()
{
	bStreamOn = False;
	//AmbientSound = None;
	Instigator.bAlwaysRelevant=False;
	bAlwaysRelevant=False;
	
	if (StreamEffect != None)
	{
		StreamEffect.bTearOff = True;
		StreamEffect.Kill();
		StreamEffect = None;
		
		StopMuzzleZap();
	}
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
}

simulated event PostNetReceive()
{
	if (bDischarge != bDischargeOld)		
	{	
		bDischargeOld = bDischarge;
		DoWaterDischarge();					
	}
	super.PostNetReceive();
}

function InitFor(Inventory I)
{
	Super.InitFor(I);
	if (I != None && HVCMk9LightningGun(I) != None)
		LG = HVCMk9LightningGun(I);
}

simulated function StartMuzzleZap()
{
	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, class'HVCMk9MuzzleFlash', DrawScale*FlashScale, self, 'tip');
}
simulated function StopMuzzleZap()
{
	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
}

simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	if (StreamEffect != None)
		StreamEffect.Kill();
	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
	super.Destroyed();
}

simulated function DoWaterDischarge()
{
	if (Role == ROLE_Authority)
		bDischarge = !bDischarge;
	if (level.NetMode == NM_DedicatedServer)
		return;
	spawn(class'IE_HVCDischarge', Instigator,, Instigator.Location);
	Instigator.PlaySound(DischargeSound, SLOT_None, 1.8, , 192, 1.0 , false);
}

simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local float Dist;

	if (Mode == 1)
	{
		if (VSize(V) < 2)
		{
			V = Instigator.Location + Instigator.EyePosition() + V * 1400;
			Tracer = Spawn(class'TraceEmitter_HVCRedMiss', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
			Tracer.Initialize(Dist, float(ChargePower));
			return;
		}
		Dist = VSize(V - GetTipLocation());
		if (Dist > 25)
		{
			Tracer = Spawn(class'TraceEmitter_HVCRedLightning', self, , GetTipLocation(), Rotator(V - GetTipLocation()));
			Tracer.Initialize(Dist, float(ChargePower)/255);
		}
	}
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	//if (Mode == 0)
	//	return;
	if (mHitLocation == vect(0,0,0))
		return;
	SpawnTracer(Mode, mHitLocation);
	if (VSize(mHitLocation) < 2)
		return;
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		bTraceWater=true;
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		bTraceWater=false;

		if (mHitActor == None)
		{	HitLocation = mHitLocation; mHitNormal = -Dir;	}
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;
		
	if (Mode == 0)
		if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);

	else if (ImpactManagerAlt != None)
		ImpactManagerAlt.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

simulated function Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	
	if (StreamEffect != None && !Instigator.IsFirstPerson())
		StreamEffect.SetLocation(GetBoneCoords('tip2').Origin);
}

defaultproperties
{
     ImpactManagerAlt=Class'BallisticProV55.IM_HVCRedLightning'
     DischargeSound=Sound'BWBP2-Sounds.LightningGun.LG-WaterDischarge'
     AltMuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
     ImpactManager=Class'BallisticProV55.IM_HVCBlueLightning'
     bDoWaterSplash=False
     WeaponLightTime=0.200000
     FlashScale=2.000000
     TracerMode=MU_Secondary
     InstantMode=MU_Secondary
     FlashMode=MU_Secondary
     TracerClass=Class'BallisticProV55.TraceEmitter_HVCRedLightning'
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP2b-Anims.HVC-3rd'
     DrawScale=0.150000
}

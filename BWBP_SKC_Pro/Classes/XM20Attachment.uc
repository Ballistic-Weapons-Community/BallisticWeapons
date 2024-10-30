//=============================================================================
// XM20Attachment.
//
// Third person actor for the XM20 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20Attachment extends BallisticAttachment;

var byte CurrentTracerMode;
var array< class<BCTraceEmitter> >	TracerClasses[2];

var   bool					bLaserOn;	//Is laser currently active
var   bool					bOldLaserOn;//Old bLaserOn
var   LaserActor			Laser;		//The laser actor
var   Rotator				LaserRot;
var   vector				PreviousHitLoc;
var   Emitter				LaserDot;
var   Vector				SpawnOffset;
var   bool					bBigLaser;

var ForceRing ForceRing3rd;
var XM20ShieldEffect3rd XM20ShieldEffect3rd;

var   BallisticWeapon 		myWeap;

replication
{
	reliable if (bNetInitial && Role == ROLE_Authority)
		XM20ShieldEffect3rd;
	reliable if ( Role==ROLE_Authority )
		bLaserOn, CurrentTracerMode;
	unreliable if ( Role==ROLE_Authority )
		LaserRot, bBigLaser;
}



simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
	{
		LaserDot = Spawn(class'BWBP_SKC_Pro.IE_XM20Impact',,,Loc);
		laserDot.bHidden=false;
	}
}

simulated function Tick(float DT)
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator X;
	local Actor Other;

	Super.Tick(DT);

	if (bLaserOn && Role == ROLE_Authority && myWeap != None)
	{
		LaserRot = Instigator.GetViewRotation() + myWeap.GetFireRot();
	}

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (Laser == None)
		Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_XM20Red',,,Location);

	if (bLaserOn != bOldLaserOn)
		bOldLaserOn = bLaserOn;

	if (!bLaserOn || Instigator == None || Instigator.IsFirstPerson() || Instigator.DrivenVehicle != None)
	{
		if (!Laser.bHidden)
			Laser.bHidden = true;
		if (LaserDot != None)
			KillLaserDot();
		return;
	}
	else
	{
		if (Laser.bHidden)
			Laser.bHidden = false;
	}

	if (Instigator != None)
		Start = Instigator.Location + Instigator.EyePosition();
	else
		Start = Location;
	X = LaserRot;

	Loc = GetTipLocation();

	if (AIController(Instigator.Controller)!=None)
	{
		HitLocation = mHitLocation;
	}
	else
	{
		End = Start + (Vector(X)*3000);
		Other = Trace (HitLocation, HitNormal, End, Start, true);
		if (Other == None)
			HitLocation = End;
	}

	if (LaserDot == None && Other != None)
		SpawnLaserDot(HitLocation);
	else if (LaserDot != None && Other == None)
		KilllaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
	}

	Laser.SetLocation(Loc);
	Laser.SetRotation(Rotator(HitLocation - Loc));
	Scale3D.X = VSize(HitLocation-Laser.Location)/128;
	if (bBigLaser)
	{
		Scale3D.Y = 9.5;
		Scale3D.Z = 9.5;
	}
	else
	{
		Scale3D.Y = 4.5;
		Scale3D.Z = 4.5;
	}
	Laser.SetDrawScale3D(Scale3D);
}

// Return the location of the muzzle.
simulated function Vector GetTipLocation()
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetEffectStart();
        
    return GetBoneCoords('tip').Origin;
}

simulated function Destroyed()
{
	local int i;
    if (XM20ShieldEffect3rd != None)
        XM20ShieldEffect3rd.Destroy();

    if (ForceRing3rd != None)
        ForceRing3rd.Destroy();


	if (Instigator != None && level.TimeSeconds <= TrackEndTime)
	{
		for(i=0;i<GetTrackCount(ActiveTrack);i++)
			Instigator.SetBoneRotation(GetTrack(ActiveTrack,i).Bone, rot(0,0,0), 0, 1.0);
	}
	
	if (Laser != None)
		Laser.Destroy();
	KillLaserDot();
	Super.Destroyed();
}

simulated function InstantFireEffects(byte Mode)
{
	if (Mode == 1)
	{
		if (VSize(PreviousHitLoc - mHitLocation) < 2)
			return;
		PreviousHitLoc = mHitLocation;
		ImpactManager = class'IM_XM20Laser';
	}
	super.InstantFireEffects(Mode);
}

// Spawn a tracer and water tracer
simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetModeTipLocation(Mode);
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (ModeInfos[Mode].TracerMix == 0)
		bThisShot=true;
	else
	{
		ModeInfos[Mode].TracerCounter++;
		if (TracerMix < 0)
		{
			if (ModeInfos[Mode].TracerCounter >= -ModeInfos[Mode].TracerMix)	{
				ModeInfos[Mode].TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (ModeInfos[Mode].TracerCounter >= ModeInfos[Mode].TracerMix)	{
			ModeInfos[Mode].TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (ModeInfos[Mode].bTracer && TracerClasses[CurrentTracerMode] != None &&
		bThisShot && (ModeInfos[Mode].TracerChance >= 1 || FRand() < ModeInfos[Mode].TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh 
    && ModeInfos[Mode].WaterTracerClass != None && ModeInfos[Mode].bWaterTracer)
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(ModeInfos[Mode].WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}

// Spawn a tracer and water tracer
/*simulated function SpawnTracer(byte Mode, Vector V)
{
	local BCTraceEmitter Tracer;
	local Vector TipLoc, WLoc, WNorm;
	local float Dist;
	local bool bThisShot;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	TipLoc = GetTipLocation();
	Dist = VSize(V - TipLoc);

	// Count shots to determine if it's time to spawn a tracer
	if (TracerMix == 0)
		bThisShot=true;
	else
	{
		TracerCounter++;
		if (TracerMix < 0)
		{
			if (TracerCounter >= -TracerMix)	{
				TracerCounter = 0;
				bThisShot=false;			}
			else
				bThisShot=true;
		}
		else if (TracerCounter >= TracerMix)	{
			TracerCounter = 0;
			bThisShot=true;					}
	}
	// Spawn a tracer
	if (TracerClasses[CurrentTracerMode] != None && TracerMode != MU_None && (TracerMode == MU_Both && Mode == 0) &&
		bThisShot && (TracerChance >= 1 || FRand() < TracerChance))
	{
		if (Dist > 200)
		Tracer = Spawn(TracerClasses[CurrentTracerMode], self, , TipLoc, Rotator(V - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(Dist);
	}
	// Spawn under water bullet effect
	if ( Instigator != None && Instigator.PhysicsVolume.bWaterVolume && level.DetailMode == DM_SuperHigh && WaterTracerClass != None &&
		 WaterTracerMode != MU_None && (WaterTracerMode == MU_Both || (WaterTracerMode == MU_Secondary && Mode != 0) || (WaterTracerMode == MU_Primary && Mode == 0)))
	{
		if (!Instigator.PhysicsVolume.TraceThisActor(WLoc, WNorm, TipLoc, V))
			Tracer = Spawn(WaterTracerClass, self, , TipLoc, Rotator(WLoc - TipLoc));
		if (Tracer != None)
			Tracer.Initialize(VSize(WLoc - TipLoc));
	}
}*/

//shield
function InitFor(Inventory I)
{
    Super.InitFor(I);

	if (BallisticWeapon(I) != None)
		myWeap = BallisticWeapon(I);

	if (XM20Carbine(I) != None && XM20Carbine(I).bIsPrototype)
	{
		CurrentTracerMode=1;
		bBigLaser=true;
	}
	
	if ( (Instigator.PlayerReplicationInfo == None) || (Instigator.PlayerReplicationInfo.Team == None)
		|| (Instigator.PlayerReplicationInfo.Team.TeamIndex > 1) )
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rd', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rdRED', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rd', I.Instigator);
    XM20ShieldEffect3rd.SetBase(I.Instigator);
}

simulated event ThirdPersonEffects()
{
	if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		//Spawn impacts, streaks, etc
		InstantFireEffects(FiringMode);
		//Flash muzzle flash
		FlashMuzzleFlash (FiringMode);
		//Weapon light
		FlashWeaponLight(FiringMode);
		//Play pawn anims
		PlayPawnFiring(FiringMode);
		//Eject Brass
		EjectBrass(FiringMode);
	}

    	Super.ThirdPersonEffects();
}

function SetBrightness(int b, bool hit)
{
    if (XM20ShieldEffect3rd != None)
        XM20ShieldEffect3rd.SetBrightness(b, hit);
}

simulated function EjectBrass(byte Mode);

defaultproperties
{
	WeaponClass=class'XM20Carbine'
	FlashBone="tip"
	AltFlashBone="tip"
	MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20FlashEmitter'
	TracerClasses(0)=class'TraceEmitter_XM20Laser'
	TracerClasses(1)=class'TraceEmitter_XM20Laser_P'
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_XM20Laser'
	FlashScale=0.750000
	ImpactManager=Class'BWBP_SKC_Pro.IM_XM20Laser'
	FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.XM20.XM20-FlyBy',Volume=0.700000)
	InstantMode=MU_Both
	FlashMode=MU_Both
	LightMode=MU_Both
	TracerMode=MU_Primary
	TracerChance=1
	TracerMix=0
	ReloadAnimRate=0.725000
	CockAnimRate=2.000000
	RelativeLocation=(X=1.00,Z=5.00)
	RelativeRotation=(Pitch=32768)
	Mesh=SkeletalMesh'BWBP_SKC_Anim.XM20_TPm'
	DrawScale=0.15
}

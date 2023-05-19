//=============================================================================
// BallisticAttachment.
//
// Base class for 3rd person weapon attachments. Lots of general functionality
// is implemented here.
// Features include:
// -MuzzleFlashes and AltMuzzleFlashes
// -Impact manager support for simple implementation of impact effect
// -Dynamic light flashing
// -Brass spawning
// -Tracer spawning
// -Use TracerMix to make tracers spawn for a set amount of shots
// -Use TracerChance to make tracers spawn randomly (only checked after TracerMix checks)
// -Water impacts
// -Under Water Tracers
// -Generated anims using 'anim tracks'
// -Wall penetration effects
// -Net Client support/implementation of these effects...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticAttachment extends xWeaponAttachment
	DependsOn(BUtil);

enum EModeUsed
{
	MU_Primary,
	MU_Secondary,
	MU_Both,
	MU_None
};

struct ModeInfo
{
    var class<BCImpactManager>    ImpactManager;
    var class<BCTraceEmitter>     TracerClass;
    var class<BCTraceEmitter>     WaterTracerClass;
    var class<Actor>              MuzzleFlashClass;
    var float                     TracerChance;
    var int                       TracerMix;
    var int                       TracerCounter;
    var Name                      FlashBone;
    var Name                      TipBone;
    var bool                      bTrackAnim;
    var bool                      bInstant;
    var bool                      bTracer;
    var bool                      bWaterTracer;
    var bool                      bFlash;
    var bool                      bLight;
    var bool                      bBrass;
};

var   ModeInfo                      ModeInfos[2];

var() class<BallisticWeapon>		WeaponClass;						// required - used to access params
var() class<actor>					MuzzleFlashClass;					//Effect to spawn fot mode 0 muzzle flash
var   actor							MuzzleFlash;						//The flash actor itself
var() class<actor>					AltMuzzleFlashClass;				//Effect to spawn fot mode 1 muzzle flash
var   actor							AltMuzzleFlash;						//The flash actor itself
var() class<BCImpactManager>		ImpactManager;						//Impact Manager to use for impact effects
var() class<BCImpactManager>		MeleeImpactManager;					//Impact Manager to use for melee effects
var() bool							bDoWaterSplash;						//Allow water splash effects and checks
var() bool							bRandomFlashRoll;					//Randomly set roll of muzzle flash actor for each shot
var   actor							LightWeapon;						//Actor currently being use for weapon light
var() float							WeaponLightTime;					//Time for weapon light to remain on
var() Name							FlashBone;							//Bone to which primary flash will be attached
var() Name							AltFlashBone;						//Bone to which secondary flash will be attached
var   int							mHitSurf;							//Surface type that was hit
var() float							FlashScale;							//Flash will be scaled by weapon drawscale and this
var() class<actor>					BrassClass;							//Type of brass to eject
var() EModeUsed						BrassMode;							//Firing mode/s that eject brass
var() Name							BrassBone;							//Name of bone from which to spawn brass
var() EModeUsed						TracerMode;							//Firing mode/s that spawn tracer effects. Still needs Instant mode to be on
var() EModeUsed						InstantMode;						//Firing mode/s that spawn instant fire effects
var() EModeUsed						FlashMode;							//Firing mode/s that spawn muzzle flash
var() EModeUsed						LightMode;							//Firing mode/s that flash light
var() EModeUsed						TrackAnimMode;						//Firing mode/s that play pawn slash anim instead of normal firing
var() class<BCTraceEmitter>			TracerClass;						//Type of tracer to use for instant fire effects
var() float							TracerChance;						//Chance of tracer effect spawning. 0=never, 1=always on super detail, 2=always
var() int							TracerMix;							//Do Tracer every ? shots. <0 means don't do tracer every ? shots
var   int							TracerCounter;						//Tracer every ? shots uses this to count shots
var   byte							FireCount;							//Incremented to to inform this attachment that a shot was fired
var   byte							OldFireCount;						//Used to check if FireCount changed
var   byte							AltFireCount;						//Incremented to to inform this attachment of secondary fire shots
var   byte							OldAltFireCount;					//Used to check if AltFireCount changed
var 	byte						MeleeFireCount, OldMeleeFireCount;
var   vector 						WaterHitLocation;					//Spot where water was hit
var() class<BCTraceEmitter>			WaterTracerClass;					//Emitter to sue for under water tracer
var() EModeUsed						WaterTracerMode;					//Modes that have water tracers
var   byte							WallPenetrates;						//Fire penetrated a wall. Tells client to do find walls and do effects
var() BUtil.FullSound				FlyBySound;							//Sound to play for bullet flyby effect
var() EModeUsed						FlyByMode;							//Firing mode/s that use flyby effect.
var() float							FlybyRange;							//Max distance from bullet trace line, at which flyby by sounds will be heard
var() float							FlyByBulletSpeed;					//Used to calculate flyby sound delay (simulate bullet speed)
var 	int 						CamoIndex;

//===========================================================================
// Animation support
//===========================================================================
var() Name							ReloadAnim, CockingAnim, WeaponSpecialAnim, StaggerAnim;			// Third person reload animation.
var() float							ReloadAnimRate, CockAnimRate, WeaponSpecialRate, StaggerRate;  // Used by SetAnimAction for third person "reload" anim rate
var()  Name							IdleHeavyAnim, IdleRifleAnim;
var()	 Name						MeleeStrikeAnim;						// Third person melee attack.
var()	 float						MeleeAnimRate;
var()	 Name						MeleeBlockAnim, MeleeWindupAnim;
var 	 bool						bIsAimed; 								// Used to have pawns raise and lower the gun
var()	 Name						SingleFireAnim, SingleAimedFireAnim, RapidFireAnim, RapidAimedFireAnim;

// Direct impacts allow the server to send the loc, norm and surf of an impact to be used on the client
// This way the server can force a specific impact, but this uses more bandwidth
// Useful for impacts with vehicles, actors that don't have client-side collision and other special cases
struct DirectImp
{
    var() byte      Mode;
	var() vector	HitLoc;		// Impact location
	var() byte		HitSurf;	// Surface type
	var() byte		HitNorm;	// Compressed normal. BUtil.NormToByte can be used to compress and BUtil.ByteToNorm can be used to decompress
};
var   DirectImp						DirectImpact;			// Compressed impact info sent from server
var   byte							DirectImpactCount		// Incremented to to inform this attachment of direct impacts
						,			OldDirectImpactCount;	// Used to check on DirectImpactCount changes

//var() bool						bHeavy, bRapidFire, bAltRapidFire; //Old stuff

// These are the settings for a special animation track system. These are used to 'make' animations that meshes don't have...

// This is a single point in a track. It has a rotation offset for the bone and the time which sets where it is in the track
// Bone Rotation Behavior: Pitch: ZBlue to ZRed, Yaw: YGreen to XRed, Roll: YGreen to ZBlue
struct BonePos
{
	var() rotator Offset;
	var() float Time;
};
// A track is a list of offset points associated with a bone
struct BoneTrack
{
	var() Name Bone;
	var() array<BonePos> Points;
};
var() array<BoneTrack> 	SlashTracks;			// The tracks used for a pawn slashing anim
var() array<BoneTrack> 	ThrowTracks;			// The tracks used for a pawn throwing anim
var   float 			TrackStartTime;			// Time when tracks started playing
var   float 			TrackEndTime;			// Time when they will stop
var   bool				bTrackPlaying;			// Track is playing;
var	byte				ActiveTrack;			// Which track of the ones defined is playing
var	byte				TrackNum[3];			// Track numbers, corresponding to firemode input

replication
{
	reliable if (bNetDirty && Role==Role_Authority)
		FireCount, AltFireCount, MeleeFireCount, WallPenetrates, DirectImpact, DirectImpactCount, bIsAimed;
	reliable if (bNetInitial && Role == ROLE_Authority)
		CamoIndex;
}

simulated function PostBeginPlay()
{
	super.PostBeginPlay();

    GenerateModeInfo();
}

//==========================================================
// InitFor
//
// Applies camo on the server
//==========================================================
function InitFor(Inventory BW)
{
	Super.InitFor(BW);

	CamoIndex = BallisticWeapon(BW).CamoIndex;
	ApplyCamo();
}

//==========================================================
// FlaggedForMode
//
// Returns whether an EModeUsed variable applies for the 
// current mode index
//==========================================================
simulated final function bool FlaggedForMode(EModeUsed enum, int mode)
{
    local byte flags;

    mode += 1;
    flags = enum + 1;

    return (flags & mode) == mode;
}

//==========================================================
// GenerateModeInfo
//
// Temporary function to generate mode information 
// for new system
//==========================================================
simulated function GenerateModeInfo()
{
    local int i;

    ModeInfos[0].MuzzleFlashClass = MuzzleFlashClass;
    ModeInfos[1].MuzzleFlashClass = AltMuzzleFlashClass;

    ModeInfos[0].FlashBone = FlashBone;
    ModeInfos[1].FlashBone = AltFlashBone;

    for(i = 0; i < 2; ++i)
    {
        ModeInfos[i].ImpactManager = ImpactManager;
        ModeInfos[i].TracerClass = TracerClass;
        ModeInfos[i].WaterTracerClass = WaterTracerClass;
        ModeInfos[i].TracerChance = TracerChance;
        ModeInfos[i].TracerMix = TracerMix;
        ModeInfos[i].bTrackAnim = FlaggedForMode(TrackAnimMode, i);
        ModeInfos[i].bInstant = FlaggedForMode(InstantMode, i);
        ModeInfos[i].bTracer = FlaggedForMode(TracerMode, i);
        ModeInfos[i].bWaterTracer = FlaggedForMode(WaterTracerMode, i);
        ModeInfos[i].bFlash = FlaggedForMode(FlashMode, i);
        ModeInfos[i].bLight = FlaggedForMode(LightMode, i);
        ModeInfos[i].bBrass = FlaggedForMode(BrassMode, i);

        if (ModeInfos[i].TracerChance < 2 && (level.DetailMode <= DM_High || class'BallisticMod'.default.EffectsDetailMode <= 1))
		    ModeInfos[i].TracerChance *= 0.5;
    }

	// give params opportunity to modify attachment (for tactical tracers)
	// fixme: do all init from fire effect params.
	if (WeaponClass != None)
		WeaponClass.default.ParamsClasses[class'BallisticReplicationInfo'.default.GameStyle].static.SetAttachmentParams(self);
}

//==========================================================
// PostNetBeginPlay
//
// Applies camo on the client
//==========================================================
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	bHeavy = bIsAimed;
	
	if (Role < ROLE_Authority)
		ApplyCamo();
}

simulated function ApplyCamo()
{
	local int i;
	local WeaponCamo WC;
	local Material M;

	// must read the params class
	if (WeaponClass == None)
	{
		log(Name$"::ApplyCamo: No weapon class set - cannot read params to set camo!");
		return;
	}

	if (CamoIndex >= WeaponClass.static.GetParams().default.Camos.Length)
	{
		log(Name$"::ApplyCamo: Camo index out of range: got "$CamoIndex$", length "$WeaponClass.static.GetParams().default.Camos.Length);
		return;
	}

	log(Name$"::ApplyCamo: Camo index "$CamoIndex);

	WC = WeaponClass.static.GetParams().default.Camos[CamoIndex];
	
	for (i = 0; i < WC.WeaponMaterialSwaps.Length; ++i)
	{
		if (WC.WeaponMaterialSwaps[i].AIndex != -1)
		{				
			if (WC.WeaponMaterialSwaps[i].Material == None)
			{
				// Azarael - cache the material to the camo params, to save a DLO every single time
				WC.WeaponMaterialSwaps[i].Material = Material(DynamicLoadObject(WC.WeaponMaterialSwaps[i].MaterialName, class'Material'));

				if (WC.WeaponMaterialSwaps[i].Material == None)
				{
					// Azarael - disable loading this particular entry if it was not found
					log(Name$"::ApplyCamo: Failed dynamically loading material " $WC.WeaponMaterialSwaps[i].MaterialName);

					WC.WeaponMaterialSwaps[i].AIndex = -1;
					continue;
				}
			}

			//log(Name$"::ApplyCamo: Material is " $ WC.WeaponMaterialSwaps[i].Material);
			Skins[WC.WeaponMaterialSwaps[i].AIndex] = WC.WeaponMaterialSwaps[i].Material;
		}
	}
}
	
// If firecount changes, start ThirdPersonEffects()
simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (DirectImpactCount != OldDirectImpactCount)
	{
		DoDirectHit(0, DirectImpact.HitLoc, class'BUtil'.static.ByteToNorm(DirectImpact.HitNorm), DirectImpact.HitSurf);
		OldDirectImpactCount = DirectImpactCount;
	}
	if (FireCount != OldFireCount)
	{
		FiringMode = 0;
		ThirdPersonEffects();
		OldFireCount = FireCount;
	}
	if (AltFireCount != OldAltFireCount)
	{
		FiringMode = 1;
		ThirdPersonEffects();
		OldAltFireCount = AltFireCount;
	}
	if (MeleeFireCount != OldMeleeFireCount)
	{
		FiringMode = 255;
		MeleeFireEffects();
		PlayPawnFiring(FiringMode);
		OldMeleeFireCount = MeleeFireCount;
	}
}
// Called when a weapon is fired to play anims, spawn impacts, brass, tracers, muzzleflashes, lights, etc...
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
		if (Level.DetailMode == DM_SuperHigh)
			EjectBrass(FiringMode);
    }
}

simulated function Vector GetTipLocation()
{
    return GetModeTipLocation(0);
}

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)	
		return Instigator.Weapon.GetEffectStart();

    return GetBoneCoords('tip').Origin;
}

// Return location of brass ejector
simulated function Vector GetEjectorLocation(optional out Rotator EjectorAngle)
{
    local Coords C;
	
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		C = Instigator.Weapon.GetBoneCoords(BrassBone);
	else
		C = GetBoneCoords(BrassBone);

	if (Instigator != None && VSize(C.Origin - Instigator.Location) > 200)
	{
		EjectorAngle = Instigator.Rotation;
		return Instigator.Location;
	}
	EjectorAngle = GetBoneRotation(BrassBone);
    return C.Origin;
}

// Fling out shell casing
simulated function EjectBrass(byte Mode)
{
	local Rotator R;
	if (!class'BallisticMod'.default.bEjectBrass)
		return;
	if (BrassClass == None)
		return;
	if (!ModeInfos[Mode].bBrass)
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	Spawn(BrassClass, self,, GetEjectorLocation(R), R);
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (!ModeInfos[Mode].bInstant)
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

		if (WallPenetrates != 0)
		{
			WallPenetrates = 0;
			DoWallPenetrate(Mode, Start, mHitLocation);	
		}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		// Check for water and spawn splash
		if (ModeInfos[Mode].ImpactManager != None && bDoWaterSplash)
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

	if (level.NetMode != NM_Client && ModeInfos[Mode].ImpactManager != None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ModeInfos[Mode].ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ModeInfos[Mode].ImpactManager != None)
		ModeInfos[Mode].ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function MeleeFireEffects()
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	If ( Level.NetMode == NM_DedicatedServer || Instigator == None || mHitLocation == vect(0,0,0))
		return;

	// Client, trace for hitnormal, hitmaterial and hitactor
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
	if (MeleeImpactManager != None)
		MeleeImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, Instigator);
}

// Play flyby sound effects
simulated function FlyByEffects(byte Mode, Vector HitLoc)
{
	local Vector TipLoc, ViewLoc, PointX, Dir;
	local float DotResult, XDist;

	if (Level.DetailMode < DM_High || !class'BallisticMod'.default.bBulletFlybys || FlyBySound.Sound == None)
		return;
	if (FlyByMode == MU_None || (FlyByMode == MU_Secondary && Mode == 0) || (FlyByMode == MU_Primary && Mode != 0))
		return;

	TipLoc = GetModeTipLocation(Mode);
	if (level.GetLocalPlayerController().ViewTarget != None)
		ViewLoc = level.GetLocalPlayerController().ViewTarget.Location;
	else
		ViewLoc = level.GetLocalPlayerController().Location;

	Dir = Normal(HitLoc-TipLoc);
	// >>> Find PointX which will be the point closest to ViewLoc on the traceline
	DotResult = Dir Dot Normal(ViewLoc-TipLoc);
	if (DotResult < 0)
		return;	// No sound effect if view is back behind where the line starts!
	XDist = DotResult * VSize(ViewLoc-TipLoc);
	PointX = TipLoc + Dir * XDist;
	// <<<
	if (VSize(PointX-ViewLoc) > FlybyRange)
		return;	// View too far from line
	if (XDist < 256 || XDist > VSize(HitLoc-TipLoc) - 128)
		return;	// PointX is not actually on the line!

	FlyBySound.Pitch = 0.85 + 0.3 * FRand();
	class'BCFlyByActor'.static.SoundOff(self, FlyBySound, PointX, XDist/FlyByBulletSpeed);
}


// Find the wall entry and exit 'wounds' and do the effects...
simulated function DoWallPenetrate(byte Mode, vector Start, vector End)
{
	local vector HitLoc, HitNorm;
	local actor Other;
	local int Surf;
	local Material HitMat;

	Other = Trace(HitLoc, HitNorm, End, Start, false,,HitMat);
	if (Other != None)
	{
		if (HitMat == None)Surf = int(Other.SurfaceType); else Surf = int(HitMat.SurfaceType);
		WallPenetrateEffect(Mode, HitLoc, HitNorm, Surf);

		Other = Trace (HitLoc, HitNorm, Start, End, false,,HitMat);
		if (Other != None)
		{
			if (HitMat == None)Surf = int(Other.SurfaceType); else Surf = int(HitMat.SurfaceType);
			WallPenetrateEffect(Mode, HitLoc, HitNorm, Surf, true);
		}
	}
}
// Find the water and spawn a splash...
simulated function DoWaterTrace(int Mode, vector Start, vector End)
{
	local vector HitLoc, HitNorm;
	local actor Other;

	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0)
		return;

	bTraceWater=true;
	Other = Trace (HitLoc, HitNorm, End, Start, true);
	bTraceWater=false;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume && VSize(HitLoc - Start) > 1) )
		ModeInfos[Mode].ImpactManager.static.StartSpawn(HitLoc, Normal(Start - HitLoc), 9, Instigator);
	else
		WaterHitLocation = vect(0,0,0);
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
	if (ModeInfos[Mode].bTracer && ModeInfos[Mode].TracerClass != None &&
		bThisShot && (ModeInfos[Mode].TracerChance >= 1 || FRand() < ModeInfos[Mode].TracerChance))
	{
		if (Dist > 200)
			Tracer = Spawn(ModeInfos[Mode].TracerClass, self, , TipLoc, Rotator(V - TipLoc));
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
// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	local rotator R;

	if (!ModeInfos[Mode].bFlash)
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (bRandomFlashRoll)
		R.Roll = Rand(65536);

	if (Mode != 0 && ModeInfos[1].MuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (AltMuzzleFlash, ModeInfos[1].MuzzleFlashClass, DrawScale*FlashScale, self, ModeInfos[1].FlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(AltFlashBone, R, 0, 1.f);
	}
	else if (Mode == 0 && ModeInfos[Mode].MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, ModeInfos[0].MuzzleFlashClass, DrawScale*FlashScale, self, ModeInfos[0].FlashBone);
		MuzzleFlash.Trigger(self, Instigator);
		if (bRandomFlashRoll)	SetBoneRotation(FlashBone, R, 0, 1.f);
	}
}

function SetAimed(bool bNewAimed)
{
	bIsAimed = bNewAimed;
	if (bIsAimed)
		Instigator.SetAnimAction('Raise');
	else Instigator.SetAnimAction('Lower');
}

function SetBlocked(bool bNewAimed)
{
}

// Play firing anims on pawn holding weapon
simulated function PlayPawnFiring(byte Mode)
{
	if ( xPawn(Instigator) == None )
		return;
	//Do this with a mask maybe? - Azarael
	if (Mode == 255)
		PlayMeleeFiring();
	else if (ModeInfos[Mode].bTrackAnim)
		PlayPawnTrackAnim(Mode);
	else
	{
		if (FiringMode == 0)
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bRapidFire);
		}
		else 
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bAltRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bAltRapidFire);
		}
			SetTimer(WeaponLightTime, false);
	}
}

simulated function PlayMeleeFiring()
{
	if (!Instigator.IsA('BallisticPawn'))
		PlayPawnTrackAnim(TrackNum[2]);
	else Instigator.SetAnimAction('MeleeStrike');
}

// Make a custom, interpolated anim for the pawn holding this weapon using our anim tracks
simulated function PlayPawnTrackAnim(byte Mode)
{
	local int i;
	
	if ( xPawn(Instigator) == None )
		return;
		
	//Reset any existing tracks.
	if (Instigator != None && level.TimeSeconds <= TrackEndTime && TrackNum[Mode] != ActiveTrack)
	{
		for(i=0;i<GetTrackCount(ActiveTrack);i++)
			Instigator.SetBoneRotation(GetTrack(ActiveTrack,i).Bone, rot(0,0,0), 0, 1.0);
	}

	Instigator.PlayAnim(Instigator.IdleWeaponAnim,, 0.2, 1);
	TrackStartTime = level.TimeSeconds;
	ActiveTrack = TrackNum[Mode];
	TrackEndTime = TrackStartTime + GetTrackTime(ActiveTrack);
	bTrackPlaying = true;

	SetTimer(WeaponLightTime, false);
}

// Interpolate all our animation tracks to make custom 'anims' for slashing and stuff...
simulated event Tick (float DT)
{
	local float TrackTime, PreviousTime, NextTime, SegmentTime;
	local Rotator PreviousOffset, NextOffset, NewOffset;
	local int i, j;

	super.Tick(DT);

	if (level.TimeSeconds > TrackEndTime)
	{
		if (!bTrackPlaying)
			return;
		TrackTime = 1.0;
		bTrackPlaying=false;
	}
	else
		TrackTime = (level.TimeSeconds - TrackStartTime) / (TrackEndTime - TrackStartTime);
	for (i=0;i<GetTrackCount(ActiveTrack);i++)
	{
		for (j=0;j<GetTrack(ActiveTrack,i).Points.length;j++)
		{
			if (GetTrack(ActiveTrack,i).Points[j].Time >= TrackTime)
			{
				if (j==0)
				{
					PreviousTime = 0;
					PreviousOffset = rot(0,0,0);
				}
				else
				{
					PreviousTime = GetTrack(ActiveTrack, i).Points[j-1].Time;
					PreviousOffset = GetTrack(ActiveTrack,i).Points[j-1].Offset;
				}
				NextTime = GetTrack(ActiveTrack,i).Points[j].Time;
				NextOffset = GetTrack(ActiveTrack,i).Points[j].Offset;
				SegmentTime = (TrackTime-PreviousTime) / (NextTime-PreviousTime);
				NewOffset = class'BUtil'.static.RSmerp(SegmentTime, PreviousOffset, NextOffset);
				Instigator.SetBoneRotation(GetTrack(ActiveTrack,i).Bone, NewOffset, 0, 1.0);
				break;
			}
		}
	}
}

simulated function float GetTrackTime(byte Mode)
{
	switch(Mode)
	{
		case 2: return 0.5;
		case 1: return 0.8;
		default: return 0.5;
	}
}

simulated function int GetTrackCount(byte Mode)
{
	switch(Mode)
	{
		case 2: return SlashTracks.length;
		case 1: return ThrowTracks.Length;
		default: return SlashTracks.length;
	}
}

simulated function BoneTrack GetTrack(byte Mode, int Index)
{
	switch(Mode)
	{
		case 2: return SlashTracks[Index];
		case 1: return ThrowTracks[Index];
		default: return SlashTracks[Index];
	}
}

// Flash a light when weapon fires
// Either the weapon will flash or this attachment will
simulated function FlashWeaponLight(byte Mode)
{
	if (!ModeInfos[Mode].bLight)
		return;
	if (Instigator == None || Level.bDropDetail || ((Level.TimeSeconds - LastRenderTime > 0.2) && (PlayerController(Instigator.Controller) == None)))
	{
//		Timer();
		return;
	}
	if (Instigator.Weapon != None)
		LightWeapon = Instigator.Weapon;
	else
		LightWeapon = self;

	LightWeapon.bDynamicLight = true;
	SetTimer(WeaponLightTime, false);
}

simulated event Destroyed()
{
	local int i;

	if (Instigator != None && level.TimeSeconds <= TrackEndTime)
	{
		for(i=0;i<GetTrackCount(ActiveTrack);i++)
			Instigator.SetBoneRotation(GetTrack(ActiveTrack,i).Bone, rot(0,0,0), 0, 1.0);
	}

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (AltMuzzleFlash);

	Super.Destroyed();
}

// Stop weapon light flashing after certain amount of time
simulated function Timer()
{
	if (xPawn(Instigator) != None)
		xPawn(Instigator).StopFiring();
	if (LightWeapon != None)
	{
		LightWeapon.bDynamicLight = false;
		LightWeapon = None;
	}
}

function UpdateBlockHit();

// Tell client to do wall penetrate effects and call local ones for listenserver or standalone games
function UpdateWallPenetrate(byte Mode, vector HitLocation, vector HitNormal, int HitSurf, optional bool bExit)
{
	WallPenetrates = Max(WallPenetrates+1, 1);
	WallPenetrateEffect(Mode, HitLocation, HitNormal, HitSurf, bExit);
}
// Spawn some wall penetration effects...
simulated function WallPenetrateEffect(byte Mode, vector HitLocation, vector HitNormal, int HitSurf, optional bool bExit)
{
	if (Level.DetailMode < DM_High || class'BallisticMod'.default.EffectsDetailMode == 0 || level.NetMode == NM_DedicatedServer || ModeInfos[Mode].ImpactManager == None)
		return;
	if (bExit && (Level.DetailMode == DM_High || class'BallisticMod'.default.EffectsDetailMode == 1) )
		return;
	if (bExit)
		ModeInfos[Mode].ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator, 2/*HF_NoSound*/);
	else
		ModeInfos[Mode].ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, instigator);
}

// Update Hit stuff. This just adds the surface info
function BallisticUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf, optional bool bIsAlt, optional vector WaterHitLoc)
{
	mHitSurf = HitSurf;
	WaterHitLocation = WaterHitLoc;
	if (bIsAlt)
		AltUpdateHit(HitActor, HitLocation, HitNormal);
	else
		UpdateHit(HitActor, HitLocation, HitNormal);
}

function UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 0;
	FireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}
function AltUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 1;
	AltFireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	ThirdPersonEffects();
}

function MeleeUpdateHit(Actor HitActor, vector HitLocation, vector HitNormal, int HitSurf)
{
	mHitSurf = HitSurf;
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FiringMode = 255;
	MeleeFireCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	PlayMeleeFiring();
	MeleeFireEffects();
}

simulated function DoDirectHit(byte Mode, vector HitLocation, vector HitNormal, int HitSurf)
{
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None && ModeInfos[Mode].ImpactManager != None)
		ModeInfos[Mode].ImpactManager.static.StartSpawn(HitLocation, HitNormal, HitSurf, Instigator);
}

function UpdateDirectHit (byte Mode, vector HitLocation, vector HitNormal, int HitSurf)
{
    DirectImpact.Mode = Mode;
	DirectImpact.HitLoc  = HitLocation;
	DirectImpact.HitNorm = class'BUtil'.static.NormToByte(HitNormal);
	DirectImpact.HitSurf = HitSurf;
	DirectImpactCount++;
	DoDirectHit(Mode, HitLocation, HitNormal, HitSurf);
}

defaultproperties
{
     bDoWaterSplash=True
     WeaponLightTime=0.150000
     FlashBone="tip"
     AltFlashBone="tip"
     FlashScale=1.000000
     BrassBone="ejector"
     TrackAnimMode=MU_None
     TracerChance=1.000000
     FlyBySound=(Volume=0.500000,Radius=64.000000,Pitch=1.000000)
     FlyByMode=MU_Both
     FlybyRange=384.000000
     FlyByBulletSpeed=8000.000000
     ReloadAnimRate=1.000000
     CockAnimRate=1.000000
	 StaggerRate=1.000000
     IdleHeavyAnim="RifleHip_Idle"
     IdleRifleAnim="RifleAimed_Idle"
     MeleeStrikeAnim="Melee_Stab"
     MeleeAnimRate=1.000000
     SingleFireAnim="RifleHip_Fire"
     SingleAimedFireAnim="RifleAimed_Fire"
     RapidFireAnim="RifleHip_Burst"
     RapidAimedFireAnim="RifleAimed_Burst"
	 ReloadAnim="Reload_AR"
	 CockingAnim="Cock_RearPull"
	 StaggerAnim="Stagger"
     SlashTracks(0)=(Bone="Bip01 R Forearm",Points=(,(offset=(Yaw=-4096),Time=0.300000),(offset=(Yaw=10000),Time=0.400000),(offset=(Yaw=12000),Time=0.600000),(Time=1.000000)))
     SlashTracks(1)=(Bone="Bip01 R UpperArm",Points=(,(offset=(Pitch=-4096,Yaw=-2048,Roll=-8192),Time=0.300000),(offset=(Pitch=8192,Yaw=4096,Roll=-8192),Time=0.600000),(Time=1.000000)))
     SlashTracks(2)=(Bone="Bip01 Spine1",Points=(,(offset=(Yaw=-4096,Roll=-8192),Time=0.300000),(offset=(Yaw=2048,Roll=-8192),Time=0.700000),(Time=1.000000)))
     SlashTracks(3)=(Bone="Bip01 L UpperArm",Points=(,(offset=(Yaw=8192),Time=0.300000),(offset=(Yaw=8192),Time=0.600000),(Time=1.000000)))
     SlashTracks(4)=(Bone="Bip01 R Hand",Points=(,(offset=(Pitch=6000,Yaw=4096,Roll=12000),Time=0.300000),(offset=(Pitch=10000,Yaw=4096,Roll=4096),Time=0.600000),(Time=1.000000)))
     SlashTracks(5)=(Bone="Bip01 Head",Points=(,(offset=(Roll=8192),Time=0.300000),(offset=(Roll=8192),Time=0.700000),(Time=1.000000)))
     ThrowTracks(0)=(Bone="Bip01 R UpperArm",Points=(,(offset=(Pitch=2048,Yaw=8192,Roll=-14000),Time=0.300000),(offset=(Pitch=12000,Yaw=-8192),Time=0.600000),(Time=1.000000)))
     ThrowTracks(1)=(Bone="Bip01 R Forearm",Points=(,(offset=(Yaw=4096),Time=0.300000),(offset=(Yaw=16384),Time=0.600000),(Time=1.000000)))
     ThrowTracks(2)=(Bone="Bip01 Spine1",Points=(,(offset=(Roll=4096),Time=0.300000),(offset=(Yaw=2048,Roll=-12000),Time=0.700000),(Time=1.000000)))
     ThrowTracks(3)=(Bone="Bip01 L UpperArm",Points=(,(offset=(Yaw=8192),Time=0.300000),(offset=(Yaw=8192),Time=0.600000),(Time=1.000000)))
     ThrowTracks(4)=(Bone="Bip01 R Hand",Points=(,(offset=(Pitch=-8192),Time=0.300000),(Time=0.600000),(Time=1.000000)))
     ThrowTracks(5)=(Bone="Bip01 Head",Points=(,(offset=(Roll=-4096),Time=0.300000),(offset=(Roll=12000),Time=0.700000),(Time=1.000000)))
     TrackNum(1)=1
     bNetNotify=True
}

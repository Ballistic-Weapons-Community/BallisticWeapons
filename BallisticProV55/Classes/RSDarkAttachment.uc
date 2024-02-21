//=============================================================================
// RSDarkAttachment.
//
// 3rd person weapon attachment for Nova Staff
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkAttachment extends BallisticAttachment;

var RSNovaStaff	NovaStaff;							// Access to the staff itself (only available to owner)

var actor		FastMuzzleFlash;
var byte		FastFireCount, FastFireCountOld, FlameCount, FlameCountOld;
var RSDarkFlameSpray		Flame;
var RSDarkFireHit FlameHitFX;
struct SingeSpot
{
	var vector	Loc;			// The spot
	var float	Time;			// Time of hit
};
var   array<SingeSpot> SingeSpots;	// To prevent many decals on the same spot (they're pretty expensive!)

var RSDarkSawHitSound Noise;

var bool bRampage;
var   RSDarkHorns	Horns;

replication
{
	reliable if (Role==ROLE_Authority && bNetDirty)
		FastFireCount, FlameCount, bRampage;
}

simulated event PostNetReceive()
{
	if (!Instigator.IsLocallyControlled())
	{
		if (bRampage && Horns == None)
		{
			Horns = spawn(class'RSDarkHorns',Instigator);
			if (Horns != None)
				Instigator.AttachToBone(Horns, 'head');
		}
		else if (!bRampage && Horns != None)
			Horns.Destroy();
	}

	if (FlameCount != FlameCountOld)
	{
		FlameCountOld = FlameCount;
		FlameFireEffects();
	}
	if (FastFireCount != FastFireCountOld)
	{
		FiringMode = 2;
		ThirdPersonEffects();
		FastFireCountOld = FastFireCount;
	}
	super.PostNetReceive();
}

simulated event ThirdPersonEffects()
{
	StopSpray();
    if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		if (FiringMode == 1)
		{
			//Spawn impacts, streaks, etc
			InstantFireEffects(FiringMode);
			//Play pawn anims
			PlayPawnFiring(FiringMode);
//			PlayPawnTrackAnim(FiringMode);
		}
		else if (FiringMode == 2)
		{
			//Flash muzzle flash
			FlashMuzzleFlash (FiringMode);
			//Weapon light
			FlashWeaponLight(FiringMode);
			//Play pawn anims
			PlayPawnFiring(FiringMode);
		}
		else
			super.ThirdPersonEffects();
    }
}

simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode == 0 && AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
			class'RSDarkStar'.static.InitMuzzleFlash (AltMuzzleFlash, AltMuzzleFlashClass, DrawScale*FlashScale, self, AltFlashBone);
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	else if (Mode == 2)
	{
		if (FastMuzzleFlash == None)
			class'RSDarkStar'.static.InitMuzzleFlash (FastMuzzleFlash, class'RSDarkFastMuzzleFlash', DrawScale*FlashScale, self, FlashBone);
		FastMuzzleFlash.Trigger(self, Instigator);
	}

}

simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
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

	if (Noise == None)
		Noise = Spawn(class'RSDarkSawHitSound', Instigator, , Instigator.Location);
	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
	{
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator, 2);//HF_NoSounds);
		Noise.SetNoise(ImpactManager.default.HitSounds[mHitSurf]);
		Noise.SetLocation(WaterHitLocation);
	}
	if (mHitActor == None || (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && Vehicle(mHitActor) == None))
		return;
	if (ImpactManager != None)
	{
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator, 2);//HF_NoSounds);
		Noise.SetNoise(ImpactManager.default.HitSounds[mHitSurf]);
		Noise.SetLocation(HitLocation);
	}
}


function DarkUpdateFlameHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
	mHitNormal = HitNormal;
	mHitActor = HitActor;
	mHitLocation = HitLocation;
	FlameCount++;
	NetUpdateTime = Level.TimeSeconds - 1;
	FlameFireEffects();
}

simulated function FlameFireEffects()
{
	local vector Dir;
	local int i;
	local float HitDelay;

    if ( Level.NetMode == NM_DedicatedServer || Instigator == None)
    	return;

	//Weapon light
	FlashWeaponLight(0);
	//Play pawn anims
	PlayPawnFiring(0);

	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);

	if (Flame == None)
		Flame = Spawn(class'RSDarkFlameSpray',Instigator,,GetModeTipLocation(), rotator(mHitLocation - GetModeTipLocation()));
	if (Instigator.IsFirstPerson())
	{}
//		Flame.bHidden = true;
	else
	{
		Flame.bHidden = false;
		Flame.SetLocation(GetModeTipLocation());
		Flame.SetRotation(Rotator(mHitLocation - Flame.Location));
	}
	Flame.SetFlameRange(VSize(mHitLocation - Flame.Location));
	if (RSDarkStar(Instigator.Weapon) != None)
		RSDarkStar(Instigator.Weapon).Flame = Flame;
	FlyByEffects(0, mHitLocation);

	if (level.NetMode == NM_Client)
	{
		Dir = Normal(mHitLocation - Instigator.Location);
		mHitActor = Trace(mHitLocation, mHitNormal, mHitLocation + Dir * 10, mHitLocation - Dir * 10, false);
	}
	if (mHitActor != None)
	{
		HitDelay = VSize(Instigator.Location - mHitLocation) / 1400;
		if (FlameHitFX == None || FlameHitFX.bLost)
			FlameHitFX = Spawn(class'RSDarkFireHit',,,mHitLocation, rotator(mHitNormal));
		if (FlameHitFX != None)
			FlameHitFX.AddHit(mHitLocation, mHitNormal, level.TimeSeconds + HitDelay);

		for(i=0;i<SingeSpots.length;i++)
			if (SingeSpots[i].Time < level.TimeSeconds - 10)
			{
				SingeSpots.Remove(i,1);
				i--;
			}
			else if (VSize(SingeSpots[i].Loc-mHitLocation) < 128)
				break;
		if (i>=SingeSpots.length)
		{
			i = SingeSpots.length;
			SingeSpots.length = i + 1;
			SingeSpots[i].Loc = mHitLocation;
			SingeSpots[i].Time = level.TimeSeconds;
			class'IM_RSDarkScorch'.static.EvilStartSpawn(mHitLocation, mHitNormal, 0, self, HitDelay);
		}
	}
/*	KillFlameTime = level.TimeSeconds + 0.12;
	if (mHitActor != None)
	{
		i = FlameHits.length;
		FlameHits.length = i + 1;
		FlameHits[i].HitLoc = mHitLocation;
		FlameHits[i].HitNorm = mHitNormal;
		FlameHits[i].HitTime = level.TimeSeconds + VSize(Instigator.Location - mHitLocation) / 3600;
	}
*/
}

simulated function FlashWeaponLight(byte Mode)
{
	if (LightMode == MU_None || (LightMode == MU_Secondary && Mode == 0) || (LightMode == MU_Primary && Mode != 0))
		return;
	if (Instigator == None || Level.bDropDetail || ((Level.TimeSeconds - LastRenderTime > 0.2) && (PlayerController(Instigator.Controller) == None)))
	{
		SetTimer(WeaponLightTime, false);
		return;
	}
	if (Instigator.Weapon != None)
		LightWeapon = Instigator.Weapon;
	else
		LightWeapon = self;

	LightWeapon.bDynamicLight = true;
	SetTimer(WeaponLightTime, false);
}

simulated event Timer()
{
	super.Timer();
	StopSpray();
}

simulated function StopSpray()
{
	if (Flame != None)
	{
		Flame.Kill();
		Flame.bHidden = false;
		Flame = None;
	}

	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
}

function DarkUpdateHit(byte WeaponMode)
{
	if (WeaponMode == 0)
	{
		FiringMode = 0;
		FireCount++;
		NetUpdateTime = Level.TimeSeconds - 1;
		ThirdPersonEffects();
	}
	else if (WeaponMode == 1)
	{
		FiringMode = 2;
		FastFireCount++;
		NetUpdateTime = Level.TimeSeconds - 1;
		ThirdPersonEffects();
	}
}

simulated function Destroyed()
{
	if (Noise != None)
		Noise.Destroy();
	if (Flame != None)
		Flame.Kill();
	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	if (FastMuzzleFlash != None)
		FastMuzzleFlash.Destroy();
	bRampage=false;
	if (Horns != None)
		Horns.Destroy();
	super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'RSDarkStar'
	MuzzleFlashClass=class'RSDarkMuzzleFlame'
	AltMuzzleFlashClass=class'RSDarkSlowMuzzleFlash'
	ImpactManager=class'IM_DarkStarSaw'
	WeaponLightTime=0.200000
	BrassMode=MU_None
	InstantMode=MU_Secondary
	LightMode=MU_Both
	ReloadAnim="Reload_MG"
	MeleeStrikeAnim="RifleHip_Burst"
	ReloadAnimRate=1.700000
	bRapidFire=True
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.TPm_DarkStar'
}

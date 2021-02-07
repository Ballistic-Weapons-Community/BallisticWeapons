//=============================================================================
// CoachGunPrimaryFire.
//
// Individual barrel fire for Coach Gun. Uses 10-gauge shells and has a longer
// barrel than the MRS138 and SKAS-21. Deals superior damage with good range.
// Lengthy reload after each shot balances the gun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class TrenchGunPrimaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor
var() sound						SlugFireSound;
var() class<BCTraceEmitter>		AltTracerClass;	
var() class<BCImpactManager>	AltImpactManager;	
var Name						AimedFireEmptyAnim, FireEmptyAnim, AimedFireSingleAnim, FireSingleAnim;
var() float						ChargeTime, DecayCharge;

var() float						ElectroDamage;

var bool                        FlashSide;

struct Point2
{
	var int X;
	var int Y;
};

var() Point2					ElectroInaccuracy, ElectroDoubleInaccuracy, ExplosiveInaccuracy, ExplosiveDoubleInaccuracy;

//======================================================================
// ApplyDamage
//
// Explosive rounds
//======================================================================

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (BW.CurrentWeaponMode == 0 && Target.bProjTarget)
		BW.TargetedHurtRadius(Damage, 512, class'DT_TrenchGunExplosive', 200, HitLocation, Pawn(Target));
}

//======================================================================
// AnimateFiring
//
// Select different animation depending on ammo and charge
//======================================================================
function AnimateFiring()
{
	if (BW.HasNonMagAmmo(0))
	{
		if (Load >= BW.MagAmmo)
		{
			BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
			
			if (BW.BlendFire())
				BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
		}
		else
		{
			BW.SafePlayAnim(FireSingleAnim, FireAnimRate, TweenTime, ,"FIRE");
			
			if (BW.BlendFire())
				BW.SafePlayAnim(AimedFireSingleAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");			
		}	
	}
	else
	{
		BW.SafePlayAnim(FireEmptyAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())
			BW.SafePlayAnim(AimedFireEmptyAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");			
	}
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	//DebugMessage("ServerPlayFiring");
		
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	AnimateFiring();
}

//Do the spread on the client side
function PlayFiring()
{
	//DebugMessage("PlayFiring");
		
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	AnimateFiring();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

//======================================================================
// SendFireEffect
//
// Send information about double shots to attachment
//======================================================================
simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, ConsumedLoad == 2, WaterHitLoc);
}

//======================================================================
// ImpactEffect
//
// Spawns effects on listen and standalone servers
//======================================================================
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;
	
	//DebugMessage("ImpactEffect: Hit actor:"@Other);

	if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
		ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

	if (!Other.bWorldGeometry && Mover(Other) == None && BallisticShield(Other) == None && Other.bProjTarget)
	{
		Spawn (class'IE_IncMinigunBulletConcrete', ,, HitLocation,);
	}
	else 
	{	
		if (Vehicle(Other) != None)
			Surf = 3;
		else if (HitMat == None)
			Surf = int(Other.SurfaceType);
		else
			Surf = int(HitMat.SurfaceType);

		ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
	}
	
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
	
	return true;
}

simulated function SwitchWeaponMode (byte newMode)
{
	if (newMode == 1) // Electro Mode
	{
		Damage = ElectroDamage;

		PenetrateForce=500;
		bPenetrate=True;

		BallisticFireSound.Sound=SlugFireSound;
		
		TracerClass=AltTracerClass;
		ImpactManager=AltImpactManager;
		
		DamageType=Class'DT_TrenchGunElectro';
		DamageTypeArm=Class'DT_TrenchGunElectro';
		DamageTypeHead=Class'DT_TrenchGunElectro';

        MaxHits=0;
		
		RangeAtten = 1.0; // electrical shots shouldn't be losing damage at range
		
		KickForce=4500;
		
		MaxWaterTraceRange=9000;

        TraceRange.Min = 4096;
        TraceRange.Max = 5120;
		
		TrenchGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(1);
	}
	else // Explosive Mode
	{
		Damage = default.Damage;

		PenetrateForce=0;
		bPenetrate=False;
		
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		
		TracerClass=default.TracerClass;
		ImpactManager=default.ImpactManager;
		
		DamageType=Class'DT_TrenchGunExplosive';
		DamageTypeArm=Class'DT_TrenchGunExplosive';
		DamageTypeHead=Class'DT_TrenchGunExplosive';

        MaxHits = default.MaxHits;
		
		RangeAtten = default.RangeAtten;
		
		KickForce=default.KickForce;
		
		MaxWaterTraceRange=default.MaxWaterTraceRange;
		
		TrenchGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(0);
	}
}

//======================================================================
// Timer
//
// Safety for replication timing issue with integrated reload
//======================================================================
simulated event Timer()
{
	if (Weapon.Role == ROLE_Authority)
	{
		if (BW != None)
			BW.ConsumeMagAmmo(ThisModeNum,ConsumedLoad);
		else
			Weapon.ConsumeAmmo(ThisModeNum,ConsumedLoad);
			
		if (BW.MagAmmo == 0 && BW.HasNonMagAmmo(0))
			BW.bServerReloading = true;
	}
	ConsumedLoad=0;
}

simulated function ModeTick(float DeltaTime)
{
	Super.ModeTick(DeltaTime);
	
	if (!bIsFiring && DecayCharge > 0)
	{
		DecayCharge -= DeltaTime * 2.5;
		
		if (DecayCharge < 0)
			DecayCharge = 0;
	}
}

//======================================================================
// ModeDoFire
//
// Handle Load and ConsumedLoad, as well as empty fire integrated reload
//======================================================================
simulated event ModeDoFire()
{
	//DebugMessage("ModeDoFire: Load:"$Load$" ConsumedLoad:"$ConsumedLoad);
	
	if (!AllowFire())
	{
		HoldTime = 0;	
        return;
	}	

	if (BW != None)
	{
		BW.bPreventReload=true;
		BW.FireCount++;

		if (BW.ReloadState != RS_None)
		{
			if (weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

	if (HoldTime >= ChargeTime && BW.MagAmmo == 2)
	{
		Load = 2;
		SwitchShotParams();
	}

	ConsumedLoad += Load;
	
	SetTimer(FMin(0.1, FireRate/2), false);
	
    // server
    if (Weapon.Role == ROLE_Authority)
    {
		//DebugMessage("DoFireEffect: Load:"$Load$" ConsumedLoad:"$ConsumedLoad);
	
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	else if (!BW.bUseNetAim && !BW.bScopeView)
    	ApplyRecoil();
    
	if (!BW.bScopeView)
		BW.AddFireChaos(FireChaos);

    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    // set the next firing time. must be careful here so client and server do not get out of sync
    if (bFireOnRelease)
    {
        if (bIsFiring)
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

	if (Load == 2)
	{    
		Load = AmmoPerFire;
		SwitchShotParams();
	}
	
	HoldTime = 0;
	
    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }

	if (BW != None)
	{
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, ConsumedLoad);
		
		if (bCockAfterFire || (bCockAfterEmpty && BW.MagAmmo - ConsumedLoad < 1))
			BW.bNeedCock=true;
			
		if (BW.HasNonMagAmmo(0) && BW.MagAmmo <= ConsumedLoad)
		{
			//DebugMessage("EmptyFire reload");

			BW.ReloadState = RS_PreClipOut;
		}
	}
}

//======================================================================
// GetTraceCount
//
// One less trace if double fired, to reduce one-shotting threshold
//======================================================================
function int GetTraceCount(int load)
{
	switch(load)
	{
		case 2: return TraceCount * 2; // - 1;
		case 1: return TraceCount;
		default: return TraceCount;
	}
}

//======================================================================
// DoFireEffect
//
// Send twice if double shot
//======================================================================
function DoFireEffect()
{
	local Vector StartTrace;
	local Rotator R, Aim;
	local int i;

	Aim = GetFireAim(StartTrace);

    if (Level.NetMode == NM_DedicatedServer)
        BW.RewindCollisions();
	
	for (i=0; i < GetTraceCount(Load); i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

    if (Level.NetMode == NM_DedicatedServer)
        BW.RestoreCollisions();

	ApplyHits();
	
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

	Super(BallisticFire).DoFireEffect();
}

//======================================================================
//	DoTrace
//
//	Must initiate impact effects against pawns if in explosive mode
//======================================================================
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				Dist = Min(Dist, MaxWaterTraceRange);
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}

			LastHitLoc = HitLocation;
				
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0, WaterHitLoc);
			
				LastOther = Other;

				if (Vehicle(Other) != None || (BW.CurrentWeaponMode == 0 && Pawn(Other) != None))
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				if (Other.bCanBeDamaged)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0, WaterHitLoc);
					break;
				}
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
}

//======================================================================
// InitEffects
//
// Flash the second barrel as well
//======================================================================
function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local Actor MuzzleSmoke;
	local vector Start, X, Y, Z;
    local int i;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    for (i = 0; i < Load; ++i)
    {
	    if (FlashSide)
        {
            C = Weapon.GetBoneCoords('tip2');
            MuzzleFlash2.Trigger(Weapon, Instigator);
        }

        else
        {
            C = Weapon.GetBoneCoords('tip');
            MuzzleFlash.Trigger(Weapon, Instigator);
        }

        FlashSide = !FlashSide;

        if (class'BallisticMod'.default.bMuzzleSmoke)
        {
            Weapon.GetViewAxes(X,Y,Z);
            Start = C.Origin + X * -180 + Y * 3;
            MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));
        }
    }

	if (!bBrassOnCock)
		EjectBrass();
}

//======================================================================
// SwitchShotParams
//
// Manage double shot parameters
//======================================================================
function SwitchShotParams()
{
	if (Load == 2)
	{
		BallisticFireSound.Volume = 2.0;
		
		if (BW.CurrentWeaponMode == 0)
		{
			XInaccuracy = ExplosiveDoubleInaccuracy.X;
			YInaccuracy = ExplosiveDoubleInaccuracy.Y;
		}

		else
		{
			XInaccuracy = ElectroDoubleInaccuracy.X;
			YInaccuracy = ElectroDoubleInaccuracy.Y;
		}
	}
	else
	{
		BallisticFireSound.Volume = 1.0;
		
		if (BW.CurrentWeaponMode == 0)
		{
			XInaccuracy = ExplosiveInaccuracy.X;
			YInaccuracy = ExplosiveInaccuracy.Y;
		}
		
		if (BW.CurrentWeaponMode == 1)
		{			
			XInaccuracy = ElectroInaccuracy.X;
			YInaccuracy = ElectroInaccuracy.Y;
		}
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	local float AdjustedFireRate;
	
	AdjustedFireRate=0.6;
	
	FS.DamageInt = int(default.Damage * default.TraceCount);

    if (default.RangeAtten < 1f)
	    FS.Damage 		= String(FS.DamageInt) @ "-" @ String(FS.DamageInt * default.RangeAtten);
    else 
        FS.Damage = String(FS.DamageInt);

    FS.HeadMult = default.HeadMult;
    FS.LimbMult = default.LimbMult;

	FS.Damage = String(FS.DamageInt);
	FS.DPS = (default.Damage * default.TraceCount) / AdjustedFireRate;
	FS.TTK = 0.6 * (Ceil(175/FS.DamageInt) - 1);
	if (AdjustedFireRate < 0.5)
		FS.RPM = String(int((1 / AdjustedFireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/AdjustedFireRate@"times/second";
	FS.RPShot = default.FireRecoil;
	FS.RPS = default.FireRecoil / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.RangeOpt = "Max:"@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
	SlugFireSound=Sound'BWBP_OP_Sounds.TechGun.electro_Shot'
	AimedFireEmptyAnim="SightFire"
	FireEmptyAnim="Fire"	
	AimedFireSingleAnim="SightFire"
	FireSingleAnim="Fire"
	ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=2.000000

    CutOffDistance=2048.000000
    CutOffStartRange=1024.000000

	TraceCount=10
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
    ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
	AltTracerClass=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
	AltImpactManager=Class'BWBPRecolorsPro.IM_Supercharge'

	TraceRange=(Min=2048.000000,Max=2560.000000)
	
	WallPenetrationForce=0

	Damage=12.000000
	ElectroDamage=7.000000

    MaxHits=14 // inflict maximum of 156 damage to a single target

	RangeAtten=0.250000
	PenetrateForce=0
	bPenetrate=False
	bFireOnRelease=True
	DamageType=Class'BWBPOtherPackPro.DT_TrenchGunExplosive'
	DamageTypeHead=Class'BWBPOtherPackPro.DT_TrenchGunExplosive'
	DamageTypeArm=Class'BWBPOtherPackPro.DT_TrenchGunExplosive'
	KickForce=3000
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	AimedFireAnim="SightFireCombined"
	FireRecoil=512.000000
	FirePushbackForce=1200.000000
	FireChaos=1.000000

	XInaccuracy=220.000000
	YInaccuracy=220.000000

	ExplosiveInaccuracy=(X=220,Y=220)
	ExplosiveDoubleInaccuracy=(X=512,Y=378)

	ElectroInaccuracy=(X=150,Y=150)
	ElectroDoubleInaccuracy=(X=378,Y=220)
	BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
	FireAnim="FireCombined"
	FireAnimRate=0.800000
	FireRate=0.100000
	AmmoClass=Class'BWBPOtherPackPro.Ammo_TrenchgunShells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}

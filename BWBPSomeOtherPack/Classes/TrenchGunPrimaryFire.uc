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

var() float						ElectroDamageHead, ElectroDamage, ElectroDamageLimb;

simulated function DebugMessage(coerce string message)
{
	if (PlayerController(BW.Instigator.Controller) != None)
	{
		if (BW.Role == ROLE_Authority)
			PlayerController(BW.Instigator.Controller).ClientMessage("SERVER:"@message);
		else
			PlayerController(BW.Instigator.Controller).ClientMessage("CLIENT:"@message);
	}
}

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
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, (BW.CurrentWeaponMode > 0), WaterHitLoc);
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

	if (!Other.bWorldGeometry && Mover(Other) == None && Other.bProjTarget)
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
		DamageHead = ElectroDamageHead;
		DamageLimb = ElectroDamageLimb;

		PenetrateForce=500;
		bPenetrate=True;

		BallisticFireSound.Sound=SlugFireSound;
		
		TracerClass=AltTracerClass;
		ImpactManager=AltImpactManager;
		
		DamageType=Class'DT_TrenchGunElectro';
		DamageTypeArm=Class'DT_TrenchGunElectro';
		DamageTypeHead=Class'DT_TrenchGunElectro';
		
		RangeAtten = 1.0; // electrical shots shouldn't be losing damage at range
		
		KickForce=10000;
	}
	else // Explosive Mode
	{
		Damage = default.Damage;
		DamageHead = default.DamageHead;
		DamageLimb = default.DamageLimb;

		PenetrateForce=0;
		bPenetrate=False;
		
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		
		TracerClass=default.TracerClass;
		ImpactManager=default.ImpactManager;
		
		DamageType=Class'DT_TrenchGunExplosive';
		DamageTypeArm=Class'DT_TrenchGunExplosive';
		DamageTypeHead=Class'DT_TrenchGunExplosive';
		
		RangeAtten = default.RangeAtten;
		
		KickForce=default.KickForce;
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
    	FireRecoil();
    
	if (!BW.bScopeView)
		BW.FireChaos = FClamp(BW.FireChaos + FireChaos, 0, 1);
		
	BW.LastFireTime = Level.TimeSeconds;

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
		case 2: return (default.TraceCount * 2) - 1;
		case 1: return default.TraceCount;
		default: return default.TraceCount;
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
	
	for (i=0; i < GetTraceCount(Load); i++)
	{
		R = Rotator(GetFireSpread() >> Aim);
		DoTrace(StartTrace, R);
	}

	ApplyHits();
	
	// Tell the attachment the aim. It will calculate the rest for the clients
	SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);
	
	if (ConsumedLoad == 2)
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
				Dist *= WaterRangeFactor;
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
	local bool Side;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
		
	Side = TrenchGunAttachment(Weapon.ThirdPersonActor).Side;

	if (Load == 2 || Side)
	{
		C = Weapon.GetBoneCoords('tip2');
		MuzzleFlash2.Trigger(Weapon, Instigator);
	}
	
	if (Load == 2 || !Side)
	{
		C = Weapon.GetBoneCoords('tip');
		MuzzleFlash.Trigger(Weapon, Instigator);
	}

    if (!class'BallisticMod'.default.bMuzzleSmoke)
    	return;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

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
		BallisticFireSound.Volume=2.0;
		
		XInaccuracy = default.XInaccuracy * 4;
		YInaccuracy = default.YInaccuracy * 3;

		if (BW.CurrentWeaponMode == 1)
		{
			DamageType=Class'DT_TrenchGunElectro';
			DamageTypeArm=Class'DT_TrenchGunElectro';
			DamageTypeHead=Class'DT_TrenchGunElectro';	
		}
	}
	else
	{
		BallisticFireSound.Volume=1.0;
		
		if (BW.CurrentWeaponMode == 0)
		{
			XInaccuracy = default.XInaccuracy;
			YInaccuracy = default.YInaccuracy;
		}
		
		if (BW.CurrentWeaponMode == 1)
		{
			DamageType=Class'DT_TrenchGunElectro';
			DamageTypeArm=Class'DT_TrenchGunElectro';
			DamageTypeHead=Class'DT_TrenchGunElectro';	
			
			XInaccuracy=128;
			YInaccuracy=128;
		}
	}
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	local float AdjustedFireRate;
	
	AdjustedFireRate=0.6;
	
	FS.DamageInt = int(default.Damage * default.TraceCount * 2);
	FS.Damage = String(FS.DamageInt);
	FS.DPS = (default.Damage * default.TraceCount) / AdjustedFireRate;
	FS.TTK = 0.6 * (Ceil(175/FS.DamageInt) - 1);
	if (AdjustedFireRate < 0.5)
		FS.RPM = String(int((1 / AdjustedFireRate) * 60))@default.ShotTypeString$"/min";
	else FS.RPM = 1/AdjustedFireRate@"times/second";
	FS.RPShot = default.RecoilPerShot;
	FS.RPS = default.RecoilPerShot / default.FireRate;
	FS.FCPShot = default.FireChaos;
	FS.FCPS = default.FireChaos / default.FireRate;
	FS.Range = "Max:"@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
	SlugFireSound=Sound'BWBPSomeOtherPackSounds.TechGun.electro_Shot'
	AimedFireEmptyAnim="SightFire"
	FireEmptyAnim="Fire"	
	AimedFireSingleAnim="SightFire"
	FireSingleAnim="Fire"
	ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=3.000000
    CutOffDistance=2048.000000
    CutOffStartRange=1280.000000
	MaxSpreadFactor=2
	TraceCount=11
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
	AltTracerClass=Class'BWBPRecolorsPro.TraceEmitter_Supercharge'
	AltImpactManager=Class'BWBPRecolorsPro.IM_Supercharge'
	ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
	TraceRange=(Min=2000.000000,Max=4000.000000)
	
	WallPenetrationForce=0

	Damage=10.000000
	DamageHead=15.000000
	DamageLimb=10.000000

	ElectroDamage=6.000000
	ElectroDamageHead=9.000000
	ElectroDamageLimb=6.000000

	RangeAtten=0.250000
	PenetrateForce=0
	bPenetrate=False
	bFireOnRelease=True
	DamageType=Class'BWBPSomeOtherPack.DT_TrenchGunExplosive'
	DamageTypeHead=Class'BWBPSomeOtherPack.DT_TrenchGunExplosive'
	DamageTypeArm=Class'BWBPSomeOtherPack.DT_TrenchGunExplosive'
	KickForce=3000
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	AimedFireAnim="SightFireCombined"
	RecoilPerShot=512.000000
	VelocityRecoil=1200.000000
	FireChaos=1.000000
	XInaccuracy=192.000000
	YInaccuracy=192.000000
	BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)
	FireAnim="FireCombined"
	FireAnimRate=0.800000
	FireRate=0.100000
	AmmoClass=Class'BWBPSomeOtherPack.Ammo_TrenchgunShells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}

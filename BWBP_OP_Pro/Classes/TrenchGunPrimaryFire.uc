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

// Projectile Vars
var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

var() float						ElectroDamage;

var bool                        FlashSide;

struct Point2
{
	var int X;
	var int Y;
};

var() Point2					ElectroInaccuracy, ElectroDoubleInaccuracy, ExplosiveInaccuracy, ExplosiveDoubleInaccuracy;

// =============================================================================================================================
simulated state Projectile
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ProjectileEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = ProjectileEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
	}

	// Copied from Proj Fire
	function float MaxRange()
	{
		if (ProjectileClass.default.MaxSpeed > ProjectileClass.default.Speed)
		{
			// We know BW projectiles have AccelSpeed
			if (class<BallisticProjectile>(ProjectileClass) != None && class<BallisticProjectile>(ProjectileClass).default.AccelSpeed > 0)
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * 2) * 2);
				else
					return FMin(ProjectileClass.default.MaxSpeed, (ProjectileClass.default.Speed + class<BallisticProjectile>(ProjectileClass).default.AccelSpeed * ProjectileClass.default.LifeSpan) * ProjectileClass.default.LifeSpan);
			}
			// For the rest, just use the max speed
			else
			{
				if (ProjectileClass.default.LifeSpan <= 0)
					return ProjectileClass.default.MaxSpeed * 2;
				else
					return ProjectileClass.default.MaxSpeed * ProjectileClass.default.LifeSpan*0.75;
			}
		}
		else // Hopefully this proj doesn't change speed.
		{
			if (ProjectileClass.default.LifeSpan <= 0)
				return ProjectileClass.default.Speed * 2;
			else
				return ProjectileClass.default.Speed * ProjectileClass.default.LifeSpan;
		}
	}

	// Get aim then spawn projectile
	// Azarael edit: Wall code
	function DoFireEffect()
	{
		local Vector Start, X, Y, Z, End, HitLocation, HitNormal, StartTrace;
		local Rotator Aim;
		local actor Other;

		Weapon.GetViewAxes(X,Y,Z);
		// the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();
		
		StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
		if ( !Weapon.WeaponCentered() )
			StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

		Aim = GetFireAim(StartTrace);
		Aim = Rotator(GetFireSpread() >> Aim);
		
		//wall check
		End = Start + (Vector(Aim) * SpawnOffset.X);
		Other = Weapon.Trace(HitLocation, HitNormal, End, Start, false);
		if (Other != None)
			StartTrace = HitLocation;
		//end wall check

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
		if (Load == 2)
			SpawnProjectile(Start + X*(SpawnOffset.X+1) + Z*SpawnOffset.Z, Aim);
		SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		if (Proj != None)
			Proj.Instigator = Instigator;
	}
}

simulated state ShotgunZap
{

	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ShotgunEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = ShotgunEffectParams(params);

		HipSpreadFactor = effect_params.HipSpreadFactor;
		KickForce=4500;
		MaxWaterTraceRange=9000;
		TrenchGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(1);
	}

	//======================================================================
	// Shotgun-DoFireEffect
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

		// update client's dispersion values before shot
		if (BallisticShotgunAttachment(Weapon.ThirdPersonActor) != None)
		{
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).XInaccuracy = GetXInaccuracy();
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).YInaccuracy = GetYInaccuracy();
		}
		
		// Tell the attachment the aim. It will calculate the rest for the clients
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

		Super(BallisticFire).DoFireEffect();
	}
}

simulated state ShotgunHE
{

	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ShotgunEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = ShotgunEffectParams(params);

		HipSpreadFactor = effect_params.HipSpreadFactor;
		TrenchGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(0);
	}

	//======================================================================
	// Shotgun-DoFireEffect
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

		// update client's dispersion values before shot
		if (BallisticShotgunAttachment(Weapon.ThirdPersonActor) != None)
		{
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).XInaccuracy = GetXInaccuracy();
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).YInaccuracy = GetYInaccuracy();
		}
		
		// Tell the attachment the aim. It will calculate the rest for the clients
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

		Super(BallisticFire).DoFireEffect();
	}


	//======================================================================
	// ApplyDamage
	//
	// Explosive rounds
	//======================================================================

	function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{
		super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
		
		if (Target.bProjTarget)
			BW.TargetedHurtRadius(Damage, 512, class'DT_TrenchGunExplosive', 200, HitLocation, Pawn(Target));
	}
}

simulated state ShotgunIncendiary
{

	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ShotgunEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = ShotgunEffectParams(params);

		HipSpreadFactor = effect_params.HipSpreadFactor;
	}

	function TrenchGunFireControl GetFireControl()
	{
		return TrenchGun(Weapon).GetFireControl();
	}

	//======================================================================
	// ShotgunIncendiary-DoFireEffect
	//
	// Spawn fire bits
	//======================================================================
	function DoFireEffect()
	{
		local Vector Start, Dir, End, HitLocation, HitNormal;
		local Rotator R, Aim;
		local actor Other;
		local float Dist, NodeDist, DR;
		local int i;

		//============================= Instant Hit Bits ====================
		Aim = GetFireAim(Start);
		
		if (Level.NetMode == NM_DedicatedServer)
			BW.RewindCollisions();
		
		//Spawn the damage tracers first
		for (i=0;i<GetTraceCount(Load);i++)
		{
			R = Rotator(GetFireSpread() >> Aim);
			DoTrace(Start, R);
		}
		
		if (Level.NetMode == NM_DedicatedServer)
			BW.RestoreCollisions();
		
		ApplyHits();

		// update client's dispersion values before shot
		if (BallisticShotgunAttachment(Weapon.ThirdPersonActor) != None)
		{
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).XInaccuracy = GetXInaccuracy();
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).YInaccuracy = GetYInaccuracy();
		}

		// argh, no
		
		//============================= Flamey Bits ==========================
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);
		Aim = Rotator(GetFireSpread() >> Aim);

		Dir = Vector(Aim);
		End = Start + (Dir*MaxRange());
		Weapon.bTraceWater=true;
		for (i=0;i<20;i++)
		{
			Other = Trace(HitLocation, HitNormal, End, Start, true);
			if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
				break;
			Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
		}
		Weapon.bTraceWater=false;

		if (Other == None)
			HitLocation = End;
		if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			Other = None;
		
		//Spawn the tracers but also spawn a bunch of fire projectiles
		for (i=0;i<GetTraceCount(Load);i++)
		{
			R = Rotator(GetFireSpread() >> Aim);
			
			if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, R);
			else
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, R);
		}

		Dist = VSize(HitLocation-Start);
		for (i=0;i<GetFireControl().GasNodes.Length;i++)
		{
			if (GetFireControl().GasNodes[i] == None || (RX22AGasCloud(GetFireControl().GasNodes[i]) == None && RX22AGasPatch(GetFireControl().GasNodes[i]) == None && RX22AGasSoak(GetFireControl().GasNodes[i]) == None))
				continue;
			NodeDist = VSize(GetFireControl().GasNodes[i].Location-Start);
			if (NodeDist > Dist)
				continue;
			DR = Dir Dot Normal(GetFireControl().GasNodes[i].Location-Start);
			if (DR < 0.75)
				continue;
			NodeDist = VSize(GetFireControl().GasNodes[i].Location - (Start + Dir * (DR * NodeDist)));
			if (NodeDist < 128)
				GetFireControl().GasNodes[i].TakeDamage(5, Instigator, GetFireControl().GasNodes[i].Location, vect(0,0,0), class'DTRX22ABurned');
		}

		// Tell the attachment the aim. It will calculate the rest for the clients
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, Start, 0);
	
		Super(BallisticFire).DoFireEffect();
	}

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
	
	if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()) > 200 && FRand() < TracerChance)
		Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetModeTipLocation()));
	
	return true;
}

simulated function SwitchWeaponMode (byte newMode)
{
	if (newMode == 1) // Electro Mode
	{
	}
	else // Explosive Mode
	{
		KickForce=default.KickForce;
		MaxWaterTraceRange=default.MaxWaterTraceRange;
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
		BallisticFireSound.Volume = BallisticFireSound.Volume*2;
		XInaccuracy = default.XInaccuracy*2.5;
		YInaccuracy = default.YInaccuracy*1.5;
	}
	else
	{
		BallisticFireSound.Volume = default.BallisticFireSound.Volume;
		XInaccuracy = default.XInaccuracy;
		YInaccuracy = default.YInaccuracy;
	}
}

defaultproperties
{
	SlugFireSound=Sound'BWBP_SKC_Sounds.TechGun.electro_Shot'
	AimedFireEmptyAnim="SightFire"
	FireEmptyAnim="Fire"	
	AimedFireSingleAnim="SightFire"
	FireSingleAnim="Fire"
	ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=2.000000
    ProjectileClass=Class'BWBP_SKC_Pro.BulldogRocket'
    SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
	TraceCount=10
	TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
    ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
	AltTracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
	AltImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'

	TraceRange=(Min=2048.000000,Max=2560.000000)
	
	WallPenetrationForce=0

	Damage=12.000000
	ElectroDamage=7.000000

    MaxHits=14 // inflict maximum of 156 damage to a single target

	RangeAtten=0.250000
	PenetrateForce=0
	bPenetrate=False
	bFireOnRelease=True
	DamageType=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
	DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
	DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
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
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)
	FireAnim="FireCombined"
	FireAnimRate=0.800000
	FireRate=0.100000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_TrenchgunShells'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.00)
	ShakeOffsetRate=(X=-160.00)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}

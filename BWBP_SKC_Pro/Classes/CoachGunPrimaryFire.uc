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
class CoachGunPrimaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor
var Name						AimedFireEmptyAnim, FireEmptyAnim, AimedFireSingleAnim, FireSingleAnim, FireLoadingAnim, AimedFireLoadingAnim;
var() float						ChargeTime, DecayCharge;

const SHOT_AMMO = 0;
const SLUG_AMMO = 1;
const ZAP_AMMO = 2;
const FLAME_AMMO = 3;
const HE_AMMO = 4;
const FRAG_AMMO = 5;

var bool                        FlashSide;

// Projectile Vars
var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor


// =============================================================================================================================
simulated state Projectile
{
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local GrenadeEffectParams effect_params;

		super(BallisticFire).ApplyFireEffectParams(params);

		effect_params = GrenadeEffectParams(params);

		ProjectileClass =  effect_params.ProjectileClass;
		SpawnOffset = effect_params.SpawnOffset;    
		default.ProjectileClass =  effect_params.ProjectileClass;
		default.SpawnOffset = effect_params.SpawnOffset;
		if (CoachGunAttachment(Weapon.ThirdPersonActor) != None)
			CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(FRAG_AMMO);
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
		if (CoachGunAttachment(Weapon.ThirdPersonActor) != None)
			CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(ZAP_AMMO);
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
		if (CoachGunAttachment(Weapon.ThirdPersonActor) != None)
			CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(HE_AMMO);
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


		// update client's dispersion values before shot
		if (BallisticShotgunAttachment(Weapon.ThirdPersonActor) != None)
		{
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).XInaccuracy = GetXInaccuracy();
			BallisticShotgunAttachment(Weapon.ThirdPersonActor).YInaccuracy = GetYInaccuracy();
		}
		
		// Tell the attachment the aim. It will calculate the rest for the clients
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, StartTrace, 0);

		Super(BallisticFire).DoFireEffect();
		
		//Moving to the end in case we kill ourselves with apply damage
		ApplyHits();
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
			BW.TargetedHurtRadius(Damage, 512, class'DT_CoachGunExplosive', 200, HitLocation, Pawn(Target));
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
		if (CoachGunAttachment(Weapon.ThirdPersonActor) != None)
			CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(FLAME_AMMO);
	}

	function CoachGunFireControl GetFireControl()
	{
		return CoachGun(Weapon).GetFireControl();
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
// Select different animation depending on ammo and weapon params
//======================================================================
function AnimateFiring()
{
	if (BW.HasNonMagAmmo(0) && CoachGun(BW).bQuickLoad) //if we have ammo and are a quickloader, play fire reload anim
	{        
		if (Load >= BW.MagAmmo)
		{
			BW.SafePlayAnim(FireLoadingAnim, FireAnimRate, TweenTime, ,"FIRE");
			
			if (BW.BlendFire())
				BW.SafePlayAnim(AimedFireLoadingAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
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
		if (Load >= 2)
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

	CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(newMode);

    SwitchShotParams();
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
			
		if (BW.MagAmmo == 0 && BW.HasNonMagAmmo(0) && CoachGun(BW).bQuickLoad)
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
	//if (class'BallisticReplicationInfo'.static.IsClassicOrRealism())
	//{
		if (BW.MagAmmo == 1)
		{
			Load=1;
			BW.BFireMode[1].ModeDoFire();
			return;
		}
		//else
		//{
		//	Load=2;
		//	super.ModeDoFire();
		//}
		//return;
	//}
	
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
			if (Weapon.Role == ROLE_Authority)
				BW.bServerReloading=false;
			BW.ReloadState = RS_None;
		}
	}

	if (/*HoldTime >= ChargeTime && */BW.MagAmmo >= 2)
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
			
		if (CoachGun(BW).bQuickLoad && BW.HasNonMagAmmo(0) && BW.MagAmmo <= ConsumedLoad)
		{
			//DebugMessage("EmptyFire reload");

			BW.ReloadState = RS_PreClipOut;
		}
	}
	
}

//======================================================================
// GetTraceCount
//======================================================================
function int GetTraceCount(int load)
{
	switch(load)
	{
		case 2: return TraceCount * 2;
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
		BallisticFireSound.Volume = default.BallisticFireSound.Volume*2;
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
	FireLoadingAnim="FireCombined"
	AimedFireLoadingAnim="SightFireCombined"
		
	FireEmptyAnim="Fire"
	AimedFireEmptyAnim="Fire"

    FireAnim="Fire"
    AimedFireAnim="Fire"

    FireSingleAnim="SightFire"
    AimedFireSingleAnim="SightFire"

    ChargeTime=0.35
	MaxHoldTime=0.0
	HipSpreadFactor=2.5

	TraceCount=10
	TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
	ImpactManager=Class'BallisticProV55.IM_Shell'

	TraceRange=(Min=2560.000000,Max=3072.000000)

	WallPenetrationForce=0

    MaxHits=14 // inflict maximum of 156 damage to a single target
	RangeAtten=0.250000
    PenetrateForce=0
	bPenetrate=False
	bFireOnRelease=False
	DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
	KickForce=500
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=1.500000
	BrassBone="EjectorR"
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	FireRecoil=768.000000
	FirePushbackForce=250.000000
	FireChaos=1.000000

	XInaccuracy=220.000000
	YInaccuracy=220.000000

	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)
	FireAnimRate=1.35
	FireRate=0.300000
	AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'

	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-12.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	
	BotRefireRate=0.60000
	WarnTargetPct=0.500000
}

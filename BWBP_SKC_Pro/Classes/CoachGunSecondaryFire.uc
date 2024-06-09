//=============================================================================
// M290SecondaryFire.
//
// Individual barrel fire for M290. Smaller spread than primary and wastes less
// ammo, but does less damage. The two individual barrels can be fired
// seperately before the gun needs to be cocked again.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CoachGunSecondaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor

// Projectile Vars
var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

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

simulated state ShotgunHE
{

	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ShotgunEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = ShotgunEffectParams(params);

		HipSpreadFactor = effect_params.HipSpreadFactor;
		CoachGunAttachment(Weapon.ThirdPersonActor).SwitchWeaponMode(0);
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
		
		for (i=0; i < TraceCount; i++)
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
		for (i=0;i<TraceCount;i++)
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
		for (i=0;i<TraceCount;i++)
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

event ModeDoFire()
{
	if (AllowFire())
	{
		if (!CoachGun(Weapon).bLeftLoaded)
		{
			CoachGun(Weapon).bRightLoaded=false;
			FireAnim='SightFire';
			AimedFireAnim='SightFire';
		}
		else
		{
			CoachGun(Weapon).bLeftLoaded=false;
			FireAnim='SightFire';
			AimedFireAnim='SightFire';
		}
	}
	super.ModeDoFire();
}
simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, CoachGun(Weapon).bRightLoaded, WaterHitLoc);
}

function EjectBrass()
{
	BrassBone='EjectorL';
	BrassClass=Class'Brass_M290Left';
	super.EjectBrass();
	BrassBone='EjectorR';
	BrassClass=Class'Brass_M290Right';
	super.EjectBrass();
}

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

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (!CoachGun(Weapon).bRightLoaded && MuzzleFlash2 != None)
    {
		C = Weapon.GetBoneCoords('tip2');
        MuzzleFlash2.Trigger(Weapon, Instigator);
    }
    else if (MuzzleFlash != None)
    {
		C = Weapon.GetBoneCoords('tip');
        MuzzleFlash.Trigger(Weapon, Instigator);
    }
    if (!class'BallisticMod'.default.bMuzzleSmoke)
    	return;
    Weapon.GetViewAxes(X,Y,Z);
//	Start = C.Origin + C.XAxis * -80 + C.YAxis * 3 + C.ZAxis * 0;
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

	if (!bBrassOnCock)
		EjectBrass();
}

defaultproperties
{
	HipSpreadFactor=1
	TraceCount=10
	TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
	ImpactManager=Class'BallisticProV55.IM_Shell'
	TraceRange=(Min=2560.000000,Max=2560.000000)
	DamageType=Class'BWBP_SKC_Pro.DT_CoachShot'
	DamageTypeHead=Class'BWBP_SKC_Pro.DT_CoachShot'
	DamageTypeArm=Class'BWBP_SKC_Pro.DT_CoachShot'
	KickForce=600
	PenetrateForce=100
	bPenetrate=True
	bCockAfterFire=False
	MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
	FlashScaleFactor=2
	BrassClass=Class'BallisticProV55.Brass_M290Left'
	BrassBone="EjectorR"
	bBrassOnCock=True
	BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
	FireRecoil=768.000000
	FirePushbackForce=600.000000
	FireChaos=0.250000
	XInaccuracy=256.000000
	YInaccuracy=256.000000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Redwood.Redwood-Fire',Volume=1.200000)
	FireAnim="SightFire"
	FireRate=0.400000
	AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-12.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000

	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.7
	WarnTargetPct=0.5
}

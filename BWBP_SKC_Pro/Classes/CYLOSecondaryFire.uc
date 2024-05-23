//=============================================================================
// CYLOSecondaryFire.
//
// State 0: A semi-auto shotgun that uses its own magazine.
// State 1: A semi-auto fire shotgun that uses its own magazine.
// State 2: A semi-auto HE shell launcher.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOSecondaryFire extends BallisticProShotgunFire;

var() Vector			SpawnOffset;		// Projectile spawned at this offset
var	  Projectile		Proj;				// The projectile actor

function CYLOFirestormFireControl GetFireControl()
{
	return CYLOUAW(Weapon).GetFireControl();
}

simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (CYLOUAW(Weapon).SGShells < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		if (bDryUncock)
			CYLOUAW(BW).bAltNeedCock=true;
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
	else if (CYLOUAW(BW).bAltNeedCock)
		return false;
    return true;
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	Super.ModeDoFire();
    CYLOUAW(Weapon).SGShells--;
	if (Weapon.Role == ROLE_Authority && CYLOUAW(Weapon).SGShells == 0)
		CYLOUAW(BW).bAltNeedCock = true;
}

simulated state FireShot
{
	
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local ShotgunEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = ShotgunEffectParams(params);

		TraceCount = effect_params.TraceCount;
		TracerClass = effect_params.TracerClass;
		ImpactManager = effect_params.ImpactManager;
		MaxHits = effect_params.MaxHits;    
		default.TraceCount = effect_params.TraceCount;
		default.TracerClass = effect_params.TracerClass;
		default.ImpactManager = effect_params.ImpactManager;
		default.MaxHits = effect_params.MaxHits;
	}
	
	// Get aim then run several individual traces using different spread for each one
	function DoFireEffect()
	{
		local Vector Start, Dir, End, HitLocation, HitNormal;
		local Rotator R, Aim;
		local actor Other;
		local float Dist, NodeDist, DR;
		local int i;

		// the to-hit trace always starts right in front of the eye
		Start = Instigator.Location + Instigator.EyePosition();
		Aim = GetFireAim(Start);

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

		if (Level.NetMode == NM_DedicatedServer)
			BW.RewindCollisions();

		for (i=0;i<TraceCount;i++)
		{
			R = Rotator(GetFireSpread() >> Aim);
			DoTrace(Start, R);
			
			if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, R);
			else
				GetFireControl().FireShotRotated(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, R);
		}

		if (Level.NetMode == NM_DedicatedServer)
			BW.RestoreCollisions();

		ApplyHits();
		
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
				GetFireControl().GasNodes[i].TakeDamage(5, Instigator, GetFireControl().GasNodes[i].Location, vect(0,0,0), class'DT_CYLOFirestormShotgun');
		}
		
		SendFireEffect(none, Vector(Aim)*TraceRange.Max, Start, 0);

		Super(BallisticFire).DoFireEffect();
	}

	// Even if we hit nothing, this is already taken care of in DoFireEffects()...
	function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
	{
		local Vector V;

		V = Instigator.Location + Instigator.EyePosition() + Dir * TraceRange.Min;
		if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
			Spawn(TracerClass, instigator, , BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation(), Rotator(V - BallisticAttachment(Instigator.Weapon.ThirdPersonActor).GetTipLocation()));
		if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
			ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);
	}

	// Spawn the impact effects here for StandAlone and ListenServers cause the attachment won't do it
	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		local int Surf;

		if (ImpactManager != None && WaterHitLoc != vect(0,0,0) && Weapon.EffectIsRelevant(WaterHitLoc,false) && bDoWaterSplash)
			ImpactManager.static.StartSpawn(WaterHitLoc, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLoc), 9, Instigator);

		if (!Other.bWorldGeometry && Mover(Other) == None)
			return false;

		if (!bAISilent)
			Instigator.MakeNoise(1.0);
		if (ImpactManager != None && Weapon.EffectIsRelevant(HitLocation,false))
		{
			if (Vehicle(Other) != None)
				Surf = 3;
			else if (HitMat == None)
				Surf = int(Other.SurfaceType);
			else
				Surf = int(HitMat.SurfaceType);
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, Surf, instigator);
			if (TracerClass != None && Level.DetailMode > DM_Low && class'BallisticMod'.default.EffectsDetailMode > 0 && VSize(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()) > 200 && FRand() < TracerChance)
				Spawn(TracerClass, instigator, , BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation(), Rotator(HitLocation - BallisticAttachment(Weapon.ThirdPersonActor).GetTipLocation()));
		}
		Weapon.HurtRadius(1, 128, DamageType, 1, HitLocation);
		return true;
	}

}

simulated state HESlug
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
	
	// Became complicated when acceleration came into the picture
	// Override for even wierder situations
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
	function DoFireEffect()
	{
		local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
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

		End = Start + (Vector(Aim)*MaxRange());
		Other = Trace (HitLocation, HitNormal, End, Start, true);

		if (Other != None)
			Aim = Rotator(HitLocation-StartTrace);
	    SpawnProjectile(StartTrace, Aim);

		SendFireEffect(none, vect(0,0,0), StartTrace, 0);
		// Skip the instant fire version which would cause instant trace damage.
		Super(BallisticFire).DoFireEffect();
	}

	function SpawnProjectile (Vector Start, Rotator Dir)
	{
		Proj = Spawn (ProjectileClass,,, Start, Dir);
		Proj.Instigator = Instigator;
	}
}

defaultproperties
{
	//shotgun
     TraceCount=9
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=5000.000000,Max=5000.000000)
     DamageType=Class'BWBP_SKC_Pro.DTCYLOShotgun'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOShotgunHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOShotgun'
     KickForce=400
     PenetrateForce=100
     bPenetrate=True
	 
	 //Proj
     ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
     SpawnOffset=(Y=20.000000,Z=-20.000000)
	 
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashBone="Muzzle2"
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     FireRecoil=512.000000
     FirePushbackForce=150.000000
     FireChaos=0.500000
     XInaccuracy=350.000000
     YInaccuracy=350.000000
     JamSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.900000)
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FireSG',Volume=1.300000,Radius=256.000000)
     //bWaitForRelease=True
     FireAnim="FireSG"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLOSG'
     AmmoPerFire=0
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-12.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.500000
}

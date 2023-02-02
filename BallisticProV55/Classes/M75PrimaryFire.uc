//=============================================================================
// M75PrimaryFire.
//
// Slow, powerful Railgun fire for the M75. Power of the shot varies depending
// on how long the weapon has been left to charge. Charge affects Damage, Kick
// Trail intensity and how far it can fire through walls.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75PrimaryFire extends BallisticRailgunFire;

const 				MAX_RAIL_POWER = 1.0f; // charges in 2 seconds, 0.6s hold time grace
var   float RailPower;
	
simulated state ClassicRail
{
	simulated event ModeDoFire()
	{
		Damage 					= default.Damage					* RailPower;
		WallPenetrationForce 	= default.WallPenetrationForce * 0.2 + (default.WallPenetrationForce * 0.8 * RailPower);
		PenetrateForce 			= default.PenetrateForce 		 	* RailPower;
		KickForce 				= default.KickForce 				* RailPower;
		FireRecoil 			    = default.FireRecoil 			    * RailPower;

		Super.ModeDoFire();

		RailPower = 0.0;
		
		Weapon.ThirdPersonActor.SoundPitch =  32;
		Weapon.ThirdPersonActor.SoundVolume =  64;
		Weapon.ThirdPersonActor.SoundRadius = 128;
	}

	simulated function ModeTick(float DT)
	{
		Super.ModeTick(DT);

		Weapon.ThirdPersonActor.SoundPitch = 32 + RailPower * 12;
		RailPower = FMin(1.0, RailPower + 0.1666*DT);
	}
	simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
	{
		M75Attachment(Weapon.ThirdPersonActor).RailPower = 255*RailPower;
		super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	}

	simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
	{
		Weapon.HurtRadius(60.0*RailPower, 48+48.0*RailPower, DamageType, 25000, HitLocation);
		return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	}

	function WallEnterEffect (vector HitLocation, vector HitNormal, vector X, actor other, Material HitMat)
	{
		Weapon.HurtRadius(60.0*RailPower, 48+48.0*RailPower, DamageType, 25000, HitLocation);
		super.WallEnterEffect(HitLocation, HitNormal, X, other, HitMat);
	}
	
	simulated function ApplyFireEffectParams(FireEffectParams params)
	{
		local InstantEffectParams effect_params;

		super.ApplyFireEffectParams(params);

		effect_params = InstantEffectParams(params);

		TraceRange = effect_params.TraceRange;             // Maximum range of this shot type
		MaxWaterTraceRange = effect_params.WaterTraceRange;        // Maximum range through water
		// FIXME - CutOffStartRange
		RangeAtten = effect_params.RangeAtten;        // Interpolation curve for damage reduction over range

		default.Damage = effect_params.Damage;
		HeadMult = effect_params.HeadMult;
		LimbMult = effect_params.LimbMult;

		DamageType = effect_params.DamageType;
		DamageTypeHead = effect_params.DamageTypeHead;	
		DamageTypeArm = effect_params.DamageTypeArm;
		bUseRunningDamage = effect_params.UseRunningDamage;
		RunningSpeedThresh = effect_params.RunningSpeedThreshold;

		default.WallPenetrationForce = effect_params.PenetrationEnergy;
		default.PenetrateForce = effect_params.PenetrateForce;
		default.FireRecoil              = effect_params.Recoil;
		bPenetrate = effect_params.bPenetrate;

		// Note - Deprecate these two
		PDamageFactor = effect_params.PDamageFactor;		    // Damage multiplied by this with each penetration
		WallPDamageFactor = effect_params.WallPDamageFactor;		// Damage multiplied by this for each wall penetration

		HookStopFactor = effect_params.HookStopFactor;	
		HookPullForce = effect_params.HookPullForce;
	}

}

//FullChargedRail - Stronger, only fires at max charge
simulated state FullChargedRail
{
	simulated event ModeDoFire()
	{
		if (!AllowFire())
			return;

		if (RailPower >= MAX_RAIL_POWER)
		{
			PenetrateForce = default.PenetrateForce * RailPower;
			WallPenetrationForce = default.WallPenetrationForce * RailPower;
			
			KickForce = default.KickForce * RailPower;
			FireRecoil = default.FireRecoil * RailPower;
			FirePushbackForce = default.FirePushbackForce * RailPower;
			BW.RcComponent.DeclineTime = BW.RcComponent.default.DeclineTime * RailPower;
			BW.RcComponent.DeclineDelay = BW.RcComponent.default.DeclineDelay * RailPower;
			
			BallisticFireSound.Volume=0.6 + RailPower * 0.8;
			BallisticFireSound.Radius=(280.0+RailPower*350.0);
			super.ModeDoFire();
		}

		RailPower = 0;
		Weapon.ThirdPersonActor.SoundPitch =  32 + RailPower * 12;
	}

	simulated function ModeTick(float DeltaTime)
	{	
		if (bIsFiring)
		{
			RailPower = FMin(MAX_RAIL_POWER, RailPower + 1.0 * DeltaTime);

			if (RailPower >= MAX_RAIL_POWER)
				bIsFiring = false;
		}
		
		else if (RailPower > 0)
			RailPower = FMax(0, RailPower - DeltaTime);
			
		Super.ModeTick(DeltaTime);
		
		if (RailPower > 0 && RailPower <= 1.0f)
		{
			Weapon.ThirdPersonActor.SoundPitch =  32 + RailPower * 12;
			//Weapon.SoundPitch = 32 + RailPower * 12;
			
			Weapon.ThirdPersonActor.SoundVolume =  64 + 190 * RailPower;
			//Weapon.SoundVolume = 64 + 190 * RailPower;
			
			Weapon.ThirdPersonActor.SoundRadius = 128 + 768 * RailPower;
		}
	}

	simulated function SendFireEffect(Actor Other, Vector HitLocation, Vector HitNormal, int Surf, optional Vector WaterHitLoc)
	{
		M75Attachment(Weapon.ThirdPersonActor).RailPower = 255 * FMin(RailPower, 1.0f);
		super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	}

	simulated function bool ImpactEffect(Vector HitLocation, Vector HitNormal, Material HitMat, Actor Other, optional Vector WaterHitLoc)
	{
		BallisticWeapon(Weapon).TargetedHurtRadius(80.0*FMin(RailPower, 1.0f), 64+64.0*FMin(RailPower, 1.0f), DamageType, 4000, HitLocation, Pawn(Other));
		return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
	}

	function WallEnterEffect (Vector HitLocation, Vector HitNormal, Vector X, Actor other, Material HitMat)
	{
		BallisticWeapon(Weapon).TargetedHurtRadius(80.0*FMin(RailPower, 1.0f), 64+64.0*FMin(RailPower, 1.0f), DamageType, 4000, HitLocation, Pawn(Other));
		super.WallEnterEffect(HitLocation, HitNormal, X, other, HitMat);
	}
}

simulated state ChargedRail
{
	simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
	{
		M75Attachment(Weapon.ThirdPersonActor).RailPower = 64;
		super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	}
}

defaultproperties
{
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=128.000000
     
	 bCockAfterFire=True
	 
     Damage=80.000000
     HeadMult=1.5f
     LimbMult=0.9f
     
     DamageType=Class'BallisticProV55.DTM75Railgun'
     DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
     DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
     KickForce=10000
     PenetrateForce=500
     bPenetrate=True
     PDamageFactor=0.700000
     MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
     FlashScaleFactor=0.750000
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     BrassOffset=(X=-33.000000,Y=-4.000000,Z=-4.000000)
     FireRecoil=768.000000
     FirePushbackForce=350.000000
     FireChaos=0.750000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Volume=0.750000,Radius=384.000000)
     FireEndAnim="'"
     FireRate=1.500000
     AmmoClass=Class'BallisticProV55.Ammo_20mmRailgun'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
     WarnTargetPct=0.75
	 
     aimerror=800.000000
}

class SRKSmgWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		RangeAtten=0.900000
		Damage=26
		HeadMult=2.0f
        LimbMult=0.75f
		DamageType=Class'BWBP_APC_Pro.DTSRKSmg'
		DamageTypeHead=Class'BWBP_APC_Pro.DTSRKSmgHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTSRKSmg'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.SRKS.SRKS-Fire')
		Recoil=128.000000
		Chaos=0.040000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.110000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=0.800000
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.SHADRACHRifleGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=65
		DamageRadius=320.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.SRKSmgAltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.600000
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireSight"			
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.0900
		DeclineTime=1.00000
		DeclineDelay=0.400000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=16,Max=128)
		ChaosDeclineTime=1.25
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=0.850000
		MagAmmo=36
        InventorySize=4
		SightingTime=0.200000
		SightOffset=(X=0.000000,Y=-0.350000,Z=15.800000)
		ViewOffset=(X=5.000000,Y=6.000000,Z=-14.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}
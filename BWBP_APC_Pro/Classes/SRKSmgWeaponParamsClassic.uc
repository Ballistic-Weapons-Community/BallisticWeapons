// Long live the PK2000!
class SRKSmgWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Burst
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryBurstEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000) //.45
		WaterTraceRange=7200.0
		RangeAtten=0.900000
		Damage=30
		DamageType=Class'BWBP_APC_Pro.DTSRKSmg'
		DamageTypeHead=Class'BWBP_APC_Pro.DTSRKSmgHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTSRKSmg'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PK2000.PK2000-Fire',Volume=1.200000)
		Recoil=256.000000
		Chaos=0.250000
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireBurstParams
		FireInterval=0.070000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=1.000000
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryBurstEffectParams'
	End Object
	
	//Auto
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000) //.45
		WaterTraceRange=7200.0
		RangeAtten=0.900000
		Damage=30
		DamageType=Class'BWBP_APC_Pro.DTSRKSmg'
		DamageTypeHead=Class'BWBP_APC_Pro.DTSRKSmgHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTSRKSmg'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MRDRFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.PK2000.PK2000-Fire',Volume=1.200000)
		Recoil=128.000000
		Chaos=0.150000
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.160000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=0.800000
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.600000
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireSight"			
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.05
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.1
		XRandFactor=0.3500
		YRandFactor=0.3500
		DeclineTime=0.60000
		DeclineDelay=0.100000
		CrouchMultiplier=0.800000
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpOffSet=(Pitch=1000,Yaw=-500)
		JumpChaos=0.250000
		AimAdjustTime=0.550000
		AimSpread=(Min=36,Max=2048)
		ChaosDeclineTime=0.5
		ViewBindFactor=0.05
		ChaosSpeedThreshold=1200.000000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.7
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		bNeedCock=True
		MagAmmo=24
        InventorySize=12
		SightingTime=0.200000
		SightOffset=(X=-20.000000,Y=-0.350000,Z=15.800000)
		ViewOffset=(X=10.000000,Y=6.000000,Z=-12.000000)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireBurstParams'
		FireParams(2)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
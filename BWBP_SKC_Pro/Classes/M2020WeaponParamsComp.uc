class M2020WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Recharge
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaRechargeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=50
        HeadMult=1.75f
        LimbMult=0.85f
		PenetrationEnergy=64
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		PushbackForce=120.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		Recoil=320.000000
		Chaos=0.600000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaRechargeFireParams
		FireInterval=0.325000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaRechargeEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Power
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaPowerEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=95
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		PenetrationEnergy=96
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.600000
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaPowerFireParams
		FireAnim="FirePowered"
		FireInterval=1.000000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPowerEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaOfflineEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=34
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		PenetrationEnergy=48
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=150.000000
		Chaos=0.050000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaOfflineFireParams
		FireAnim="FireUnPowered"
		FireInterval=0.200000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaOfflineEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRechargeRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.550000
		CrouchMultiplier=0.650000
	End Object

	Begin Object Class=RecoilParams Name=ArenaPowerRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		DeclineDelay=1.1
		CrouchMultiplier=0.650000
	End Object

	Begin Object Class=RecoilParams Name=ArenaOfflineRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0500000
		YRandFactor=0.0500000
		DeclineDelay=0.3
		CrouchMultiplier=0.650000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1536)
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(Y=12.000000,Z=-12.000000)
		SightOffset=(Y=-3.000000,Z=18.000000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.8
		SightingTime=0.500000		
		DisplaceDurationMult=1
		MagAmmo=10
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ArenaRechargeRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaPowerRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaOfflineRecoilParams'
		RecoilParams(3)=RecoilParams'ArenaOfflineRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaRechargeFireParams'
		FireParams(1)=FireParams'ArenaPowerFireParams'
		FireParams(2)=FireParams'ArenaOfflineFireParams'
		FireParams(3)=FireParams'ArenaOfflineFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
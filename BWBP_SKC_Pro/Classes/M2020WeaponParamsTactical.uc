class M2020WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Recharge
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalRechargeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=70
        HeadMult=2f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=64
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		PushbackForce=120.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		Recoil=320.000000
		Chaos=0.600000
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalRechargeFireParams
		FireInterval=0.8000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalRechargeEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Power
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalPowerEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=1.5f
        LimbMult=0.75f
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
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalPowerFireParams
		FireAnim="FirePowered"
		FireInterval=1.500000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPowerEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalOfflineEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=40
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=48
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=150.000000
		Chaos=0.050000
		BotRefireRate=0.5
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalOfflineFireParams
		FireAnim="FireUnPowered"
		FireInterval=0.400000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalOfflineEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRechargeRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		ClimbTime=0.06
		DeclineDelay=0.5
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=RecoilParams Name=TacticalPowerRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.45
		YRandFactor=0.45
		ClimbTime=0.1
		DeclineDelay=0.7
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=2
		MaxMoveMultiplier=3
	End Object

	Begin Object Class=RecoilParams Name=TacticalOfflineRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2560)
		AimAdjustTime=0.5
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=26,Y=-2.500000,Z=18.000000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.35
		SightingTime=0.45	
		ScopeScale=0.75
		DisplaceDurationMult=1
		MagAmmo=10
		// sniper 5-10x
        ZoomType=ZT_Logarithmic
		MinZoom=5
		MaxZoom=10
		ZoomStages=1
		RecoilParams(0)=RecoilParams'TacticalRechargeRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalPowerRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalOfflineRecoilParams'
		RecoilParams(3)=RecoilParams'TacticalOfflineRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalRechargeFireParams'
		FireParams(1)=FireParams'TacticalPowerFireParams'
		FireParams(2)=FireParams'TacticalOfflineFireParams'
		FireParams(3)=FireParams'TacticalOfflineFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
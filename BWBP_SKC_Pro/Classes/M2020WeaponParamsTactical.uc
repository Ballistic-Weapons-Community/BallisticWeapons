class M2020WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Recharge
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalRechargeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=70
        HeadMult=2
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=48
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
		FireInterval=0.6000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalRechargeEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Power
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalPowerEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=2
        LimbMult=0.67f
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
		FireInterval=1.000000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPowerEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalOfflineEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=40
        HeadMult=2
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
        PenetrationEnergy=24
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
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.550000
		CrouchMultiplier=0.650000
	End Object

	Begin Object Class=RecoilParams Name=TacticalPowerRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		DeclineDelay=1.1
		CrouchMultiplier=0.650000
	End Object

	Begin Object Class=RecoilParams Name=TacticalOfflineRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0500000
		YRandFactor=0.0500000
		DeclineDelay=0.3
		CrouchMultiplier=0.650000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=3072)
		ADSMultiplier=0.75
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ViewOffset=(Y=12.000000,Z=-12.000000)
		SightOffset=(Y=-3.000000,Z=18.000000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.5
		SightingTime=0.65
		DisplaceDurationMult=1
		MagAmmo=10
        ZoomType=ZT_Logarithmic
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
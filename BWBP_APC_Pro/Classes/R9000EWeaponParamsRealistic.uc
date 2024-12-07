class R9000EWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY STANDARD FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimarySTDEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=140
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifle'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_APC_Sounds.R9000E.R9000E-Fire1',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimarySTDFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimarySTDEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY INCENDIARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryINCEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=125
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifleInc'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleIncHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifleInc'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_APC_Sounds.R9000E.R9000E-Fire2',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryINCFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryINCEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY RADIATION FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryRADEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifleRad'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleRadHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifleRad'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitterRad'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_APC_Sounds.R9000E.R9000E-Fire4',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryRADFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryRADEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.2
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=1.25
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ADSMultiplier=0.25
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.700000
		AimSpread=(Min=64,Max=512)
		ChaosSpeedThreshold=500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		ReloadAnimRate=1.250000
		SightingTime=0.550000
		SightPivot=(Roll=-1024)
		SightOffset=(Y=-1.600000,Z=22.000000)
		SightMoveSpeedFactor=0.8
		//ViewOffset=(X=12.000000,Y=7.000000,Z=-14.000000)
		bNeedCock=True
		MagAmmo=6
		bMagPlusOne=True
        InventorySize=7
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimarySTDFireParams'
		FireParams(1)=FireParams'RealisticPrimaryINCFireParams'
		FireParams(2)=FireParams'RealisticPrimaryRADFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}
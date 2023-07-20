class R9000EWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY STANDARD FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimarySTDEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
        HeadMult=2
        LimbMult=0.85
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifle'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_CC_Sounds.R9000E.R9000E-Fire1',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimarySTDFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimarySTDEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY INCENDIARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryINCEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=95
        HeadMult=2
        LimbMult=0.85
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifleInc'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleIncHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifleInc'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitter'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_CC_Sounds.R9000E.R9000E-Fire2',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryINCFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryINCEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY RADIATION FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryRADEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=95
        HeadMult=2
        LimbMult=0.85
		DamageType=Class'BWBP_APC_Pro.DTR9000ERifleRad'
		DamageTypeHead=Class'BWBP_APC_Pro.DTR9000ERifleRadHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTR9000ERifleRad'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_APC_Pro.R9000EFlashEmitterRad'
		Recoil=378.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_CC_Sounds.R9000E.R9000E-Fire4',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryRADFireParams
		FireInterval=0.95
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryRADEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=1.25
		DeclineTime=1.000000
        ClimbTime=0.08
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.7 //Heavier than R78
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.700000
		AimSpread=(Min=424,Max=1380)
		ChaosSpeedThreshold=300.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		SightPivot=(Roll=-1024)
		SightOffset=(Y=-1.600000,Z=22.000000)
		SightingTime=0.5
		SightMoveSpeedFactor=0.35
		MagAmmo=6
        InventorySize=6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimarySTDFireParams'
		FireParams(1)=FireParams'TacticalPrimaryINCFireParams'
		FireParams(2)=FireParams'TacticalPrimaryRADFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
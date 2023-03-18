class SARWeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalAutoEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1250,Max=3750)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=180.000000
		Chaos=0.022000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalAutoFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalAutoEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalBurstEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
        DecayRange=(Min=1250,Max=3750)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'FlashEmitter_AR'
		FlashScaleFactor=0.900000
		Recoil=128.000000
		Chaos=0.030000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalBurstFireParams
		FireInterval=0.09
		FireEndAnim=
		AimedFireAnim="AimedFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalBurstEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		BotRefireRate=0.300000
        EffectString="Blinding flash"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=10.000000
		AmmoPerFire=0
		MaxHoldTime=0.5
		FireAnim=
		FireEndAnim=
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalAutoRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.35
		CrouchMultiplier=0.75
		DeclineDelay=0.14
	End Object

	Begin Object Class=RecoilParams Name=TacticalBurstRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.230000),(InVal=0.400000,OutVal=0.360000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
	   	XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.5
		ViewBindFactor=0.45
		CrouchMultiplier=1
		DeclineDelay=0.14
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAutoAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.300000
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalBurstAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.45
		AimSpread=(Min=48,Max=378)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
        CockAnimRate=1.250000
		ReloadAnimRate=1.100000
		SightPivot=(Pitch=350)
		SightOffset=(X=20.000000,Y=-0.010000,Z=12.400000)
		ViewOffset=(X=5.000000,Y=9.000000,Z=-11.000000)
		MagAmmo=32
        InventorySize=5
        SightingTime=0.35 // adjust the factor with stock mode
        SightMoveSpeedFactor=0.6
        RecoilParams(0)=RecoilParams'TacticalAutoRecoilParams'
        RecoilParams(1)=RecoilParams'TacticalBurstRecoilParams'
        AimParams(0)=AimParams'TacticalAutoAimParams'
        AimParams(1)=AimParams'TacticalBurstAimParams'
		FireParams(0)=FireParams'TacticalAutoFireParams'
		FireParams(1)=FireParams'TacticalBurstFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
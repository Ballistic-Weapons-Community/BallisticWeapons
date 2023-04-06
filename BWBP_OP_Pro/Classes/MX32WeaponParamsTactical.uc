class MX32WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 1;
	BWA.ModeInfos[0].TracerMix = 5;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.5
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DTMX32Primary'
		DamageTypeHead=Class'BWBP_OP_Pro.DTMX32PrimaryHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTMX32PrimaryLimb'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=128
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.113000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalFastRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=500.000000
		MaxSpeed=30000.000000
		AccelSpeed=10000.000000
		Damage=48
		DamageRadius=150.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.5
		Recoil=192
		Chaos=0.06
		Inaccuracy=(X=96,Y=48)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalFastRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalFastRocketEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=TacticalGuidedRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32SeekerRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=500.000000
		MaxSpeed=30000.000000
		AccelSpeed=10000.000000
		Damage=32
		DamageRadius=150.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.5
		Recoil=96
		Chaos=0.04
		Inaccuracy=(X=80,Y=40)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalGuidedRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalGuidedRocketEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineTime=1.5
		DeclineDelay=0.16
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		CrouchMultiplier=0.850000
		AimSpread=(Min=512,Max=2048)
		AimAdjustTime=0.800000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=1500)
		ChaosDeclineTime=0.800000
		ChaosDeclineDelay=0.600000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=0.800000
		SightOffset=(X=16.000000,Y=-0.340000,Z=22.720000)
		PlayerSpeedFactor=0.95
        SightMoveSpeedFactor=0.45
		MagAmmo=50
		SightingTime=0.45
		DisplaceDurationMult=1.4
        InventorySize=7
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalFastRocketFireParams'
		AltFireParams(1)=FireParams'TacticalGuidedRocketFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
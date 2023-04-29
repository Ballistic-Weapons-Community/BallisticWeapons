class AS50WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=125 // .50 + lol sniper bonus
        HeadMult=2
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
		PDamageFactor=0.800000
		PushbackForce=255.000000
		WallPDamageFactor=0.850000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=3072.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.4
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1
		FireAnim="CFire"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=90
        HeadMult=2
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
		PDamageFactor=0.000000
		WallPDamageFactor=0.850000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=3072.000000
		Chaos=1.000000
		BotRefireRate=0.50000
		WarnTargetPct=0.40000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.80000
		FireAnim="CFire"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.040000),(InVal=0.400000,OutVal=0.060000),(InVal=0.800000,OutVal=0.1300000),(InVal=1.000000,OutVal=0.17)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.45
		YRandFactor=0.25
		MinRandFactor=0.35
		MaxRecoil=8192
		ClimbTime=0.15
		DeclineDelay=0.75
		DeclineTime=1.5
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2560)
		ADSMultiplier=0.7
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.700000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//SightOffset=(X=18.000000,Y=15.000000,Z=6.700000)
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
        DisplaceDurationMult=1.25
		InventorySize=7
        SightMoveSpeedFactor=0.35
		SightingTime=0.55	
		ScopeScale=0.7
		MagAmmo=6
		// sniper 4-8x
        ZoomType=ZT_Logarithmic
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
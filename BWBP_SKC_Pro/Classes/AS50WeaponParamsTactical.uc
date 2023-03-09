class AS50WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=150
        HeadMult=2
        LimbMult=0.85
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
        PenetrationEnergy=96
		PenetrateForce=450
		bPenetrate=True
		PDamageFactor=0.800000
		PushbackForce=255.000000
		WallPDamageFactor=0.850000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=1024.000000
		Chaos=1.000000
		BotRefireRate=0.5
		WarnTargetPct=0.4
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.800000
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
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
		PDamageFactor=0.000000
		WallPDamageFactor=0.850000
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		Recoil=1024.000000
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

	Begin Object Class=RecoilParams Name=FSSG50RecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=0.400000),(InVal=1.000000,OutVal=0.5)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.15
		YRandFactor=0.15
		MinRandFactor=0.15
		DeclineTime=1.500000
		DeclineDelay=0.5
		CrouchMultiplier=0.650000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=128,Max=1536)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.350000
		ReloadAnimRate=1.250000
		SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		ViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
		PlayerSpeedFactor=0.800000
        DisplaceDurationMult=1.25
		InventorySize=24
		SightMoveSpeedFactor=0.8
		SightingTime=0.45
		MagAmmo=6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
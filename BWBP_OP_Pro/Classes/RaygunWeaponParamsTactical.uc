class RaygunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RaygunProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		MaxSpeed=10000.000000
		AccelSpeed=80000.000000
		Damage=70
        HeadMult=2
        LimbMult=0.75f
		MaxDamageGainFactor=0.5
		DamageGainStartTime=0.05
		DamageGainEndTime=0.2
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlashAlt'
		FlashScaleFactor=2.500000
		Recoil=108.000000
		Chaos=0.070000
		BotRefireRate=0.70000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.185000
		FireAnim="FireSmall"
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecondaryEffectParams
		Damage=70
		DamageType=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeHead=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeArm=Class'BWBP_OP_Pro.DTRaygunCharged'
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlash'
		FlashScaleFactor=4.000000
		Recoil=960.000000
		Chaos=0.320000
		BotRefireRate=0.250000
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-FireBig',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=8
		MaxHoldTime=2.50000
		FireAnim="ChargedFire"
		FireEndAnim=
		AimedFireAnim="Fire"	
		FireEffectParams(0)=InstantEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.140000),(InVal=0.600000,OutVal=0.120000),(InVal=0.700000,OutVal=0.120000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=0.320000),(InVal=0.450000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.04
		DeclineDelay=0.180000
		DeclineTime=1
		CrouchMultiplier=1
		HipMultiplier=1.25
		MaxMoveMultiplier=2
 	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=1
        AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.500000
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
        DisplaceDurationMult=0.75
		InventorySize=5
		SightMoveSpeedFactor=0.75
		SightingTime=0.3
		SightPivot=(Pitch=450)
		MagAmmo=24
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
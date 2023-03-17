class FG50WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPriStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=100
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=512.000000
		Chaos=0.200000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriStandardFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriStandardEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalPriControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=100
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PushbackForce=125.000000
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=384.000000
		Chaos=0.070000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPriControlledFireParams
		FireInterval=0.600000
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalPriControlledEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalSecStandardEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=512.000000
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecStandardFireParams
		FireInterval=0.165000
		FireAnim="Fire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecStandardEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalSecControlledEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		Damage=65
		DamageType=Class'BWBP_SKC_Pro.DT_FG50Torso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_FG50Head'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_FG50Limb'
		PenetrateForce=150
		PDamageFactor=0.800000
		WallPDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.FG50FlashEmitter'
		FlashScaleFactor=1.500000
		Recoil=384.000000
		Chaos=0.5
		WarnTargetPct=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.X82.X82-Fire2',Volume=7.100000,Pitch=1.000000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecControlledFireParams
		FireInterval=0.600000
		FireAnim="CFire"
		FireEndAnim=
		AimedFireAnim="SGCFireAimed"
		FireAnimRate=2.400000	
		FireEffectParams(0)=InstantEffectParams'TacticalSecControlledEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=0.15,OutVal=0.075),(InVal=0.400000,OutVal=0.130000),(InVal=0.550000,OutVal=0.15000),(InVal=0.700000,OutVal=0.21000),(InVal=1.000000,OutVal=0.225000)))
		YCurve=(Points=(,(InVal=0.20000,OutVal=0.250000),(InVal=0.400000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=8192
		DeclineTime=1.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalStandardAimParams
		ADSMultiplier=0.5
		AimSpread=(Min=128,Max=1536)
		ChaosDeclineTime=1.750000
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	Begin Object Class=AimParams Name=TacticalControlledAimParams
		AimAdjustTime=1
		ADSMultiplier=0.4
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=1.25
		ChaosSpeedThreshold=300
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object 

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.5
		SightingTime=0.8
		DisplaceDurationMult=1.4
		MagAmmo=40
		ViewOffset=(X=5.000000,Y=-7.000000,Z=-8.000000)
		SightOffset=(Y=25.000000,Z=10.300000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalStandardAimParams'
		AimParams(1)=AimParams'TacticalControlledAimParams'
		FireParams(0)=FireParams'TacticalPriControlledFireParams'
		FireParams(2)=FireParams'TacticalPriStandardFireParams'
		AltFireParams(0)=FireParams'TacticalSecControlledFireParams'
		AltFireParams(2)=FireParams'TacticalSecStandardFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
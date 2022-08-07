class CX61WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000)
		RangeAtten=0.350000
		Damage=85
		HeadMult=2.1
		LimbMult=0.66
		DamageType=Class'BWBP_OP_Pro.DT_CX61Chest'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_CX61Head'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_CX61Chest'
		PenetrationEnergy=24.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.700000
		Recoil=512.000000
		Chaos=0.20000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.CX61.CX61-FireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.150000
		FireAnim="SightFire"
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.000000	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.090000
		AmmoPerFire=0
		FireAnim=
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.1000),(InVal=0.200000,OutVal=0.19000),(InVal=0.400000,OutVal=0.360000),(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		XRandFactor=0.35000
		YRandFactor=0.35000
		MaxRecoil=4096.000000
		DeclineTime=1.5
		DeclineDelay=0.150000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=550.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.300000
		DisplaceDurationMult=1
		WeaponModes(0)=(ModeName="Flamethrower",Value=2,ModeID="WM_BigBurst")
		WeaponModes(1)=(ModeName="Healing Gas",Value=2,ModeID="WM_BigBurst")
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=16
		WeaponName="CX61 15mm Flechette Rifle"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}
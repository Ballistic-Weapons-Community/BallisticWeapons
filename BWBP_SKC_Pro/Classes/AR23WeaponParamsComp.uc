class AR23WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		Damage=50
		DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
		PenetrationEnergy=128.000000
		PenetrateForce=100.000000
		bPenetrate=True
		PDamageFactor=0.8
		PushbackForce=250.000000
		WallPDamageFactor=0.75
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=350.000000
		Chaos=0.080000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.170000
		BurstFireRateFactor=1
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=2560.000000,Max=2560.000000)
		WaterTraceRange=5000.0
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=1850.000000
		MomentumTransfer=50.000000
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2
		Recoil=768.000000
		Chaos=0.25
		Inaccuracy=(X=512,Y=768)
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"
		AimedFireAnim="GrenadeFireAimed"
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.200000
		CrouchMultiplier=0.750000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.20000),(InVal=0.500000,OutVal=0.220000),(InVal=0.700000,OutVal=0.35000),(InVal=0.500000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.300000),(InVal=0.500000,OutVal=0.550000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.07
		YRandFactor=0.07
		MaxRecoil=5040.000000
		DeclineTime=1.500000
		DeclineDelay=0.40000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-4000)
		ADSMultiplier=0.350000
		AimAdjustTime=0.450000
		ChaosDeclineTime=1.750000
        ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.800000
		SightingTime=0.550000
		DisplaceDurationMult=1.2
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=3,Scale=1f)
		MagAmmo=18
		ViewOffset=(X=7.000000,Y=7.00000,Z=-12.000000)
		ViewPivot=(Pitch=384)
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'
}
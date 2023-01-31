class XMK5WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=7000.000000,Max=7000.000000)
		WaterTraceRange=5600.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.600000
		Damage=15.0
		HeadMult=3.7
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
		PenetrationEnergy=24.000000
		PenetrateForce=175
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.XMK5Dart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		Damage=30.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=2.000000
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireAnim="Fire2"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=-0.250000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.225000,OutVal=0.450000),(InVal=0.350000,OutVal=0.600000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.150000
		YRandFactor=0.250000
		MaxRecoil=3000.000000
		DeclineTime=0.800000
		ViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=2560)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=1000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=45
		SightOffset=(X=1.000000,Z=17.750000)
		SightPivot=(Pitch=200)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Layouts(0)=WeaponParams'ClassicParams'


}
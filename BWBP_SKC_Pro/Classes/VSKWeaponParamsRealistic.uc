class VSKWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=60
		HeadMult=2.3
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
		PenetrationEnergy=1.000000
		PenetrateForce=150
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.VSK.VSK-SuperShot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		Chaos=-1.0
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.400000
		XRandFactor=0.35000
		YRandFactor=0.35000
		MaxRecoil=2048
		DeclineTime=0.600000
		DeclineDelay=0.100000;
		ViewBindFactor=0.100000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=392,Max=1336)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		bMagPlusOne=True
		SightOffset=(X=-20.000000,Y=-1.250000,Z=31.000000)
		ViewOffset=(X=10.000000,Y=15.000000,Z=-27.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Smooth
		WeaponModes(0)=(ModeName="Bolt-Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Bolt-Action",bUnavailable=True)
		WeaponModes(2)=(ModeName="Bolt-Action",bUnavailable=True)
		WeaponModes(3)=(ModeName="Bolt-Action",bUnavailable=True)
		WeaponModes(4)=(ModeName="Bolt-Action",bUnavailable=True)
		WeaponName="VSK-421 7mm Tranq Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
class SRS900WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1800.000000,Max=9000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=55.0
		HeadMult=2.127272
		LimbMult=0.654545
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=850.000000
		Chaos=0.100000
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="AimedFire"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object	
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.185000
		YRandFactor=0.185000
		MaxRecoil=4000
		DeclineTime=0.900000
		DeclineDelay=0.180000;
		ViewBindFactor=0.500000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-2560,Yaw=-4096)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=550.000000
		ChaosTurnThreshold=170000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Scoped"
		Weight=10
		//Attachments
		SightOffset=(X=9.000000,Z=3.150000)
        ZoomType=ZT_Logarithmic
		//Function
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		InventorySize=7
		MagAmmo=20
		bMagPlusOne=True
		//ViewOffset=(X=-1.000000,Y=6.000000,Z=-11.000000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=1f)
		InitialWeaponMode=1
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName="Holosight"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=0f)
		SightOffset=(X=6.000000,Z=2.03)
        ZoomType=ZT_Irons
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=20
		bMagPlusOne=True
		//ViewOffset=(X=-1.000000,Y=6.000000,Z=-11.000000)
		//SightOffset=(X=24.000000,Z=11.800000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Irons
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=5,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=6,Scale=0f)
		SightOffset=(X=1.000000,Z=1.30000)
        ZoomType=ZT_Irons
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=20
		bMagPlusOne=True
		//ViewOffset=(X=-1.000000,Y=6.000000,Z=-11.000000)
		//SightOffset=(X=24.000000,Z=11.800000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="SRS900-E 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	Layouts(2)=WeaponParams'RealisticParams_Irons'


}
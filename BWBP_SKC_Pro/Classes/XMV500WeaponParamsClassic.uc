class XMV500WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		WaterTraceRange=9600.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35.0
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTXMV500MG'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTXMV500MGHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTXMV500MG'
		PenetrationEnergy=40.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.550.Mini-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=40.000000
		Chaos=0.000850
		PushbackForce=15.000000
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.050000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Drop"
		FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.250000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=-0.300000),(InVal=0.500000,OutVal=0.400000),(InVal=0.700000,OutVal=-0.300000),(InVal=1.000000,OutVal=0.400000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=-0.100000),(InVal=0.450000,OutVal=-0.250000),(InVal=0.650000,OutVal=0.500000),(InVal=0.800000,OutVal=0.700000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.500000
		XRandFactor=0.024000
		YRandFactor=0.024000
		MaxRecoil=3000.000000
		ViewBindFactor=0.750000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=1000,Max=2000)
		CrouchMultiplier=0.500000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		//SightAimFactor=1.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		MagAmmo=600
		//ViewOffset=(X=50.000000,Y=0.000000,Z=-50.000000)
		//SightOffset=(X=-40.000000,Y=0,Z=90.000000)
		SightPivot=(Pitch=1024,Roll=0)
		//ViewOffset=(X=5.000000,Y=0.000000,Z=-30.000000)
		////SightOffset=(X=8.000000,Z=28.000000)
		//SightPivot=(Pitch=700,Roll=2048)
		WeaponModes(0)=(bUnavailable=True)
		WeaponModes(1)=(ModeName="600 RPM",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
		WeaponModes(3)=(ModeName="2400 RPM",ModeID="WM_FullAuto")
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
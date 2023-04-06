class AM67WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			WaterTraceRange=2500.0
			DecayRange=(Min=0.0,Max=0.0)
			RangeAtten=0.350000
			Damage=55.0
			HeadMult=2.0
			LimbMult=0.636363
			DamageType=Class'BallisticProV55.DTAM67Pistol'
			DamageTypeHead=Class'BallisticProV55.DTAM67PistolHead'
			DamageTypeArm=Class'BallisticProV55.DTAM67Pistol'
			PenetrationEnergy=24.000000
			PenetrateForce=200
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
			FlashScaleFactor=0.900000
			FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Fire',Volume=1.100000)
			Recoil=2048.000000
			Chaos=0.300000
			Inaccuracy=(X=4,Y=4)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.200000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
			FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
            EffectString="Blinding flash"
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=4.000000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="SecFire"
			FireEndAnim=
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.600000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2048)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.400000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Iron Sights"
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=0f)
		Weight=7
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=14
		//SightOffset=(X=-15.000000,Y=-0.700000,Z=12.300000)
		//SightPivot=(Pitch=1024,Roll=-1024)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_RDS
		LayoutName="RDS"
		WeaponBoneScales(0)=(BoneName="Sight",Slot=12,Scale=1f)
		Weight=2
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=14
		//SightOffset=(X=10.000000,Y=0.04,Z=7.950000)
		SightPivot=(Pitch=0,Roll=-0)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_RDS'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=AM67_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AM67_Gray
		Index=1
		CamoName="Pounder"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AM67Camos.AM67.AH104-MainMk2",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AM67_Silver
		Index=2
		CamoName="Special Edition"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AM67Camos.AH999-Main",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'AM67_Green'
	Camos(1)=WeaponCamo'AM67_Gray'
	Camos(2)=WeaponCamo'AM67_Silver'
}
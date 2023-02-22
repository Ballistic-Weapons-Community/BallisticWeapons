class M290WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=3500.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=24
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		LimbMult=0.24
		DamageType=Class'BallisticProV55.DTM290Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter_C'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290Fire',Volume=1.500000)
		Recoil=768.000000
		Chaos=-1.0
		PushbackForce=1000.000000
		Inaccuracy=(X=1400,Y=800)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		bCockAfterFire=True	
		FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=1500.000000,Max=3500.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.200000
		TraceCount=12
		TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.0
		LimbMult=0.24
		DamageType=Class'BallisticProV55.DTM290Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Circle
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=3.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290SingleFire',Volume=1.200000)
		Recoil=256.000000
		Chaos=-1.0
		PushbackForce=600.000000
		Inaccuracy=(X=900,Y=700)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireAnim="FireRight"	
		FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=0.900000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=1.0
		JumpOffSet=(Pitch=2000,Yaw=-5000)
		FallingChaos=0.4
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Yellow"
		Weight=30
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Magazine",Slot=2,Scale=0f)
		InventorySize=12
		
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		SightOffset=(X=-50.000000,Z=17.000000)
		SightPivot=(Pitch=512)
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-RNS
		LayoutName="Dark"
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SWC_Tex.M290MagiCannon.MiniThorSkin',Index=1)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Magazine",Slot=2,Scale=0f)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		SightOffset=(X=-50.000000,Z=17.000000)
		SightPivot=(Pitch=512)
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-C
		LayoutName="High Tech"
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.M290Camos.M290_SH1',Index=1)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Magazine",Slot=2,Scale=0f)
		
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=10
		SightOffset=(X=-50.000000,Z=17.000000)
		SightPivot=(Pitch=512)
		CockAnimRate=1.000000
		ReloadAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-RNS'
	Layouts(12)=WeaponParams'ClassicParams-C'

}
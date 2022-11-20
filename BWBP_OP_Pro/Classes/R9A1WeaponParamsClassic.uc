class R9A1WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=72.0
		HeadMult=1.7
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTR9Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
		PenetrationEnergy=48.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
		Recoil=128.000000
		Chaos=-1.0
		BotRefireRate=0.150000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicFreezeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.5
		Damage=35
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ClassicFreezeFireParams
		FireInterval=0.300000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicFreezeEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ClassicHeatEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		WaterTraceRange=5000
		RangeAtten=0.5
		Damage=20
		HeadMult=1.5
		LimbMult=0.85
		DamageType=Class'BWBP_OP_Pro.DTR9A1Rifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DTR9A1RifleHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTR9A1Rifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
		FlashScaleFactor=1.400000
		Recoil=192.000000
		Chaos=0.450000
		BotRefireRate=0.6
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	End Object

	Begin Object Class=FireParams Name=ClassicHeatFireParams
		FireInterval=0.300000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicHeatEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=3072)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightPivot=(Roll=6000)
		SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicFreezeFireParams'
		FireParams(2)=FireParams'ClassicHeatFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Yellow
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_body_SH2',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_scope_SH2',Index=2)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightPivot=(Roll=6000)
		SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicFreezeFireParams'
		FireParams(2)=FireParams'ClassicHeatFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Jungle
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_body_SH3',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_scope_SH2',Index=2)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightPivot=(Roll=6000)
		SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicFreezeFireParams'
		FireParams(2)=FireParams'ClassicHeatFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Grey
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_Boom_Tex.R9.R9_body_SH4',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_scope_SH2',Index=2)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightPivot=(Roll=6000)
		SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicFreezeFireParams'
		FireParams(2)=FireParams'ClassicHeatFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-DDPAT
		Weight=20
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_Boom_Tex.R9.R9_body_SH5',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_OP_Tex.R9A1.R9_scope_SH2',Index=2)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightPivot=(Roll=6000)
		SightOffset=(X=-5.000000,Y=-2.300000,Z=9.150000)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicFreezeFireParams'
		FireParams(2)=FireParams'ClassicHeatFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Yellow'
	Layouts(2)=WeaponParams'ClassicParams-Jungle'
	Layouts(3)=WeaponParams'ClassicParams-Grey'
	Layouts(4)=WeaponParams'ClassicParams-DDPAT'

}
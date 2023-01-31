class MarlinWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=77.0
		HeadMult=1.493506
		LimbMult=0.519480
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=48.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
		Recoil=1024.000000
		Chaos=-1.0
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.300000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=1.500000	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ClassicGaussPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=77.0
		HeadMult=1.493506
		LimbMult=0.519480
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrationEnergy=48.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FlashScaleFactor=0.6
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M50A2.M50A2-SilenceFire')
		Recoil=1024.000000
		Chaos=-1.0
		BotRefireRate=0.300000
		WarnTargetPct=0.050000
	End Object

	Begin Object Class=FireParams Name=ClassicGaussPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=
		FireAnimRate=1.150000	
	FireEffectParams(0)=InstantEffectParams'ClassicGaussPrimaryEffectParams'
	End Object
	
	Begin Object Class=FireParams Name=ClassicGoldPrimaryFireParams
		FireInterval=0.80000
		bCockAfterFire=True
		FireEndAnim=
		FireAnim="SightFireCock"
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		Damage=65.0
		HeadMult=1.538461
		LimbMult=0.461538
		DamageType=Class'BallisticProV55.DTMarlinMelee'
		DamageTypeHead=Class'BallisticProV55.DTMarlinMeleeHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinMelee'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.900000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSwipe"
		FireAnim="Swipe"
		PreFireAnimRate=1.500000
		FireAnimRate=1.500000
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=1.000000
		DeclineDelay=0.100000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.300000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=2560)
		CrouchMultiplier=0.300000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.200000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpOffSet=(Pitch=1000)
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=800.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=4.000000,Z=12.600000)
		SightPivot=(Pitch=384)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Bearmaster
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_KBP_Tex.MarlinRifle-K.MarlinK-Shiny',Index=1)
		Weight=30
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=4.000000,Z=12.600000)
		SightPivot=(Pitch=384)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_OB
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Deermaster-Camos.DeermasterOrange-Main-Shine',Index=1)
		Weight=10
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=4.000000,Z=12.600000)
		SightPivot=(Pitch=384)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gauss
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_KBP_Tex.MarlinRifle-K.MarlinK-Shiny',Index=1)
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=1f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=4.000000,Y=-0.100000,Z=10.500000)
		SightPivot=(Pitch=128)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGaussPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_BearmasterGauss
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_KBP_Tex.MarlinRifle-K.MarlinK-Shiny',Index=1)
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=1f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=8
		SightOffset=(X=4.000000,Y=-0.100000,Z=10.500000)
		SightPivot=(Pitch=128)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGaussPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Gold
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.MarlinGold.MarlinGold-Shine',Index=1)
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=12
		SightOffset=(X=4.000000,Z=12.600000)
		SightPivot=(Pitch=384)
		ReloadAnimRate=1.500000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGoldPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_Bearmaster'
	Layouts(2)=WeaponParams'ClassicParams_OB'
	Layouts(3)=WeaponParams'ClassicParams_Gauss'
	Layouts(4)=WeaponParams'ClassicParams_BearmasterGauss'
	Layouts(5)=WeaponParams'ClassicParams_Gold'
}
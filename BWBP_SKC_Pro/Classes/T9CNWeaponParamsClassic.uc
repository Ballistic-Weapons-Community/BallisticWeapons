class T9CNWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Max=5000.000000)
		WaterTraceRange=3000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.700000
		Damage=22
		HeadMult=2.3
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTT9CN'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTT9CNHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTT9CN'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter_C'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.T9CN.T9CN-FireOld',Volume=1.200000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=48,Y=48)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.200000
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.300000
		DeclineTime=0.400000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams_Light
		AimSpread=(Min=64,Max=8192)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.050000
		JumpChaos=0.050000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.050000
		AimDamageThreshold=480.000000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=11200.000000
	End Object
 
	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=8192)
		AimAdjustTime=0.350000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		AimDamageThreshold=480.000000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=1200.000000
		ChaosTurnThreshold=196608.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=6
		InventorySize=6
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RCSliderFront",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="RCAttachmentIron",Slot=4,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainE",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideE",Index=3)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_S
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		Weight=1
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_TT
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineB",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineB",Index=3)
		Weight=1
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_B
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineC",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineC",Index=3)
		Weight=1
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_BW
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainShineD",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideShineC",Index=3)
		Weight=1
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_T
		WeaponBoneScales(0)=(BoneName="RCAttachment",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="RCSlider",Slot=2,Scale=0f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-MainE",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.T9CNCamos.Ber-SlideE",Index=3)
		Weight=1
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.150000
		bNeedCock=True
		MagAmmo=18
		SightPivot=(Pitch=128)
		SightOffset=(X=-10.000000,Y=-2.090000,Z=9.35000)
		ViewOffset=(X=0.000000,Y=6.500000,Z=-8.00000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams' //Robocop
	Layouts(1)=WeaponParams'ClassicParams_S' //Silver
	Layouts(2)=WeaponParams'ClassicParams_TT' //Two Tone
	Layouts(3)=WeaponParams'ClassicParams_B' //Black
	Layouts(4)=WeaponParams'ClassicParams_BW' //Black + Wood
	Layouts(5)=WeaponParams'ClassicParams_T' //Tan
	
}
class DragonsToothWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		Damage=200
		HeadMult=2.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.200000
		HookPullForce=80.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=1.100000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Swing1"
		FireAnimRate=0.850000
		FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		Damage=190
		HeadMult=2.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=2.700000
		HookPullForce=150.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=5.500000,Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.600000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee3"
		FireAnimRate=0.850000
		FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Blue
		//Layout
		Weight=10
		LayoutName="Blue"
		LayoutTags="blue"
		//Visual
		AllowedCamos(0)=0
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=20000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Red
		//Layout
		Weight=10
		LayoutName="Red"
		LayoutTags="red"
		//Visual
		AllowedCamos(0)=1
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=20000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Black
		//Layout
		Weight=10
		LayoutName="Nanoblack"
		LayoutTags="black"
		//Visual
		AllowedCamos(0)=2
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=20000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Gold
		//Layout
		Weight=1
		LayoutName="Royal Dragon"
		LayoutTags="gold"
		//Visual
		AllowedCamos(0)=3
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=2
		WeaponPrice=20000
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Blue'
	Layouts(1)=WeaponParams'RealisticParams_Red'
	Layouts(2)=WeaponParams'RealisticParams_Black'
	Layouts(3)=WeaponParams'RealisticParams_Gold'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=DTS_Blue
		Index=0
		CamoName="Blue"
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-MainRedFinal',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.DragonToothSword.DTS-BladeMaskRed',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-MainBlackFinal',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-BladeGlowBlack',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Gold
		Index=3
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-MainGoldFinal',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-BladeGlowGold',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'DTS_Blue'
	Camos(1)=WeaponCamo'DTS_Red'
	Camos(2)=WeaponCamo'DTS_Black'
	Camos(3)=WeaponCamo'DTS_Gold'
}
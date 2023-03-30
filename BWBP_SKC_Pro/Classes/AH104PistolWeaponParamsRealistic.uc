class AH104PistolWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=6000.000000) //.60 armor piercing
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.350000
		Damage=100
		HeadMult=2.3f
		LimbMult=0.6f
		DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		PenetrationEnergy=24.000000
		PenetrateForce=70
		bPenetrate=True
		PDamageFactor=0.7
		WallPDamageFactor=0.5
		MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
		FlashScaleFactor=1.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=7.100000)
		Recoil=4096.000000
		Chaos=0.200000
		Inaccuracy=(X=16,Y=16)
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		PushbackForce=170.000000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		BurstFireRateFactor=1.00
		FireInterval=1.1
		PreFireAnimRate=0.800000	
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnim="FireBig"
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.600000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.01
		Chaos=0.05
		Damage=14.000000
		HeadMult=1.0f
		LimbMult=1.0f
		//DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		//DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
		//DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
		Inaccuracy=(X=0,Y=0)
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.050000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.40000)))
		PitchFactor=0.600000
		YawFactor=0.100000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=3572.000000
		DeclineTime=0.900000
		DeclineDelay=0.100000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=706,Max=1452)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.100000
		SprintChaos=0.300000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.750000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=575.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
		SightOffset=(X=-30.000000,Y=-0.700000,Z=22.600000)
		//Function
        InventorySize=8
		WeaponPrice=3000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=7
		bMagPlusOne=True
		ViewOffset=(X=8,Y=8,Z=-18)
		WeaponName="AH104 .600 Handcannon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex',Index=4,AIndex=-1,PIndex=-1)
		SightOffset=(X=-30.000000,Y=-0.700000,Z=26.730000)
		//Function
        InventorySize=8
		WeaponPrice=3000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=7
		bMagPlusOne=True
		ViewOffset=(X=8,Y=8,Z=-18)
		WeaponName="AH104 .600 Handcannon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Holo'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=AH_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainRed",Index=1,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Green
		Index=2
		CamoName="Green"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainGreen",Index=1,AIndex=0,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Tiger
		Index=3
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainTiger",Index=1,AIndex=0,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Meat
		Index=4
		CamoName="Meat"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainMeat",Index=1,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainGoldShine",Index=1,AIndex=0,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AH_Black'
	Camos(1)=WeaponCamo'AH_Red'
	Camos(2)=WeaponCamo'AH_Green'
	Camos(3)=WeaponCamo'AH_Tiger'
	Camos(4)=WeaponCamo'AH_Meat'
	Camos(5)=WeaponCamo'AH_Gold'
}
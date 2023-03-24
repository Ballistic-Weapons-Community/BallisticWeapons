class MJ51WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		WaterTraceRange=10400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=24
		HeadMult=3.125
		LimbMult=0.5
		DamageType=Class'BWBP_SKC_Pro.DTMJ51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTMJ51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTMJ51AssaultLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MJ51FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.SCAR-Fire',Volume=2.600000)
		Recoil=128.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.075000
		AimedFireAnim="SightFire"
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MJ51ChaffRifleGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=65.000000
		DamageRadius=192.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'MJ51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.600000
		BurstFireRateFactor=1.00
		FireAnim="FireGrenade"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=1.500000
		YawFactor=0.400000
		XRandFactor=1.000000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.5
		DeclineDelay=0.100000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2050)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.0
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Adv Holosight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightLower",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=0.000000,Y=-6.450000,Z=24.000000)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_NoCarry
		//Layout core
		Weight=10
		LayoutName="Adv Holosight 2"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=1f)
		SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_NoRDS
		//Layout core
		Weight=3
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=10.000000,Y=-6.450000,Z=20.900000)
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.200000
		bNeedCock=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_NoCarry'
	Layouts(2)=WeaponParams'ClassicParams_NoRDS'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=G51_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Green
		Index=1
		CamoName="Green"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGreen",Index=1,AIndex=0,PIndex=1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_GreenHex
		Index=2
		CamoName="Hex Green"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexG",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_BlueHex
		Index=3
		CamoName="Hex Blue"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexB",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Desert
		Index=4
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainDesert",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_UTC
		Index=5
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.UTCG51Tex",Index=1,AIndex=0,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Inferno
		Index=6
		CamoName="Inferno"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainRed",Index=1,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGold",Index=1,AIndex=0,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'G51_Black'
	Camos(1)=WeaponCamo'G51_Green'
	Camos(2)=WeaponCamo'G51_GreenHex'
	Camos(3)=WeaponCamo'G51_BlueHex'
	Camos(4)=WeaponCamo'G51_Desert'
	Camos(5)=WeaponCamo'G51_UTC'
	Camos(6)=WeaponCamo'G51_Inferno'
	Camos(7)=WeaponCamo'G51_Gold'
}
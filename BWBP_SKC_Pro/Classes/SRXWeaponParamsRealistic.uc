class SRXWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1800.000000,Max=9000.000000) //7.62x51mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.1
		Damage=60.0
		HeadMult=2.2
		LimbMult=0.65
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrationEnergy=24.000000
		PenetrateForce=125
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire4',Pitch=1.000000,Volume=1.500000)
		Recoil=850.000000
		Chaos=0.100000
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
		BotRefireRate=0.150000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Incendiary
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParamsInc
		TraceRange=(Min=1800.000000,Max=9000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=2.2
		LimbMult=0.65
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Pitch=1.500000,Volume=1.500000)
		Recoil=1024.000000
		Chaos=0.200000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.250000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsInc
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParamsInc'
	End Object
	
	//Corrosive
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParamsAcid
		TraceRange=(Min=1800.000000,Max=9000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=55
		HeadMult=2.2
		LimbMult=0.65
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		PenetrationEnergy=48.000000
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire',Pitch=1.200000,Volume=1.500000)
		Recoil=128.000000
		Chaos=0.08000
		Inaccuracy=(X=2,Y=2)
		BotRefireRate=0.122500
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsAcid
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParamsAcid'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.200000
		XRandFactor=0.165000
		YRandFactor=0.165000
		MaxRecoil=4000
		DeclineTime=0.800000
		DeclineDelay=0.180000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParamsInc
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.2
		MaxRecoil=4000
		DeclineTime=1.20000
		DeclineDelay=1.000000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParamsAcid
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.1
		MaxRecoil=4000
		DeclineTime=0.30000
		DeclineDelay=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=640,Max=1436)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=575.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Iron Sight"
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.SRX.SRX-Rifle',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.SRX.SRX-Stock',Index=2)
		WeaponBoneScales(0)=(BoneName="Sight",Slot=53,Scale=1f)
		SightOffset=(X=0,Y=0,Z=2.60)
		//Function
		InventorySize=7
		WeaponPrice=1400
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=20
		bMagPlusOne=True
		//ViewOffset=(X=-2,Y=8,Z=-25)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="SRK-650 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticRecoilParamsInc'
		RecoilParams(2)=RecoilParams'RealisticRecoilParamsAcid'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsInc'
		FireParams(2)=FireParams'RealisticPrimaryFireParamsAcid'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		Weight=30
		LayoutName="Red Dot Sight"
		LayoutTags="optic"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SightBase",Slot=54,Scale=0f)
		//SightPivot=(Pitch=-128,Yaw=16)
		SightOffset=(X=0.000000,Y=0.06,Z=2.7)
		//SightOffset=(X=15.000000,Y=-0.750000,Z=28.200000)
		//SightOffset=(X=-10.000000,Y=-0.650000,Z=27.200000)
		//Function
		InventorySize=7
		WeaponPrice=1400
		SightMoveSpeedFactor=0.500000
		SightingTime=0.300000
		MagAmmo=20
		bMagPlusOne=True
		//ViewOffset=(X=-2,Y=8,Z=-25)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		WeaponName="SRK-650 7.62mm Marksman Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		RecoilParams(1)=RecoilParams'RealisticRecoilParamsInc'
		RecoilParams(2)=RecoilParams'RealisticRecoilParamsAcid'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsInc'
		FireParams(2)=FireParams'RealisticPrimaryFireParamsAcid'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SRX_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Wood
		Index=1
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RifleV2",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockV2",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingV2",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RifleTan",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.SRX.SRX-StockBlack',Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingTan",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Urban
		Index=3
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RifleUrban",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockUrban",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingV2",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Jungle
		Index=4
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RifleJungle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockJungle",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingV2",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_RedWinter
		Index=5
		CamoName="Red Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RiflePatriot",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockRedCamo",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingV2",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_RedTiger
		Index=6
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-RifleTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockRedBlack",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-IronsV2",Index=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-HoloV2",Index=4)
		WeaponMaterialSwaps(5)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-CableV2",Index=5)
		WeaponMaterialSwaps(6)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-PlatingV2",Index=6)
		WeaponMaterialSwaps(7)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-BarrelV2",Index=7)
		WeaponMaterialSwaps(8)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-MiscV2",Index=8)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'SRX_Gray'
	Camos(1)=WeaponCamo'SRX_Wood'
	Camos(2)=WeaponCamo'SRX_Desert'
	Camos(3)=WeaponCamo'SRX_Urban'
	Camos(4)=WeaponCamo'SRX_Jungle'
	Camos(5)=WeaponCamo'SRX_RedWinter'
	Camos(6)=WeaponCamo'SRX_RedTiger'
}
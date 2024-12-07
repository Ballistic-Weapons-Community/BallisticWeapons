class SRXWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalStandardEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=55 // 7.62 NATO
        HeadMult=3
        LimbMult=0.75
		PenetrationEnergy=48
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.2000000
		Recoil=600.000000
		Chaos=0.100000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire3',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=TacticalStandardFireParams
		FireInterval=0.27000
		BurstFireRateFactor=1
		FireEndAnim=
		FireAnimRate=0.8
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalStandardEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalExplosiveEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=75
        HeadMult=3
        LimbMult=0.75
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=1.1000000
		Recoil=800.000000
		Chaos=0.450000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=TacticalExplosiveFireParams
		FireInterval=0.35000
		BurstFireRateFactor=1
		FireEndAnim=
		FireAnimRate=0.8
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalExplosiveEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalAcidEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2625,Max=6300) // 50-120m
		RangeAtten=0.75
		Damage=40
        HeadMult=3
        LimbMult=0.75
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.4000000
		Recoil=300.000000
		Chaos=0.150000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=TacticalAcidFireParams
		FireInterval=0.20000
		BurstFireRateFactor=1
		FireEndAnim=
		FireAnimRate=1
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalAcidEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.38),(InVal=0.5,OutVal=0.55),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=1)))
		XRandFactor=0.2
		YRandFactor=0.2
		ClimbTime=0.06
		DeclineDelay=0.29
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalExplosiveRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.38),(InVal=0.5,OutVal=0.55),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=1)))
		YRandFactor=0.2
		ClimbTime=0.06
		DeclineDelay=0.29
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalAcidRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.38),(InVal=0.5,OutVal=0.55),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=1)))
		YRandFactor=0.08
		ClimbTime=0.05
		DeclineDelay=0.2
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.35
		ADSViewBindFactor=0
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=384,Max=1280)
		AimAdjustTime=0.600000
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
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
        SightingTime=0.35
		MagAmmo=20
        InventorySize=6
        SightMoveSpeedFactor=0.45
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalAcidRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalStandardFireParams'
		FireParams(1)=FireParams'TacticalExplosiveFireParams'
		FireParams(2)=FireParams'TacticalAcidFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Begin Object Class=WeaponParams Name=TacticalParams_RDS
		//Layout core
		Weight=30
		LayoutName="Red Dot Sight"
		LayoutTags="optic"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SightBase",Slot=54,Scale=0f)
		//SightPivot=(Pitch=-128,Yaw=16)
		SightOffset=(X=0.000000,Y=0.06,Z=2.7)
		//Function
        SightingTime=0.35
		MagAmmo=20
        InventorySize=6
        SightMoveSpeedFactor=0.45
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		RecoilParams(1)=RecoilParams'TacticalExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'TacticalAcidRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalStandardFireParams'
		FireParams(1)=FireParams'TacticalExplosiveFireParams'
		FireParams(2)=FireParams'TacticalAcidFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
	
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
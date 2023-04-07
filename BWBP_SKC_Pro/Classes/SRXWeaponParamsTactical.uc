class SRXWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalStandardEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=52
        HeadMult=2.5f
        LimbMult=0.75f
		PenetrationEnergy=48
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.2000000
		Recoil=512.000000
		Chaos=0.100000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=TacticalStandardFireParams
		FireInterval=0.185000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalStandardEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=TacticalExplosiveEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=75
        HeadMult=2.5f
        LimbMult=0.75f
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		PenetrateForce=120
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=1.1000000
		Recoil=650.000000
		Chaos=0.450000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=TacticalExplosiveFireParams
		FireInterval=0.280000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalExplosiveEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalAcidEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=40
        HeadMult=2.5f
        LimbMult=0.75f
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
		FireInterval=0.160000
		BurstFireRateFactor=0.30
		FireEndAnim=
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
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.12),(InVal=0.85,OutVal=0.1),(InVal=1,OutVal=0.3)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		XRandFactor=0.2
		YRandFactor=0.2
		ClimbTime=0.05
		DeclineTime=0.75
		DeclineDelay=0.250000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=RecoilParams Name=TacticalExplosiveRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.2
		DeclineTime=0.75
		DeclineDelay=0.32
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	Begin Object Class=RecoilParams Name=TacticalAcidRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.08
		DeclineTime=0.75
		DeclineDelay=0.2
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.SRX.SRX-Rifle",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_OP_Tex.SRX.SRX-Stock",Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=4) //A3
		WeaponMaterialSwaps(4)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=5) //A4
		WeaponMaterialSwaps(5)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=6) //A5
		WeaponMaterialSwaps(6)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=11) //A10
		WeaponMaterialSwaps(7)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=12) //A11
		WeaponBoneScales(0)=(BoneName="Sight",Slot=53,Scale=1f)
		SightOffset=(X=0.000000,Y=-0.700000,Z=26.100000)
		SightPivot=(Pitch=-128,Yaw=16)
		//Function
        SightingTime=0.35
		MagAmmo=20
        InventorySize=6
        SightMoveSpeedFactor=0.6
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
		//SightPivot=(Pitch=-128,Yaw=16)
		SightOffset=(X=15.000000,Y=-0.750000,Z=28.200000)
		//SightOffset=(X=-10.000000,Y=-0.650000,Z=27.200000)
		//Function
        SightingTime=0.35
		MagAmmo=20
        InventorySize=6
        SightMoveSpeedFactor=0.6
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
	
	Begin Object Class=WeaponCamo Name=SRX_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_OP_Tex.SRX.SRX-RifleDark',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_OP_Tex.SRX.SRX-StockBlack',Index=2,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Stealth
		Index=2
		CamoName="Dead Stealth"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_OP_Tex.SRX.SRX-RifleDark',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockRedBlack",Index=2,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Banana
		Index=3
		CamoName="Banana"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.BWBP_OP_Tex.SRX.SRX-Rifle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockYellowCamo",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_Jungle
		Index=4
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.SRX.SRX-Rifle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockJungle",Index=2,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SRX_RedWinter
		Index=5
		CamoName="Red Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_OP_Tex.SRX.SRX-Rifle",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SRXCamos.SRX-StockRedCamo",Index=2,AIndex=1,PIndex=1)
		Weight=5
	End Object
	
	Camos(0)=WeaponCamo'SRX_Gray'
	Camos(1)=WeaponCamo'SRX_Black'
	Camos(2)=WeaponCamo'SRX_Stealth'
	Camos(3)=WeaponCamo'SRX_Banana'
	Camos(4)=WeaponCamo'SRX_Jungle'
	Camos(5)=WeaponCamo'SRX_RedWinter'
}
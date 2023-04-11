class SRXWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaStandardEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		PenetrationEnergy=48
		RangeAtten=0.75
		Damage=34
        HeadMult=2.0f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.2000000
		Recoil=200.000000
		Chaos=0.100000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaStandardFireParams
		FireInterval=0.185000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaStandardEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaExplosiveEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=45
        HeadMult=2.0f
        LimbMult=0.75f
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=1.1000000
		Recoil=320.000000
		Chaos=0.450000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaExplosiveFireParams
		FireInterval=0.280000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaExplosiveEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaAcidEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=25
        HeadMult=2.0f
        LimbMult=0.75f
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.4000000
		Recoil=64.000000
		Chaos=0.150000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaAcidFireParams
		FireInterval=0.160000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaAcidEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		XRandFactor=0.15
		YRandFactor=0.15
		ClimbTime=0.05
		DeclineDelay=0.250000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	Begin Object Class=RecoilParams Name=ArenaExplosiveRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.2
		ClimbTime=0.05
		DeclineDelay=0.32
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	Begin Object Class=RecoilParams Name=ArenaAcidRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.0),(InVal=0.2,OutVal=0.07),(InVal=0.4,OutVal=0.04),(InVal=0.5,OutVal=0.06),(InVal=0.7,OutVal=-0.01),(InVal=0.85,OutVal=0.04),(InVal=1,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.08
		ClimbTime=0.05
		DeclineDelay=0.2
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
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
		SightOffset=(X=0,Y=0,Z=2.5)
		SightPivot=(Pitch=-128,Yaw=16)
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaAcidRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardFireParams'
		FireParams(1)=FireParams'ArenaExplosiveFireParams'
		FireParams(2)=FireParams'ArenaAcidFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		Weight=30
		LayoutName="Red Dot Sight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="Sight",Slot=53,Scale=0f)
		SightPivot=(Pitch=-128,Yaw=16)
		SightOffset=(X=0.000000,Y=0.06,Z=2.22)
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaAcidRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardFireParams'
		FireParams(1)=FireParams'ArenaExplosiveFireParams'
		FireParams(2)=FireParams'ArenaAcidFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_RDS'
	
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
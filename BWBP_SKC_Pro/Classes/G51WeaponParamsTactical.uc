class G51WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
	BWA.ModeInfos[0].TracerMix = 0;
}

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56mm
		HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
		PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.SCAR-Fire',Volume=2.600000)
		Recoil=180.000000
		Chaos=0.040000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.1
		BurstFireRateFactor=0.825
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//Suppressed
	Begin Object Class=InstantEffectParams Name=TacticalPrimarySuppressedEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=4250) // 35-100m
		RangeAtten=0.76
		Damage=34 // 5.56mm
		HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
		PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=16,Y=16)
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash'
		FlashScaleFactor=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Silenced',Volume=1.500000,Radius=232.000000,bAtten=True)
		Recoil=160.000000
		Chaos=0.306942
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimarySuppressedFireParams
		FireInterval=0.1
		BurstFireRateFactor=0.825
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimarySuppressedEffectParams'
	End Object

	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Chaff
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Chaff
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Chaff'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		MaxSpeed=3500.000000
		Damage=65
		DamageRadius=192.000000
        ImpactDamage=100
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Chaff
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'TacticalSecondaryEffectParams_Chaff'
	End Object
	
	//Radar
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Sensor'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		MaxSpeed=3500.000000
		Damage=15
		DamageRadius=10.000000
        ImpactDamage=100
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Sensor
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'TacticalSecondaryEffectParams_Sensor'
	End Object
	
	//High Explosive
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams_HE
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)

		Speed=3500.000000
		MaxSpeed=3500.000000

		Damage=100
        ImpactDamage=100
		DamageRadius=768.000000

		bOverrideArming=True
		ArmingDelay=0.3
		UnarmedDetonateOn=DT_ImpactTimed
		UnarmedPlayerImpactType=PIT_Bounce
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
		DetonateDelay=2

		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_HE
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'TacticalSecondaryEffectParams_HE'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.250000,OutVal=0.060000),(InVal=0.400000,OutVal=-0.020000),(InVal=0.800000,OutVal=0.100),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.15
		ADSViewBindFactor=1
		EscapeMultiplier=1.0
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.250000,OutVal=0.060000),(InVal=0.400000,OutVal=-0.020000),(InVal=0.800000,OutVal=0.100),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	Begin Object Class=AimParams Name=TacticalAimParams_Scope
		ADSViewBindFactor=1
		ADSMultiplier=0.7
		AimAdjustTime=0.6
		AimSpread=(Min=256,Max=1024)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Chaff
		//Layout core
		Weight=30
		LayoutName="Adv Holo + Chaff"
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightUpper",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=-0.01000,Z=3.100000)
		// ADS handling
		SightingTime=0.32
		SightMoveSpeedFactor=0.6
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Chaff'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Sensor
		//Layout core
		Weight=3
		LayoutName="Adv Holo + Sensor"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=1f)
		SightOffset=(X=-0.50,Y=0.00,Z=-0.12)
		// ADS handling
		SightingTime=0.32
		SightMoveSpeedFactor=0.6
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_HE
		//Layout core
		Weight=10
		LayoutName="Iron Sights + HE"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=0.00000,Z=0.90)
		// ADS handling
		SightingTime=0.32
		SightMoveSpeedFactor=0.6
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_HE'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_3X
		//Layout core
		Weight=5
		LayoutName="3X Scope"
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=-0.01000,Z=3.100000)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_ACOG',BoneName="tip",Scale=0.1,AugmentOffset=(x=-25,y=-4.6,z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=-16384))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=3
		// ADS handling
		SightingTime=0.45 //+0.1
		SightMoveSpeedFactor=0.35
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
		AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
		bNoaltfire=True
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_IR
		//Layout core
		Weight=5
		LayoutName="IR Scope"
		LayoutTags="IR"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=3.000000,Y=-0.01000,Z=0.500000)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_IRScope',BoneName="tip",Scale=0.05,AugmentOffset=(x=-27,y=-2.6,z=0),AugmentRot=(Pitch=0,Yaw=0,Roll=-16384))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-IRScope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=4
		// ADS handling
		SightingTime=0.45 //+1.0
		SightMoveSpeedFactor=0.35
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
		AimParams(0)=AimParams'TacticalAimParams_Scope'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object

	Begin Object Class=WeaponParams Name=TacticalParams_Suppressed
		//Layout core
		Weight=5
		LayoutName="Suppressed"
		LayoutTags="no_grenade"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=0.00000,Z=0.90)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.15,AugmentOffset=(X=0,Y=0,Z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=-16384))
		// ADS handling
		SightingTime=0.32
		SightMoveSpeedFactor=0.6
		//Function
		MagAmmo=30
        InventorySize=6
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimarySuppressedFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Chaff'
	Layouts(1)=WeaponParams'TacticalParams_Sensor'
	Layouts(2)=WeaponParams'TacticalParams_HE'
	Layouts(3)=WeaponParams'TacticalParams_Suppressed'
	//Layouts(4)=WeaponParams'TacticalParams_3X'
	//Layouts(5)=WeaponParams'TacticalParams_IR'
	

	//Camos =====================================
	Begin Object Class=WeaponCamo Name=G51_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Green
		Index=1
		CamoName="Green"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGreen",Index=1,AIndex=0,PIndex=1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_GreenHex
		Index=2
		CamoName="Green Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexG",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_BlueHex
		Index=3
		CamoName="Blue Hex"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainHexB",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Desert
		Index=4
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainDesert",Index=1,AIndex=0,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_UTC
		Index=5
		CamoName="UTC"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.UTCG51Tex",Index=1,AIndex=0,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Inferno
		Index=6
		CamoName="Inferno"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainRed",Index=1,AIndex=0,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=G51_Gold
		Index=7
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BWBP_Camos_Tex.G51Camos.G51-MainGold",Index=1,AIndex=0,PIndex=1)
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
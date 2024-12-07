class G51WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.670000
		Damage=23
		DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ55-Fire')
		Recoil=150.000000
		Chaos=0.040000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.0825
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//Suppressed
	Begin Object Class=InstantEffectParams Name=ArenaPrimarySuppressedEffectParams
		TraceRange=(Min=10000.000000,Max=13000.000000)
		DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.760000
		Damage=23
		DamageType=Class'BWBP_SKC_Pro.DT_G51Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_G51AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_G51AssaultLimb'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51FlashEmitter'
		FlashScaleFactor=0.010000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51-Silenced',Volume=1.500000,Radius=192.000000,bAtten=True)
		Recoil=130.000000
		Chaos=0.130000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimarySuppressedFireParams
		FireInterval=0.0825
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimarySuppressedEffectParams'
	End Object
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Chaff
	Begin Object Class=GrenadeEffectParams Name=ArenaSecondaryEffectParams_Chaff
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Chaff'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
        ImpactDamage=100
		Damage=65
		DamageRadius=512.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Chaff
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'ArenaSecondaryEffectParams_Chaff'
	End Object
	
	//High Explosive
	Begin Object Class=GrenadeEffectParams Name=ArenaSecondaryEffectParams_HE
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_HE'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
		Damage=120
        ImpactDamage=150
		DamageRadius=1024.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_HE
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'ArenaSecondaryEffectParams_HE'
	End Object
	
	//Radar Sensor
	Begin Object Class=GrenadeEffectParams Name=ArenaSecondaryEffectParams_Sensor
		ProjectileClass=Class'BWBP_SKC_Pro.G51Grenade_Sensor'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3750.000000
		MaxSpeed=4500.000000
        ImpactDamage=100
		Damage=10
		DamageRadius=10.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.G51AltFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MJ51.MJ51Carbine-GrenLaunch',Volume=2.200000)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Sensor
		FireInterval=0.600000
		FireAnim="FireGrenade"	
	FireEffectParams(0)=GrenadeEffectParams'ArenaSecondaryEffectParams_Sensor'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.250000,OutVal=0.060000),(InVal=0.400000,OutVal=-0.020000),(InVal=0.800000,OutVal=0.100),(InVal=1.000000,OutVal=0.00000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.0900
		ClimbTime=0.04
		DeclineDelay=0.140000
		DeclineTime=1.00000
		CrouchMultiplier=0.850000
		ViewBindFactor=0.4
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Chaff
		//Layout core
		Weight=30
		LayoutName="Adv Holo + Chaff"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightLower",Slot=55,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		
		//ADS
		SightOffset=(X=-0.500000,Y=-0.01000,Z=3.100000)
		SightingTime=0.350000	
		SightMoveSpeedFactor=0.8

		// Need it auto in Pro
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=False)
		InitialWeaponMode=2
		
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Chaff'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Sensor
		//Layout core
		Weight=3
		LayoutName="Adv Holo + Sensor"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=1f)
		
		//ADS
		SightOffset=(X=-0.50,Y=0.00,Z=-0.12)
		SightingTime=0.350000	
		SightMoveSpeedFactor=0.8

		// Need it auto in Pro
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=False)
		InitialWeaponMode=2
		
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Sensor'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_HE
		//Layout core
		Weight=10
		LayoutName="Irons + HE"
		
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		
		//ADS
		SightOffset=(X=-0.500000,Y=0.00000,Z=0.90)
		SightingTime=0.350000	
		SightMoveSpeedFactor=0.8

		// Need it auto in Pro
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=False)
		InitialWeaponMode=2
		
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_HE'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_3XScope
		//Layout core
		Weight=5
		LayoutName="3X Scope"
		//Attachments
		WeaponBoneScales(0)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(1)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(2)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_ACOG',BoneName="tip",Scale=0.1,AugmentOffset=(x=-25,y=-4.6,z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=-16384))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=3
		// ADS handling
		SightOffset=(X=-0.500000,Y=-0.01000,Z=3.100000)
		SightingTime=0.40 //+0.5
		SightMoveSpeedFactor=0.35
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
		bNoaltfire=True
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_IRScope
		//Layout core
		Weight=5
		LayoutName="IR Scope"
		LayoutTags="IR"
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=-1)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_IRScope',BoneName="tip",Scale=0.05,AugmentOffset=(x=-27,y=-2.6,z=0),AugmentRot=(Pitch=0,Yaw=0,Roll=-16384))
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-IRScope'
		// Zoom
		ZoomType=ZT_Fixed
		MaxZoom=4
		// ADS handling
		SightOffset=(X=3.000000,Y=-0.01000,Z=0.500000)
		SightingTime=0.45 //+1.0
		SightMoveSpeedFactor=0.35
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object
	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Suppressed
		//Layout core
		Weight=5
		LayoutName="Suppressed"
		LayoutTags="silencer"
			
		//Attachments
		WeaponBoneScales(0)=(BoneName="IronsLower",Slot=53,Scale=0f)
		WeaponBoneScales(1)=(BoneName="CarryHandle",Slot=54,Scale=1f)
		WeaponBoneScales(2)=(BoneName="HoloSightUpper",Slot=55,Scale=0f)
		WeaponBoneScales(3)=(BoneName="HoloSightLower",Slot=56,Scale=0f)
		SightOffset=(X=-0.500000,Y=0.00000,Z=0.90)

		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.15,AugmentOffset=(X=0,Y=0,Z=0),AugmentRot=(Pitch=32768,Yaw=0,Roll=-16384))	
		// ADS handling
		SightingTime=0.35
		SightMoveSpeedFactor=0.8
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		MagAmmo=30
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimarySuppressedFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object

	Layouts(0)=WeaponParams'ArenaParams_Chaff'
	Layouts(1)=WeaponParams'ArenaParams_Sensor'
	Layouts(2)=WeaponParams'ArenaParams_HE'
	Layouts(3)=WeaponParams'ArenaParams_3XScope'
	Layouts(4)=WeaponParams'ArenaParams_IRScope'
	Layouts(5)=WeaponParams'ArenaParams_Suppressed'

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
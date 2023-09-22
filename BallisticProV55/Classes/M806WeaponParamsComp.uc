class M806WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000,Max=4000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=16
        RangeAtten=0.67
		Damage=33
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		Recoil=512.000000
		Chaos=0.2
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.25000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Laser
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams_SG
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=6
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BallisticProV55.DTM806Shotgun'
		DamageTypeHead=Class'BallisticProV55.DTM806ShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Shotgun'
		PenetrationEnergy=4.000000
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=768.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_SG
		TargetState="Shotgun"
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="FireAlt"
		AimedFireAnim='FireAlt'
		FireAnimRate=1.100000	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams_SG'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.06
		DeclineTime=0.75
		DeclineDelay=0.25
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.320000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Laser + Ext Mags"
		Weight=30
		WeaponPrice=800
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		SightOffset=(X=-13.000000,Y=-4.2,Z=37.50000)
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		//Stats
		ViewOffset=(X=0,Y=30,Z=-20)
		DisplaceDurationMult=0.5
		MagAmmo=12
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout core
		LayoutName="4X Scope"
		Weight=5
		WeaponPrice=800
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BW_Core_WeaponTex.M806.M806_Main-SD',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'ONSstructureTextures.CoreGroup.Invisible',Index=2)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_PistolRail',BoneName="Muzzle",Scale=0.35,AugmentOffset=(x=-60,y=0,z=-50),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.35,AugmentOffset=(x=-120,y=0,z=25),AugmentRot=(Pitch=0,Roll=0,Yaw=0))
		//Zoom
		ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
		ZoomType=ZT_Fixed	
		MaxZoom=4	
		//ADS
		SightMoveSpeedFactor=0.35
		SightingTime=0.4 //+.2
		SightOffset=(X=0,Y=0,Z=18)
		SightPivot=(Pitch=0,Roll=0)
		//Function
		ViewOffset=(X=0.00,Y=20.00,Z=-20.00)
		DisplaceDurationMult=0.5
		MagAmmo=12
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object

	Begin Object Class=WeaponParams Name=ArenaParams_SG
		// Layout core
		LayoutName="Shotgun"
		LayoutTags="shotgun"
		Weight=5
		WeaponPrice=1200
		// Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M806SG'
		// ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		SightPivot=(Pitch=0,Roll=0) 
		SightOffset=(X=-5.000000,Y=0,Z=4.50000)
		bAdjustHands=false
		RootAdjust=(Yaw=0,Pitch=0)
		WristAdjust=(Yaw=0,Pitch=0)
		// Stats
		bDualBlocked=true
		ViewOffset=(X=0,Y=30,Z=-20)
		DisplaceDurationMult=0.5
		MagAmmo=12
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_SG'
    End Object
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Scope'
    Layouts(2)=WeaponParams'ArenaParams_SG'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M806_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainBlackShine",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Tiger
		Index=3
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainTigerShine",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Dragon
		Index=4
		CamoName="Dragon"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.Dragon_Main-SD",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=M806_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M806Camos.M806-MainGoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'M806_Gray'
	Camos(1)=WeaponCamo'M806_Black'
	Camos(2)=WeaponCamo'M806_Desert'
	Camos(3)=WeaponCamo'M806_Tiger'
	Camos(4)=WeaponCamo'M806_Dragon'
	Camos(5)=WeaponCamo'M806_Gold'
}
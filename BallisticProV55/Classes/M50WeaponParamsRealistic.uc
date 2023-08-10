class M50WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1500.000000,Max=7500.000000) //5.56mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.25
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Pitch=1.150000,Volume=1.10000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=600.000000
		Chaos=0.050000
		Inaccuracy=(X=9,Y=9)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.085714 //770 RPM
		BurstFireRateFactor=1.00
		AimedFireAnim="AimedFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Heavy Barrel
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_HB
		TraceRange=(Min=1500.000000,Max=7500.000000) //5.56mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.25
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter' //
		FlashScaleFactor=1.00
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire3',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False) //
		Recoil=500.000000 //
		Chaos=0.080000
		Inaccuracy=(X=6,Y=6) //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_HB
		FireInterval=0.090714 //
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_HB'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_S
		TraceRange=(Min=1500.000000,Max=7500.000000) //5.56mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.25
		LimbMult=0.65
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrationEnergy=18.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=1.25
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.100000,Radius=192.000000,bAtten=True) //
		Recoil=475.000000 //
		Chaos=0.100000 //
		Inaccuracy=(X=6,Y=6) //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_S
		FireInterval=0.090714 //
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"	
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_S'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3600.000000
		Damage=200.000000
		DamageRadius=400.000000
		MomentumTransfer=30000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
		Recoil=400.000000 //600 hip
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=1.250000
		WarnTargetPct=0.300000	
		bOverrideArming=true
		ArmingDelay=0.25
		UnarmedDetonateOn=DT_Disarm
		UnarmedPlayerImpactType=PIT_Bounce
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.400000
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"
		PreFireAnimRate=1.500000	
	FireEffectParams(0)=GrenadeEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.400000)))
		XCurveAlt=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurveAlt=(Points=(,(InVal=0.400000,OutVal=0.100000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.150000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=2800
		DeclineTime=0.725000
		DeclineDelay=0.175000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.500000
		CrouchMultiplier=0.700000
		bViewDecline=True
		bUseAltSightCurve=True
	End Object

	Begin Object Class=RecoilParams Name=RealisticRecoilParams_Scope
		XCurve=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.400000)))
		XCurveAlt=(Points=(,(InVal=0.400000,OutVal=0.250000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		YCurveAlt=(Points=(,(InVal=0.400000,OutVal=0.100000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.150000
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=2800
		DeclineTime=0.725000
		DeclineDelay=0.175000
		ViewBindFactor=0.200000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.500000
		CrouchMultiplier=0.700000
		bViewDecline=True
		bUseAltSightCurve=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3072,Yaw=-6144)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.450000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Grenadier"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		//Stats
		InventorySize=7
		WeaponPrice=2000
		bMagPlusOne=True
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		SightOffset=(X=-8,Y=0.08,Z=2.7)
		SightPivot=(Pitch=200)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="M50A1 5.56mm Assault Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_AdvSupp
		//Layout core
		LayoutName="A3 Suppressed"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		AttachmentMesh=SkeletalMesh'BW_Core_WeaponAnim.M50A3_TPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.2,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Scope",Scale=0.05)
        WeaponBoneScales(0)=(BoneName="Sights",Slot=0,Scale=0f)
		SightOffset=(X=0.000000,Y=0.000000,Z=3.40000)
		SightPivot=(Pitch=80,Roll=0,Yaw=0)
		//Function
		InventorySize=7
		WeaponPrice=2000
		bMagPlusOne=True
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="M50A3 5.56mm Assault Rifle (Sil)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_S'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_AdvHolo
		//Layout core
		LayoutName="A3 Holo"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		AttachmentMesh=SkeletalMesh'BW_Core_WeaponAnim.M50A3_TPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-39,y=-1.4,z=-0.125),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
        WeaponBoneScales(0)=(BoneName="Irons",Slot=0,Scale=0f)
		SightOffset=(X=0.000000,Y=0.000000,Z=3.35000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
		InventorySize=7
		WeaponPrice=2000
		bMagPlusOne=True
		SightMoveSpeedFactor=0.500000
		SightingTime=0.25
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="M50A3 5.56mm Assault Rifle (Holo)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_HB'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_AdvScope
		//Layout core
		LayoutName="A3 4X Scope"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		AttachmentMesh=SkeletalMesh'BW_Core_WeaponAnim.M50A3_TPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_3XScope',BoneName="tip",Scale=0.065,AugmentOffset=(x=-43,y=-1.75,z=-0.125),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
        WeaponBoneScales(0)=(BoneName="Irons",Slot=0,Scale=0f)
		//Zoom
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=4
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		SightOffset=(X=0.000000,Y=0.000000,Z=3.50000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
		InventorySize=7
		WeaponPrice=2000
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		WeaponName="M50A3 5.56mm Assault Rifle (4X)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams_Scope'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_HB'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_AdvSupp'
	Layouts(2)=WeaponParams'RealisticParams_AdvHolo'
	Layouts(3)=WeaponParams'RealisticParams_AdvScope'
	
	//Camos
	Begin Object Class=WeaponCamo Name=M50_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Black
		Index=1
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.M50.M50Laser',Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50Gren-D',Index=5,AIndex=4,PIndex=3)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50.M900Grenade',Index=6,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Jungle
		Index=2
		CamoName="Jungle"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SATiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SBTiger",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Gold
		Index=3
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main1_S1",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main2_S1",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Laser_S1",Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main3_S1",Index=5,AIndex=4,PIndex=3)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50A3_Black
		Index=4
		CamoName="Black"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-CoverBlack',Index=3,AIndex=4,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-MainBlack',Index=4,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=5,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=3,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50A3_Desert
		Index=5
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-CoverTan",Index=3,AIndex=4,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-MainTan",Index=4,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=5,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=3,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50A3_Red
		Index=6
		CamoName="Red"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-CoverRed",Index=3,AIndex=4,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-MainBlack',Index=4,AIndex=2,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=5,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=3,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'M50_Silver'
	Camos(1)=WeaponCamo'M50_Black'
	Camos(2)=WeaponCamo'M50_Jungle'
	Camos(3)=WeaponCamo'M50_Gold'
	Camos(4)=WeaponCamo'M50A3_Black'
	Camos(5)=WeaponCamo'M50A3_Desert'
	Camos(6)=WeaponCamo'M50A3_Red'
}
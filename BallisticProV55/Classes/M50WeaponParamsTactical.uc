class M50WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Standard
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.25
		Recoil=180.000000
		Chaos=0
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.0825 // 800 rpm
		FireEndAnim=
		FireAnim="AimedFire"
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//Heavy Barrel
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_HB
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=20,Y=20) //
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter' //
		FlashScaleFactor=1.25
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire3',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False) //
		Recoil=180.000000 //
		Chaos=0.01 //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_HB
		FireInterval=0.0855 //
		FireEndAnim=
		FireAnim="SightFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_HB'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams_S
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1838,Max=5250) // 35-100m
		RangeAtten=0.67
		Damage=34 // 5.56mm
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=20,Y=20) //
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=1.25
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50FireSil',Volume=1.100000,Radius=192.000000,bAtten=True) //
		Recoil=160.000000 //
		Chaos=0.02 //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_S
		FireInterval=0.0855 //
		FireEndAnim=
		FireAnim="SightFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams_S'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)

		Speed=2700.000000 // 4200 = 80 m/s, we slow it down in accordance with the ranges we're playing at
		MaxSpeed=2700.000000

		Damage=120
        ImpactDamage=50
		DamageRadius=768.000000

		bOverrideArming=True
		ArmingDelay=0
		ArmedDetonateOn=DT_Timer
		ArmedPlayerImpactType=PIT_Bounce
		DetonateDelay=3

		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		PreFireTime=0.450000
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
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
		ViewBindFactor=0.2
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.35
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.03),(InVal=0.30000,OutVal=0.04),(InVal=0.40000,OutVal=0.01),(InVal=0.600000,OutVal=-0.04000),(InVal=0.800000,OutVal=0.070000),(InVal=1.00000,OutVal=0.00000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.120000     
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	Begin Object Class=RecoilParams Name=TacticalRecoilParams_Scope
		ViewBindFactor=0.2
		ADSViewBindFactor=1.0 //
		EscapeMultiplier=1.0 //
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.03),(InVal=0.30000,OutVal=0.04),(InVal=0.40000,OutVal=0.01),(InVal=0.600000,OutVal=-0.04000),(InVal=0.800000,OutVal=0.070000),(InVal=1.00000,OutVal=0.00000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.120000     
		DeclineTime=0.75
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
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=256,Max=1024)
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Standard"
		Weight=30
		AllowedCamos(0)=0
		AllowedCamos(1)=1
		AllowedCamos(2)=2
		AllowedCamos(3)=3
		//Stats
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
        MagAmmo=30
        InventorySize=7
		SightOffset=(X=-8,Y=0.08,Z=2.7)
		SightPivot=(Pitch=200)
		WeaponName="M50 5.56mm Assault Rifle"
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_AdvSupp
		//Layout core
		LayoutName="A3 Suppressed"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Suppressor',BoneName="tip",Scale=0.2,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		//GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Scope",Scale=0.05)
        WeaponBoneScales(0)=(BoneName="Sights",Slot=0,Scale=0f)
		SightOffset=(X=0.000000,Y=0.000000,Z=3.40000)
		SightPivot=(Pitch=80,Roll=0,Yaw=0)
		//Function
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
        MagAmmo=30
        InventorySize=7
		WeaponName="M50A3 5.56mm Assault Rifle (Sil)"
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_S'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_AdvHolo
		//Layout core
		LayoutName="A3 Holo"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="tip",Scale=0.06,AugmentOffset=(x=-39,y=-2,z=-0.125),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		SightOffset=(X=0.000000,Y=0.000000,Z=4.25000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
        MagAmmo=30
        InventorySize=7
		WeaponName="M50A3 5.56mm Assault Rifle (Holo)"
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_HB'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_AdvScope
		//Layout core
		LayoutName="A3 3X Scope"
		LayoutTags="no_grenade"
		Weight=5
		AllowedCamos(0)=4
		AllowedCamos(1)=5
		AllowedCamos(2)=6
		//Attachments
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.FPm_M50A3'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_3XScope',BoneName="tip",Scale=0.065,AugmentOffset=(x=-43,y=-1.75,z=-0.125),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
        WeaponBoneScales(0)=(BoneName="Irons",Slot=0,Scale=0f)
		//Zoom
		ScopeViewTex=Texture'BW_Core_WeaponTex.Attachment.SKAR-Scope'
        ZoomType=ZT_Fixed
		MaxZoom=3
		//ADS
		SightMoveSpeedFactor=0.350000
		SightingTime=0.40
		SightOffset=(X=0.000000,Y=0.000000,Z=3.50000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		//Function
        MagAmmo=30
        InventorySize=7
		WeaponName="M50A3 5.56mm Assault Rifle (3X)"
        RecoilParams(0)=RecoilParams'TacticalRecoilParams_Scope'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_HB'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_AdvSupp'
    Layouts(2)=WeaponParams'TacticalParams_AdvHolo'
    Layouts(3)=WeaponParams'TacticalParams_AdvScope'
	
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
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-CoverBlack',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-MainBlack',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50A3_Desert
		Index=5
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-CoverTan",Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-MainTan",Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50A3_Red
		Index=6
		CamoName="Red"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50A3.M50A3-CoverRed",Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-MainBlack',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Barrel',Index=5,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(6)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50A3-Misc',Index=6,AIndex=-1,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'M50_Silver'
	Camos(1)=WeaponCamo'M50_Black'
	Camos(2)=WeaponCamo'M50_Jungle'
	Camos(3)=WeaponCamo'M50_Gold'
	Camos(4)=WeaponCamo'M50A3_Black'
	Camos(5)=WeaponCamo'M50A3_Desert'
	Camos(6)=WeaponCamo'M50A3_Red'
}
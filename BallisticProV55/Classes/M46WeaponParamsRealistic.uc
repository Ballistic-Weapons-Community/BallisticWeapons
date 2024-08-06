class M46WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=9000.000000,Max=9000.000000) //.310 (7.87mm)
		WaterTraceRange=7200.0
		DecayRange=(Min=1800.0,Max=9000.0)
		Damage=60.0
		HeadMult=2.2
		LimbMult=0.65
        DamageType=Class'BallisticProV55.DTM46Assault'
        DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
        DamageTypeArm=Class'BallisticProV55.DTM46Assault'
		PenetrationEnergy=26.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Volume=1.100000,Pitch=1.100000,Slot=SLOT_Interact,bNoOverride=false)
		Recoil=880.000000
		Chaos=-1.0
		Inaccuracy=(X=2,Y=2)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        AimedFireAnim="AimedFire"
		FireInterval=0.055000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=class'BallisticProV55.M46Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Damage=160.000000
		DamageRadius=340.000000
		Speed=2400.000000
		HeadMult=2.000000
		LimbMult=0.500000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_FireGren',Volume=1.750000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		bLimitMomentumZ=False
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=2.500000
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.400000,OutVal=-0.100000),(InVal=0.70000,OutVal=0.300000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.300000),(InVal=0.70000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		YawFactor=0.200000
		XRandFactor=0.190000
		YRandFactor=0.190000
		MaxRecoil=3600
		DeclineTime=1.000000
		DeclineDelay=0.200000;
		ViewBindFactor=0.500000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1792)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.075000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-2560,Yaw=-4096)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Scoped"
		Weight=30
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=0,Scale=0f)
		SightOffset=(X=-1,Y=0.050000,Z=3.9)
		SightPivot=(Pitch=0,Roll=0)
        ZoomType=ZT_Logarithmic
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
        SightingTime=0.300000
		MagAmmo=24
		bMagPlusOne=True
		ViewPivot=(Pitch=384)
		InitialWeaponMode=1
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponName="M46A2 .310 Battle Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object

    Begin Object Class=WeaponParams Name=RealisticRDSParams
		//Layout core
		LayoutName="RDS"
		Weight=20
		//Attachments
        WeaponBoneScales(0)=(BoneName="Scope",Slot=0,Scale=0f)
		SightOffset=(X=-2.5,Y=0.04,Z=3.85)
		SightPivot=(Pitch=0,Roll=0)
        ZoomType=ZT_Irons
		//Function
        SightingTime=0.25
        MagAmmo=24
		bMagPlusOne=True
		InventorySize=7
		WeaponPrice=2300
        //SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
		//ViewOffset=(X=5.000000,Y=4.750000,Z=-9.000000)
		InitialWeaponMode=1
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=2.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponName="M46A2 .310 Battle Rifle (RDS)"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
	
	Layouts(0)=WeaponParams'RealisticParams'
    Layouts(1)=WeaponParams'RealisticRDSParams'
		
	//Camos ====================================================

	Begin Object Class=WeaponCamo Name=M46_Tan
		Index=0
		CamoName="Desert"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M46_Jungle
		Index=1
		CamoName="Jungle"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenMain",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenClip",Index=2,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenGrenadeLauncher",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6,AIndex=4,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M46_Blue
		Index=2
		CamoName="Ocean"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoBlueMain",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AL_PulseRifle_Clip",Index=2,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoBlueGrenadeLauncher",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5,Index=5,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6,AIndex=4,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=M46_Black
		Index=3
		CamoName="Stealth"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayMain",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayClip",Index=2,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayGrenadeLauncher",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5,Index=5,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6,AIndex=4,PIndex=-1)
	End Object
	
	Camos(0)=WeaponCamo'M46_Tan'
    Camos(1)=WeaponCamo'M46_Jungle'
    Camos(2)=WeaponCamo'M46_Blue'
    Camos(3)=WeaponCamo'M46_Black'
}
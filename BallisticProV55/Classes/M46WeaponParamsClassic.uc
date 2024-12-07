class M46WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=30.0
		HeadMult=3.3
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTM46Assault'
		DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM46Assault'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter_C'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Fire1',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=85.000000
		Chaos=-1.0
		Inaccuracy=(X=1,Y=1)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		AimedFireAnim="AimedFire"
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M46Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Damage=160.000000
		DamageRadius=340.000000
		Speed=1500.000000
		HeadMult=2.000000
		LimbMult=0.500000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.500000
		BurstFireRateFactor=1.00
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.000000),(InVal=0.400000,OutVal=-0.300000),(InVal=0.600000,OutVal=0.400000),(InVal=0.800000,OutVal=-0.500000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.250000,OutVal=0.500000),(InVal=0.300000,OutVal=0.700000),(InVal=0.600000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Scope
		//Layout core
		LayoutName="Scoped"
		Weight=30
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=0,Scale=0f)
		SightOffset=(X=-1,Y=0.050000,Z=3.9)
		//Function
		SightMoveSpeedFactor=0.500000
		SightingTime=0.40000
		bNeedCock=True
		MagAmmo=25
		InventorySize=7
		SightPivot=(Pitch=600,Roll=-1024)
        ZoomType=ZT_Logarithmic
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ViewOffset=(X=7,Y=5.00,Z=-3.5)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

    Begin Object Class=WeaponParams Name=ClassicParams_RDS
		//Layout core
		LayoutName="RDS"
		Weight=20
		//Attachments
        WeaponBoneScales(0)=(BoneName="Scope",Slot=0,Scale=0f)
		SightOffset=(X=-2.5,Y=0.04,Z=3.85)
		SightPivot=(Pitch=0,Roll=0)
		//Function
        SightingTime=0.350000
		bNeedCock=True
        MagAmmo=25
        InventorySize=7
        //SightPivot=(Pitch=-300,Roll=0)
        //SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ViewOffset=(X=7,Y=5.00,Z=-3.5)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
	
	Layouts(0)=WeaponParams'ClassicParams_Scope'
    Layouts(1)=WeaponParams'ClassicParams_RDS'

	//Camos
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
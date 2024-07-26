class PS9mWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=3000.000000)
		Damage=12
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_PS9MDart'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_PS9MDartHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_PS9MDart'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.300000
		Recoil=64.000000
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Fire',Volume=0.25,Radius=16,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.075000
		FireAnimRate=3
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Neurotoxin
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Tox
		TraceRange=(Min=3000.000000)
		Damage=12
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_PS9MDart'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_PS9MDartHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_PS9MDart'
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
		FlashScaleFactor=0.300000
		Recoil=64.000000
		Chaos=0.050000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-FireAlt',Volume=0.25,Radius=16,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Tox
		FireInterval=0.11
		FireAnimRate=1.5
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Tox'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.PS9mMedDart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=6500.000000
		Damage=20
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-DartFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		FireAnim="Dart_Fire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.000000),(InVal=0.50000,OutVal=0.120000),,(InVal=0.7000,OutVal=-0.010000),(InVal=1.000000,OutVal=0.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.200000),(InVal=0.4500000,OutVal=0.40000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.04
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=0.450000
		AimSpread=(Min=64,Max=128)
        ADSMultiplier=1
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout
		LayoutName="Poison Auto"
		Weight=10
		//Stats
		MagAmmo=10
		InventorySize=1
        SightingTime=0.200000
        SightMoveSpeedFactor=0.9
        DisplaceDurationMult=0.5
		ReloadAnimRate=1.25
		CockAnimRate=1.25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Tox
		//Layout
		LayoutName="Neurotoxin"
		LayoutTags="tox"
		Weight=2
		//Stats
		MagAmmo=10
		InventorySize=1
        SightingTime=0.200000
        SightMoveSpeedFactor=0.9
        DisplaceDurationMult=0.5
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Rapid Burst",ModeID="WM_BigBurst",Value=2.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Tox'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=PS_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-Black",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-TigerGreen",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=PS_RedTiger
		Index=3
		CamoName="Ember"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.StealthCamos.Stealth-Tiger",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'PS_Gray' //Black
	Camos(1)=WeaponCamo'PS_Black'
	Camos(2)=WeaponCamo'PS_Jungle'
	Camos(3)=WeaponCamo'PS_RedTiger'
}
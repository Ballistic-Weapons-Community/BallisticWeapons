class M46WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=2363,Max=5000)
		PenetrationEnergy=48
        RangeAtten=0.75
        Damage=30
        HeadMult=2.0f
        LimbMult=0.75f
        DamageType=Class'BallisticProV55.DTM46Assault'
        DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
        DamageTypeArm=Class'BallisticProV55.DTM46Assault'
        PenetrateForce=150
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.M46FlashEmitter'
        FlashScaleFactor=0.450000
        Recoil=170.000000
        Chaos=0.032000
        BotRefireRate=0.99
        WarnTargetPct=0.2
        FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Fire1',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        AimedFireAnim="AimedFire"
		FireInterval=0.135000
        FireEndAnim=	
        FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        ProjectileClass=Class'BallisticProV55.M46Grenade'
        SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
        Speed=2700.000000
        Damage=90.000000
		DamageRadius=384.000000
        MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
        Recoil=None
        Chaos=None
        BotRefireRate=0.3
        WarnTargetPct=0.8	
        FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_FireGren',Volume=1.750000)
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.750000
        PreFireTime=0.450000
        PreFireAnim="GrenadePrepFire"
        FireAnim="GrenadeFire"	
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.10000,OutVal=0.000000),(InVal=0.150000,OutVal=0.080000),(InVal=0.25000,OutVal=0.04000),(InVal=0.300000,OutVal=-0.0500000),(InVal=0.450000,OutVal=0.0000000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=-0.12),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.500000,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineDelay=0.165000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.550000
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout core
		LayoutName="Scoped"
		Weight=30
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=0,Scale=0f)
		//Function
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
        MagAmmo=24
        InventorySize=6
		// ADS handling
		SightingTime=0.4
        SightMoveSpeedFactor=0.6
		// Zoom
        ZoomType=ZT_Fixed
		MaxZoom=3
		ScopeScale=0.65
		SightPivot=(Pitch=600,Roll=-1024)
		SightOffset=(X=-1,Y=0.050000,Z=3.9)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		LayoutName="RDS"
		Weight=20
		//Attachments
        WeaponBoneScales(0)=(BoneName="Scope",Slot=0,Scale=0f)
		//Function
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightingTime=0.350000
        MagAmmo=24
        InventorySize=6
		SightOffset=(X=-2.5,Y=-1.000000,Z=3.85)
		SightMoveSpeedFactor=0.8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
		
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
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenMain",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenClip",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoGreenGrenadeLauncher",Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6)
	End Object
	
	Begin Object Class=WeaponCamo Name=M46_Blue
		Index=2
		CamoName="Ocean"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoBlueMain",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AL_PulseRifle_Clip",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-CamoBlueGrenadeLauncher",Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6)
	End Object
	
	Begin Object Class=WeaponCamo Name=M46_Black
		Index=3
		CamoName="Stealth"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayMain",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayClip",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M46Camos.AR-GrayGrenadeLauncher",Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.OA-AR.OA-AR_Grenade',Index=4)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.OA-AR.OA-AR_Scope_Shine',Index=5)
		WeaponMaterialSwaps(6)=(Material=FinalBlend'BW_Core_WeaponTex.OA-SMG.OA-SMG_SightFB',Index=6)
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams_Scope'
    Layouts(1)=WeaponParams'ArenaParams_RDS'
	Camos(0)=WeaponCamo'M46_Tan'
    Camos(1)=WeaponCamo'M46_Jungle'
    Camos(2)=WeaponCamo'M46_Blue'
    Camos(3)=WeaponCamo'M46_Black'
}
class M46WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
        TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=2363,Max=5000)
        RangeAtten=0.75
        Damage=45
        HeadMult=2.75f
        LimbMult=0.75f
        DamageType=Class'BallisticProV55.DTM46Assault'
        DamageTypeHead=Class'BallisticProV55.DTM46AssaultHead'
        DamageTypeArm=Class'BallisticProV55.DTM46Assault'
        PenetrationEnergy=48
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

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        AimedFireAnim="AimedFire"
		FireInterval=0.125000
        FireEndAnim=	
        FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
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

    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=0.750000
        PreFireTime=0.450000
        PreFireAnim="GrenadePrepFire"
        FireAnim="GrenadeFire"	
        FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.080000,OutVal=0.050000),(InVal=0.110000,OutVal=0.080000),(InVal=0.150000,OutVal=0.14000),(InVal=0.300000,OutVal=0.2300000),(InVal=0.450000,OutVal=0.2500000),(InVal=0.600000,OutVal=0.350000),(InVal=0.800000,OutVal=0.380000),(InVal=1.000000,OutVal=0.25)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.120000),(InVal=0.300000,OutVal=0.350000),(InVal=0.5,OutVal=0.600000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineDelay=0.1700000
		DeclineTime=0.65
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.60000
		AimSpread=(Min=384,Max=1536)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams_Scope
		SightingTime=0.5
        SightMoveSpeedFactor=0.35
        MagAmmo=24
        InventorySize=6
		// acog
        ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=4
		ZoomStages=1
        WeaponBoneScales(0)=(BoneName="RDS",Slot=0,Scale=0f)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=TacticalParams_RDS
		SightingTime=0.35000
        SightMoveSpeedFactor=0.6
        MagAmmo=24
        InventorySize=6
		ViewOffset=(X=5.000000,Y=4.750000,Z=-8.000000)
		ViewPivot=(Pitch=384)
        SightPivot=(Pitch=-300,Roll=0)
        SightOffset=(X=-10.000000,Y=0.000000,Z=11.550000)
        WeaponBoneScales(0)=(BoneName="Scope",Slot=0,Scale=0f)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
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
	
    Layouts(0)=WeaponParams'TacticalParams_Scope'
    Layouts(1)=WeaponParams'TacticalParams_RDS'
	Camos(0)=WeaponCamo'M46_Tan'
    Camos(1)=WeaponCamo'M46_Jungle'
    Camos(2)=WeaponCamo'M46_Blue'
    Camos(3)=WeaponCamo'M46_Black'
}
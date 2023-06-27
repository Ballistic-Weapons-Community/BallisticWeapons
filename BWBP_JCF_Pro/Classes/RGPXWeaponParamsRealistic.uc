class RGPXWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.RGPXRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=5000.000000
		MaxSpeed=17500.000000
		AccelSpeed=18000.000000
		Damage=120
		DamageRadius=512.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BWBP_JCF_Pro.RGPXFlashEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_Fire',Volume=1.500000)
		Recoil=256.000000
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.RGPXFlakGrenade'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=1800.000000
		MaxSpeed=3000.000000
		AccelSpeed=18000.000000
		Damage=40
		DamageRadius=384.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BWBP_JCF_Pro.RGPXFlashEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_FireFlak',Volume=1.800000)
		Recoil=256.000000
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.7
		EscapeMultiplier=1.4
		XRandFactor=0.350000
		YRandFactor=0.350000
		MaxRecoil=8192
		ClimbTime=0.1
		DeclineDelay=0.250000
		DeclineTime=1
		CrouchMultiplier=0.85
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.7
		AimAdjustTime=0.6
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
        JumpOffset=(Pitch=-6000,Yaw=-1500)
        ChaosSpeedThreshold=300
		ChaosDeclineTime=1.600000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=RealisticParams
	    PlayerJumpFactor=0.9
		InventorySize=8
		SightMoveSpeedFactor=0.35
		SightingTime=0.4		
		DisplaceDurationMult=1
		PlayerSpeedFactor=0.90000
		MagAmmo=6
		WeaponBoneScales(0)=(BoneName="Irons",Slot=18,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=19,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RocketMain",Slot=20,Scale=1f)
		WeaponBoneScales(3)=(BoneName="RocketBig",Slot=21,Scale=0f)
		ViewOffset=(X=10.000000,Y=20.000000,Z=-22.000000)
		SightOffset=(X=-5.000000,Y=-30.000000,Z=24.300000)
		SightPivot=(Yaw=-512)
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=RPG_Orange
		Index=0
		CamoName="Orange"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RPG_Green
		Index=1
		CamoName="Green"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RGPCamos.RGP_Launcher_S2",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=RPG_Wood
		Index=2
		CamoName="Wood"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RGPCamos.RGX_Black_Diff",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'RPG_Orange'
	Camos(1)=WeaponCamo'RPG_Green'
	Camos(2)=WeaponCamo'RPG_Wood'
}
class RGPXWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
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

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
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
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
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

	Begin Object Class=AimParams Name=TacticalAimParams
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

    Begin Object Class=WeaponParams Name=TacticalParams
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
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
class RGPXWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.RGPXRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=5000.000000
		MaxSpeed=17500.000000
		AccelSpeed=18000.000000
		Damage=80
		DamageRadius=356.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BWBP_JCF_Pro.RGPXFlashEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_Fire',Volume=1.500000)
		Recoil=256.000000
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_JCF_Pro.RGPXFlakGrenade'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=1800.000000
		MaxSpeed=3000.000000
		AccelSpeed=18000.000000
		Damage=40
		DamageRadius=520.000000
		MomentumTransfer=100000.000000
		MuzzleFlashClass=Class'BWBP_JCF_Pro.RGPXFlashEmitter'
		FlashScaleFactor=0.250000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_FireFlak',Volume=1.800000)
		Recoil=256.000000
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
     	XRandFactor=1.500000
		YRandFactor=0.700000
		DeclineDelay=0.700000
		DeclineTime=1.00000
		MaxRecoil=512
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.200000
		FallingChaos=0.200000
		SprintChaos=0.200000
		AimAdjustTime=0.900000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
	    PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.85
		SightingTime=0.4		
		DisplaceDurationMult=1
		PlayerSpeedFactor=0.850000
		MagAmmo=6
		WeaponBoneScales(0)=(BoneName="Irons",Slot=18,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Scope",Slot=19,Scale=0f)
		WeaponBoneScales(2)=(BoneName="RocketMain",Slot=20,Scale=1f)
		WeaponBoneScales(3)=(BoneName="RocketBig",Slot=21,Scale=0f)
		SightOffset=(X=-20.000000,Y=-30.000000,Z=24.300000)
		SightPivot=(Yaw=-512)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}
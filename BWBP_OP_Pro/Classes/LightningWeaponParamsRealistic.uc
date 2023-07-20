class LightningWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=80
        HeadMult=1.75
        LimbMult=0.75
		DamageType=Class'BWBP_OP_Pro.DT_LightningRifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_LightningHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_LightningRifle'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
		FlashScaleFactor=0.600000
		PushbackForce=256.000000
		Recoil=128.000000
		Chaos=0.800000
		BotRefireRate=0.400000
		WarnTargetPct=0.5
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.850000
		FireAnim="FireCharged"
		FireAnimRate=0.800000	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.LightningProjectile'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.LS14-EnergyRocket',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Speed=2000.000000
		MaxSpeed=2000.000000
		Damage=70
		DamageRadius=100.000000
		PushbackForce=256.000000
		MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=400.000000
		Chaos=0.800000
		BotRefireRate=0.400000
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.5
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.300000
		ClimbTime=0.07
		DeclineDelay=0.4
		DeclineTime=0.750000
		CrouchMultiplier=0.75
		HipMultiplier=1.5
		MaxMoveMultiplier=2.5
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=740,Max=2508) //Huge ass hunk of metal
		AimAdjustTime=0.900000
		OffsetAdjustTime=0.325000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		ChaosDeclineTime=1.300000
		ChaosSpeedThreshold=300
		SprintChaos=0.450000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-6000,Yaw=2000)
		FallingChaos=0.450000
		
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//SightOffset=(X=35,Z=51.000000)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=7
		SightMoveSpeedFactor=0.35
		SightingTime=0.45	
		ScopeScale=0.7
		DisplaceDurationMult=1.25
		MagAmmo=20
		// sniper 4-8x
        ZoomType=ZT_Logarithmic
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}
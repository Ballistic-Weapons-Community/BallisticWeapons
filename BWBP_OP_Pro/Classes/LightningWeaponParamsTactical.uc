class LightningWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=80
        HeadMult=1.5f
        LimbMult=0.75f
		DamageType=Class'BWBP_OP_Pro.DT_LightningRifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_LightningHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_LightningRifle'
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
		FlashScaleFactor=0.600000
		PushbackForce=256.000000
		Recoil=1024.000000
		Chaos=0.800000
		BotRefireRate=0.400000
		WarnTargetPct=0.5
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.850000
		FireAnim="FireCharged"
		FireAnimRate=0.800000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
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

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.5
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.300000
		ClimbTime=0.15
		DeclineDelay=0.75
		DeclineTime=0.750000
		CrouchMultiplier=0.6
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=768,Max=4096)
		ADSMultiplier=0.5
		AimAdjustTime=0.80000
		ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=0.9
		SightOffset=(X=35,Z=51.000000)
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
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
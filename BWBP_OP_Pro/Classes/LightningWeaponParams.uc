class LightningWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=80
		HeadMult=1.5f
		LimbMult=0.9f
		DamageType=Class'BWBP_OP_Pro.DT_LightningRifle'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_LightningHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_LightningRifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=1024.000000
		Chaos=0.800000
		BotRefireRate=0.400000
		WarnTargetPct=0.500000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.850000
		FireAnim="FireCharged"
		FireAnimRate=0.800000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.LightningProjectile'
		Speed=750.000000
		MaxSpeed=1500.000000
		AccelSpeed=1500.000000
		Damage=70
		DamageRadius=100.000000
		MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=400.000000
		Chaos=0.800000
		BotRefireRate=0.400000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.500000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.500000
		YawFactor=0.100000
		XRandFactor=0.200000
		YRandFactor=0.300000
		DeclineDelay=1.000000
		DeclineTime=0.800000
		CrouchMultiplier=0.6
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=192,Max=1024)
		ADSMultiplier=0.2
		AimAdjustTime=0.750000
		ChaosSpeedThreshold=600.000000
		ChaosDeclineTime=0.750000
		SprintOffset=(Pitch=-8192,Yaw=-12288)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.950000
		PlayerJumpFactor=0.950000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.450000
		DisplaceDurationMult=1.25
		MagAmmo=8
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
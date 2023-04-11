class LightningWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=80
        HeadMult=1.75f
        LimbMult=0.85f
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
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.LS14-EnergyRocket',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Speed=750.000000
		MaxSpeed=1500.000000
		AccelSpeed=1500.000000
		Damage=70
		DamageRadius=100.000000
		PushbackForce=256.000000
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
		ClimbTime=0.07
		DeclineDelay=0.4
		DeclineTime=0.750000
		CrouchMultiplier=0.6
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1024)
		ADSMultiplier=0.35
		AimAdjustTime=0.750000
		ChaosSpeedThreshold=300
		ChaosDeclineTime=0.750000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		//SightOffset=(X=35,Z=51.000000)
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=6
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		ScopeScale=0.7
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
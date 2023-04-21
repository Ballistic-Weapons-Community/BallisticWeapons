class HVPCMk5WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		Damage=100
		HeadMult=2.75f
		LimbMult=0.65f
		DamageRadius=512.000000
		MomentumTransfer=65000.000000
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.400000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=5
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=6500.000000
		MaxSpeed=20000.000000
		AccelSpeed=150000.000000
		Damage=50
		HeadMult=2.75f
		LimbMult=0.65f
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		FlashScaleFactor=0.400000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.025000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.175000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.3
		ADSViewBindFactor=0.7
		YawFactor=0.100000
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		ClimbTime=0.05
		DeclineDelay=0.300000
		DeclineTime=0.600000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.25
		AimAdjustTime=0.8
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=3000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.50000		
		SightPivot=(Pitch=256)
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}
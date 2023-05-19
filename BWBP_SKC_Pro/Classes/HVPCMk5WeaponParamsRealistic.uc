// Strong and fast, one shot instead of the spread of 3
class HVPCMk5WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=1350.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		MomentumTransfer=65000.000000
		Damage=85
		DamageRadius=278.000000
		HeadMult=2.0
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=270.000000
		Chaos=0.150000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.720000
		AmmoPerFire=5
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.0
		LimbMult=0.65
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=10.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.200000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		DeclineTime=1.750000
		ViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=3072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpChaos=0.400000
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=29
		SightMoveSpeedFactor=0.500000
		//SightOffset=(X=-12.000000,Y=-0.200000,Z=17.300000)
		//ViewOffset=(X=0.000000,Y=-0.200000,Z=-15.000000)
	 	SightPivot=(Pitch=256)		
		WeaponName="HVM Experimental Plasma Cannon Mk5"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
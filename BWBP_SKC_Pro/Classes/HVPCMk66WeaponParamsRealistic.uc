class HVPCMk66WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66Projectile'
		SpawnOffset=(X=100.000000,Y=10.000000,Z=-9.000000)
		Speed=8500.000000
		MaxSpeed=1000000.000000
		AccelSpeed=100.000000
		Damage=500.000000
		DamageRadius=1200.000000
		MomentumTransfer=280000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BWBP_SKC_Pro.BFGFlashEmitter'
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-Fire',Volume=4.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=820.000000
		Chaos=0.600000
		Inaccuracy=(X=8,Y=8)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=2.500000
		AmmoPerFire=50
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66ProjectileSmall'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=250.000000
		MaxSpeed=2000000.000000
		AccelSpeed=190000.000000
		Damage=60
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.083333
		LimbMult=0.666666
		MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-SmallFire',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=20.000000
		Chaos=0.050000
		Inaccuracy=(X=24,Y=24)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.110000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireAnim="Fire2"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.4000000)))
		YawFactor=0.100000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		DeclineTime=0.750000
		ViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=3072)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-5000)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.650000
		PlayerJumpFactor=0.600000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		//SightOffset=(X=-18.000000,Z=23.299999)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
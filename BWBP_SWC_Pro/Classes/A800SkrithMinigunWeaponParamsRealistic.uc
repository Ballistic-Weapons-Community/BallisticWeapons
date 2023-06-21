class A800SkrithMinigunWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=5500.000000
		MaxSpeed=14000.000000
		AccelSpeed=100000.000000
		Damage=60
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_SWC_Sounds.A800.A800-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=120.000000
		Chaos=0.100000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.075000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A800StickyBombProjectile'
		SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
		Speed=1000.000000
		MaxSpeed=2000.000000
		AccelSpeed=8000.000000
		Damage=150
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.A800.A800-AltFire2',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=650.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.850000
		AmmoPerFire=20
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.05000,OutVal=-0.200000),(InVal=0.20000,OutVal=-0.100000),(InVal=0.500000,OutVal=0.350000),(InVal=0.600000,OutVal=0.450000),(InVal=0.700000,OutVal=0.500000),(InVal=0.8500000,OutVal=0.650000),(InVal=1.000000,OutVal=0.700000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.050000),(InVal=0.475000,OutVal=0.250000),(InVal=0.575000,OutVal=0.500000),(InVal=0.675000,OutVal=0.400000),(InVal=0.825000,OutVal=0.500000),(InVal=1.000000,OutVal=0.350000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		DeclineTime=1.700000
		DeclineDelay=0.40000
		ViewBindFactor=0.150000
		MaxRecoil=2096
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ViewBindFactor=0.2
		ADSMultiplier=1
		AimSpread=(Min=128,Max=2048)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.650000
		AimDamageThreshold=75.000000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		ChaosDeclineTime=5.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		SightingTime=0.600000
        MagAmmo=80
        InventorySize=7
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		SightOffset=(X=-30.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=20.000000,Y=20.000000,Z=-15.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
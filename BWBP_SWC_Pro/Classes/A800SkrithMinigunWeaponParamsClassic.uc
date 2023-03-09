class A800SkrithMinigunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewProjectile'
		SpawnOffset=(X=1.000000,Y=5.000000,Z=-5.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=60000.000000
		Damage=27
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.A73E.A73E-Fire',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=40.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.075000
		FireLoopAnim="FireLoop"
		FireEndAnim="FireEnd"
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A73NewPowerProjectile'
		SpawnOffset=(X=400.000000,Y=7.000000,Z=-9.000000)
		Speed=1000.000000
		MaxSpeed=2000.000000
		AccelSpeed=8000.000000
		Damage=75
		DamageRadius=384.000000
		MomentumTransfer=50000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SWC_Pro.A73FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.A73E.A73E-Power',Slot=SLOT_Interact,bNoOverride=False)
		Recoil=650.000000
		Chaos=0.500000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.850000
		AmmoPerFire=20
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.2
		//XCurve=(Points=(,(InVal=0.070000,OutVal=0.050000),(InVal=0.100000,OutVal=0.085000),(InVal=0.180000,OutVal=0.060000),(InVal=0.300000,OutVal=0.100000),(InVal=0.500000,OutVal=0.200000),(InVal=0.650000,OutVal=0.300000),(InVal=0.700000,OutVal=0.4500000),(InVal=0.850000,OutVal=0.400000),(InVal=1.000000,OutVal=0.55)))
		//YCurve=(Points=(,(InVal=0.050000,OutVal=0.070000),(InVal=0.100000,OutVal=0.120000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.400000),(InVal=0.550000,OutVal=0.650000),(InVal=0.650000,OutVal=0.750000),(InVal=0.800000,OutVal=0.820000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.450000
		YRandFactor=0.450000
		DeclineTime=1.700000
		DeclineDelay=0.40000
		MaxRecoil=4096
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
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
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		SightingTime=0.600000
        MagAmmo=80
        InventorySize=29
        SightMoveSpeedFactor=0.75
		ZoomType=ZT_Logarithmic
		SightOffset=(X=-30.000000,Y=-25.000000,Z=6.500000)
		SightPivot=(Roll=-1900)
		ViewOffset=(X=40.000000,Y=14.000000,Z=-15.000000)
		ViewPivot=(Roll=-256)
		ReloadAnimRate=1.300000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
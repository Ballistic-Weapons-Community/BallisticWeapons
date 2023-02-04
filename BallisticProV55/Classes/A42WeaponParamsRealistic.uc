class A42WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A42Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
		Speed=1200.000000
		MaxSpeed=5000.000000
		AccelSpeed=20000.000000
		Damage=30.0
		DamageRadius=42.000000
		MomentumTransfer=150.000000
		HeadMult=2.366666
		LimbMult=0.7
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.800000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Fire',Volume=0.750000,Pitch=1.10000)
		Recoil=252.000000
		Chaos=0.030000
		Inaccuracy=(X=92,Y=92)
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		TargetState="Spread"
		FireInterval=0.240000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
		FlashScaleFactor=0.600000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-SecFire',Pitch=1.100000,Volume=0.800000)
		Recoil=84.000000
		Chaos=0.010000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.08000
		BurstFireRateFactor=1.00
		FireAnim="SecFire"
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.400000,OutVal=0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=1536.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		SightingTime=0.15
		MagAmmo=72
		ViewOffset=(X=9.000000,Y=9.000000,Z=-10.000000)
		SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
		SightPivot=(Pitch=1024,Roll=-768)
        WeaponName="A48 Skrith Blaster"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
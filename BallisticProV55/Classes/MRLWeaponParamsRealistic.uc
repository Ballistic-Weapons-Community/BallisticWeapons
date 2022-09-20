class MRLWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocket'
		SpawnOffset=(X=28.000000,Y=10.000000,Z=-8.000000)
		Speed=800.000000
		MaxSpeed=5000.000000
		AccelSpeed=8000.000000
		Damage=100.000000
		DamageRadius=120.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Recoil=32.000000
		Chaos=-0.100000
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.125000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLDrunkRocketSecondary'
		SpawnOffset=(X=28.000000,Y=8.000000,Z=-6.000000)
		MaxSpeed=3500
		AccelSpeed=5000
		HeadMult=2.000000
		LimbMult=0.500000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
		Recoil=32.000000
		Chaos=0.020000
		Inaccuracy=(X=512,Y=512)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.50000
		YRandFactor=0.50000
		MaxRecoil=512.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=1024,Max=3584)
		AimAdjustTime=0.600000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-5000,Yaw=-7000)
		AimDamageThreshold=375.000000
		ChaosDeclineTime=1.650000
		ChaosSpeedThreshold=400
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.80000
		InventorySize=29
		SightMoveSpeedFactor=0.500000
		SightingTime=0.45
		MagAmmo=40
		ViewOffset=(X=12.000000,Y=9.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-512,Roll=1024)
		WeaponName="JL21 'PeaceMaker' Rocket Launcher"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
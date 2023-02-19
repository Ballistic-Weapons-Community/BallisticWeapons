class MACWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MACShell'
		SpawnOffset=(X=28.000000,Y=10.000000)
		Speed=1300.000000
		MaxSpeed=20000.000000
		AccelSpeed=20000.000000
		Damage=350.000000
		DamageRadius=192.000000
		MomentumTransfer=80000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire')
		Recoil=8000.000000
		Chaos=0.800000
		PushbackForce=500.000000
		Inaccuracy=(X=72,Y=72)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=1.500000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=8192.000000
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
		AimSpread=(Min=1536,Max=3072)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.400000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		ChaosDeclineTime=4.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=29
		SightMoveSpeedFactor=0.500000
		SightingTime=0.4500000
		MagAmmo=5
		bMagPlusOne=True
        ZoomType=ZT_Logarithmic
		WeaponName="J2329-HAMR Assault Cannon"
		ViewOffset=(X=3.000000,Y=12.000000,Z=-3.000000)
		SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
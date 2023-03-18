class A500WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A500Projectile'
		Speed=6000.000000
		MaxSpeed=6000.000000
		Damage=17.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=2.235294
		LimbMult=0.588235
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_Fire1',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=500)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.750000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=class'BallisticProV55.A500AltProjectile'
		Speed=2400.000000
		MaxSpeed=2400.000000
		Damage=120.000000
		DamageRadius=96.000000
		MomentumTransfer=1000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=0.0
		Chaos=-1.0
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.100000),(InVal=1.000000,OutVal=0.400000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.700000,OutVal=0.500000),(InVal=1.000000,OutVal=0.300000)))
		PitchFactor=0.500000
		YawFactor=0.200000
		XRandFactor=0.275000
		YRandFactor=0.275000
		MaxRecoil=1536.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=1792)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=10
		WeaponBoneScales(0)=(BoneName="Diamond",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SuperCharger",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Stands",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Glass",Slot=4,Scale=0f)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=10
		ViewOffset=(X=-9.000000,Y=13.000000,Z=-15.000000)
		ViewPivot=(Pitch=600)
		SightOffset=(X=4.000000,Y=0.100000,Z=30.250000)
		SightPivot=(Pitch=1024)
		WeaponName="A500 'Reptile' Chemical Gun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
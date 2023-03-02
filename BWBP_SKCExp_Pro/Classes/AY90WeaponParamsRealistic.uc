class AY90WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Uncharged
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=6000.000000
		MaxSpeed=35000.000000
		AccelSpeed=90000.000000
		DamageRadius=230.000000
		Damage=150
		MomentumTransfer=30000.000000
		HeadMult=2.000000
		LimbMult=0.500000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsNoCharge
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Half Charged
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryChargedEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileFast'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		MaxSpeed=10000.000000
		AccelSpeed=90000.000000
		Damage=250
		DamageRadius=250.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlast',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsHalfCharge
		FireInterval=1.000000
		AmmoPerFire=20
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryChargedEffectParams'
	End Object
	
	//Fully Charged
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryMaxEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileSuper'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		MaxSpeed=1000000.000000
		AccelSpeed=90000.000000
		Damage=400
		DamageRadius=832.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlastMax',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParamsMaxCharge
		FireInterval=1.000000
		AmmoPerFire=40
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryMaxEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'AY90Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=85.000000
		MaxSpeed=4500.000000
		AccelSpeed=70000.000000
		Damage=40
		DamageRadius=96.000000
		MomentumTransfer=150.000000
		HeadMult=2.5
		LimbMult=0.5
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
		Recoil=0.0
		Chaos=-1.0
		Inaccuracy=(X=2000,Y=10)
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=256,Max=1536)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		JumpChaos=0.400000
		FallingChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=15
		MagAmmo=40
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		SightOffset=(Y=4.700000,Z=8.000000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParamsNoCharge'
		FireParams(1)=FireParams'RealisticPrimaryFireParamsHalfCharge'
		FireParams(2)=FireParams'RealisticPrimaryFireParamsMaxCharge'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(2)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
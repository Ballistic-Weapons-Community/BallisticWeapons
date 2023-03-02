class AY90WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Uncharged
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=2000.000000
		MaxSpeed=35000.000000
		AccelSpeed=35000.000000
		DamageRadius=230.000000
		Damage=150
		MomentumTransfer=30000.000000
		HeadMult=2.000000
		LimbMult=0.500000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsNoCharge
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Half Charged
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryChargedEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileFast'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=5000.000000
		MaxSpeed=10000.000000
		AccelSpeed=90000.000000
		Damage=250
		DamageRadius=250.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlast',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsHalfCharge
		FireInterval=1.000000
		AmmoPerFire=20
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryChargedEffectParams'
	End Object
	
	//Fully Charged
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryMaxEffectParams
		ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileSuper'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=8500.000000
		MaxSpeed=1000000.000000
		AccelSpeed=100.000000
		Damage=500
		DamageRadius=832.000000
		HeadMult=2.000000
		LimbMult=0.500000
		MomentumTransfer=30000.000000
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltBlastMax',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsMaxCharge
		FireInterval=1.000000
		AmmoPerFire=40
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryMaxEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1740)
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
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=15
		MagAmmo=40
		SightMoveSpeedFactor=0.500000
		SightOffset=(Y=4.700000,Z=8.000000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParamsNoCharge'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsHalfCharge'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsMaxCharge'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
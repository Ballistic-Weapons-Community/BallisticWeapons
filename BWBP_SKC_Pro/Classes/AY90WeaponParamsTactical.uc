class AY90WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Uncharged
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AY90BoltProjectile'
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
		Recoil=512.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParamsNoCharge
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//Half Charged
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryChargedEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AY90BoltProjectileFast'
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
		Recoil=768.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParamsHalfCharge
		FireInterval=1.000000
		AmmoPerFire=20
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryChargedEffectParams'
	End Object
	
	//Fully Charged
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryMaxEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AY90BoltProjectileSuper'
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
		Recoil=2048.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParamsMaxCharge
		FireInterval=1.000000
		AmmoPerFire=40
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryMaxEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Yes Charge
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'AY90WaveProjectile'
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
		Inaccuracy=(X=100,Y=10)
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//No Charge
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParamsNoCharge
		ProjectileClass=Class'AY90WaveProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=85.000000
		MaxSpeed=4500.000000
		AccelSpeed=70000.000000
		Damage=20
		DamageRadius=96.000000
		MomentumTransfer=150.000000
		HeadMult=2.5
		LimbMult=0.5
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
		Recoil=0.0
		Chaos=-1.0
		Inaccuracy=(X=100,Y=10)
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParamsNoCharge
		FireInterval=1.000000
		AmmoPerFire=10
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParamsNoCharge'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=8192.000000
		ClimbTime=0.15
		DeclineTime=1.500000
		ViewBindFactor=0.150000
		HipMultiplier=2
		CrouchMultiplier=0.600000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=512,Max=2560)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		ADSMultiplier=0.5
		AimAdjustTime=0.800000
		ChaosDeclineTime=1.200000
        ChaosSpeedThreshold=500
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=8
		MagAmmo=40
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParamsNoCharge'
		FireParams(1)=FireParams'TacticalPrimaryFireParamsHalfCharge'
		FireParams(2)=FireParams'TacticalPrimaryFireParamsMaxCharge'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParamsNoCharge'
		AltFireParams(1)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(2)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}
class AY90WeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
		//UnCharged
		Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryUnChargedEffectParams
			ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=5500.000000
			MaxSpeed=14000.000000
			AccelSpeed=100000.000000
			HeadMult=1.5f
			LimbMult=0.9f
			Damage=20
			DamageRadius=30.000000
			MaxDamageGainFactor=0.75
			DamageGainStartTime=0.05
			DamageGainEndTime=0.25
			MomentumTransfer=500.000000
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=128.000000
			Chaos=0.300000
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryUnChargedFireParams
			FireInterval=0.750000
			AmmoPerFire=5
			AimedFireAnim="SightFire"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryUnChargedEffectParams'
		End Object
		
		//Charged
		Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryChargedEffectParams
			ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileFast'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=5500.000000
			MaxSpeed=14000.000000
			AccelSpeed=100000.000000
			HeadMult=1.5f
			LimbMult=0.9f
			Damage=200
			DamageRadius=180.000000
			MaxDamageGainFactor=1.75
			DamageGainStartTime=0.05
			DamageGainEndTime=0.25
			MomentumTransfer=1000.000000
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=256.000000
			Chaos=0.500000
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryChargedFireParams
			FireInterval=0.750000
			AmmoPerFire=15
			AimedFireAnim="SightFire"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryChargedEffectParams'
		End Object
		
		//Max
		Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryMaxEffectParams
			ProjectileClass=Class'BWBP_SKCExp_Pro.AY90BoltProjectileSuper'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=5500.000000
			MaxSpeed=14000.000000
			AccelSpeed=100000.000000
			HeadMult=1.5f
			LimbMult=0.9f
			Damage=205
			DamageRadius=768.000000
			MaxDamageGainFactor=1.75
			DamageGainStartTime=0.05
			DamageGainEndTime=0.25
			MomentumTransfer=2000.000000
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SkrithBow.SkrithBow-BoltShot',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=512.000000
			Chaos=0.500000
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ArenaPrimaryMaxFireParams
			FireInterval=0.750000
			AmmoPerFire=30
			AimedFireAnim="SightFire"
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryMaxEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
			ProjectileClass=Class'AY90WaveProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=5500.000000
			MaxSpeed=14000.000000
			AccelSpeed=70000.000000
			Damage=50
			DamageRadius=15.000000
			MaxDamageGainFactor=1.00
			DamageGainStartTime=0.05
			DamageGainEndTime=0.7
			MomentumTransfer=150.000000
			HeadMult=1.5f
			LimbMult=0.9f
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
			Recoil=130.00000
			Chaos=0.020000
			Inaccuracy=(X=200,Y=10)
			WarnTargetPct=0.500000	
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams
			FireInterval=0.750000
			AmmoPerFire=5
			BurstFireRateFactor=1.00
			AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
		End Object
	
		Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_NoCharge
			ProjectileClass=Class'AY90WaveProjectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=5500.000000
			MaxSpeed=14000.000000
			AccelSpeed=70000.000000
			Damage=25
			DamageRadius=15.000000
			MaxDamageGainFactor=1.00
			DamageGainStartTime=0.05
			DamageGainEndTime=0.7
			MomentumTransfer=150.000000
			HeadMult=1.5f
			LimbMult=0.9f
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.SkirthBow.SkrithBow-WaveFire',Volume=1.700000)
			Recoil=130.00000
			Chaos=0.020000
			Inaccuracy=(X=200,Y=10)
			WarnTargetPct=0.500000	
		End Object

		Begin Object Class=FireParams Name=ArenaSecondaryFireParams_NoCharge
			FireInterval=0.750000
			AmmoPerFire=5
			BurstFireRateFactor=1.00
			AimedFireAnim="SightFire"
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_NoCharge'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
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

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		AimSpread=(Min=16,Max=1740)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=12
		SightMoveSpeedFactor=0.900000
		SightOffset=(Y=4.700000,Z=7.050000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryUnChargedFireParams'
		FireParams(1)=FireParams'ArenaPrimaryChargedFireParams'
		FireParams(2)=FireParams'ArenaPrimaryMaxFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_NoCharge'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(2)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}
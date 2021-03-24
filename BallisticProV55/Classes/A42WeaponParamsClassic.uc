class A42WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BallisticProV55.A42Projectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
			Speed=50.000000
			MaxSpeed=8000.000000
			AccelSpeed=60000.000000
			Damage=15.0
			DamageRadius=48.000000
			MomentumTransfer=100.000000
			HeadMult=2.0
			LimbMult=0.533333
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
			FireSound=(Sound=Sound'BallisticSounds3.A42.A42-Fire',Volume=0.700000)
			Recoil=24.000000
			Chaos=-1.0
			Inaccuracy=(X=8,Y=4)
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.250000
			AmmoPerFire=5
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=8000.000000,Max=8000.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=65.0
			HeadMult=1.615384
			LimbMult=0.384615
			DamageType=Class'BallisticProV55.DTA42SkrithBeam'
			DamageTypeHead=Class'BallisticProV55.DTA42SkrithBeam'
			DamageTypeArm=Class'BallisticProV55.DTA42SkrithBeam'
			PenetrationEnergy=32.000000
			PenetrateForce=150
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.A42FlashEmitter'
			FireSound=(Sound=Sound'BallisticSounds3.A42.A42-SecFire',Volume=0.800000)
			Recoil=96.000000
			Chaos=-1.0
			Inaccuracy=(X=2,Y=2)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.100000
			AmmoPerFire=25
			BurstFireRateFactor=1.00
			FireAnim="SecFire"	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.000000),(InVal=0.200000,OutVal=-0.100000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=-0.500000),(InVal=0.700000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.200000),(InVal=0.400000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=512.000000
		DeclineTime=1.000000
		DeclineDelay=0.100000
		ViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=2048)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=300
		SightOffset=(X=-24.000000,Y=-3.100000,Z=15.000000)
		SightPivot=(Pitch=1024,Roll=-768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
class A73WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
			ProjectileClass=Class'BallisticProV55.A73Projectile'
			SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
			Speed=50.000000
			MaxSpeed=3000.000000
			AccelSpeed=60000.000000
			Damage=20.0
			DamageRadius=64.000000
			MomentumTransfer=100.000000
			HeadMult=2.0
			LimbMult=0.45
			SpreadMode=None
			MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
			FireSound=(Sound=Sound'BallisticSounds3.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=40.000000
			Chaos=-1.0
			Inaccuracy=(X=8,Y=4)
			WarnTargetPct=0.200000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.100000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=160.000000,Max=160.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=65.0
			HeadMult=1.538461
			LimbMult=0.461538
			DamageType=Class'BallisticProV55.DTA73Stab'
			DamageTypeHead=Class'BallisticProV55.DTA73StabHead'
			DamageTypeArm=Class'BallisticProV55.DTA73Stab'
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			HookStopFactor=1.700000
			HookPullForce=100.000000
			SpreadMode=None
			FireSound=(Sound=Sound'BallisticSounds3.A73.A73Stab',Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.700000
			WarnTargetPct=0.050000
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.300000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepStab"
			FireAnim="Stab"	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.270000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.170000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.100000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.250000
		ADSViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=40
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
class A909WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=100.000000,Max=100.000000)
			WaterTraceRange=5000.0
			Damage=22.0
			HeadMult=2.954545
			LimbMult=0.545454
			DamageType=Class'BallisticProV55.DTA909Blades'
			DamageTypeHead=Class'BallisticProV55.DTA909Head'
			DamageTypeArm=Class'BallisticProV55.DTA909Limb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=1.700000
			HookPullForce=100.000000
			SpreadMode=None
			FireSound=(Sound=SoundGroup'BallisticSounds3.A909.A909Slash',Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.350000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="PrepHack"
			FireAnimRate=1.300000
			FireEffectParams(0)=MeleeEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=120.000000,Max=120.000000)
			WaterTraceRange=5000.0
			Damage=75.0
			HeadMult=1.466666
			LimbMult=0.466666
			DamageType=Class'BallisticProV55.DTA909Blades'
			DamageTypeHead=Class'BallisticProV55.DTA909Head'
			DamageTypeArm=Class'BallisticProV55.DTA909Limb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=1.700000
			HookPullForce=100.000000
			SpreadMode=None
			FireSound=(Sound=SoundGroup'BallisticSounds3.A909.A909Slash',Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.300000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepBigHack3"
			FireAnim="BigHack3"
			FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.200000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
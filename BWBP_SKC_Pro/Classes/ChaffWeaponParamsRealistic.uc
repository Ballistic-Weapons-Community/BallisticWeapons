class ChaffWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.ChaffGrenade'
		SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
		Speed=1400
		MaxSpeed=1400
		Damage=65.000000
		DamageRadius=256.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=2
		BurstFireRateFactor=1.00
		PreFireAnim="PrepThrow"
		FireAnim="Throw"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=128.000000,Max=128.000000)
		WaterTraceRange=5000.0
		Damage=30
		HeadMult=1.666666
		LimbMult=0.833333
		DamageType=Class'BWBP_SKC_Pro.DTChaffSmack'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTChaffSmack'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTChaffSmack'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,Pitch=0.800000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.900000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="PrepSmack"
		FireAnim="Smack"
		PreFireAnimRate=2.000000
		FireAnimRate=1.500000
		FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
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
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=2
		SightMoveSpeedFactor=0.500000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
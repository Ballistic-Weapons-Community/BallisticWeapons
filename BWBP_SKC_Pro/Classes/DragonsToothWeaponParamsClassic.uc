class DragonsToothWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=125
			HeadMult=2.0
			LimbMult=0.6
			DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=1.200000
			HookPullForce=80.000000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.100000
		End Object
		
		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=1.100000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="Slash1"
			FireAnimRate=0.850000
			FireEffectParams(0)=MeleeEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=115
			HeadMult=1.5
			LimbMult=0.5
			DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=2.700000
			HookPullForce=150.000000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=5.500000,Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=1.600000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="Melee3"
			FireAnimRate=0.850000
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
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
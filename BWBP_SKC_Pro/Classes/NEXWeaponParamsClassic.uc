class NEXWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=35
			HeadMult=1.857142
			LimbMult=0.571428
			DamageType=Class'BWBP_SKC_Pro.DTNEXSlash'
			DamageTypeHead=Class'BWBP_SKC_Pro.DTNEXSlashHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DTNEXSlashLimb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=1.700000
			HookPullForce=100.000000
			SpreadMode=FSM_Rectangle
			FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.NEX.NEX-SlashAttack',Radius=32.000000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.100000
		End Object
		
		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.500000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="Swing1"
			FireAnimRate=0.700000
			FireEffectParams(0)=MeleeEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=50
			HeadMult=1.7
			LimbMult=0.8
			DamageType=Class'BWBP_SKC_Pro.DTNEXSlash'
			DamageTypeHead=Class'BWBP_SKC_Pro.DTNEXSlashHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DTNEXSlashLimb'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			HookStopFactor=1.700000
			HookPullForce=100.000000
			SpreadMode=FSM_Rectangle
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.800000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=1.800000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepHack"
			FireAnim="Hack"
			FireAnimRate=0.8
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
		PlayerSpeedFactor=0.950000
		PlayerJumpFactor=0.950000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		MagAmmo=100
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
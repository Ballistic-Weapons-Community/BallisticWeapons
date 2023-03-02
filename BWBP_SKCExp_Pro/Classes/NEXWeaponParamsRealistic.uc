class NEXWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=35
			HeadMult=1.857142
			LimbMult=0.571428
			DamageType=Class'BWBP_SKCExp_Pro.DTNEXSlash'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DTNEXSlashHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DTNEXSlashLimb'
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
		
		Begin Object Class=FireParams Name=RealisticPrimaryFireParams
			FireInterval=0.500000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireAnim="Swing1"
			FireAnimRate=0.700000
			FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=50
			HeadMult=1.7
			LimbMult=0.8
			DamageType=Class'BWBP_SKCExp_Pro.DTNEXSlash'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DTNEXSlashHead'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DTNEXSlashLimb'
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
		
		Begin Object Class=FireParams Name=RealisticSecondaryFireParams
			FireInterval=1.800000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepHack"
			FireAnim="Hack"
			FireAnimRate=0.8
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
		bViewDecline=True
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
		PlayerSpeedFactor=0.950000
		PlayerJumpFactor=0.950000
		InventorySize=8
		SightMoveSpeedFactor=0.500000
		MagAmmo=100
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
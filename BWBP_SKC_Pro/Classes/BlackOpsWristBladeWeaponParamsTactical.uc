class BlackOpsWristBladeWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=100.000000,Max=100.000000)
		Damage=80
		Fatigue=0.060000
		DamageType=Class'BWBP_SKC_Pro.DTBOBTorso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBOBHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBOBLimb'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.100000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Slash1"
		FireAnimRate=0.900000
	FireEffectParams(0)=MeleeEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		Damage=120
		Fatigue=0.250000
		DamageType=Class'BWBP_SKC_Pro.DTBOBTorsoLunge'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBOBHeadLunge'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBOBTorsoLunge'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.500000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		PreFireAnim="PrepHack"
		FireAnim="Hack"
	FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		PlayerSpeedFactor=1.150000
		MagAmmo=1
		InventorySize=1
		//ViewOffset=(X=50.000000,Y=00.000000,Z=-40.000000)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}
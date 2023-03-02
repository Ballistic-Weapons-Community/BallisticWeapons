class BlackOpsWristBladeWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=100.000000,Max=100.000000)
		Damage=95.0
		HeadMult=2.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKCExp_Pro.DTBOBTorso'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTBOBHead'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTBOBLimb'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.100000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Slash1"
		FireAnimRate=0.900000
	FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		Damage=195
		HeadMult=2.2
		LimbMult=0.5
		DamageType=Class'BWBP_SKCExp_Pro.DTBOBTorsoLunge'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DTBOBHeadLunge'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DTBOBTorsoLunge'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.500000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		PreFireAnim="PrepHack"
		FireAnim="Hack"
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.150000
		MagAmmo=1
		InventorySize=8
		WeaponPrice=1000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
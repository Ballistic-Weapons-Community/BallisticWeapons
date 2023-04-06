class BlackOpsWristBladeWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=100.000000,Max=100.000000)
		Damage=55
		HeadMult=2.0
		LimbMult=0.8
		DamageType=Class'BWBP_SKC_Pro.DTBOBTorso'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBOBHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBOBLimb'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.100000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Slash1"
		FireAnimRate=0.900000
	FireEffectParams(0)=MeleeEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		Damage=115
		HeadMult=1.5
		LimbMult=0.8
		DamageType=Class'BWBP_SKC_Pro.DTBOBTorsoLunge'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTBOBHeadLunge'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTBOBTorsoLunge'
		HookStopFactor=1.700000
		HookPullForce=100.000000
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Volume=2.500000,Radius=32.000000,bAtten=True)
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=0
		PreFireAnim="PrepHack"
		FireAnim="Hack"
	FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.150000
		MagAmmo=1
		InventorySize=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
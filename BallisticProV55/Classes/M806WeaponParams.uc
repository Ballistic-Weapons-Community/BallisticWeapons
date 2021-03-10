class M806WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000,Max=4000)
		RangeAtten=0.30000
		Damage=40
		HeadMult=1.5f
		LimbMult=0.5f
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		Recoil=256.000000
		Chaos=0.2
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.25000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.5
		DeclineDelay=0.37000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.320000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.5
		PlayerSpeedFactor=1.05
		SightingTime=0.20000
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
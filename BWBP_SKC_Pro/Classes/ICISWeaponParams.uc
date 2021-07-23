class ICISWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=ArenaPrimaryEffectParams
		//Damage=1
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.5
        AmmoPerFire=4
        PreFireTime=0.65
        PreFireAnim="PrepHealLoop"
        FireLoopAnim="HealLoopA"
        FireEndAnim="HealLoopEnd"
        FireEffectParams(0)=FireEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=96.000000,Max=96.000000)
        Damage=50
        DamageType=Class'BWBP_SKC_Pro.DT_ICIS'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_ICIS'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_ICIS'
        HookStopFactor=1.700000
        HookPullForce=100.000000
        BotRefireRate=0.800000
        WarnTargetPct=0.050000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Radius=32.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.600000
        AmmoPerFire=0
        PreFireAnim="PrepFriendlyShank"
        FireAnim="FriendlyShank"
        FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=UniversalAimParams
        ViewBindFactor=0.00
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        PlayerSpeedFactor=1.000000
        MagAmmo=1
        InventorySize=4
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class FP9WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
        ProjectileClass=Class'BallisticProV55.FP9Bomb'
        SpawnOffset=(X=15.000000,Y=-10.000000,Z=-5.000000)
        Speed=600.000000
        Damage=325
        DamageRadius=250.000000
        MomentumTransfer=90000.000000
		bLimitMomentumZ=False
        BotRefireRate=0.300000
        WarnTargetPct=0.9	
        FireSound=(Sound=Sound'BW_Core_WeaponSound.FP9A5.FP9-Throw')
    End Object

    Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        FireInterval=1.500000
        PreFireAnim="PrepThrow"
        FireAnim="Throw"	
        FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
        BotRefireRate=0.300000
        EffectString="Detonate"
    End Object
    
    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        FireInterval=0.300000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
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
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
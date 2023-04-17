class FP9WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
        ProjectileClass=Class'BallisticProV55.FP9Bomb'
        SpawnOffset=(X=15.000000,Y=-10.000000,Z=-5.000000)
        Speed=350.000000
        Damage=150
        DamageRadius=1024.000000
        MomentumTransfer=50000.000000
        BotRefireRate=0.300000
        WarnTargetPct=0.9	
        FireSound=(Sound=Sound'BW_Core_WeaponSound.FP9A5.FP9-Throw')
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        FireInterval=1.500000
        PreFireAnim="PrepThrow"
        FireAnim="Throw"	
        FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
        BotRefireRate=0.300000
        EffectString="Detonate"
    End Object
    
    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=0.300000
        AmmoPerFire=0
        FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
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
        MagAmmo=1
        InventorySize=1
		MaxInventoryCount=1
		//ViewOffset=(X=10.000000,Y=-1.000000,Z=-6.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
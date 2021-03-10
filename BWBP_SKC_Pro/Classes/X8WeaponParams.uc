class X8WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=130.000000,Max=130.000000)
        Damage=45
        DamageType=Class'BWBP_SKC_Pro.DTX8Knife'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTX8Knife'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTX8Knife'
        BotRefireRate=0.800000
        WarnTargetPct=0.100000
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.300000
        AmmoPerFire=0
        FireAnim="Slash1"
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.X8ProjectileHeld'
        SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
        Damage=0
        MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=1.700000
        PreFireAnim="PrepShoot"
        FireAnim="Shoot"	
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
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
        SprintOffSet=(Pitch=-3000,Yaw=-4000)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        PlayerSpeedFactor=1.1
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=3
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class XM84WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.XM84Thrown'
        SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
        Damage=45
        DamageRadius=768.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=2.000000
        PreFireAnim="PrepThrow"
        FireAnim="Throw"	
        FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams

    End Object
		
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        PreFireAnim="PrepRoll"
        FireAnim="Roll"
        FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
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
        InventorySize=3
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
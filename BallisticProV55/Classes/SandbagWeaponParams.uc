class SandbagWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY/SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=ArenaEffectParams
        BotRefireRate=2.000000
    End Object
    
    Begin Object Class=FireParams Name=ArenaFireParams
        FireInterval=0.750000
        FireAnim="Place2"
        FireAnimRate=1.300000
        FireEffectParams(0)=FireEffectParams'ArenaEffectParams'
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
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
        AltFireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class SandbagWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY/SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=UniversalEffectParams
        BotRefireRate=2.000000
        EffectString="Deploy bags"
    End Object
    
    Begin Object Class=FireParams Name=UniversalFireParams
        FireInterval=0.750000
        FireAnim="Place2"
        FireAnimRate=1.300000
        FireEffectParams(0)=FireEffectParams'UniversalEffectParams'
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
        InventorySize=1
		ViewOffset=(X=40.000000,Z=-10.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
        FireParams(0)=FireParams'UniversalFireParams'
        AltFireParams(0)=FireParams'UniversalFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
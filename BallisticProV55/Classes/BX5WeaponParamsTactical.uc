class BX5WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.BX5VehicleMine'
		SpawnOffset=(X=15.000000,Y=-10.000000,Z=-5.000000)
		Damage=70
		DamageRadius=128.000000
		MomentumTransfer=90000.000000
		BotRefireRate=0.300000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.000000
		FireAnim="Deploy"	
	    FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
        EffectString="Spring mode"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.700000
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
        MagAmmo=1
        InventorySize=20
		ViewOffset=(X=5.000000,Z=-6.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
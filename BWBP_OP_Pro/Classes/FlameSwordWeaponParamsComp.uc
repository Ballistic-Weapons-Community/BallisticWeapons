class FlameSwordWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=90
		Fatigue=0.150000
        DamageType=Class'BWBP_OP_Pro.DT_FlameSwordChest'
        DamageTypeHead=Class'BWBP_OP_Pro.DT_FlameSwordHead'
        DamageTypeArm=Class'BWBP_OP_Pro.DT_FlameSwordChest'
        BotRefireRate=0.800000
        WarnTargetPct=0.800000
        FireSound=(Sound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Swing',Volume=1.000000,Radius=48.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.7
        AmmoPerFire=0
        FireAnim="Slash1"
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams

    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=2.000000
        AmmoPerFire=0
        FireAnim="SpellShield"
        FireAnimRate=2
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
        
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=2
		//ViewOffset=(X=20.000000,Y=10.000000,Z=-20.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
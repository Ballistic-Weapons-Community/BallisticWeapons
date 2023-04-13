class MAG78WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=175.000000,Max=175.000000)
        Damage=90
		Fatigue=0.064000
        DamageType=Class'BWBP_OP_Pro.DT_MAGSAWStab'
        DamageTypeHead=Class'BWBP_OP_Pro.DT_MAGSAWStabHead'
        DamageTypeArm=Class'BWBP_OP_Pro.DT_MAGSAWStab'
        BotRefireRate=0.800000
        WarnTargetPct=0.100000
        FireSound=(Sound=Sound'BWBP_OP_Sounds.LongSword.SawSwing',Radius=378.000000,bAtten=True,bNoOverride=False)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.750000
        AmmoPerFire=0
        FireAnim="Swing1"
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=25
        DamageType=Class'DT_MAGSAWStab'
        DamageTypeHead=Class'DT_MAGSAWStabHead'
        DamageTypeArm=Class'DT_MAGSAWStab'
        HookStopFactor=1.500000
        HookPullForce=150.000000
        WarnTargetPct=0.05
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=256.000000)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.100000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="SawStart"
        FireEndAnim="SawEnd"
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
		//ViewOffset=(X=10.000000,Z=-20.000000)
 	    
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=1
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class MAG78WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=RealisticPrimaryEffectParams
        TraceRange=(Min=175.000000,Max=175.000000)
        Damage=80
		Fatigue=0.064000
        DamageType=Class'BWBP_OP_Pro.DT_MAGSAWStab'
        DamageTypeHead=Class'BWBP_OP_Pro.DT_MAGSAWStabHead'
        DamageTypeArm=Class'BWBP_OP_Pro.DT_MAGSAWStab'
        BotRefireRate=0.800000
        WarnTargetPct=0.100000
        FireSound=(Sound=Sound'BWBP_OP_Sounds.LongSword.SawSwing',Radius=378.000000,bAtten=True,bNoOverride=False)
    End Object
    
    Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        FireInterval=0.750000
        AmmoPerFire=0
        FireAnim="Swing1"
        FireEffectParams(0)=MeleeEffectParams'RealisticPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
        TraceRange=(Min=160.000000,Max=160.000000)
        Damage=20
        DamageType=Class'DT_MAGSAWStab'
        DamageTypeHead=Class'DT_MAGSAWStabHead'
        DamageTypeArm=Class'DT_MAGSAWStab'
        HookStopFactor=1.500000
        HookPullForce=150.000000
        WarnTargetPct=0.05
        FireSound=(Sound=Sound'BW_Core_WeaponSound.DarkStar.Dark-SawOpen',Volume=0.750000,Radius=256.000000)
    End Object
    
    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        FireInterval=0.100000
        AmmoPerFire=0
        PreFireAnim=
        FireAnim="SawStart"
        FireEndAnim="SawEnd"
        FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=RealisticRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
        DeclineTime=1.500000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=RealisticAimParams
        ViewBindFactor=0.00
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=RealisticParams
		//ViewOffset=(X=10.000000,Z=-20.000000)
 	    PlayerSpeedFactor=1.10
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=4
		WeaponPrice=1500
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}
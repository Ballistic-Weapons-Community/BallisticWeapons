class DefibWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=130,Max=130)
        Damage=40
		Fatigue=0.015000
        DamageType=Class'BWBP_OP_Pro.DTShockGauntlet'
        DamageTypeHead=Class'BWBP_OP_Pro.DTShockGauntlet'
        DamageTypeArm=Class'BWBP_OP_Pro.DTShockGauntlet'
        BotRefireRate=0.800000
        WarnTargetPct=0.050000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.400000
        AmmoPerFire=0
        FireAnim="PunchL1"
        FireAnimRate=1.250000
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=130,Max=130)
        Damage=65
		Fatigue=0.030000
        DamageType=Class'BWBP_OP_Pro.DTShockGauntletAlt'
        DamageTypeHead=Class'BWBP_OP_Pro.DTShockGauntletAlt'
        DamageTypeArm=Class'BWBP_OP_Pro.DTShockGauntletAlt'
        BotRefireRate=0.800000
        WarnTargetPct=0.050000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=1.000000
        AmmoPerFire=0
        PreFireAnim="UppercutPrep"
        FireAnim="Uppercut"
        FireAnimRate=1.500000
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
        
        MagAmmo=100
        InventorySize=2
		//ViewOffset=(X=40.000000,Z=-10.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class N3XWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Fatigue=0.120000
		Damage=40
		DamageType=Class'BWBP_SKC_Pro.DTShockN3X'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTShockN3X'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTShockN3X'
        BotRefireRate=0.99
        WarnTargetPct=0.3
        FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.NEX.NEX-SlashAttack',Radius=32.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.550000
        AmmoPerFire=0
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=75
		DamageType=Class'BWBP_SKC_Pro.DTShockN3XAlt'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTShockN3XAlt'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTShockN3XAlt'
		Fatigue=0.350000
        HookStopFactor=1.700000
        HookPullForce=100.000000
        BotRefireRate=0.99
        WarnTargetPct=0.5
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=1.200000
        AmmoPerFire=0
        PreFireAnim="PrepHack"
        FireAnim="Hack"
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
        WeaponBoneScales(0)=(BoneName="WeldingShield",Slot=1,Scale=0f)
 	    PlayerSpeedFactor=1.10
        MagAmmo=1
        InventorySize=5
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
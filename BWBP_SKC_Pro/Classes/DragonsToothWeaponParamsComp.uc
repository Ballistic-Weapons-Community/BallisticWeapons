class DragonsToothWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=175.000000,Max=175.000000)
        Damage=140
		Fatigue=0.100000
        DamageType=Class'BWBP_SKC_Pro.DT_DTSStabChest'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSStabHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSStabChest'
        BotRefireRate=0.800000
        WarnTargetPct=0.800000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=4.100000,Radius=256.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        AmmoPerFire=0
		FireInterval=0.800000
        FireAnim="Stab"
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=120
		Fatigue=0.200000
        DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
        BotRefireRate=0.700000
        WarnTargetPct=0.800000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Volume=5.500000,Radius=256.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=2.000000
        AmmoPerFire=0
        FireAnim="Melee3"
        FireAnimRate=0.850000
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
        PlayerSpeedFactor=1.1
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
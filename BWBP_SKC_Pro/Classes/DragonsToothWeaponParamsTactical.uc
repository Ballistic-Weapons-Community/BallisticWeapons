class DragonsToothWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=TacticalPrimaryEffectParams
        TraceRange=(Min=175.000000,Max=175.000000)
        Damage=90
		Fatigue=0.100000
        DamageType=Class'BWBP_SKC_Pro.DT_DTSStabChest'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSStabHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSStabChest'
        BotRefireRate=0.800000
        WarnTargetPct=0.800000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Radius=48.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        AmmoPerFire=0
		FireInterval=0.800000
        FireAnim="Stab"
        FireEffectParams(0)=MeleeEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=70
		Fatigue=0.200000
        DamageType=Class'BWBP_SKC_Pro.DT_DTSChest'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_DTSHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_DTSLimb'
        BotRefireRate=0.700000
        WarnTargetPct=0.800000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.DTS.DragonsTooth-Swipe',Radius=48.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=2.000000
        AmmoPerFire=0
        FireAnim="Melee3"
        FireAnimRate=0.850000
        FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
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
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
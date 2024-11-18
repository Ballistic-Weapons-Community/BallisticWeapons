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

    Begin Object Class=WeaponParams Name=TacticalParams_Blue
		//Layout
		Weight=10
		LayoutName="Blue"
		LayoutTags="blue"
		//Visual
		AllowedCamos(0)=0
		//Stats
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Red
		//Layout
		Weight=10
		LayoutName="Red"
		LayoutTags="red"
		//Visual
		AllowedCamos(0)=1
		//Stats
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Black
		//Layout
		Weight=10
		LayoutName="Nanoblack"
		LayoutTags="black"
		//Visual
		AllowedCamos(0)=2
		//Stats
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Gold
		//Layout
		Weight=1
		LayoutName="Royal Dragon"
		LayoutTags="gold"
		//Visual
		AllowedCamos(0)=3
		//Stats
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=2
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Blue'
	Layouts(1)=WeaponParams'TacticalParams_Red'
	Layouts(2)=WeaponParams'TacticalParams_Black'
	Layouts(3)=WeaponParams'TacticalParams_Gold'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=DTS_Blue
		Index=0
		CamoName="Blue"
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-Red',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-BladeGlowRed',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-MainBlackFinal',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-BladeGlowBlack',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=DTS_Gold
		Index=3
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-MainGoldFinal',Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.DragonToothSword.DTS-BladeGlowGold',Index=2,AIndex=-1,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'DTS_Blue'
	Camos(1)=WeaponCamo'DTS_Red'
	Camos(2)=WeaponCamo'DTS_Black'
	Camos(3)=WeaponCamo'DTS_Gold'
}
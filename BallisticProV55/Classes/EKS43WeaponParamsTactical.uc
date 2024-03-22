class EKS43WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=TacticalPrimaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Fatigue=0.060000
		Damage=75
        DamageType=Class'BallisticProV55.DTEKS43Katana'
        DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
        DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
        BotRefireRate=0.99
        WarnTargetPct=0.3
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Volume=0.5,Radius=24.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        FireInterval=0.750000
        AmmoPerFire=0
        FireAnim="Slash1"
        FireEffectParams(0)=MeleeEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=75
		Fatigue=0.250000
        DamageType=Class'BallisticProV55.DTEKS43Katana'
        DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
        DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
        HookStopFactor=1.700000
        HookPullForce=100.000000
        BotRefireRate=0.99
        WarnTargetPct=0.5
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Volume=0.5,Radius=24.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        FireInterval=1.200000
        AmmoPerFire=0
        PreFireAnim="PrepHack1"
        FireAnim="Hack1"
        FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=UniversalAimParams
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
		LayoutName="Perfect Steel"
		Weight=30
		AllowedCamos(0)=0	
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(X=6.000000,Z=-18.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=UniversalParams_Hot
		LayoutName="Superheated"
		Weight=10
		AllowedCamos(0)=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EKSCamos.Katana-KGlow",Index=1)
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(X=6.000000,Z=-18.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'UniversalParams'
    Layouts(1)=WeaponParams'UniversalParams_Hot'
	
	//Camos ===================================
	Begin Object Class=WeaponCamo Name=EKS_Steel
		Index=0
		CamoName="Perfect Steel"
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=EKS_Heated
		Index=1
		CamoName="Superheated"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EKSCamos.Katana-KGlow",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'EKS_Steel'
	Camos(1)=WeaponCamo'EKS_Heated'	

}
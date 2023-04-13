class EKS43WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Fatigue=0.060000
		Damage=80
        DamageType=Class'BallisticProV55.DTEKS43Katana'
        DamageTypeHead=Class'BallisticProV55.DTEKS43KatanaHead'
        DamageTypeArm=Class'BallisticProV55.DTEKS43KatanaLimb'
        BotRefireRate=0.99
        WarnTargetPct=0.3
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.EKS43.EKS-Slash',Volume=0.5,Radius=24.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.750000
        AmmoPerFire=0
        FireAnim="Slash1"
        FireEffectParams(0)=MeleeEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=165.000000,Max=165.000000)
        Damage=80
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
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=1.200000
        AmmoPerFire=0
        PreFireAnim="PrepHack1"
        FireAnim="Hack1"
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
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
		LayoutName="Perfect Steel"
		Weight=30
		
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(X=6.000000,Z=-18.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=UniversalParams_Hot
		LayoutName="Superheated"
		Weight=10
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.EKS43Camos.Katana-KGlow",Index=1)
        DisplaceDurationMult=0.33
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(X=6.000000,Z=-18.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'UniversalParams'
    Layouts(1)=WeaponParams'UniversalParams_Hot'
}
class A909WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=MeleeEffectParams Name=ArenaPriEffectParams
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=55.000000
        Fatigue=0.030000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Volume=0.7,Radius=24.000000,bAtten=True)
        DamageType=Class'BallisticProV55.DTA909Blades'
        DamageTypeHead=Class'BallisticProV55.DTA909Head'
        DamageTypeArm=Class'BallisticProV55.DTA909Limb'
        MomentumTransfer=100
        WarnTargetPct=0.300000
        BotRefireRate=0.99
    End Object

    Begin Object Class=FireParams Name=ArenaPriFireParams
        AmmoPerFire=0
        FireAnim="PrepHack"
        FireAnimRate=1.200000
        FireInterval=0.350000
        FireEffectParams(0)=MeleeEffectParams'ArenaPriEffectParams'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=MeleeEffectParams Name=ArenaSecEffectParams
        Fatigue=0.200000
        TraceRange=(Min=150.000000,Max=150.000000)
        Damage=75.000000
        DamageType=Class'BallisticProV55.DTA909Blades'
        DamageTypeHead=Class'BallisticProV55.DTA909Head'
        DamageTypeArm=Class'BallisticProV55.DTA909Limb'
        MomentumTransfer=100
        HookStopFactor=1.700000
        HookPullForce=100.000000
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.A909.A909Slash',Volume=0.5,Radius=24.000000,bAtten=True)
        WarnTargetPct=0.500000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=ArenaSecFireParams
        AmmoPerFire=0
        PreFireAnim="PrepBigHack3"
        FireAnim="BigHack3"
        FireInterval=1.000000
        FireEffectParams(0)=MeleeEffectParams'ArenaSecEffectParams'
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
        SprintOffSet=(Pitch=0,Yaw=0)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        DisplaceDurationMult=0.0
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(X=63.000000,Y=-4.000000,Z=-6.000000)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
        FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=A909_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A909_Blue
		Index=1
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.A909Camos.EnergyWristBladeShine",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'A909_Green'
	Camos(1)=WeaponCamo'A909_Blue'
}
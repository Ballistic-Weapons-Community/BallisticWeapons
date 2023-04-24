class ChaffWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.ChaffGrenade'
        SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
        Speed=1000.000000
        Damage=50
        DamageRadius=256.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Volume=0.5,Radius=12.000000,bAtten=True)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=2.000000
        PreFireAnim="PrepThrow"
        FireAnim="Throw"	
        FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
        TraceRange=(Min=140.000000,Max=140.000000)
        Damage=65
        DamageType=Class'BWBP_SKC_Pro.DTChaffSmack'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTChaffSmack'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTChaffSmack'
        BotRefireRate=0.900000
        WarnTargetPct=0.050000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,Pitch=0.800000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.700000
        AmmoPerFire=0
        PreFireAnim="PrepSmack"
        FireAnim="Smack"
        PreFireAnimRate=2.000000
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
        
        MagAmmo=1
        InventorySize=1
		//ViewOffset=(Y=4.000000,Z=-15.000000)
		ViewPivot=(Pitch=1024,Yaw=-1024)

		WeaponModes(0)=(ModeName="Fixed Throw",ModeID="WM_None",Value=1.00)
		WeaponModes(1)=(ModeName="Charged Throw",ModeID="WM_None",Value=0.00)
		WeaponModes(2)=(bUnavailable=True)

        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
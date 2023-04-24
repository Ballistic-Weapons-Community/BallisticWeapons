class XM84WeaponParamsComp extends BallisticWeaponParams;

static simulated function OnInitialize(BallisticWeapon BW)
{
	XM84Flashbang(BW).bCookable=False;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.XM84Thrown'
        SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
        Damage=55
        DamageRadius=1024.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Volume=0.5,Radius=12.000000,bAtten=True)
		Speed=1000.000000
        MaxSpeed=1000.000000
		HeadMult=1.00
		LimbMult=1.00
        BotRefireRate=0.4
        WarnTargetPct=0.75	
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
	
    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.XM84Rolled'
        SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
        Damage=55
        DamageRadius=1024.000000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Volume=0.5,Radius=12.000000,bAtten=True)
		Speed=350.000000
        MaxSpeed=350.000000
		HeadMult=1.00
		LimbMult=1.00
        BotRefireRate=0.4
        WarnTargetPct=0.75
    End Object
		
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        PreFireAnim="PrepRoll"
        FireAnim="Roll"
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
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
        ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-1024)
		
		WeaponModes(0)=(ModeName="Fixed Throw",ModeID="WM_None",Value=1.00)
		WeaponModes(1)=(ModeName="Charged Throw",ModeID="WM_None",Value=0.00)
		WeaponModes(2)=(bUnavailable=True)

        MagAmmo=1
        InventorySize=1
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class NRP57WeaponParamsTactical extends BallisticWeaponParams;

static simulated function OnInitialize(BallisticWeapon BW)
{
	NRP57Grenade(BW).bCookable=False;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
        ProjectileClass=Class'BallisticProV55.NRP57Thrown'
        SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
        Speed=1000.000000
        MaxSpeed=1000.000000
        Damage=150
        DamageRadius=1024.000000
		HeadMult=1.0
		LimbMult=1.0
        BotRefireRate=0.4
        WarnTargetPct=0.75	
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Volume=0.5,Radius=12.000000,bAtten=True)
    End Object

    Begin Object Class=FireParams Name=TacticalPrimaryFireParams
        PreFireAnim="PrepThrow"
        FireAnim="Throw"	
        FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
        ProjectileClass=Class'BallisticProV55.NRP57Rolled'
		SpawnOffset=(Z=-14.000000)
        Speed=1400.000000
        MaxSpeed=1500.000000
        Damage=100
        DamageRadius=1024.000000
		HeadMult=1.0
		LimbMult=1.0
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Volume=0.5,Radius=12.000000,bAtten=True)
    End Object
    
    Begin Object Class=FireParams Name=TacticalSecondaryFireParams
        PreFireAnim="PrepRoll"
        FireAnim="Roll"
        FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
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
		MaxInventoryCount=1
		//ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
				
		WeaponModes(0)=(ModeName="Charged Throw",ModeID="WM_None",Value=0.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)

		ViewPivot=(Pitch=1024,Yaw=-1024)
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class WrenchWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	// Boost Pad
	Begin Object Class=FireEffectParams Name=TacticalBoostPadEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalBoostPadFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalBoostPadEffectParams'
	End Object
	
	// Teleporter
	Begin Object Class=FireEffectParams Name=TacticalTeleporterEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalTeleporterFireParams
		FireInterval=1.000000
		AmmoPerFire=50
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalTeleporterEffectParams'
	End Object
	
	// SandBags
	Begin Object Class=FireEffectParams Name=TacticalSandBagEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalSandBagFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalSandBagEffectParams'
	End Object
	
	// Shield Generator
	Begin Object Class=FireEffectParams Name=TacticalGeneratorEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalGeneratorFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalGeneratorEffectParams'
	End Object
	
	// AmmoCrate
	Begin Object Class=FireEffectParams Name=TacticalAmmoCrateEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalAmmoCrateFireParams
		FireInterval=1.000000
		AmmoPerFire=30
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalAmmoCrateEffectParams'
	End Object
	
	// Minigun Turret
	Begin Object Class=FireEffectParams Name=TacticalMinigunEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalMinigunFireParams
		FireInterval=1.000000
		AmmoPerFire=100
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalMinigunEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=20
		FireAnim="BarrierButton"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
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
        SprintOffset=(Pitch=-3000,Yaw=-4000)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        ViewOffset=(X=10.000000,Z=-7.000000)
		PlayerSpeedFactor=0.8
        PlayerJumpFactor=0.8
        MagAmmo=1
        InventorySize=20
		WeaponModes(0)=(ModeName="Boost Pad",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Teleporter",ModeID="WM_SemiAuto")
		WeaponModes(2)=(ModeName="Sandbag Stack")
		WeaponModes(3)=(ModeName="Shield Generator",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Ammo Crate",ModeID="WM_FullAuto")
		WeaponModes(5)=(ModeName="Minigun Turret",ModeID="WM_SemiAuto")
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalBoostPadFireParams'
		FireParams(1)=FireParams'TacticalTeleporterFireParams'
		FireParams(2)=FireParams'TacticalSandbagFireParams'
		FireParams(3)=FireParams'TacticalGeneratorFireParams'
		FireParams(4)=FireParams'TacticalAmmoCrateFireParams'
		FireParams(5)=FireParams'TacticalMinigunFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
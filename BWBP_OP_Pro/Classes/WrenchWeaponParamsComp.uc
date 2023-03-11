class WrenchWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	// Boost Pad
	Begin Object Class=FireEffectParams Name=ArenaBoostPadEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaBoostPadFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaBoostPadEffectParams'
	End Object
	
	// Teleporter
	Begin Object Class=FireEffectParams Name=ArenaTeleporterEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaTeleporterFireParams
		FireInterval=1.000000
		AmmoPerFire=50
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaTeleporterEffectParams'
	End Object
	
	// SandBags
	Begin Object Class=FireEffectParams Name=ArenaSandBagEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaSandBagFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaSandBagEffectParams'
	End Object
	
	// Shield Generator
	Begin Object Class=FireEffectParams Name=ArenaGeneratorEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaGeneratorFireParams
		FireInterval=1.000000
		AmmoPerFire=10
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaGeneratorEffectParams'
	End Object
	
	// AmmoCrate
	Begin Object Class=FireEffectParams Name=ArenaAmmoCrateEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaAmmoCrateFireParams
		FireInterval=1.000000
		AmmoPerFire=30
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaAmmoCrateEffectParams'
	End Object
	
	// Minigun Turret
	Begin Object Class=FireEffectParams Name=ArenaMinigunEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaMinigunFireParams
		FireInterval=1.000000
		AmmoPerFire=100
		FireAnim="Button"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaMinigunEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=20
		FireAnim="BarrierButton"
		FireAnimRate=2
	FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
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
		SprintOffset=(Pitch=-3072,Yaw=-4096)
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        ViewOffset=(X=10.000000,Z=-7.000000)
		PlayerSpeedFactor=0.65
        PlayerJumpFactor=0.65
        MagAmmo=1
        InventorySize=12
		WeaponModes(0)=(ModeName="Boost Pad",ModeID="WM_FullAuto")
		WeaponModes(1)=(ModeName="Teleporter",ModeID="WM_SemiAuto")
		WeaponModes(2)=(ModeName="Sandbag Stack")
		WeaponModes(3)=(ModeName="Shield Generator",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Ammo Crate",ModeID="WM_FullAuto")
		WeaponModes(5)=(ModeName="Minigun Turret",ModeID="WM_SemiAuto")
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'ArenaBoostPadFireParams'
		FireParams(1)=FireParams'ArenaTeleporterFireParams'
		FireParams(2)=FireParams'ArenaSandbagFireParams'
		FireParams(3)=FireParams'ArenaGeneratorFireParams'
		FireParams(4)=FireParams'ArenaAmmoCrateFireParams'
		FireParams(5)=FireParams'ArenaMinigunFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
}
class L8GIAmmoPackWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.L8GIThrown'
		SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
		Speed=600.000000
		MaxSpeed=600.000000
		Damage=0
		DamageRadius=250.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		PreFireAnim="PrepThrow"
		FireAnim="Throw"	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ArenaSecondaryEffectParams
		Damage=50
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=2.850000
		AmmoPerFire=0
		FireAnim="UseOnSelf"
	FireEffectParams(0)=MeleeEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//ViewOffset=(X=0.000000,Y=10.000000,Z=-13.000000)
     	ViewPivot=(Pitch=1024,Yaw=-1024)
		PlayerSpeedFactor=0.750000
        MagAmmo=1
        InventorySize=2
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}
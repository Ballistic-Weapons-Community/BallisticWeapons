class L8GIAmmoPackWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.L8GIThrown'
		SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
		Speed=600.000000
		MaxSpeed=600.000000
		Damage=0
		DamageRadius=250.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		PreFireAnim="PrepThrow"
		FireAnim="Throw"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		Damage=50
	End Object
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=2.850000
		AmmoPerFire=0
		FireAnim="UseOnSelf"
	FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
        ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		ViewOffset=(X=0.000000,Y=10.000000,Z=-13.000000)
     	ViewPivot=(Pitch=1024,Yaw=-1024)
		PlayerSpeedFactor=0.750000
        MagAmmo=1
        InventorySize=2
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'

}
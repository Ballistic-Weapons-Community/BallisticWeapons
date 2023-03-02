class A51GrenadeWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A51Thrown'
		SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
		Damage=100
		DamageRadius=250.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
		Speed=1400.000000
        MaxSpeed=1500.000000
		HeadMult=1.0
		LimbMult=1.0
        BotRefireRate=0.4
        WarnTargetPct=0.75
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		PreFireAnim="PrepThrow"
		FireAnim="Throw"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A51Rolled'
		SpawnOffset=(Z=-14.000000)
        Speed=1000.000000
        MaxSpeed=1500.000000
		Damage=100.000000
		DamageRadius=250.000000
		HeadMult=1.0
		LimbMult=1.0
		WarnTargetPct=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		PreFireAnim="PrepRoll"
		FireAnim="Roll"
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-1024)
		PlayerSpeedFactor=1.000000
        MagAmmo=2
        InventorySize=3
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
class A51GrenadeWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
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

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		PreFireAnim="PrepThrow"
		FireAnim="Throw"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
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
		
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		PreFireAnim="PrepRoll"
		FireAnim="Roll"
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
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
		ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-1024)
		PlayerSpeedFactor=1.000000
        MagAmmo=2
        InventorySize=3
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
class A51GrenadeWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.A51Thrown'
		SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
		Damage=5
		DamageRadius=768.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
        Speed=1000.000000
        MaxSpeed=1000.000000
		HeadMult=1.0
		LimbMult=1.0
        BotRefireRate=0.4
        WarnTargetPct=0.75
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
		ProjectileClass=Class'BWBP_SWC_Pro.A51Rolled'
		SpawnOffset=(Z=-14.000000)
		Speed=350.000000
		MaxSpeed=350.000000
		Damage=5
		DamageRadius=768.000000
		HeadMult=1.0
		LimbMult=1.0
		WarnTargetPct=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)	
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		PreFireAnim="PrepRoll"
		FireAnim="Roll"
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		DeclineTime=1.500000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ChaosDeclineTime=0.320000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		ViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
		ViewPivot=(Pitch=1024,Yaw=-1024)
		PlayerSpeedFactor=1.000000
        MagAmmo=1
        InventorySize=1
		MaxInventoryCount=1
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
}
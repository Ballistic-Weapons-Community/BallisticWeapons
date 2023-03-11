class PD97WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97Dart'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		Speed=15000.000000
		Damage=20
		Recoil=256.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Radius=128,Volume=0.5)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.400000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.150000
		JumpChaos=0.200000
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		SightOffset=(X=-10.000000,Y=-4.400000,Z=12.130000)
		ViewOffset=(X=5.000000,Y=8.000000,Z=-10.000000)
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=6
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
class MRLWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocket'
		SpawnOffset=(X=28.000000,Y=10.000000,Z=-8.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=35
		DamageRadius=420.000000
		MomentumTransfer=5500.000000
		MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
		Recoil=0.000000
		Chaos=0.170000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.110000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.MRLRocket'
		SpawnOffset=(X=28.000000,Y=8.000000,Z=-6.000000)
		Speed=4500.000000
		MaxSpeed=25000.000000
		AccelSpeed=10000.000000
		Damage=35
		DamageRadius=420.000000
		MomentumTransfer=5500.000000
		Recoil=0.000000
		Chaos=0.080000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MRL.MRL-Fire',Volume=1.200000,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.070000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XRandFactor=0.000000
		YRandFactor=0.000000
 	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.25
		SprintOffSet=(Pitch=-7000,Yaw=-3000)
		OffsetAdjustTime=0.600000
		AimSpread=(Min=128,Max=2048)
		ChaosDeclineTime=0.320000
		ChaosSpeedThreshold=500.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.8
		PlayerJumpFactor=0.8
        DisplaceDurationMult=1.4
		SightingTime=0.65
		MagAmmo=36
        InventorySize=35
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
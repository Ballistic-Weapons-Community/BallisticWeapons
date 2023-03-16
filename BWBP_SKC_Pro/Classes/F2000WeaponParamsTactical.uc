class F2000WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTF2000Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTF2000AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTF2000Assault'
        PenetrationEnergy=16
		PenetrateForce=150
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MARSFlashEmitter'
		FlashScaleFactor=0.5
		Recoil=160.000000
		Chaos=0.02000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-RapidFire',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.080000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.F2000Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=80
        ImpactDamage=80
		DamageRadius=512.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		Chaos=0.5
		BotRefireRate=0.300000
		WarnTargetPct=0.600000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		PreFireAnim="GLPrepFire"
		FireAnim="GLFire"
		AimedFireAnim="GLSightFireFromPrep"	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.150000),(InVal=0.4800000,OutVal=0.20000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=0.0500000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.3)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.5
		DeclineDelay=0.140000
		ViewBindFactor=0.4
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		ChaosDeclineTime=0.5
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		CockAnimRate=1.10000
		ReloadAnimRate=1.10000
		InventorySize=7
		SightMoveSpeedFactor=0.75
		SightingTime=0.35
		DisplaceDurationMult=1
		MagAmmo=30
		ViewOffset=(X=0.5,Y=12.000000,Z=-18.000000)
		SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
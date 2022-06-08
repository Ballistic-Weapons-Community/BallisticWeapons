class ARWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=10
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=20.000000
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_OP_Pro.DT_ARShotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_ARShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_ARShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_OP_Pro.ARFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.RCS.RCS-Fire')
		Recoil=256.000000
		Chaos=0.500000
		Inaccuracy=(X=192,Y=192)
		BotRefireRate=0.900000
		WarnTargetPct=0.500000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.ARProjectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=4000.000000
		MaxSpeed=15000.000000
		AccelSpeed=3000.000000
		Damage=50
		DamageRadius=128.000000
		MomentumTransfer=0.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=650.000000
		Chaos=0.450000
		BotRefireRate=0.600000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.GL-Fire',Volume=1.300000)	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.650000
		AmmoPerFire=0
		FireAnim="GLFire"
		FireAnimRate=1.250000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineTime=1.0
		DeclineDelay=0.4
		ViewBindFactor=0.4
		ADSViewBindFactor=0.4
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		SightMoveSpeedFactor=0.500000
		MagAmmo=20
		SightOffset=(X=60.000000,Y=5.690000,Z=35.820000)
		WeaponName="RCS-715 Assault Shotgun"
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
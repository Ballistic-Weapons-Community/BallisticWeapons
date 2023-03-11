class ARWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
        DecayRange=(Min=750,Max=2250)
		RangeAtten=0.300000
		TraceCount=6
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		DamageType=Class'BWBP_OP_Pro.DT_ARShotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_ARShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_ARShotgun'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=256.000000
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.XMV-850.XMV-Fire-3')
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
		PushbackForce=180.000000
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
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.150000),(InVal=0.500000,OutVal=0.250000),(InVal=0.750000,OutVal=0.30000),(InVal=1.000000,OutVal=0.350000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineDelay=0.4
		DeclineTime=1.0	
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=16,Max=512)
		SprintOffset=(Pitch=-4096,Yaw=-4096)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=0.750000
		SightOffset=(X=60.000000,Y=5.690000,Z=35.820000)
		ViewOffset=(Y=16.000000,Z=-25.000000)
		PlayerSpeedFactor=0.95000
		PlayerJumpFactor=0.95000
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.550000
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
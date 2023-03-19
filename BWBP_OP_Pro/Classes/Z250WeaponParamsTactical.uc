class Z250WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		Damage=36
        HeadMult=2.25
        LimbMult=0.67f
		DamageType=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeHead=Class'BWBP_OP_Pro.DTZ250Bullet'
		DamageTypeArm=Class'BWBP_OP_Pro.DTZ250Bullet'
		PenetrateForce=150
		MuzzleFlashClass=Class'BallisticProV55.XMV850FlashEmitter'
		FlashScaleFactor=0.800000
		PushbackForce=150.000000
		Recoil=64.000000
		Chaos=0.120000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Fire-1',Slot=SLOT_Interact,Pitch=0.750000,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.200000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.Z250Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4000.000000
		Damage=50
		DamageRadius=64.000000
		MuzzleFlashClass=Class'BWBP_OP_Pro.Z250GrenadeFlashEmitter'
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Z250.Z250-GrenadeFire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		PreFireAnim=
		FireAnim="GLFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.30000,OutVal=0.090000),(InVal=0.4500000,OutVal=0.230000),(InVal=0.600000,OutVal=0.250000),(InVal=0.800000,OutVal=0.350000),(InVal=1.000000,OutVal=0.4)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.350000,OutVal=0.400000),(InVal=0.5,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.070000
		YRandFactor=0.070000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		CrouchMultiplier=0.8
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=2048)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		AimAdjustTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=50.000000,Y=-10.690000,Z=45.400002)
		ViewOffset=(Y=15.000000,Z=-25.000000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.4
		SightingTime=0.45
		DisplaceDurationMult=1.25
		MagAmmo=100
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
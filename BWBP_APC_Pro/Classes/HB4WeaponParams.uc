class HB4WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HB4PulseProjectile'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		Damage=55
		DamageRadius=256.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HB4FlashEmitter'
		Inaccuracy=(X=64,Y=64)
        WarnTargetPct=0.300000
		BotRefireRate=0.300000	
		FlashScaleFactor=0.650000
		FireSound=(Sound=Sound'BWBP_CC_Sounds.EP110.EP110-Fire',Pitch=1.500000,Volume=9.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.850000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
        FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
        WarnTargetPct=1.000000
        BotRefireRate=0.3
		FlashScaleFactor=1.300000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		MaxHoldTime=0.500000
		AimedFireAnim="ToggleFlashlight"	
		FireInterval=10.000000
		FireEndAnim=
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=6144.000000
		DeclineDelay=0.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=192,Max=768)
		SprintOffset=(Pitch=0,Yaw=0)
		ChaosDeclineTime=1.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=0.95
		PlayerJumpFactor=0.95
		InventorySize=2
		SightMoveSpeedFactor=0.9
		SightingTime=0.40000	
		ViewOffset=(X=0.000000,Y=11.000000,Z=-13.000000)
		SightOffset=(X=10.000000,Y=-5.53,Z=10.300000)
		DisplaceDurationMult=1
		MagAmmo=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
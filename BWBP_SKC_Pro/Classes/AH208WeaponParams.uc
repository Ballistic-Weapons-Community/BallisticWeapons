class AH208WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=7500.000000,Max=7500.000000)
		RangeAtten=0.350000
		Damage=85
		HeadMult=1.5f
		LimbMult=0.8f
		DamageType=Class'BWBP_SKC_Pro.DTAH208Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH208PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH208Pistol'
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=512.000000
		Chaos=0.350000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire4',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.400000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.03),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.00),(InVal=0.7,OutVal=0.03),(InVal=1.0,OutVal=0.00)))
        ViewBindFactor=0.5
        XRandFactor=0.100000
        YRandFactor=0.100000
        MaxRecoil=6144.000000
        DeclineDelay=0.65
        DeclineTime=1
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
        ADSMultiplier=2
        AimSpread=(Min=16,Max=128)
        ChaosDeclineTime=0.60000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerSpeedFactor=1.050000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=1
		SightingTime=0.250000
		DisplaceDurationMult=0.5
		MagAmmo=7
		SightOffset=(X=20.000000,Y=-7.350000,Z=45.400002)
		ViewOffset=(X=15.000000,Y=12.000000,Z=-37.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
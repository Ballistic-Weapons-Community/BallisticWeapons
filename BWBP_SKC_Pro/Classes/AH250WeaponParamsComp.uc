class AH250WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=60
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrateForce=200
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=512.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Fire3',Volume=4.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.40000
		FireEndAnim=
		AimedFireAnim='SightFire'	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.15,OutVal=0.1),(InVal=0.35,OutVal=-0.05),(InVal=0.5,OutVal=0.02),(InVal=0.7,OutVal=-0.06),(InVal=1.0,OutVal=0.0)))
		ViewBindFactor=0.5
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=6144.000000
		DeclineDelay=0.65
		DeclineTime=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		AimSpread=(Min=16,Max=256)
		ChaosDeclineTime=0.60000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		InventorySize=4
		SightMoveSpeedFactor=0.8
		SightingTime=0.40000
		DisplaceDurationMult=0.75
		MagAmmo=7
        ZoomType=ZT_Fixed
		SightOffset=(X=70.000000,Y=-7.350000,Z=45.400002)
		ViewOffset=(X=15.000000,Y=24.000000,Z=-37.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
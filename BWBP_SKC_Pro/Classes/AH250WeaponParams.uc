class AH250WeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=9000.000000)
		RangeAtten=0.50000
		Damage=60
		HeadMult=1.5f
		LimbMult=0.85f
		DamageType=Class'BWBP_SKC_Pro.DTAH250Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTAH250PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTAH250Pistol'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=512.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
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
		PlayerSpeedFactor=1.050000
		PlayerJumpFactor=1.000000
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.40000
		DisplaceDurationMult=0.75
		MagAmmo=7
        ZoomType=ZT_Fixed
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
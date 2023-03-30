class ProtoWeaponParams extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Standard
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		RangeAtten=0.100000
		Damage=20
		DamageType=Class'BWBP_APC_Pro.DTProto'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProto'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=70.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.P90.P90Fire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.075000
		PreFireAnim=
		FireEndAnim=
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - Photon Burst
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPhotonPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=12000.000000)
		RangeAtten=0.100000
		Damage=22
		DamageType=Class'BWBP_APC_Pro.DTProtoPhoton'
		DamageTypeHead=Class'BWBP_APC_Pro.DTProtoPhotonHead'
		DamageTypeArm=Class'BWBP_APC_Pro.DTProtoPhoton'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.900000
		Recoil=70.000000
		Chaos=0.032000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.F2000-FireAlt1',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaPhotonPrimaryFireParams
		FireInterval=0.085000
		PreFireAnim=
		FireEndAnim=
		FireAnim="FireAlt"
		AimedFireAnim="SightFireAlt"
		FireEffectParams(0)=InstantEffectParams'ArenaPhotonPrimaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
		XCurve=(Points=(,(InVal=0.1,OutVal=0.09),(InVal=0.2,OutVal=0.12),(InVal=0.25,OutVal=0.13),(InVal=0.3,OutVal=0.11),(InVal=0.35,OutVal=0.08),(InVal=0.40000,OutVal=0.050000),(InVal=0.50000,OutVal=-0.020000),(InVal=0.600000,OutVal=-0.040000),(InVal=0.700000,OutVal=0.04),(InVal=0.800000,OutVal=0.070000),(InVal=1.000000,OutVal=0.13)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.07),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.2600000),(InVal=0.400000,OutVal=0.4000),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineTime=0.4
		DeclineDelay=0.160000
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.3
		AimSpread=(Min=16,Max=768)
		SprintOffset=(Pitch=-3000,Yaw=-8000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=7000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.400000
		SightPivot=(Pitch=128)
		SightOffset=(X=-20.000000,Y=-0.950000,Z=24.950000)
		ViewOffset=(X=10.000000,Y=6.000000,Z=-18.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000		
		DisplaceDurationMult=1
		MagAmmo=50
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPhotonPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
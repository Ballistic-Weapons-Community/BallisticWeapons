class SRS600WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.450000
		Damage=36
		HeadMult=1.5f
		LimbMult=0.8f
		DamageType=Class'BallisticProV55.DTSRS600Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS600RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS600Rifle'
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=210.000000
		Chaos=0.065000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.20000
		BurstFireRateFactor=0.55
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1000
		YRandFactor=0.1000
		DeclineTime=1.00000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimSpread=(Min=16,Max=192)
		ChaosDeclineTime=0.75
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=20
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
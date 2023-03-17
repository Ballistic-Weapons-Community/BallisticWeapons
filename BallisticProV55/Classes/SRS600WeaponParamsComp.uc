class SRS600WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=6000)
		RangeAtten=0.75
		Damage=34
        HeadMult=2.0f
        LimbMult=0.67f
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
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Radius=1536.000000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
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
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=64,Max=768)
        ADSMultiplier=0.5
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.200000
		SightOffset=(X=16.000000,Z=10.460000)
		ViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
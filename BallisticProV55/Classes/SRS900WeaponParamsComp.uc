class SRS900WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=9000)
		RangeAtten=0.450000
		Damage=34
		HeadMult=1.5f
		LimbMult=0.8f
		DamageType=Class'BallisticProV55.DTSRS900Rifle'
		DamageTypeHead=Class'BallisticProV55.DTSRS900RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSRS900Rifle'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Fire',Slot=SLOT_Interact,bNoOverride=False)
		FlashScaleFactor=0.500000
		Recoil=320.000000
		Chaos=0.070000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.20000
		BurstFireRateFactor=0.55
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.250000,OutVal=0.180000),(InVal=0.400000,OutVal=0.30000),(InVal=0.800000,OutVal=0.40000),(InVal=1.000000,OutVal=0.60000)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.180000),(InVal=0.300000,OutVal=0.320000),(InVal=0.500000,OutVal=0.5000),(InVal=0.750000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
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
		CockAnimRate=1.200000
		SightOffset=(X=20.000000,Z=11.750000)
		ViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
		MagAmmo=20
		SightingTime=0.50000
		SightMoveSpeedFactor=0.8
        InventorySize=12
        ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
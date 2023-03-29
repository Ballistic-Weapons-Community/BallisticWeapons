class XRS10WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaPriEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=525,Max=1225)
		RangeAtten=0.5
     	PenetrationEnergy=16
		PenetrateForce=135
		bPenetrate=True
     	Damage=15.000000
        HeadMult=2.25f
        LimbMult=0.75f
     	DamageType=Class'BallisticProV55.DTXRS10SMG'
     	DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
    	DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=140.000000
     	Inaccuracy=(X=64,Y=64)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Fire',Volume=0.900000,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPriFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.066
		FireEffectParams(0)=InstantEffectParams'ArenaPriEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=ArenaSecEffectParams
        BotRefireRate=0.3
        EffectString="Laser sight"
    End Object

	Begin Object Class=FireParams Name=ArenaSecFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecEffectParams'
	End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		HipMultiplier=1
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.05),(InVal=0.30000,OutVal=-0.07000),(InVal=0.5500000,OutVal=0.090000),(InVal=0.800000,OutVal=-0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.220000),(InVal=0.400000,OutVal=0.400000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		MaxRecoil=4096.000000
		DeclineTime=0.5
		DeclineDelay=0.1
	End Object

    //=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
    	AimSpread=(Min=64,Max=256)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.450000
		ADSMultiplier=0.5
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		SightOffset=(X=-15.000000,Z=9.500000)
		DisplaceDurationMult=0.5
		MagAmmo=30
		SightingTime=0.200000
        InventorySize=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
class XRS10WeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		HipMultiplier=1
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
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
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.450000
		ADSMultiplier=2
	End Object

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaPriEffectParams
		DecayRange=(Min=600,Max=1024)
     	TraceRange=(Min=3072,Max=3072)
		RangeAtten=0.250000
     	PenetrationEnergy=8.000000
		PenetrateForce=135
		bPenetrate=True
     	Damage=25.000000
     	HeadMult=1.4f
     	LimbMult=0.5f
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
		FireInterval=0.1000
		BurstFireRateFactor=0.55
		FireEffectParams(0)=InstantEffectParams'ArenaPriEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=ArenaSecEffectParams
        BotRefireRate=0.3
    End Object

	Begin Object Class=FireParams Name=ArenaSecFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecEffectParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=0.5
		PlayerSpeedFactor=1.050000
		MagAmmo=30
		SightingTime=0.200000
        InventorySize=12
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
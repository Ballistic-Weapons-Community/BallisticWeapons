class XRS10WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=TacticalPriEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=525,Max=1225)
		RangeAtten=0.5
     	PenetrationEnergy=8.000000
		PenetrateForce=135
		bPenetrate=True
     	Damage=26
        HeadMult=2.75
        LimbMult=0.67f
     	DamageType=Class'BallisticProV55.DTXRS10SMG'
     	DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
    	DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=240.000000
     	Inaccuracy=(X=64,Y=64)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Fire',Volume=0.900000,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPriFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.066
		FireEffectParams(0)=InstantEffectParams'TacticalPriEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=TacticalSecEffectParams
        BotRefireRate=0.3
        EffectString="Laser sight"
    End Object

	Begin Object Class=FireParams Name=TacticalSecFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecEffectParams'
	End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
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

	Begin Object Class=AimParams Name=TacticalAimParams
    	AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.450000
		ADSMultiplier=0.5
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=-15.000000,Z=9.500000)
		ViewOffset=(X=5.000000,Y=11.000000,Z=-11.000000)
		DisplaceDurationMult=0.5
		MagAmmo=30
		SightingTime=0.200000
        SightMoveSpeedFactor=0.7
        InventorySize=3
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPriFireParams'
        AltFireParams(0)=FireParams'TacticalSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
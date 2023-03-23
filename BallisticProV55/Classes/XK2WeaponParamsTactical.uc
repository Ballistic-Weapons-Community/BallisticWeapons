class XK2WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		Inaccuracy=(X=32,Y=32)
		RangeAtten=0.5
		Damage=24
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTXK2SMG'
		DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=72.000000
		Chaos=0.025000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Volume=0.5,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object

	//Ice
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryIceEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		Inaccuracy=(X=32,Y=32)
		RangeAtten=0.5
		Damage=18
        HeadMult=2.75
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.250000
		Recoil=98.000000
		Chaos=0.050000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryIceFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryIceEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.45
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.600000,OutVal=0.10000),(InVal=0.800000,OutVal=0.120000),(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.100000),(InVal=0.200000,OutVal=0.25),(InVal=0.400000,OutVal=0.5),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.15
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.500000
		AimSpread=(Min=384,Max=1536)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Pitch=256)
		SightOffset=(X=5.000000,Z=12.700000)
		ViewOffset=(X=4.000000,Y=8.000000,Z=-11.000000)
		DisplaceDurationMult=0.75
		MagAmmo=30
		SightingTime=0.25
        InventorySize=4
        SightMoveSpeedFactor=0.75
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireParams'
		FireParams(2)=FireParams'TacticalPrimaryFireParams'
		FireParams(3)=FireParams'TacticalPrimaryFireParams'
		FireParams(4)=FireParams'TacticalPrimaryIceFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
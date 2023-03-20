class MD24WeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=48,Y=48)
		RangeAtten=0.5
		Damage=24
        HeadMult=3.0f
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=8
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=140.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.13000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.65
		XRandFactor=0.03000
		YRandFactor=0.03000
		DeclineTime=0.5
		DeclineDelay=0.220000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=96,Max=384)
		ADSMultiplier=0.5
		AimAdjustTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=0.6
		MagAmmo=16
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
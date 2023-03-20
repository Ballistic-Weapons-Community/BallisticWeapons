class M806WeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=4000,Max=4000)
        DecayRange=(Min=788,Max=1838)
		Inaccuracy=(X=48,Y=48)
		RangeAtten=0.67 // listed as "HV" isn't it?
		Damage=40
        HeadMult=3
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTM806Pistol'
		DamageTypeHead=Class'BallisticProV55.DTM806PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTM806Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M806FlashEmitter'
		Recoil=256.000000
		Chaos=0.2
		BotRefireRate=0.900000
		WarnTargetPct=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Fire',Volume=0.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.25000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Laser sight"
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
		ViewBindFactor=0.4
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.5
		DeclineDelay=0.37000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
    	AimSpread=(Min=128,Max=512)
        ADSMultiplier=0.5
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.320000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=-5.000000,Y=-1.315,Z=12.600000)
		SightPivot=(Pitch=-110,Roll=-675)              //Aligned
		bAdjustHands=true
		RootAdjust=(Yaw=-375,Pitch=3500)
		WristAdjust=(Yaw=-3500,Pitch=-000)
		ViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
		DisplaceDurationMult=0.5
		SightingTime=0.20000
        SightMoveSpeedFactor=0.6
		MagAmmo=7
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
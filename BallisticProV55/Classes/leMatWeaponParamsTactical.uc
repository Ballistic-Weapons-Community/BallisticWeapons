class leMatWeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=8000.000000,Max=8000.000000)
        DecayRange=(Min=788,Max=1838)
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=40
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTleMatRevolver'
		DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
        PenetrationEnergy=24
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=800.000000
		Chaos=0.0400000
		BotRefireRate=0.9
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.3
		FireEndAnim=
		//AimedFireAnim="SightFire"
		FireAnimRate=1.5	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=2500.000000,Max=2500.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.5
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=6
        HeadMult=1.5f
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=1536.000000
		Chaos=0.300000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.2,OutVal=0.03),(InVal=0.36,OutVal=0.07),(InVal=0.62,OutVal=0.09),(InVal=0.6,OutVal=0.11),(InVal=1,OutVal=0.15)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		ClimbTime=0.08
		DeclineTime=0.5
		DeclineDelay=0.25
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		AimAdjustTime=0.45
        ADSMultiplier=0.75
		ChaosDeclineTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//SightOffset=(X=-15.000000,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
        DisplaceDurationMult=0.5
        SightingTime=0.200000
        SightMoveSpeedFactor=0.6
        MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalPrimaryFireParams'
        AltFireParams(0)=FireParams'TacticalSecondaryFireParams';
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
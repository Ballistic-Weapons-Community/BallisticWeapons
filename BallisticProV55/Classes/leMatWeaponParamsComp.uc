class leMatWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=8000.000000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=24
		RangeAtten=0.5
		Damage=30
		DamageType=Class'BallisticProV55.DTleMatRevolver'
		DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=300.000000
		Chaos=0.0400000
		BotRefireRate=0.9
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.32
		FireEndAnim=
		//AimedFireAnim="SightFire"
		FireAnimRate=1.5	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=2500.000000,Max=2500.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.5
		TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=512.000000
		Chaos=0.300000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.2,OutVal=0.03),(InVal=0.36,OutVal=0.07),(InVal=0.62,OutVal=0.09),(InVal=0.6,OutVal=0.11),(InVal=1,OutVal=0.15)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.34
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		//SightOffset=(X=-15.000000,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
        DisplaceDurationMult=0.5
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams';
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
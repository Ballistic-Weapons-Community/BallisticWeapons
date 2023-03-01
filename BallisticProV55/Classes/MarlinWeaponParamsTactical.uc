class MarlinWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=2300,Max=5000)
		RangeAtten=0.75
		Damage=90
        HeadMult=2.25f
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=512.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.80000
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=TacticalGaussEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=125
        HeadMult=2
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrateForce=20
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=0.000000
		Recoil=768.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalGaussFireParams
		FireInterval=0.80000
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalGaussEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.65
		CrouchMultiplier=0.750000
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.400000,OutVal=0.10000),(InVal=0.600000,OutVal=0.25000),(InVal=0.800000,OutVal=0.33000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		MaxRecoil=6400.000000
		DeclineTime=0.650000
		DeclineDelay=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		AimAdjustTime=0.400000
		ChaosDeclineDelay=1.000000
		ChaosDeclineTime=0.650000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Electro Shot",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=True)
		CockAnimRate=1.700000
		ReloadAnimRate=2.000000
		SightOffset=(X=4.000000,Y=-0.100000,Z=9.100000)
		ViewOffset=(X=4.000000,Y=11.000000,Z=-10.000000)
		SightingTime=0.25
		MagAmmo=8
        InventorySize=20
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalGaussFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
class RS8WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		RangeAtten=0.5
		Damage=28
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTRS8Pistol'
		DamageTypeHead=Class'BallisticProV55.DTRS8PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTRS8Pistol'
		PenetrateForce=135
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=192.000000
		Chaos=0.250000
		BotRefireRate=0.750000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Fire',Volume=1.100000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.20000
		FireEndAnim=
		AimedFireAnim='SightFire'
		FireAnimRate=2	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Laser sight"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XRandFactor=0.05
		YRandFactor=0.05
		DeclineTime=0.500000
		DeclineDelay=0.250000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightOffset=(X=-18.000000,Y=-2.000000,Z=18.8750000)
		SightPivot=(Pitch=-200,Roll=-1050)
		bAdjustHands=true
		RootAdjust=(Yaw=-290,Pitch=3000)
		WristAdjust=(Yaw=-3000,Pitch=-000)
		ViewOffset=(X=3.000000,Y=9.000000,Z=-12.000000)
		DisplaceDurationMult=0.33
		
		SightingTime=0.200000
		MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
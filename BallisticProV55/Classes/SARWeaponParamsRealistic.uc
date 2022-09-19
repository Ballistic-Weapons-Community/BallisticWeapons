class SARWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.0500000
		Damage=43.0
		HeadMult=2.139534
		LimbMult=0.651162
		DamageType=Class'BallisticProV55.DTSARRifle'
		DamageTypeHead=Class'BallisticProV55.DTSARRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTSARRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Fire',Pitch=1.250000,Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=775.000000
		Chaos=0.05000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.2000000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.AM67FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-SecFire',Volume=0.600000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=7.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim=
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.3500000),(InVal=0.650000,OutVal=0.300000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		YawFactor=0.15000
		XRandFactor=0.165000
		YRandFactor=0.165000
		MaxRecoil=3000.000000
		DeclineTime=0.750000
		DeclineDelay=0.175000
		ViewBindFactor=0.060000
		ADSViewBindFactor=0.060000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.060000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048);
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=565.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=30
		SightMoveSpeedFactor=0.500000
		SightingTime=0.22
		MagAmmo=35
		ViewOffset=(X=-8.000000,Y=7.000000,Z=-11.000000)
		//SightOffset=(X=8.000000,Y=-0.045000,Z=8.140000)
		SightOffset=(X=20.000000,Y=-0.010000,Z=12.400000)
		ReloadAnimRate=0.925000
		CockAnimRate=1.000000
		WeaponName="AC-12 5.56mm Assault Carbine"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
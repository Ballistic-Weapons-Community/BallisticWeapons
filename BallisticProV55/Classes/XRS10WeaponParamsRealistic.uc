class XRS10WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=800.000000,Max=4000.000000)
		WaterTraceRange=2000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=44.0
		HeadMult=2.318181
		LimbMult=0.568181
		DamageType=Class'BallisticProV55.DTXRS10SMG'
		DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Fire',Volume=0.900000)
		Recoil=700.000000
		Chaos=0.100000
		Inaccuracy=(X=48,Y=48)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireAnimRate=2.80000	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.450000,OutVal=0.200000),(InVal=0.800000,OutVal=0.300000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.200000),(InVal=0.700000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		PitchFactor=0.800000
		YawFactor=0.300000
		XRandFactor=0.190000
		YRandFactor=0.190000
		MaxRecoil=2560.000000
		DeclineTime=0.600000
		DeclineDelay=0.145000
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.600000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=1.100000
		InventorySize=20
		SightMoveSpeedFactor=0.500000
		MagAmmo=25
		ViewOffset=(X=5.000000,Y=9.000000,Z=-11.000000)
		SightOffset=(X=-10.000000,Z=9.45000)
		SightPivot=(Pitch=32)
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=true)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=true)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
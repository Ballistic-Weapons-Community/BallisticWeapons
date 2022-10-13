class RX22AWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=500.000000,Max=3000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=20.0
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=64.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		BurstFireRateFactor=1.00
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-FuelLoop',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.500000
		YawFactor=0.500000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=512
		DeclineTime=0.400000
		ViewBindFactor=0.250000
		ADSViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.875000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=680,Max=1792)
		CrouchMultiplier=0.875000
		ADSMultiplier=0.875000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-2048,Yaw=-4096)
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.775000
		PlayerJumpFactor=0.800000
        InventorySize=24
		SightMoveSpeedFactor=0.500000
		SightingTime=0.4
		MagAmmo=200
		ViewOffset=(X=6.000000,Y=6.000000,Z=-8.000000)
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		WeaponName="RX220-A Incinerator"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
class RX22AWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=1800.000000,Max=1800.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=17.0
			HeadMult=3.3
			LimbMult=0.6
			PenetrateForce=50
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=None
			FireSound=(Sound=Sound'BallisticSounds3.RX22A.RX22A-Ignite',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=64.000000
			Chaos=0.050000
			Inaccuracy=(X=32,Y=32)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.080000
			BurstFireRateFactor=1.00
			FireAnim="FireLoop"
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=None
			FireSound=(Sound=Sound'BallisticSounds3.RX22A.RX22A-FuelLoop',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=32.000000
			Chaos=-1.0
			Inaccuracy=(X=128,Y=128)
			WarnTargetPct=0.200000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.100000
			BurstFireRateFactor=1.00
			FireEndAnim=
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
		ViewBindFactor=0.250000
		ADSViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1536)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=55
		SightMoveSpeedFactor=0.500000
		MagAmmo=150
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
class AS50WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=7500000.000000,Max=7500000.000000)
			WaterTraceRange=6000000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=75
			HeadMult=2.5
			LimbMult=0.7
			DamageType=Class'BWBP_SKC_Pro.DT_AS50Torso'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_AS50Head'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_AS50Limb'
			PenetrationEnergy=64.000000
			PenetrateForce=220
			bPenetrate=True
			PDamageFactor=0.800000
			WallPDamageFactor=0.8500000
			MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AS50.AS50-Fire',Pitch=1.000000,Volume=5.100000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=2300.000000
			Chaos=1.500000
			Inaccuracy=(X=2,Y=2)
			BotRefireRate=0.300000
			WarnTargetPct=0.050000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.200000
			BurstFireRateFactor=1.00
			FireAnim="CFire"
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.400000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.400000,OutVal=0.650000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.550000
		MaxRecoil=6000
		DeclineTime=2.500000
		DeclineDelay=0.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=128,Max=3840)
		AimAdjustTime=0.900000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.850000
		ViewBindFactor=0.550000
		SprintChaos=0.400000
		ChaosDeclineTime=1.800000
		ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.900000
		PlayerJumpFactor=0.750000
		InventorySize=45
		SightMoveSpeedFactor=0.500000
		MagAmmo=10
		SightOffset=(X=-5.000000,Y=25.000000,Z=10.300000)
		ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'

}
class MG36TW_WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=1600.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.266666
		LimbMult=0.666666
		PenetrationEnergy=18.000000
		PenetrateForce=55
		bPenetrate=True
		DamageType=Class'BWBP_SKC_Pro.DT_MG36Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_MG36AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_MG36Assault'
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.JSOC.JSOC-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=128.000000
		Chaos=0.09
		Inaccuracy=(X=3,Y=3)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.200000),(InVal=0.800000,OutVal=0.500000),(InVal=1.000000,OutVal=0.400000)))
		PitchFactor=0.250000
		YawFactor=0.300000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3200.000000
		DeclineTime=0.550000
		DeclineDelay=0.145000;
		ViewBindFactor=1.000000
		ADSViewBindFactor=1.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=32,Max=2872)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=1.000000
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		FallingChaos=0.450000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="MagSmall",Slot=30,Scale=0f)
		WeaponBoneScales(1)=(BoneName="MagDrum",Slot=31,Scale=1f)
		WeaponBoneScales(2)=(BoneName="Reciever",Slot=32,Scale=0f)
		PlayerSpeedFactor=0.900000
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		SightingTime=0.3
		MagAmmo=100
		bMagPlusOne=True
		//ViewOffset=(X=5.000000,Y=4.000000,Z=-12.000000)
		//SightOffset=(X=-15.000000,Y=-0.350000,Z=12.300000)
		ZoomType=ZT_Logarithmic
		WeaponName="Mk 88 5.56mm Squad Automatic Weapon"
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'


}
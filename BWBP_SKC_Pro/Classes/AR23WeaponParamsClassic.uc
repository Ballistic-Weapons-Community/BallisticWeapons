class AR23WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=12000.000000,Max=15000.000000)
			WaterTraceRange=12000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=60
			HeadMult=3.0
			LimbMult=0.7
			DamageType=Class'BWBP_SKC_Pro.DT_AR23HR'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23HRHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23HR'
			PenetrationEnergy=48.000000
			PenetrateForce=250
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter_C'
			FlashScaleFactor=0.500000
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AR23.AR23-HFire',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
			Recoil=512.000000
			Chaos=0.1
			Inaccuracy=(X=1,Y=1)
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.170000
			BurstFireRateFactor=1.00
			FireEndAnim=	
			AimedFireAnim="SightFire"
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=2000.000000,Max=4000.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.300000
			TraceCount=36
			TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
			ImpactManager=Class'BallisticProV55.IM_Shell'
			Damage=25
			LimbMult=1.0
			DamageType=Class'BWBP_SKC_Pro.DT_AR23Flak'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_AR23Flak'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_AR23Flak'
			PenetrationEnergy=16.000000
			PenetrateForce=500
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.Misc.FLAK-Fire',Volume=1.800000)
			Recoil=2048.000000
			Chaos=0.5
			Inaccuracy=(X=1600,Y=1600)
			HipSpreadFactor=1
			BotRefireRate=0.300000
			WarnTargetPct=0.300000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=2.500000
			PreFireAnim="GrenadePrep"
			FireAnim="GrenadeFire"
			AimedFireAnim="GrenadeFireAimed"
			FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		//XCurve=(Points=((InVal=0.100000,OutVal=-0.100000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.500000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.000000),(InVal=0.700000,OutVal=0.100000),(InVal=0.800000,OutVal=0.300000),(InVal=1.000000,OutVal=0.500000)))
		//XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		ViewBindFactor=0.600000
		HipMultiplier=1.000000
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.200000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams //Stock sight
		Weight=30
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="IronsFront",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=3,Scale=1f)
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_EOTech
		Weight=10
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(1)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=53,Scale=0f)
		GunAugmentClass=class'BallisticProV55.Augment_Holo'
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Wut
		Weight=10
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=51,Scale=0f)
		WeaponBoneScales(1)=(BoneName="GLIrons",Slot=52,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Holo",Slot=53,Scale=0f)
		GunAugmentClass=class'BallisticProV55.Augment_RDS'
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams_Irons
		Weight=3
		WeaponBoneScales(0)=(BoneName="IronsRear",Slot=51,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Holo",Slot=52,Scale=0f)
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-10,Y=-0.000000,Z=15.700000)
		SightPivot=(Pitch=-800)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams_EOTech'
	Layouts(2)=WeaponParams'ClassicParams_Irons'
	Layouts(3)=WeaponParams'ClassicParams_Wut'


}
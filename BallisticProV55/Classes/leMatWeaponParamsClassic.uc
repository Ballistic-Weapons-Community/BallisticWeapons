class leMatWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=8000.000000,Max=8000.000000)
			WaterTraceRange=6400.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=60.0
			HeadMult=1.7
			LimbMult=0.4
			DamageType=Class'BallisticProV55.DTleMatRevolver'
			DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
			DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
			PenetrationEnergy=24.000000
			PenetrateForce=150
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
			FlashScaleFactor=0.600000
			FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
			Recoil=1600.000000
			Chaos=-1.0
			Inaccuracy=(X=16,Y=16)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.250000
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=1500.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.300000
			TraceCount=9
			TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
			ImpactManager=Class'BallisticProV55.IM_Shell'
			Damage=22.0
			HeadMult=1.4
			LimbMult=0.3
			DamageType=Class'BallisticProV55.DTleMatShotgun'
			DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
			DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Circle
			MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
			FlashScaleFactor=2.000000
			FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
			Recoil=512.000000
			Chaos=-1.0
			Inaccuracy=(X=500,Y=500)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			BurstFireRateFactor=1.00
			FireAnim="Fire2"
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		ChaosDeclineTime=0.700000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.100000
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		MagAmmo=9
		SightOffset=(X=-30.000000,Y=-0.550000,Z=12.300000)
		SightPivot=(Pitch=768,Roll=-1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
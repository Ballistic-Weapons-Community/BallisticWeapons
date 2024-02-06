class HVCMk9WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
		Begin Object Class=FireEffectParams Name=ClassicPrimaryEffectParams
			SpreadMode=FSM_Circle
			FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-FireStart')
			Recoil=64.000000
			Chaos=-1.0
			Inaccuracy=(X=6000,Y=6000)
			BotRefireRate=0.990000
		End Object
		
		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.100000
			BurstFireRateFactor=1.00
			TargetState="BranchingFire"
			FireEffectParams(0)=FireEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=1600.000000,Max=1600.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=285.0
			HeadMult=1.315789
			LimbMult=0.754385
			DamageType=Class'BallisticProV55.DT_HVCRedLightning'
			DamageTypeHead=Class'BallisticProV55.DT_HVCRedLightning'
			DamageTypeArm=Class'BallisticProV55.DT_HVCRedLightning'
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
			FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=0.900000)
			Recoil=96.000000
			Chaos=-1.0
			PushbackForce=1600.000000
			Inaccuracy=(X=2,Y=2)
			BotRefireRate=1.000000
			WarnTargetPct=0.200000
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.700000
			BurstFireRateFactor=1.00
			FireAnim="Fire2"
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=1.000000
		ViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=32,Max=2048)
		AimAdjustTime=0.700000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.850000
		PlayerJumpFactor=0.750000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		ViewOffset=(X=9,Y=9,Z=-7)
		//SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}

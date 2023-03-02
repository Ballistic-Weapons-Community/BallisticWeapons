class LS440WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

//=================================================================
// PRIMARY FIRE
//=================================================================	

	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=1500000.000000,Max=1500000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=180
		HeadMult=1.0
		LimbMult=1.0
		DamageType=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
		DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
		DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_LS440Instagib'
		PenetrationEnergy=64.000000
		PenetrateForce=500
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireInstagib',Volume=2.000000)
		Recoil=100.000000
		Chaos=-1.0
		BotRefireRate=1.050000
		WarnTargetPct=0.050000
	End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=2.500000
			AmmoPerFire=25
			BurstFireRateFactor=1.00
			FireAnim="FireBig"
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=1500000.000000,Max=1500000.000000)
			WaterTraceRange=5000.0
			DecayRange=(Min=0.0,Max=0.0)
			Damage=45
			HeadMult=2.0
			LimbMult=0.7
			DamageType=Class'BWBP_SKCExp_Pro.DT_LS440Body'
			DamageTypeHead=Class'BWBP_SKCExp_Pro.DT_LS440Head'
			DamageTypeArm=Class'BWBP_SKCExp_Pro.DT_LS440Body'
			PenetrationEnergy=64.000000
			PenetrateForce=500
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			SpreadMode=FSM_Rectangle
			MuzzleFlashClass=Class'BWBP_SKCExp_Pro.A48FlashEmitter'
			FlashScaleFactor=0.400000
			FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
			Recoil=20.000000
			Chaos=-1.0
			BotRefireRate=1.050000
			WarnTargetPct=0.050000
		End Object

		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.150000
			AmmoPerFire=2
			BurstFireRateFactor=1.00
			FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.700000
		YRandFactor=0.700000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
		ViewBindFactor=0.550000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=20,Max=1400)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=1.000000
		ChaosDeclineTime=1.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerJumpFactor=1.100000
		InventorySize=15
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=20
		SightOffset=(X=18.000000,Y=-8.500000,Z=22.000000)
		SightPivot=(Pitch=600,Roll=-1024)
		ZoomType=ZT_Logarithmic
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
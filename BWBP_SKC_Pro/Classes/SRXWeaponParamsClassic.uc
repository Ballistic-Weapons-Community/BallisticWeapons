class SRXWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Standard
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=35
		HeadMult=3.0
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrationEnergy=48.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Pitch=0.900000,Volume=1.500000)
		Recoil=140.000000
		Chaos=0.025000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.150000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.150000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Incendiary
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsInc
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=65
		HeadMult=3.0
		LimbMult=0.7
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Pitch=1.500000,Volume=1.500000)
		Recoil=386.000000
		Chaos=0.025000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.250000
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsInc
		FireInterval=0.250000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsInc'
	End Object
	
	//Corrosive
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParamsAcid
		TraceRange=(Min=15000.000000,Max=15000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=15
		HeadMult=4.0
		LimbMult=0.67
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire',Pitch=1.200000,Volume=1.500000)
		Recoil=128.000000
		Chaos=0.025000
		Inaccuracy=(X=1,Y=1)
		BotRefireRate=0.122500
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsAcid
		FireInterval=0.122500
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParamsAcid'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.200000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=3.000000
		YawFactor=0.200000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=2048.000000
		DeclineDelay=0.150000
		ViewBindFactor=1.0
		HipMultiplier=1.000000
		CrouchMultiplier=0.200000
		bViewDecline=True
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsInc
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.2
		MaxRecoil=3072.000000
		DeclineTime=1.20000
		DeclineDelay=1.000000
	End Object

	Begin Object Class=RecoilParams Name=ClassicRecoilParamsAcid
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.08
		MaxRecoil=3072.000000
		DeclineTime=0.30000
		DeclineDelay=0.300000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=8,Max=2648)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.200000
		ADSMultiplier=0.700000
		ViewBindFactor=0.350000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=35
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=20
		SightOffset=(X=-10.000000,Y=-0.650000,Z=27.200000)
		SightPivot=(Pitch=-128,Yaw=16)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		RecoilParams(1)=RecoilParams'ClassicRecoilParamsInc'
		RecoilParams(2)=RecoilParams'ClassicRecoilParamsAcid'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParamsInc'
		FireParams(2)=FireParams'ClassicPrimaryFireParamsAcid'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
class SK410WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=ClassicPrimaryEffectParams
			TraceRange=(Min=4000.000000,Max=6000.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.600000
			TraceCount=8
			TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
			ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
			Damage=25.0
			LimbMult=0.4
			DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
			FlashScaleFactor=1.600000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
			Recoil=640.000000
			Chaos=-1.0
			Inaccuracy=(X=1400,Y=1200)
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=ClassicPrimaryFireParams
			FireInterval=0.300000
			BurstFireRateFactor=1.00
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'ClassicPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
			TraceRange=(Min=128.000000,Max=128.000000)
			WaterTraceRange=5000.0
			Damage=70
			HeadMult=1.5
			LimbMult=0.5
			DamageType=Class'BWBP_SKC_Pro.DT_SK410Hit'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410HitHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Hit'
			ChargeDamageBonusFactor=1
			PenetrationEnergy=0.000000
			FireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,Pitch=0.800000,bAtten=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.900000
			WarnTargetPct=0.050000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.700000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			PreFireAnim="PrepBash"
			FireAnim="Bash"
			PreFireAnimRate=2.000000
			FireAnimRate=1.500000
			FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=1.500000
		ViewBindFactor=0.900000
		ADSViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=1960)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
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
		MagAmmo=6
		SightOffset=(X=-8.000000,Y=-10.000000,Z=21.000000)
		SightPivot=(Pitch=150)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'


}
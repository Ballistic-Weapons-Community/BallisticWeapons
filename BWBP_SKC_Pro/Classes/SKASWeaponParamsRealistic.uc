class SKASWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=2000.000000,Max=4000.000000)
		WaterTraceRange=5000.0
		RangeAtten=0.300000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=30
		LimbMult=0.333333
		DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
		PenetrationEnergy=16.000000
		PenetrateForce=100
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SKAS.SKAS-Rapid')
		Recoil=300.000000
		Chaos=-1.0
		Inaccuracy=(X=900,Y=900)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.130000
		BurstFireRateFactor=1.00
		FireAnim="FireRot"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object

    Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryManualEffectParams
        TraceRange=(Min=2048.000000,Max=4096.000000)
        RangeAtten=0.400000
        TraceCount=7
        TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
        ImpactManager=Class'BallisticProV55.IM_Shell'
        Damage=45
        DamageType=Class'BWBP_SKC_Pro.DTSKASShotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgun'
        PenetrateForce=100
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
        FlashScaleFactor=2.0
        Recoil=1024.000000
        Chaos=0.250000
        BotRefireRate=0.800000
        WarnTargetPct=0.400000
		Inaccuracy=(X=450,Y=450)
		HipSpreadFactor=1.000000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Power',Volume=1.300000)	
    End Object

    Begin Object Class=FireParams Name=RealisticPrimaryManualFireParams
        FireInterval=1.750000
        FireAnim="SemiFire"
        FireEndAnim=
        FireAnimRate=1.000000	
        FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryManualEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams
			TraceRange=(Min=3000.000000,Max=4000.000000)
			WaterTraceRange=5000.0
			RangeAtten=0.850000
			TraceCount=30
			TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
			ImpactManager=Class'BallisticProV55.IM_Shell'
			Damage=42
			HeadMult=1.4
			LimbMult=0.357142
			DamageType=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
			DamageTypeHead=Class'BWBP_SKC_Pro.DTSKASShotgunHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DTSKASShotgunAlt'
			PenetrationEnergy=16.000000
			PenetrateForce=100
			bPenetrate=True
			PDamageFactor=0.6
			WallPDamageFactor=0.4
			MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
			FlashScaleFactor=1.000000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.SKAS.SKAS-Triple',Volume=2.200000)
			Recoil=2048.000000
			Chaos=-1.0
			Inaccuracy=(X=1600,Y=1600)
			HipSpreadFactor=1.000000
			BotRefireRate=0.900000
			WarnTargetPct=0.100000	
		End Object

		Begin Object Class=FireParams Name=RealisticSecondaryFireParams
			FireInterval=1.700000
			AmmoPerFire=3
			BurstFireRateFactor=1.00
			PreFireAnim="ChargeUp"
			FireAnim="FireBig"
			FireEndAnim=	
			FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=0.600000)))
		PitchFactor=0.000000
		YawFactor=0.00000
		XRandFactor=1.000000
		YRandFactor=1.000000
		MaxRecoil=2048.000000
		DeclineTime=1.000000
		DeclineDelay=0.050000
		ViewBindFactor=0.900000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=1024)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.350000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		MagAmmo=36
		WeaponModes(0)=(ModeName="Semi-Automatic",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Automatic",ModeID="WM_FullAuto")
		WeaponModes(2)=(ModeName="Manual",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(3)=(ModeName="Semi-Auto",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(4)=(ModeName="1110011",bUnavailable=True,ModeID="WM_FullAuto")
		WeaponModes(5)=(ModeName="XR4 System",bUnavailable=True,ModeID="WM_FullAuto")
		InitialWeaponMode=1
		WeaponName="SKAS-21 Automatic Shotgun"
		SightOffset=(X=-10.000000,Y=2.000000,Z=14.000000)
		SightPivot=(Pitch=512,Roll=-1024,Yaw=-512)
		ReloadAnimRate=0.900000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
        FireParams(1)=FireParams'RealisticPrimaryFireParams'
        FireParams(2)=FireParams'RealisticPrimaryManualFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
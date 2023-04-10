class SK410WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=750.000000,Max=3000.000000)
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
		bPenetrate=False
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.600000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.200000,Pitch=1.200000)
		Recoil=2048.000000
		Chaos=0.5
		Inaccuracy=(X=1100,Y=1100)
		HipSpreadFactor=1.000000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.140000
		BurstFireRateFactor=1.00
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=10000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=80
        DamageRadius=256.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=2048.000000
        Chaos=0.450000
        BotRefireRate=0.6
        WarnTargetPct=0.4	
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000,Pitch=1.200000)
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        FireInterval=0.140000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.250000	
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		DeclineTime=0.800000
		ViewBindFactor=0.300000
		ADSViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.800000
		ADSMultiplier=0.800000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.850000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=20,Y=-8.570000,Z=18.000000)
		SightPivot=(Pitch=150)
		//Function
		InventorySize=4
		PlayerSpeedFactor=1.050000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		ReloadAnimRate=1.100000
		CockAnimRate=1.000000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SK-410 8ga Breaching Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticRDSParams
		//Layout core
		Weight=10
		LayoutName="Red Dot Sight"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=1f)
		SightPivot=(Pitch=150)
		SightOffset=(X=19.000000,Y=-8.5700000,Z=19.290000)
		//Function
		InventorySize=4
		PlayerSpeedFactor=1.050000
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		MagAmmo=6
		bMagPlusOne=True
		ReloadAnimRate=1.100000
		CockAnimRate=1.000000
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=0
		WeaponName="SK-410 8ga Breaching Shotgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticRDSParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=SK_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-C-CamoSnow",Index=1,AIndex=2,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Wood
		Index=2
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-UC-CamoJungle",Index=1,AIndex=2,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Digital
		Index=3
		CamoName="Digital"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-UC-CamoDigital",Index=1,AIndex=2,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Blood
		Index=4
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-R-CamoBlood",Index=1,AIndex=2,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_RedTiger
		Index=5
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-R-CamoTiger",Index=1,AIndex=2,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Corrupt
		Index=6
		CamoName="Corrupt"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-Charged",Index=1,AIndex=2,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'SK_Black'
	Camos(1)=WeaponCamo'SK_Urban'
	Camos(2)=WeaponCamo'SK_Wood'
	Camos(3)=WeaponCamo'SK_Digital'
	Camos(4)=WeaponCamo'SK_Blood'
	Camos(5)=WeaponCamo'SK_RedTiger'
	Camos(6)=WeaponCamo'SK_Corrupt'
}
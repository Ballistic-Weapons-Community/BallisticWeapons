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
		HipSpreadFactor=1.000000
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

    Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=6300.000000
        MaxSpeed=6300.000000
        AccelSpeed=3000.000000
        Damage=65
        DamageRadius=200.000000
        MomentumTransfer=10000.000000
		RadiusFallOffType=RFO_Linear
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.600000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000,Pitch=1.200000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
        BotRefireRate=0.6
        WarnTargetPct=0.4	
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        FireInterval=0.300000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
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
		SprintOffSet=(Pitch=-1000,Yaw=-2048)
		JumpChaos=0.850000
		JumpOffSet=(Pitch=1000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=20,Y=-8.570000,Z=18.000000)
		SightPivot=(Pitch=150)
		//Function
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		//BringUpTime=1.000000
		bNeedCock=True
		MagAmmo=6
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicRDSParams
		//Layout core
		Weight=10
		LayoutName="Red Dot Sight"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=1f)
		SightPivot=(Pitch=150)
		SightOffset=(X=19.000000,Y=-8.5700000,Z=19.290000)
		//Function
		InventorySize=5
		SightMoveSpeedFactor=0.500000
		SightingTime=0.250000
		bNeedCock=True
		MagAmmo=6
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
    Layouts(0)=WeaponParams'ClassicParams' //Standard
    Layouts(1)=WeaponParams'ClassicRDSParams' //Standard
	
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
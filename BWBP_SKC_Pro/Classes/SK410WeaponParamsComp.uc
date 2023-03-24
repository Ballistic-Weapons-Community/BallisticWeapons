class SK410WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
        TraceRange=(Min=2048.000000,Max=2048.000000)
        DecayRange=(Min=788,Max=1838)
        RangeAtten=0.350000
        TraceCount=7
        TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunHE'
        ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
        Damage=9
        DamageType=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_SK410ShotgunHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_SK410Shotgun'
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=378.000000
        Chaos=0.400000
        BotRefireRate=0.900000
        WarnTargetPct=0.500000
		Inaccuracy=(X=256,Y=256)
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-Blast',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        FireInterval=0.225000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.750000	
        FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        ProjectileClass=Class'BWBP_SKC_Pro.SK410HEProjectile'
        SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
        Speed=8000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=50
        DamageRadius=256.000000
		PushbackForce=180.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
        FlashScaleFactor=0.500000
        Recoil=650.000000
        Chaos=0.450000
        BotRefireRate=0.6
        WarnTargetPct=0.4	
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.M781.M781-FireFRAG',Volume=1.300000)
    End Object

    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.650000
        FireEndAnim=
        AimedFireAnim="SightFire"
        FireAnimRate=1.250000	
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=ArenaRecoilParams
        ViewBindFactor=0.65
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.050000),(InVal=0.400000,OutVal=0.120000),(InVal=0.600000,OutVal=0.15000),(InVal=0.750000,OutVal=0.250000),(InVal=1.000000,OutVal=0.32)))
        YCurve=(Points=(,(InVal=0.500000,OutVal=0.400000),(InVal=1.000000,OutVal=1.000000)))
        YRandFactor=0.05
        XRandFactor=0.05
        DeclineTime=0.500000
        DeclineDelay=0.450000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3072,Yaw=-4096)
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=0f)
		SightOffset=(X=-8.000000,Y=-10.000000,Z=21.000000)
		SightPivot=(Pitch=150)
		//Function
		CockAnimRate=1.250000
    	ReloadAnimRate=1.250000
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
		PlayerJumpFactor=1.000000
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=0.75
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_RDS
		//Layout core
		Weight=10
		LayoutName="Red Dot Sight"
		//Attachments
        WeaponBoneScales(0)=(BoneName="RDS",Slot=7,Scale=1f)
		SightPivot=(Pitch=150)
		SightOffset=(X=20.000000,Y=-10.000000,Z=22.500000)
		//Function
		CockAnimRate=1.250000
    	ReloadAnimRate=1.250000
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
		
		PlayerJumpFactor=1.000000
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		DisplaceDurationMult=0.75
		MagAmmo=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams' //Standard
    Layouts(1)=WeaponParams'ArenaParams_RDS'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=SK_Black
		Index=0
		CamoName="Black" //This needs to be core, with urban in camos
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-Main",Index=1,Index=1,AIndex=2,PIndex=0)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Urban
		Index=1
		CamoName="Urban"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Wood
		Index=2
		CamoName="Wood"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-UC-CamoJungle",Index=1,Index=1,AIndex=2,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Digital
		Index=3
		CamoName="Digital"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-UC-CamoDigital",Index=1,Index=1,AIndex=2,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Blood
		Index=4
		CamoName="Bloodied"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-R-CamoBlood",Index=1,AIndex=2,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_RedTiger
		Index=5
		CamoName="Red Tiger"
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SK410Camos.SK410-R-CamoTiger",Index=1,AIndex=2,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SK_Corrupt
		Index=6
		CamoName="Corrupt"
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
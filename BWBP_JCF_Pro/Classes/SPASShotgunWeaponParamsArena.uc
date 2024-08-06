class SPASShotgunWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//12ga shot
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=7500.000000,Max=7500.000000)
		RangeAtten=0.30000
		TraceCount=8
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		HeadMult=2.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.35
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-FireOld',Volume=1.300000)
		Recoil=650.000000
		Chaos=0.3
		Inaccuracy=(X=190,Y=270)
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.450000
		FireEndAnim=
		AimedFireAnim="SightFire"	
	FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//12ga slug
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams_Slug
		TraceRange=(Min=6000.000000,Max=6000.000000)
        DecayRange=(Min=750,Max=3000)
		RangeAtten=0.15
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Default'
		ImpactManager=Class'BallisticProV55.IM_BigBulletHMG'
		Damage=100
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=2048.000000 //x1.5
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		Inaccuracy=(X=32,Y=32)
		FireSound=(Sound=SoundGroup'BWBP_JCF_Sounds.SPAS.SPAS-HFire',Volume=1.800000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Slug
		FireInterval=0.500000
		BurstFireRateFactor=1.00
		AimedFireAnim="SightFire"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams_Slug'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
		RangeAtten=0.300000
		TraceCount=14
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=9
		HeadMult=2.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_JCF_Pro.DTSPASShotgun'
		DamageTypeHead=Class'BWBP_JCF_Pro.DTSPASShotgunHead'
		DamageTypeArm=Class'BWBP_JCF_Pro.DTSPASShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=0.1
		FireSound=(Sound=Sound'BWBP_JCF_Sounds.SPAS.SPAS-FireDouble',Volume=1.800000)
		Inaccuracy=(X=190,Y=540)
		Recoil=900.000000
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.80000
		AmmoPerFire=2
		FireAnim="FireCock"
		FireEndAnim=
		AimedFireAnim="SightFireCock"	
	FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		CrouchMultiplier=0.800000
		ViewBindFactor=0.4
        XCurve=(Points=(,(InVal=0.200000,OutVal=0.10000),(InVal=0.350000,OutVal=0.13000),(InVal=0.550000,OutVal=0.230000),(InVal=0.800000,OutVal=0.35000),(InVal=1.000000,OutVal=0.45)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.150000),(InVal=0.40000,OutVal=0.50000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
        YRandFactor=0.100000
        DeclineTime=0.500000
        DeclineDelay=0.750000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	ViewBindFactor=0.15
        ADSMultiplier=0.350000
        SprintOffSet=(Pitch=-1000,Yaw=-2048)
        JumpChaos=1.000000
        ChaosDeclineTime=0.750000	
		ChaosSpeedThreshold=550.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Slug
		//Layout core
		LayoutName="12 Gauge Slug"
		LayoutTags="slug"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.35
		//Stats
		ReloadAnimRate=1.500000
		MagAmmo=5
        InventorySize=4
		ViewOffset=(X=-1.000000,Y=4.000000,Z=-10.000000)
		SightOffset=(X=7.000000,Y=-0.050000,Z=10.200000)
		bNoaltfire=true
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Slug'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="12 Gauge Shot"
		Weight=30
		//ADS
		SightMoveSpeedFactor=0.9
		SightingTime=0.35
		//Stats
		ReloadAnimRate=1.500000
		MagAmmo=5
        InventorySize=4
		ViewOffset=(X=-1.000000,Y=4.000000,Z=-10.000000)
		SightOffset=(X=7.000000,Y=-0.050000,Z=10.200000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams_Slug'
	Layouts(1)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=SP_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Cobalt
		Index=1
		CamoName="Cobalt"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S4",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Bricks
		Index=2
		CamoName="Bricks"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S2",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Hazard
		Index=3
		CamoName="Hazard"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S5",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=SP_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SPASCamos.SPASShort_Main_S3",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'SP_Gray'
	Camos(1)=WeaponCamo'SP_Cobalt'
	Camos(2)=WeaponCamo'SP_Bricks'
	Camos(3)=WeaponCamo'SP_Hazard'
	Camos(4)=WeaponCamo'SP_Gold'
}
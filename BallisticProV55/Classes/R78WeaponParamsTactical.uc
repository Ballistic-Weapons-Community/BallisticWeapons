class R78WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=120
        HeadMult=2f
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PDamageFactor=0.800000
		bPenetrate=True
		PenetrateForce=250
		PenetrationEnergy=96
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=1024.000000
		Chaos=0.5
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=1.500000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.1
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		CrouchMultiplier=0.850000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.25
		YRandFactor=0.25
        ClimbTime=0.075
		DeclineDelay=0.22
        DeclineTime=0.75
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.800000
		AimSpread=(Min=384,Max=1280)
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Scope"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
		SightPivot=(Roll=-1024)
		SightOffset=(X=18.000000,Y=-1.600000,Z=17.000000)
		SightingTime=0.4500
		ScopeScale=0.6
		SightMoveSpeedFactor=0.45
        ZoomType=ZT_Logarithmic// sniper 4-8x
		MinZoom=4
		MaxZoom=8
		ZoomStages=1
		//Function
		//ViewOffset=(X=-1.000000,Y=8.000000,Z=-13.00000)
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_NoScope
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
		ZoomType=ZT_Irons
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		//Function
		//ViewOffset=(X=-1.000000,Y=8.000000,Z=-13.00000)
		SightingTime=0.4
		SightMoveSpeedFactor=0.45
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=R78_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Tan
		Index=1
		CamoName="Tan"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R87_Main-SD",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R87_Scope-SD",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.RifleSkinDesertCamo",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Jungle
		Index=3
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_JTiger-SD",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Tiger
		Index=4
		CamoName="Tiger"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_RTiger-SD",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Winter
		Index=5
		CamoName="Winter"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R98_Winter-SD",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Gold
		Index=6
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.GoldRifle-Shine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'R78_Gray'
	Camos(1)=WeaponCamo'R78_Tan'
	Camos(2)=WeaponCamo'R78_Desert'
	Camos(3)=WeaponCamo'R78_Jungle'
	Camos(4)=WeaponCamo'R78_Tiger'
	Camos(5)=WeaponCamo'R78_Winter'
	Camos(6)=WeaponCamo'R78_Gold'
}
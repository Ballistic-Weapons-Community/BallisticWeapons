class R78WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
        HeadMult=1.75f
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.1
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=1.25
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.25
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		AimSpread=(Min=64,Max=1024)
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Scope"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
        ZoomType=ZT_Logarithmic
		SightOffset=(X=18.000000,Y=-1.600000,Z=17.000000)
		SightPivot=(Roll=-1024)
		SightingTime=0.550000
		SightMoveSpeedFactor=0.6
		//Function
		ReloadAnimRate=1.250000
		ViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_NoScope
		//Layout core
		LayoutName="Iron Sights"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
		ZoomType=ZT_Irons
		SightPivot=(Pitch=-32,Roll=-1024)
		SightOffset=(X=-10.000000,Y=-1.180000,Z=11.950000)
		SightingTime=0.450000
		SightMoveSpeedFactor=0.6
		//Function
		ReloadAnimRate=1.250000
		ViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
		MagAmmo=7
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_NoScope'
	
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
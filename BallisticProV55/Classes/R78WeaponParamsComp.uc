class R78WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
        HeadMult=1.50
        LimbMult=0.90
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=2048.000000
		Chaos=0.500000
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=1.500000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.1
		bCockAfterFire=True
		AimedFireAnim="SightFireCock"
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.15)))
		XRandFactor=0.10000
		YRandFactor=0.10000
        ClimbTime=0.08
		DeclineDelay=0.22
        DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
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
		LayoutTags="quickpull"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=1f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
        ZoomType=ZT_Logarithmic
     	SightOffset=(X=-1.500000,Y=-0.5,Z=5.30000)
		SightPivot=(Roll=-1024)
		SightingTime=0.4500
		ScopeScale=0.6
		SightMoveSpeedFactor=0.6
		//Function
		ReloadAnimRate=1.250000
		//ViewOffset=(X=-1.000000,Y=8.000000,Z=-13.00000)
		MagAmmo=5
        InventorySize=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=ArenaParams_NoScope
		//Layout core
		LayoutName="Iron Sights"
		LayoutTags="quickpull"
		Weight=10
		//Attachments
		WeaponBoneScales(0)=(BoneName="Scope",Slot=6,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Silencer",Slot=78,Scale=0f)
		ZoomType=ZT_Irons
		SightPivot=(Pitch=-64)
		SightOffset=(X=-1.000000,Y=0.00,Z=1.9)
		SightingTime=0.4
		SightMoveSpeedFactor=0.6
		//Function
		ReloadAnimRate=1.250000
		//ViewOffset=(X=-1.000000,Y=8.000000,Z=-13.00000)
		MagAmmo=5
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
	
	Begin Object Class=WeaponCamo Name=R78_Wood
		Index=1
		CamoName="Black n' Wood"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainWood",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Jungle
		Index=3
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Urban
		Index=4
		CamoName="Urban"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainUrban",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Patriot
		Index=5
		CamoName="Patriot"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainPatriot",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Tiger
		Index=6
		CamoName="Red Tiger"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainRedTiger",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=R78_Gold
		Index=7
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.R78Camos.R78-ScopeDark",Index=2,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'R78_Gray'
	Camos(1)=WeaponCamo'R78_Wood'
	Camos(2)=WeaponCamo'R78_Desert'
	Camos(3)=WeaponCamo'R78_Jungle'
	Camos(4)=WeaponCamo'R78_Urban'
	Camos(5)=WeaponCamo'R78_Patriot'
	Camos(6)=WeaponCamo'R78_Tiger'
	Camos(7)=WeaponCamo'R78_Gold'
}
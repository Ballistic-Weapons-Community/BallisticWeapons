class MarlinWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6500)
		RangeAtten=0.75
		Damage=80
        HeadMult=2f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
        PenetrationEnergy=48
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=1536.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	
	Begin Object Class=InstantEffectParams Name=TacticalGaussEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		RangeAtten=0.75
		Damage=100
        HeadMult=2f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTMarlinRifle'
		DamageTypeHead=Class'BallisticProV55.DTMarlinRifleHead'
		DamageTypeArm=Class'BallisticProV55.DTMarlinRifle'
		PenetrateForce=20
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=0.000000
		Recoil=1536.000000
		Chaos=0.800000
		BotRefireRate=0.7
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalGaussFireParams
		FireInterval=1
		bCockAfterFire=True
		FireEndAnim=
		AimedFireAnim="SightFireCock"
		FireAnimRate=1.150000	
		FireEffectParams(0)=InstantEffectParams'TacticalGaussEffectParams'
	End Object
	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.65
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.400000,OutVal=0.10000),(InVal=0.600000,OutVal=0.25000),(InVal=0.800000,OutVal=0.33000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.150000),(InVal=0.400000,OutVal=0.5),(InVal=0.700000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		MaxRecoil=8192
		ClimbTime=0.06
		DeclineDelay=0.35
		DeclineTime=1
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosDeclineDelay=1.000000
		ChaosDeclineTime=0.650000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Iron Sights"
		Weight=30
		//Attachments
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=0f)
		SightOffset=(X=6.000000,Y=-0.040000,Z=2.850000)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(bUnavailable=True)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		CockAnimRate=1.250000
		//ViewOffset=(X=0.000000,Y=14.000000,Z=-13.000000)
		SightingTime=0.35
        SightMoveSpeedFactor=0.60
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		//FireParams(1)=FireParams'TacticalGaussFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_Gauss
		//Layout core
		LayoutName="Gauss Mod"
		LayoutTags="gauss"
		Weight=5
		//Attachments
		WeaponBoneScales(0)=(BoneName="Gauss",Slot=19,Scale=1f)
		SightOffset=(X=6.000000,Y=-0.060000,Z=6.300000)
		SightPivot=(Pitch=128)
		//Function
		WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Accelerated Shot",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(2)=(bUnavailable=True)
		InitialWeaponMode=0
		CockAnimRate=1.25
		//ViewOffset=(X=0.000000,Y=14.000000,Z=-13.000000)
		SightingTime=0.35
        SightMoveSpeedFactor=0.60
		MagAmmo=8
        InventorySize=6
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalGaussFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_Gauss'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=Deer_Wood
		Index=0
		CamoName="Wood"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Redwood
		Index=1
		CamoName="Redwood"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.MarlinK-Shiny",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Orange
		Index=2
		CamoName="Tiger"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.DeermasterOrange-Main-Shine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=Deer_Gold
		Index=3
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MarlinCamos.MarlinGold-Shine",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'Deer_Wood'
	Camos(1)=WeaponCamo'Deer_Redwood'
	Camos(2)=WeaponCamo'Deer_Orange'
	Camos(3)=WeaponCamo'Deer_Gold'
}
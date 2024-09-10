class M75WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=3072.000000
		Chaos=0.750000
		BotRefireRate=0.3
		WarnTargetPct=0.75
		Damage=170
		PushbackForce=350.000000
	    DamageType=Class'BallisticProV55.DTM75Railgun'
        DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
        DamageTypeArm=Class'BallisticProV55.DTM75Railgun'		
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Volume=0.750000,Radius=384.000000)
	End Object
	
	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        TargetState="ChargedRail"
		AimedFireAnim="SightFire"
		FireInterval=1.500000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
		FlashScaleFactor=0.400000
		Recoil=4096.000000
		Chaos=0.750000
		Damage=170
		BotRefireRate=0.3
		WarnTargetPct=0.75
		PushbackForce=1300.000000
		DamageType=Class'BallisticProV55.DTM75Railgun'
		DamageTypeHead=Class'BallisticProV55.DTM75RailgunHead'
		DamageTypeArm=Class'BallisticProV55.DTM75Railgun'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75Fire',Radius=768.000000)
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.50000
		bCockAfterFire=True
		FireEndAnim="'"
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.15
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.15)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.400000
		ClimbTime=0.15
		DeclineDelay=0.25
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-8000,Yaw=-10000)
		JumpOffset=(Pitch=-6000,Yaw=2000)
		JumpChaos=0.800000
		AimSpread=(Min=64,Max=1536)
		ChaosDeclineTime=0.800000
		ADSMultiplier=0.25
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="X-Ray Scope"
		Weight=70
		//Visual
		AllowedCamos(0)=0
		AllowedCamos(1)=1
        ZoomType=ZT_Logarithmic
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		//SightOffset=(X=20.000000,Z=24.700000)
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		ScopeScale=0.6
        MagAmmo=5
        InventorySize=8
		ScopeViewTex=Texture'BW_Core_WeaponTex.M75.M75ScopeView'
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Proto
		//Layout core
		LayoutName="X75 Prototype"
		Weight=5
		//Visual
		AllowedCamos(0)=2
		WeaponBoneScales(0)=(BoneName="Scope",Slot=1,Scale=0f)
		SightOffset=(X=15.000000,Z=0)
		ZoomType=ZT_Irons
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.6
		SightingTime=0.40 //
        MagAmmo=5
        InventorySize=8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Proto'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=M75_Standard
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M75_Winter
		Index=1
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Main-S1",Index=3,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Main2-S1",Index=4,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Clip-D1",Index=2,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75-Scope-S1",Index=1,AIndex=3,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=M75_Prototype
		Index=2
		CamoName="Prototype"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75_SKPart1_Shine",Index=3,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M75Camos.M75_SKPart2_Shine",Index=4,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'M75_Standard'
	Camos(1)=WeaponCamo'M75_Winter'
	Camos(2)=WeaponCamo'M75_Prototype'
}
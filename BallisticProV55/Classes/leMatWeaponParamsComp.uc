class leMatWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=8000.000000,Max=8000.000000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=24
		RangeAtten=0.5
		Damage=38
		DamageType=Class'BallisticProV55.DTleMatRevolver'
		DamageTypeHead=Class'BallisticProV55.DTleMatrevolverHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatRevolver'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
		FlashScaleFactor=0.600000
		Recoil=800.000000
		Chaos=0.0400000
		BotRefireRate=0.9
		WarnTargetPct=0.35
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-Fire',Volume=1.200000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.32
		FireEndAnim=
		//AimedFireAnim="SightFire"
		FireAnimRate=1.5	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Shot
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=2500.000000,Max=2500.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.5
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=7
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=1536.000000
		Chaos=0.300000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Slug
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams_Slug
		TraceRange=(Min=2500.000000,Max=2500.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.5
		TraceCount=1
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=60
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=1024.000000
		Chaos=0.300000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.leMat.LM-SecFireSlug',Volume=1.500000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Slug
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams_Slug'
	End Object
	
	//Decoy
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams_Decoy
		TraceRange=(Min=3150.000000,Max=3150.000000)
        DecayRange=(Min=1050,Max=3150) // 20-60m
		RangeAtten=0.5
		TraceCount=1
		TracerClass=None //
		ImpactManager=Class'BallisticProV55.IM_Decoy' //
		Damage=35
        HeadMult=3.25
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTleMatShotgun'
		DamageTypeHead=Class'BallisticProV55.DTleMatShotgunHead'
		DamageTypeArm=Class'BallisticProV55.DTleMatShotgun'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=2.000000
		Recoil=256.000000
		Chaos=0.300000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=0.700000,Radius=48.000000,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Decoy
		FireInterval=None
		FireAnim="Fire2"
		FireEndAnim=	
		FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams_Decoy'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.6
		XCurve=(Points=((InVal=0.0,OutVal=0.0),(InVal=0.2,OutVal=0.03),(InVal=0.36,OutVal=0.07),(InVal=0.62,OutVal=0.09),(InVal=0.6,OutVal=0.11),(InVal=1,OutVal=0.15)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		ClimbTime=0.08
		DeclineTime=0.5
		DeclineDelay=0.25
		CrouchMultiplier=1
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		LayoutName="20ga Shot"
		Weight=30
		
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
        DisplaceDurationMult=0.5
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams';
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Slug
		LayoutName="20ga Slug"
		LayoutTags="slug"
		Weight=10
		
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
        DisplaceDurationMult=0.5
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Slug';
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Decoy
		LayoutName="Noisemaker"
		LayoutTags="decoy"
		Weight=5
		
        CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		SightOffset=(X=-18,Y=-1.5,Z=15.30000)
		SightPivot=(Pitch=512,Roll=-50)
		bAdjustHands=true
		RootAdjust=(Yaw=-350,Pitch=2500)
		WristAdjust=(Yaw=-3000,Pitch=-0000)
        DisplaceDurationMult=0.5
        SightingTime=0.200000
		SightMoveSpeedFactor=0.9
        MagAmmo=9
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
        FireParams(0)=FireParams'ArenaPrimaryFireParams'
        AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Decoy';
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Slug'
    Layouts(2)=WeaponParams'ArenaParams_Decoy'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=LeMat_Engraved
		Index=0
		CamoName="Engraved"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Rusted
		Index=1
		CamoName="Rusted"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMattBR-Main1-Shine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMattBR-Main2-Shine",Index=2,PIndex=1,AIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Black
		Index=2
		CamoName="Blued"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainBlue",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Chrome
		Index=3
		CamoName="Chrome"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainChromeShine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=LeMat_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LeMattCamos.LeMat-MainGoldShine",Index=1,PIndex=0,AIndex=0)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=2,PIndex=1,AIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'LeMat_Engraved'
	Camos(1)=WeaponCamo'LeMat_Rusted'
	Camos(2)=WeaponCamo'LeMat_Black'
	Camos(3)=WeaponCamo'LeMat_Chrome'
	Camos(4)=WeaponCamo'LeMat_Gold'
}
class AK490WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Carbine
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=1536,Max=4000)
		PenetrationEnergy=48
		RangeAtten=0.75
		Damage=35
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'AK490FlashEmitter'
		FlashScaleFactor=1.1
		Recoil=250.000000
		Chaos=0.04000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.11000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Heavy Barrel
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_HB
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=1536,Max=4000)
		PenetrationEnergy=48
		RangeAtten=0.7
		Damage=35
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter' //
		FlashScaleFactor=0.800000 //
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK490-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False) //
		Recoil=230.000000 //
		Chaos=0.06000 //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_HB
		AimedFireAnim="Fire"
		FireInterval=0.12000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_HB'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_S
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=1536,Max=4000)
		PenetrationEnergy=48
		RangeAtten=0.7 //
		Damage=35
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.800000 //
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK490-SilFire',Volume=1.500000,Radius=768.000000,bAtten=True) //
		Recoil=210.000000 //
		Chaos=0.08000 //
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_S
		AimedFireAnim="Fire"
		FireInterval=0.12000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_S'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK490Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=90
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=0.5,Radius=16,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
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
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.35000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		ClimbTime=0.04
		DeclineDelay=0.15
		DeclineTime=1.25
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
        ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams //Standard
		//Layout core
		Weight=30
		LayoutName="Carbine"
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1.000000
		InventorySize=6
		SightOffset=(X=-6.500000,Y=0.02,Z=2.55)
		SightPivot=(Pitch=64)
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressed"
		LayoutTags="no_knife"
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.AKM490_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Holo',BoneName="Muzzle",Scale=0.05,AugmentOffset=(x=-26,y=-3.6,z=-0.2),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorAK',BoneName="Muzzle",AugmentOffset=(x=0,y=-0.5,z=0),Scale=0.075,AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		SightOffset=(X=0.000000,Y=-0.250000,Z=6.505000)
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1.000000
		InventorySize=6
		SightPivot=(Pitch=64)
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_S'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Scope
		//Layout core
		Weight=10
		LayoutName="3X Scope"
		LayoutTags="no_knife"
		//Visual
		LayoutMesh=SkeletalMesh'BWBP_SKC_Anim.AKM490_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_4XScope',BoneName="Muzzle",Scale=0.07,AugmentOffset=(x=-26,y=-3.6,z=-0.1),AugmentRot=(Pitch=32768,Roll=-16384,Yaw=0))
		SightOffset=(X=3.000000,Y=-0.100000,Z=5.000000)
		ZoomType=ZT_Fixed
		ScopeViewTex=Texture'BWBP_SKC_Tex.VSK.VSKScopeView'
		MaxZoom=3
		//Function
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1.000000
		InventorySize=6
		SightPivot=(Pitch=64)
		SightMoveSpeedFactor=0.8
		SightingTime=0.400000
		DisplaceDurationMult=1
		MagAmmo=25
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_HB'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Supp'
    Layouts(2)=WeaponParams'ArenaParams_Scope'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=AK_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-C-CamoDesert",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Flecktarn
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoGerman",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blood
		Index=3
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoBlood",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blue
		Index=4
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoBlue",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Red
		Index=5
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoRed",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_AU
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.GoldAK-Shine",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_Tex.AK490.AK490-Misc',Index=-1,AIndex=0,PIndex=-1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AK_Black' //Black
	Camos(1)=WeaponCamo'AK_Desert'
	Camos(2)=WeaponCamo'AK_Flecktarn'
	Camos(3)=WeaponCamo'AK_Blood'
	Camos(4)=WeaponCamo'AK_Blue'
	Camos(5)=WeaponCamo'AK_Red'
	Camos(6)=WeaponCamo'AK_AU'
}
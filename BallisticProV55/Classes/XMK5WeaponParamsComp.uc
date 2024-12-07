class XMK5WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=16
		RangeAtten=0.5
		Damage=23
        HeadMult=2.00f
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
		PenetrateForce=175
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=190.000000
		Chaos=0.035000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Suppressed
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams_Supp
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=16
		RangeAtten=0.5
		Damage=23
        HeadMult=2.00f
        LimbMult=0.75
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
		PenetrateForce=175
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.800000
		Recoil=170.000000 //
		Chaos=0.035000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-SilenceFire',Volume=0.5,Pitch=0.8,Radius=128,bAtten=True) //
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Supp
		FireInterval=0.09000 //
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams_Supp'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.XMK5Dart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		Damage=35
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim=
		FireAnim="Fire2"	
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
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.12,OutVal=0.00),(InVal=0.33,OutVal=0.04),(InVal=0.45,OutVal=-0.06),(InVal=0.58,OutVal=0.00),(InVal=0.8,OutVal=-0.04),(InVal=1.0,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.250000),(InVal=0.30000,OutVal=0.350000),(InVal=0.450000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.13
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.350000
		AimSpread=(Min=64,Max=378)
        ADSMultiplier=0.4
		AimDamageThreshold=190.000000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Dart + RDS"
		//Visual
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Darter",Slot=19,Scale=1f)
		SightOffset=(X=1.000000,Y=0.01,Z=1.80000)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.75
		SightMoveSpeedFactor=0.9
		MagAmmo=32
		SightingTime=0.250000
        InventorySize=4
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Supp
		//Layout core
		Weight=15
		LayoutName="Suppressed"
		//Visual
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Darter",Slot=19,Scale=0f)
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_SuppressorSOCOM',BoneName="Muzzle",Scale=0.05,AugmentOffset=(x=-50,y=0,z=-0),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_ReflexCircle',BoneName="Muzzle",Scale=0.025,AugmentOffset=(x=-60,y=-0.3,z=7),AugmentRot=(Pitch=0,Roll=0,Yaw=-32768))
		SightOffset=(X=1.0,Y=0.01,Z=-0.6)
		//Stats
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		DisplaceDurationMult=0.75
		SightMoveSpeedFactor=0.9
		MagAmmo=32
		SightingTime=0.250000
        InventorySize=4
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Scope'
		bNoaltfire=True	
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Supp'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XMK5_Tan
		Index=0
		CamoName="Brown"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainDesert",Index=1,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainJungle",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-ShieldDark",Index=2,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Red
		Index=3
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGMain",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGShield",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGClip",Index=3,AIndex=2,PIndex=2)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Blast
		Index=4
		CamoName="Blast"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainOrk",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGShield",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGClip",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-DarterOrk",Index=4,AIndex=3,PIndex=3) //aka dOrk
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainGold",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-ShieldDark",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MagDark",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-DarterDark",Index=4,AIndex=3,PIndex=3)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XMK5_Tan'
	Camos(1)=WeaponCamo'XMK5_Desert'
	Camos(2)=WeaponCamo'XMK5_Jungle'
	Camos(3)=WeaponCamo'XMK5_Red'
	Camos(4)=WeaponCamo'XMK5_Blast'
	Camos(5)=WeaponCamo'XMK5_Gold'
}
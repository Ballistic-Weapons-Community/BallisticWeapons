class XMK5WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=900.000000,Max=4500.000000) //10mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.100000
		Damage=37.0
		HeadMult=2.216216
		LimbMult=0.594594
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
		PenetrationEnergy=9.000000
		PenetrateForce=35
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=10,Y=10)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.090000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.XMK5Dart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		Damage=10.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireAnim="Fire2"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.550000,OutVal=0.30000),(InVal=0.800000,OutVal=-0.100000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.200000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=3072.000000
		DeclineTime=0.550000
		DeclineDelay=0.160000
		ViewBindFactor=0.150000
		ADSViewBindFactor=0.150000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1200)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.0500000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3536,Yaw=-2048)
		JumpChaos=0.750000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=575.000000
		ChaosTurnThreshold=185000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=35
		bMagPlusOne=True
		//ViewOffset=(X=2.000000,Y=8.000000,Z=-10.000000)
		//SightOffset=(X=1.000000,Z=17.750000)
		SightPivot=(Pitch=200)
		//ReloadAnimRate=1.200000
		//CockAnimRate=1.200000
		WeaponName="XMk5 10mm Urban Submachinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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
	Camos(1)=WeaponCamo'XMK5_Jungle'
	Camos(2)=WeaponCamo'XMK5_Desert'
	Camos(3)=WeaponCamo'XMK5_Red'
	Camos(4)=WeaponCamo'XMK5_Blast'
	Camos(5)=WeaponCamo'XMK5_Gold'
}
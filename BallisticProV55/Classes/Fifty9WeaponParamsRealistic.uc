class Fifty9WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTFifty9SMG'
		DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
		PenetrationEnergy=7.000000
		PenetrateForce=20
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-Fire',Pitch=1.000000,Volume=0.950000)
		Recoil=600.000000
		Chaos=-1.0
		Inaccuracy=(X=24,Y=24)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
        AimedFireAnim="SightFire"
		FireInterval=0.080000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Burst
        AimedFireAnim="SightFire"
		FireInterval=0.050000
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Supp
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams_Supp
		TraceRange=(Min=4000.000000,Max=4000.000000)
		WaterTraceRange=800.0
		DecayRange=(Min=800.0,Max=4000.0)
		Damage=33.0
		HeadMult=2.2
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTFifty9SMG'
		DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
		PenetrationEnergy=7.000000
		PenetrateForce=20
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2SilencedFlash' //
		FlashScaleFactor=0.600000 //
		FireSound=(Sound=Sound'BW_Core_WeaponSound.UZI.UZI-FireSil',Volume=0.800000,Radius=48.000000,bAtten=True) //
		Recoil=550.000000 //
		Chaos=-1.0
		Inaccuracy=(X=24,Y=24)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Supp
        AimedFireAnim="SightFire"
		FireInterval=0.082500
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams_Supp'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=80.000000,Max=80.000000)
		WaterTraceRange=5000.0
		Damage=57.0
		HeadMult=2.192982
		LimbMult=0.456140
		DamageType=Class'BallisticProV55.DTFifty9Blade'
		DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
		DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.UZI.Melee',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.750000
		WarnTargetPct=0.100000
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.600000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Melee1"
	FireEffectParams(0)=MeleeEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Scope
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams_Scope
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Scope
		TargetState="Scope"
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams_Scope'
	End Object	
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.300000,OutVal=-0.100000),(InVal=0.700000,OutVal=0.200000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.350000,OutVal=0.225000),(InVal=0.600000,OutVal=0.300000),(InVal=1.000000,OutVal=0.500000)))
		YawFactor=0.200000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2560.000000
		DeclineTime=0.600000
		DeclineDelay=0.125000
		ClimbTime=0.03
		ViewBindFactor=0.100000
		ADSViewBindFactor=0.100000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-1024)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.900000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Bladed"
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.165
		SightPivot=(Pitch=128)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=4
		MagAmmo=36
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
        WeaponName="Fifty-9 9mm SMG"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Burst
		//Layout core
		Weight=10
		LayoutName="Burst"
		LayoutTags="laser,lock,open"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.Fifty9Tac_FPm'
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_Laser',BoneName="tip",Scale=0.08,AugmentOffset=(x=-40,y=0,z=-10.0),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_RMR',BoneName="tip",Scale=0.085,AugmentOffset=(x=-85,y=0,z=7.0),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
        WeaponBoneScales(0)=(BoneName="Suppressor",Slot=0,Scale=0f)
		WeaponBoneScales(1)=(BoneName="Irons",Slot=1,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.165
		SightPivot=(Pitch=128)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=4
		MagAmmo=36
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto",bUnavailable=true)
		InitialWeaponMode=1
        WeaponName="Fifty-9 9mm SMG"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Burst'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Supp
		//Layout core
		Weight=10
		LayoutName="Suppressed"
		LayoutTags="lock"
		//Attachments
		LayoutMesh=SkeletalMesh'BW_Core_WeaponAnim.Fifty9Tac_FPm'
        WeaponBoneScales(0)=(BoneName="StockWire",Slot=2,Scale=0f)
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.17 //
		SightPivot=(Pitch=128)
		//Stats
		PlayerSpeedFactor=1.100000
		InventorySize=4
		MagAmmo=36
		bDualBlocked=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst",ModeID="WM_BigBurst",Value=3.000000)
		WeaponModes(2)=(ModeName="Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
        WeaponName="Fifty-9 9mm SMG"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Supp'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_Burst'
	Layouts(2)=WeaponParams'RealisticParams_Supp'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Fifty_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Fifty_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.Fifty7Skin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Fifty_Orange
		Index=2
		CamoName="Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.Fifty9Camos.TigerUziSkin",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'Fifty_Blue'
	Camos(1)=WeaponCamo'Fifty_Red'
	Camos(2)=WeaponCamo'Fifty_Orange'
}
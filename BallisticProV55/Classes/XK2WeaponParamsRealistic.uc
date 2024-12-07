class XK2WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //9mm
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.10000
		Damage=30.0
		HeadMult=2.6
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTXK2SMG'
		DamageTypeHead=Class'BallisticProV55.DTXK2SMGHead'
		DamageTypeArm=Class'BallisticProV55.DTXK2SMG'
		PenetrationEnergy=11.000000
		PenetrateForce=15
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Fire',Pitch=1.250000,Volume=1.100000)
		Recoil=520.000000
		Chaos=0.000000
		Inaccuracy=(X=10,Y=10)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.067
		AimedFireAnim="SightFire"	
		BurstFireRateFactor=1.00	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object

	//Ice
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryIceEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
		RangeAtten=0.2
		Damage=14
		HeadMult=1.4f
		LimbMult=0.6f
		DamageType=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeHead=Class'BallisticProV55.DTXK2Freeze'
		DamageTypeArm=Class'BallisticProV55.DTXK2Freeze'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.250000
		Recoil=98.000000
		Chaos=0.050000
		Inaccuracy=(X=96,Y=96)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryIceFireParams
		FireInterval=0.09000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryIceEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
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
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.550000,OutVal=0.20000),(InVal=0.800000,OutVal=-0.100000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.300000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=2560.000000
		DeclineTime=0.550000
		DeclineDelay=0.150000
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
		AimSpread=(Min=576,Max=1280)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.0500000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3536,Yaw=-2048)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.650000
		ChaosSpeedThreshold=600.000000
		ChaosTurnThreshold=140000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Suppressed"
		//ADS
		SightMoveSpeedFactor=0.500000
		SightingTime=0.18
		SightOffset=(X=6.00,Y=0.02,Z=3.75)
		SightPivot=(Pitch=40)
		//Stats
		bDualBlocked=True
		PlayerSpeedFactor=1.050000
		InventorySize=5
		MagAmmo=40
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Burst",ModeID="WM_BigBurst",Value=4.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=3
		WeaponName="XK2-SD 9mm Submachinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		FireParams(3)=FireParams'RealisticPrimaryFireParams'
		FireParams(4)=FireParams'RealisticPrimaryIceFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_RDS
		//Layout core
		LayoutName="RDS"
		LayoutTags="no_muzzle"
		Weight=5
		//Attachments
		GunAugments(0)=(GunAugmentClass=class'BallisticProV55.Augment_PistolRail',BoneName="Muzzle",Scale=0.15,AugmentOffset=(x=-180,y=0,z=-12),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		GunAugments(1)=(GunAugmentClass=class'BallisticProV55.Augment_Reflex',BoneName="Muzzle",Scale=0.09,AugmentOffset=(x=-210,y=0,z=26),AugmentRot=(Pitch=0,Roll=0,Yaw=32768))
		//ADS
		SightOffset=(X=0.000000,Y=0.080000,Z=10.2000)
		SightPivot=(Pitch=0,Roll=0,Yaw=1)
		SightMoveSpeedFactor=0.500000
		SightingTime=0.18
		//Function
		bDualBlocked=True
		PlayerSpeedFactor=1.050000
		InventorySize=5
		MagAmmo=40
		bMagPlusOne=True
		WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Burst",ModeID="WM_BigBurst",Value=4.000000)
		WeaponModes(3)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		WeaponModes(4)=(ModeName="Amp: Ice Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=3
		WeaponName="XK2 9mm Submachinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		FireParams(2)=FireParams'RealisticPrimaryFireParams'
		FireParams(3)=FireParams'RealisticPrimaryFireParams'
		FireParams(4)=FireParams'RealisticPrimaryIceFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Scope'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_RDS'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XK2_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Jungle
		Index=1
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainJungle",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainDesert",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Winter
		Index=3
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainWinter",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Silver
		Index=4
		CamoName="Silver"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK3-NickelShine",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Pink
		Index=5
		CamoName="Fabulous"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-MainPink",Index=1,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XK2_Gold //reduce shine
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XK2Camos.XK2-GoldShine",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XK2_Black'
	Camos(1)=WeaponCamo'XK2_Jungle'
	Camos(2)=WeaponCamo'XK2_Desert'
	Camos(3)=WeaponCamo'XK2_Winter'
	Camos(4)=WeaponCamo'XK2_Silver'
	Camos(5)=WeaponCamo'XK2_Pink'
	Camos(6)=WeaponCamo'XK2_Gold'
}
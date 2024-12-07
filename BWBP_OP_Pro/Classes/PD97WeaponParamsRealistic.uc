class PD97WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=5000.000000,Max=5000.000000)
		RangeAtten=0.750000
		TraceCount=6
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DTPD97Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DTPD97ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTPD97Shotgun'
		PenetrationEnergy=4.000000
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		Recoil=768.000000
		Chaos=0.500000
		Inaccuracy=(X=400,Y=400)
		BotRefireRate=0.700000
		WarnTargetPct=0.500000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Fire',Volume=1.100000,Radius=256.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.200000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ShotgunEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Dart
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Dart
		ProjectileClass=Class'BWBP_OP_Pro.PD97Dart'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		Speed=15000.000000
		Damage=30
		Recoil=128.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=0.5,Radius=24)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Dart
        TargetState="Projectile"
		FireInterval=0.400000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Dart'
	End Object
	
	//Rocket
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Rocket
		ProjectileClass=Class'BWBP_OP_Pro.PD97Rocket'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		AccelSpeed=2000.000000
		Speed=4500.000000
		MaxSpeed=10000.000000
		Damage=80.000000
		DamageRadius=192.000000
		Recoil=256.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.PD97.PD97-RocketFire',Volume=1.0)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Rocket
        TargetState="Projectile"
		FireInterval=0.200000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Rocket'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Tazer
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		AccelSpeed=8000.000000
		Speed=2240.000000
		MaxSpeed=10000.000000
		Damage=80
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Tracker
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Tracker
		ProjectileClass=Class'BWBP_OP_Pro.PD97TrackerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		AccelSpeed=8000.000000
		Speed=8000.000000
		MaxSpeed=10000.000000
		Damage=25
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Tracker
		TargetState="Tracker"
		FireInterval=0.100000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Tracker'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.40000),(InVal=7.00000,OutVal=0.50000),(InVal=1.00000,OutVal=0.40000)))
		PitchFactor=0.500000
		YawFactor=0.200000
		XRandFactor=0.50000
		YRandFactor=0.50000
		MaxRecoil=3000.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
		ViewBindFactor=0.400000
		ADSViewBindFactor=0.400000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=576,Max=1152)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=650.000000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosTurnThreshold=196608.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Shotgun"
		LayoutTags="shotgun"
		Weight=30
		//Visual
		WeaponName="PD97 .410 Shotgun Revolver"
		//Stats
		//SightOffset=(X=-10.000000,Y=-4.400000,Z=12.130000)
		//ViewOffset=(X=5.000000,Y=8.000000,Z=-10.000000)
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=4
		WeaponPrice=600
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=5
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=RealisticParams_Rocket
		//Layout core
		LayoutName="Missile"
		Weight=15
		//Visual
		WeaponName="PD97 Missile Revolver"
		//Stats
		//SightOffset=(X=-10.000000,Y=-4.400000,Z=12.130000)
		//ViewOffset=(X=5.000000,Y=8.000000,Z=-10.000000)
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=4
		WeaponPrice=600
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=2
		MagAmmo=5
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Rocket'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Tracker'
    End Object 

	Begin Object Class=WeaponParams Name=RealisticParams_Dart
		//Layout core
		LayoutName="Plague Dart"
		Weight=10
		//Visual
		WeaponName="PD97 Dart Revolver"
		//Stats
		//SightOffset=(X=-10.000000,Y=-4.400000,Z=12.130000)
		//ViewOffset=(X=5.000000,Y=8.000000,Z=-10.000000)
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=4
		WeaponPrice=600
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=5
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Dart'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'RealisticParams'
    Layouts(1)=WeaponParams'RealisticParams_Rocket'
    Layouts(2)=WeaponParams'RealisticParams_Dart'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=PUG_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=PUG_Red
		Index=1
		CamoName="Military Red"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MainRed",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MagDark",Index=2,AIndex=1,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=PUG_Blue
		Index=2
		CamoName="Police Blue"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MainBlue",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MagDark",Index=2,AIndex=1,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=PUG_Black
		Index=3
		CamoName="Riot Police"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MainBlack",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MagDark",Index=2,AIndex=1,PIndex=2)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=PUG_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MainGold",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.PD97Camos.PD97-MagDark",Index=2,AIndex=1,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'PUG_Gray'
	Camos(1)=WeaponCamo'PUG_Red'
	Camos(2)=WeaponCamo'PUG_Blue'
	Camos(3)=WeaponCamo'PUG_Black'
	Camos(4)=WeaponCamo'PUG_Gold'
}
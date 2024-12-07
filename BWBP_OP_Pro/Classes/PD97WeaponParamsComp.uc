class PD97WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Dart
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Dart
		ProjectileClass=Class'BWBP_OP_Pro.PD97Dart'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		Speed=15000.000000
		Damage=20
		Recoil=128.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=0.5,Radius=24)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Dart
        TargetState="Projectile"
		FireInterval=0.400000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Dart'
	End Object
	
	//Rocket
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Rocket
		ProjectileClass=Class'BWBP_OP_Pro.PD97Rocket'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		AccelSpeed=2000.000000
		Speed=4500.000000
		MaxSpeed=10000.000000
		Damage=40.000000
		DamageRadius=192.000000
		Recoil=256.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.PD97.PD97-RocketFire',Volume=1.0)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Rocket
        TargetState="Projectile"
		FireInterval=0.200000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Rocket'
	End Object
	
	//Shotgun
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.200000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	//Tazer
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=8
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Tracker
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Tracker
		ProjectileClass=Class'BWBP_OP_Pro.PD97TrackerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=8
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Tracker
		TargetState="Tracker"
		FireInterval=0.100000
		AmmoPerFire=1
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Tracker'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.5
		DeclineTime=1.500000
		CrouchMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.150000
		JumpChaos=0.200000
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Shotgun"
		LayoutTags="shotgun"
		Weight=30
		//Visual
		WeaponName="PD97 Shotgun Revolver"
		//Stats
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		//SightOffset=(X=0.000000,Y=-4.400000,Z=12.130000)		
		PlayerJumpFactor=1.05
		InventorySize=2
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Rocket
		//Layout core
		LayoutName="Missile"
		Weight=15
		//Visual
		WeaponName="PD97 Missile Revolver"
		//Stats
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		//SightOffset=(X=0.000000,Y=-4.400000,Z=12.130000)		
		PlayerJumpFactor=1.05
		InventorySize=2
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=5
		InitialWeaponMode=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Rocket'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Tracker'
    End Object 

	Begin Object Class=WeaponParams Name=ArenaParams_Dart
		//Layout core
		LayoutName="Plague Dart"
		Weight=10
		//Visual
		WeaponName="PD97 Dart Revolver"
		//Stats
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		//SightOffset=(X=0.000000,Y=-4.400000,Z=12.130000)		
		PlayerJumpFactor=1.05
		InventorySize=2
		SightMoveSpeedFactor=0.9
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		MagAmmo=5
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Dart'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Rocket'
    Layouts(2)=WeaponParams'ArenaParams_Dart'
	
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
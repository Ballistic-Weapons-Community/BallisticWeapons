class AkeronWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=15000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=200
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=386.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.70000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Barrage Rocket
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=800.000000
		MaxSpeed=4000.000000
		AccelSpeed=8000.000000
		Damage=200
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		Inaccuracy=(X=100,Y=100)
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb')
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBarrageFireParams
		FireInterval=0.10000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryBarrageEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=105
		DamageRadius=300.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')	
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		AmmoPerFire=1
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.75
		DeclineTime=1.000000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.650000
		AimAdjustTime=1.000000
		SprintChaos=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		FallingChaos=0.500000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=440.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=RealisticParams
		//SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)
		//ViewOffset=(X=20.000000,Y=15.000000,Z=-11.000000)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
        DisplaceDurationMult=1.25
		InventorySize=8
		SightMoveSpeedFactor=0.8
		SightingTime=0.500000
		WeaponModes(0)=(ModeName="Mode: Barrage",ModeID="WM_BigBurst",Value=3)
		WeaponModes(1)=(ModeName="Mode: High Velocity",ModeID="WM_SemiAuto",Value=1)
		WeaponModes(2)=(ModeName="Mode: Barrage",ModeID="WM_BigBurst",Value=3,bUnavailable=True)
		InitialWeaponMode=0
		MagAmmo=3
        ZoomType=ZT_Logarithmic
		WeaponName="AN-56 Akeron 60mm Guided Missile Launcher"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryBarrageFireParams'
		FireParams(1)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=AN56_Brown
		Index=0
		CamoName="Brown"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Blue
		Index=1
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontBlue",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackBlue",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Red
		Index=2
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackRed",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_White
		Index=3
		CamoName="White"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontWhite",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackWhite",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Stripes
		Index=4
		CamoName="MLN Labs"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontStripes",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackStripes",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=7
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Meat
		Index=5
		CamoName="MEAT"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontMeat",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackMeat",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackGold",Index=2,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=2)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AN56_Brown'
	Camos(1)=WeaponCamo'AN56_Blue'
	Camos(2)=WeaponCamo'AN56_Red'
	Camos(3)=WeaponCamo'AN56_White'
	Camos(4)=WeaponCamo'AN56_Stripes'
	Camos(5)=WeaponCamo'AN56_Meat'
	Camos(6)=WeaponCamo'AN56_Gold'
}
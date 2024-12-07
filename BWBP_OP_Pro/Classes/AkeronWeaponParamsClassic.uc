class AkeronWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//High-Speed Rocket
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=800.000000
		MaxSpeed=8500.000000
		AccelSpeed=6000.000000
		Damage=150
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=256.000000
		Chaos=0.500000
		Inaccuracy=(X=25,Y=25)
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb2')
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.50000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//Barrage Rocket
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=450.000000
		MaxSpeed=1500.000000
		AccelSpeed=6000.000000
		Damage=150
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

	Begin Object Class=FireParams Name=ClassicPrimaryBarrageFireParams
		FireInterval=0.20000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryBarrageEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=155
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumbTriple')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryBarrageFireParams
		AmmoPerFire=3
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryBarrageEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocketHE'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=155
		DamageRadius=150.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		AmmoPerFire=1
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.75
		DeclineTime=1.000000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.650000
		SprintChaos=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		FallingChaos=0.500000
		AimDamageThreshold=300.000000
		AimAdjustTime=1.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=340.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		//SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)
		//ViewOffset=(X=30.000000,Y=20.000000,Z=-18.000000)
		//ViewOffset=(X=25.000000,Y=15.000000,Z=-15.000000)
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
        DisplaceDurationMult=1.25
		InventorySize=12
		SightMoveSpeedFactor=0.8
		SightingTime=0.500000
		WeaponModes(0)=(ModeName="Mode: Barrage",ModeID="WM_FullAuto",bUnavailable=True)
		WeaponModes(1)=(ModeName="Mode: High Velocity",ModeID="WM_SemiAuto",Value=1)
		WeaponModes(2)=(ModeName="Mode: Barrage",ModeID="WM_BigBurst",Value=3)
		InitialWeaponMode=2
		MagAmmo=3
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryBarrageFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireParams'
		FireParams(2)=FireParams'ClassicPrimaryBarrageFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryBarrageFireParams'
		AltFireParams(1)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(2)=FireParams'ClassicSecondaryBarrageFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
	
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
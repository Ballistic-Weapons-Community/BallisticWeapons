class AkeronWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=90
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=128.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.70000
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryBarrageEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=3000.000000
		MaxSpeed=20000.000000
		AccelSpeed=100000.000000
		Damage=90
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=256.000000
		Chaos=0.800000
		BotRefireRate=0.5
		WarnTargetPct=0.25	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.M202-FireDumb')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryBarrageFireParams
		FireInterval=0.250000
		BurstFireRateFactor=0.3
		FireEndAnim=
		FireAnimRate=1.1	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryBarrageEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.AkeronRocket'
		SpawnOffset=(X=50.000000,Y=10.000000,Z=-3.000000)
		Speed=4000.000000
		MaxSpeed=35000.000000
		AccelSpeed=100000.000000
		Damage=90
		DamageRadius=400.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.500000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Akeron.Akeron-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		AmmoPerFire=1
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.75
		ClimbTime=0.04
		DeclineTime=1.000000
		CrouchMultiplier=0.85
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
		ADSMultiplier=0.50000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//SightOffset=(X=-30.000000,Y=-17.000000,Z=15.000000)
		//ViewOffset=(X=15.000000,Y=13.000000,Z=-16.000000)
		WeaponModes(0)=(ModeName="Barrage",ModeID="WM_BigBurst",Value=3)
		WeaponModes(1)=(ModeName="High Velocity",ModeID="WM_FullAuto",Value=1)
		WeaponModes(2)=(ModeName="N/A",ModeID="WM_BigBurst",Value=3,bUnavailable=True)
		InitialWeaponMode=1
		PlayerSpeedFactor=0.95
        DisplaceDurationMult=1.25
		InventorySize=5
		SightMoveSpeedFactor=0.6
		ScopeScale=0.7
		SightingTime=0.450000
		MagAmmo=9
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryBarrageFireParams'
		FireParams(1)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackBlue",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Red
		Index=2
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontRed",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackRed",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_White
		Index=3
		CamoName="White"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontWhite",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackWhite",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Stripes
		Index=4
		CamoName="Limited"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontStripes",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackStripes",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
		Weight=7
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Meat
		Index=5
		CamoName="MEAT"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontMeat",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackMeat",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AN56_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-FrontGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-BackGold",Index=2,AIndex=1,PIndex=-1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.AkeronCamos.Akeron-GripBlack",Index=3,AIndex=2,PIndex=-2)
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
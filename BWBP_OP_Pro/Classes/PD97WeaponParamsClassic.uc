class PD97WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97Rocket'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-10.000000)
		AccelSpeed=2000.000000
		Speed=4500.000000
		MaxSpeed=10000.000000
		Damage=40.000000
		DamageRadius=192.000000
		MomentumTransfer=20000.000000
		Recoil=256.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=SoundGroup'BWBP_OP_Sounds.PD97.PD97-RocketFire',Volume=1.0)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.200000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TrackerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		AccelSpeed=8000.000000
		Speed=2240.000000
		MaxSpeed=10000.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.45
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		ADSMultiplier=0.150000
		AimAdjustTime=0.450000
		ChaosDeclineTime=0.450000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosSpeedThreshold=1400.000000
		ChaosTurnThreshold=196608.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=1.05
		PlayerJumpFactor=1.05
		InventorySize=3
		SightMoveSpeedFactor=1
		SightingTime=0.20000
		DisplaceDurationMult=0.5
		WeaponModes(0)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
		WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_BigBurst",Value=3.000000,bUnavailable=True)
		WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto")
		InitialWeaponMode=2
		bNeedCock=True
		MagAmmo=5
		ViewOffset=(X=1.000000,Y=7.000000,Z=-1.800000)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
	
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
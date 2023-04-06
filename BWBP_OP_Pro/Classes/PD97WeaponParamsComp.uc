class PD97WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97Dart'
		SpawnOffset=(X=15.000000,Y=15.000000,Z=-20.000000)
		Speed=15000.000000
		Damage=20
		Recoil=256.000000
		Chaos=0.150000
		BotRefireRate=0.700000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Radius=128,Volume=0.5)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.400000
		PreFireAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.100000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.PD97TazerProj'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10240.000000
		Damage=5
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Tazer.BloodhoundTazerFire',Volume=2.250000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.900000
		AmmoPerFire=0
		PreFireAnim=
		FireAnim="TazerFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.45
		XRandFactor=0.10000
		YRandFactor=0.10000
		MaxRecoil=8192.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
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
		CockAnimRate=1.250000
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
    Layouts(0)=WeaponParams'ArenaParams'
	
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
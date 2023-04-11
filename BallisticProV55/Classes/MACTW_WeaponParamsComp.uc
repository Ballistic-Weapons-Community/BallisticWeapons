class MACTW_WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MACShell'
		SpawnOffset=(X=18.000000,Y=4.000000)
		Speed=9000.000000
		MaxSpeed=9000.000000
		Damage=160
		DamageRadius=192.000000
		MomentumTransfer=70000.000000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.500000
		Recoil=2048.000000
		Chaos=0.550000
		BotRefireRate=0.7
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire',Radius=768.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Deploy weapon"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.000000
		PitchFactor=0.100000
		YawFactor=0.500000
		XRandFactor=0.300000
		YRandFactor=0.200000
		DeclineTime=0.75
		MinRandFactor=0.350000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ViewBindFactor=1
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=8,Max=32)
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=300
		AimDamageThreshold=2000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.6
		SightingTime=0.10000
		MagAmmo=5
        InventorySize=8
		ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=MAC_Desert
		Index=0
		CamoName="Desert"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MAC_Jungle
		Index=1
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MACCamos.Artillery-MainJungle",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MAC_Urban
		Index=2
		CamoName="Urban"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MACCamos.Artillery-MainUrban",Index=1,AIndex=0,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'MAC_Desert'
	Camos(1)=WeaponCamo'MAC_Jungle'
	Camos(2)=WeaponCamo'MAC_Urban'
}
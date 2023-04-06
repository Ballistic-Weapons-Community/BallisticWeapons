class MACWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MACShell'
		SpawnOffset=(X=18.000000,Y=4.000000)
		Speed=9000.000000
		MaxSpeed=9000.000000
		Damage=150
		DamageRadius=378.000000
		MomentumTransfer=70000.000000
		PushBackForce=1000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.500000
		Recoil=256.000000
		Chaos=0.550000
		BotRefireRate=0.7
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire',Radius=768.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.350000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="Deploy"
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XRandFactor=0.600000
		YRandFactor=0.900000
		MinRandFactor=0.350000
		ClimbTime=0.1
		CrouchMultiplier=1
		HipMultiplier=1 // always on shoulder
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffSet=(Pitch=-3072,Yaw=-1024)
		JumpOffSet=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=0.700000
		AimSpread=(Min=512,Max=2560)
		ChaosDeclineTime=1.200000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		SightPivot=(Pitch=450)
		SightOffset=(X=-5.000000,Y=-15.000000,Z=10.000000)
		ViewOffset=(X=3.000000,Y=12.000000,Z=-3.000000)
		DisplaceDurationMult=1.25
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.35
		SightingTime=0.8	
		ScopeScale=0.7
		MagAmmo=5
        InventorySize=8
		// acog-like
        ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=4
		ZoomStages=1
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
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
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MACCamos.Artillery-MainJungle",Index=1,AIndex=1,PIndex=0)
	End Object
	
	Begin Object Class=WeaponCamo Name=MAC_Urban
		Index=2
		CamoName="Urban"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MACCamos.Artillery-MainUrban",Index=1,AIndex=1,PIndex=0)
	End Object
	
	Camos(0)=WeaponCamo'MAC_Desert'
	Camos(1)=WeaponCamo'MAC_Jungle'
	Camos(2)=WeaponCamo'MAC_Urban'
}
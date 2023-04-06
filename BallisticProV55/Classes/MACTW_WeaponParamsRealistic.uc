class MACTW_WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.MACShell'
		SpawnOffset=(X=28.000000,Y=10.000000)
		Speed=15000.000000
		MaxSpeed=15000.000000
		Damage=350.000000
		DamageRadius=192.000000
		MomentumTransfer=80000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		FlashScaleFactor=2.500000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire')
		Recoil=8000.000000
		Chaos=0.800000
		PushbackForce=0.000000
		Inaccuracy=(X=4,Y=4)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=1.500000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		SpreadMode=FSM_Rectangle
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Deploy weapon"
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.100000
		YawFactor=0.000000
		XRandFactor=0.300000
		YRandFactor=0.200000
		MaxRecoil=1000.000000
		DeclineTime=1.500000
		ViewBindFactor=0.000000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=8,Max=2048)
		AimAdjustTime=1.000000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.000000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.000000
		MagAmmo=5
		ZoomType=ZT_Logarithmic
		WeaponName="J2329-HAMR Assault Cannon"
		//SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
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
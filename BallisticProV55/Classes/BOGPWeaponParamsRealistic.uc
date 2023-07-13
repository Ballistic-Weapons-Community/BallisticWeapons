class BOGPWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=RealisticGrenadeEffectParams
		ProjectileClass=class'BallisticProV55.BOGPGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2400.000000
		Damage=180.000000
		DamageRadius=400.000000
		MomentumTransfer=30000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.BOGP.BOGP_Fire',Volume=1.750000)
		Recoil=1280.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
		SplashDamage=True
		RecommendSplashDamage=True
		bLimitMomentumZ=False
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		bOverrideArming=true
		ArmingDelay=0.25
		UnarmedDetonateOn=DT_Disarm
		UnarmedPlayerImpactType=PIT_Bounce
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
	End Object

	Begin Object Class=FireParams Name=RealisticGrenadeFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		PreFireAnim=	
	FireEffectParams(0)=GrenadeEffectParams'RealisticGrenadeEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=RealisticFlareEffectParams
		ProjectileClass=Class'BallisticProV55.BOGPFlare'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=7500.000000
		AccelSpeed=100000.000000
		Damage=50.000000
		DamageRadius=64.000000
		MomentumTransfer=0.000000
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Chaos=0.700000
		Inaccuracy=(X=64,Y=64)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.BOGP.BOGP_FlareFire',Volume=2.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		WarnTargetPct=0.100000
		BotRefireRate=0.300000
	End Object

	Begin Object Class=FireParams Name=RealisticFlareFireParams
		PreFireAnim=
		FireEffectParams(0)=ProjectileEffectParams'RealisticFlareEffectParams'
		bCockAfterFire=True
	End Object 
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.300000
        EffectString="Switch grenade"
	End Object
		
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
	FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1280.000000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.900000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=600,Max=1024)
		CrouchMultiplier=0.900000
		ADSMultiplier=0.900000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		WeaponBoneScales(0)=(BoneName="Scope",Slot=5,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		ViewOffset=(X=3.000000,Y=5.000000,Z=-3.500000)
		//ViewOffset=(X=5.000000,Y=6.000000,Z=-7.000000)
		//SightOffset=(X=-10.000000,Y=-0.650000,Z=10.500000)
		//SightPivot=(Pitch=1024,Roll=-1024)
		SightPivot=(Pitch=300)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticGrenadeFireParams'
		FireParams(1)=FireParams'RealisticFlareFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=BORT_Red
		Index=0
		CamoName="Red"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=BORT_White
		Index=1
		CamoName="White"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BOGPCamos.whiteBOGP_Main",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=BORT_Flame
		Index=2
		CamoName="Radical"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BOGPCamos.FGP",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'BORT_Red'
	Camos(1)=WeaponCamo'BORT_White'
	Camos(2)=WeaponCamo'BORT_Flame'
}
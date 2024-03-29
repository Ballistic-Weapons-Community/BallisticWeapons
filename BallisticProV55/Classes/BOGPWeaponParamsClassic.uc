class BOGPWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=ClassicGrenadeEffectParams
		ProjectileClass=Class'BallisticProV55.BOGPGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=1750.000000
		Damage=120.000000
		DamageRadius=384.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.BOGP.BOGP_Fire',Volume=1.750000)
		Recoil=0.0
		Chaos=-1.0
		SplashDamage=True
		RecommendSplashDamage=True
		bLimitMomentumZ=False
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		bOverrideArming=true
		ArmingDelay=0.25
		UnarmedDetonateOn=DT_Impact
		UnarmedPlayerImpactType=PIT_Detonate
		ArmedDetonateOn=DT_Impact
		ArmedPlayerImpactType=PIT_Detonate
	End Object

	Begin Object Class=FireParams Name=ClassicGrenadeFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		PreFireAnim=	
	FireEffectParams(0)=GrenadeEffectParams'ClassicGrenadeEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicFlareEffectParams
		ProjectileClass=Class'BallisticProV55.BOGPFlare'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=5500.000000
		MaxSpeed=7500.000000
		AccelSpeed=100000.000000
		Damage=40.000000
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

	Begin Object Class=FireParams Name=ClassicFlareFireParams
		PreFireAnim=
		FireEffectParams(0)=ProjectileEffectParams'ClassicFlareEffectParams'
		bCockAfterFire=True
	End Object 
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=FireEffectParams Name=ClassicSecondaryEffectParams
			SpreadMode=FSM_Rectangle
			FireSound=(Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.0
			Chaos=-1.0
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=ClassicSecondaryFireParams
			FireInterval=0.200000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=FireEffectParams'ClassicSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=8192.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=48,Max=1024)
		AimAdjustTime=0.450000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=1400.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Red"
		Weight=30
		WeaponBoneScales(0)=(BoneName="Scope",Slot=5,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//SightOffset=(X=-8.000000,Y=-0.650000,Z=10.500000)
		//SightPivot=(Pitch=1024,Roll=-1024)
		SightPivot=(Pitch=300)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		ViewOffset=(X=3,Y=5.00,Z=-2.0)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGrenadeFireParams'
		FireParams(1)=FireParams'ClassicFlareFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	/*
	Begin Object Class=WeaponParams Name=ClassicParams-W
		LayoutName="White"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BOGPCamos.whiteBOGP_Main",Index=1)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=5,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//SightOffset=(X=-8.000000,Y=-0.650000,Z=10.500000)
		SightPivot=(Pitch=1024,Roll=-1024)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGrenadeFireParams'
		FireParams(1)=FireParams'ClassicFlareFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-F
		LayoutName="Radical"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BOGPCamos.FGP",Index=1)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=5,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//SightOffset=(X=-8.000000,Y=-0.650000,Z=10.500000)
		SightPivot=(Pitch=1024,Roll=-1024)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGrenadeFireParams'
		FireParams(1)=FireParams'ClassicFlareFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-M
		LayoutName="Medical"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BOGPCamos.MGP",Index=1)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=5,Scale=0f)
		PlayerSpeedFactor=1.100000
		InventorySize=3
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		//SightOffset=(X=-8.000000,Y=-0.650000,Z=10.500000)
		SightPivot=(Pitch=1024,Roll=-1024)
		//ReloadAnimRate=1.000000
		//CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicGrenadeFireParams'
		FireParams(1)=FireParams'ClassicFlareFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	*/
	Layouts(0)=WeaponParams'ClassicParams'
	
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
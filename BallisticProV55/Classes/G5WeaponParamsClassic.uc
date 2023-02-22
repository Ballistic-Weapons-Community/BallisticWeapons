class G5WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.G5Rocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=500.000000
		MaxSpeed=2500.000000
		AccelSpeed=1500.000000
		Damage=200.000000
		DamageRadius=448.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Fire1')
		Recoil=64.000000
		Chaos=-1.0
		Inaccuracy=(X=4,Y=4)
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.500000
		WarnTargetPct=0.300000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		bCockAfterFire=True
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
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
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=512.000000
		DeclineTime=1.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=20,Max=1600)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.450000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.450000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="UTC Issue"
		Weight=30
		
		PlayerSpeedFactor=0.850000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		MagAmmo=2
		ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Silver
		LayoutName="Pirated Gray"
		Weight=10
		
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_TexExp.SMAA.SMAA-Shine',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BWBP_SKC_TexExp.SMAA.SMAAScope',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_TexExp.SMAA.SMAARocket',Index=4)
		PlayerSpeedFactor=0.850000
		InventorySize=25
		SightMoveSpeedFactor=0.500000
		MagAmmo=2
		ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Silver'
}
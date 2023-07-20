class HVPCMk5WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Triple spread
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams_Triple
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileTriple'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=50.000000
		MaxSpeed=8000.000000
		AccelSpeed=90000.000000
		Damage=65
		DamageRadius=200.000000
		MomentumTransfer=65000.000000
		HeadMult=2.0
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=270.000000
		Chaos=0.150000
		Inaccuracy=(X=256,Y=256)
		WarnTargetPct=0.200000	
		Heat=4.5
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams_Triple
		TargetState="SpreadShot"
		FireInterval=0.720000
		AmmoPerFire=5
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams_Triple'
	End Object

	//Single power shot
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=50.000000
		MaxSpeed=8000.000000
		AccelSpeed=90000.000000
		Damage=75
		DamageRadius=265.000000
		MomentumTransfer=65000.000000
		HeadMult=2.0
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=270.000000
		Chaos=0.150000
		Inaccuracy=(X=256,Y=256)
		WarnTargetPct=0.200000	
		Heat=1.5
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParamsSingle
		TargetState="SingleShot"
		FireInterval=0.720000
		AmmoPerFire=5
		BurstFireRateFactor=1.00
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.0
		LimbMult=0.65
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams_Green
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66ProjectileSmall'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.0
		LimbMult=0.65
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=100.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Green
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams_Green'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.100000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=256.000000
		DeclineTime=0.750000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=150,Max=1900)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.250000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpChaos=0.400000
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=380.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams_Proto
		LayoutName="MK1 Unstable"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MainProto",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MiscProto",Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5)
		Weight=10
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.65000
		//SightOffset=(X=-12.000000,Y=-0.200000,Z=17.300000)
		SightPivot=(Pitch=1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Triple'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Green'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_DX
		LayoutName="MK3 Mainline"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-Main",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-Misc",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5)
		Weight=30
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.65000
		//SightOffset=(X=-12.000000,Y=-0.200000,Z=17.300000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams_Triple'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Green'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="MK5 Focused"
		Weight=10
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.65000
		//SightOffset=(X=-12.000000,Y=-0.200000,Z=17.300000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParamsSingle'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ClassicParams_Military
		LayoutName="E55 Plasma Cannon"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MainBlack",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MiscBlack",Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5)
		
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=11
		SightMoveSpeedFactor=0.500000
		SightingTime=0.65000
		//SightOffset=(X=-12.000000,Y=-0.200000,Z=17.300000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParamsSingle'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams_Proto' //Mk1 - Prototype, green spread shot
	Layouts(1)=WeaponParams'ClassicParams_DX' //Mk2 - Green spread shot
	Layouts(2)=WeaponParams'ClassicParams' //Mk5 - Red single shot
	Layouts(3)=WeaponParams'ClassicParams_Military' //Military - Black, clip, red single shot


}
class HVPCMk5WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Single
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		Damage=100
		HeadMult=1.75
		LimbMult=0.85
		DamageRadius=256.000000
		MomentumTransfer=65000.000000
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.400000
		WarnTargetPct=0.200000	
		Inaccuracy=(X=6,Y=6)
		Heat=1.5
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		TargetState="SingleShot"
		FireInterval=0.700000
		AmmoPerFire=5
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	//Triple
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams_Triple
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileTriple'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=3000.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		Damage=70
		HeadMult=1.75
		LimbMult=0.85
		DamageRadius=200.000000
		MomentumTransfer=65000.000000
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.400000
		WarnTargetPct=0.200000	
		Inaccuracy=(X=256,Y=256)
		Heat=3.0
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams_Triple
		TargetState="SpreadShot"
		FireInterval=0.700000
		AmmoPerFire=5
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams_Triple'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Red
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=6500.000000
		MaxSpeed=20000.000000
		AccelSpeed=150000.000000
		Damage=50
		HeadMult=3.25
		LimbMult=0.75
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		FlashScaleFactor=0.400000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.025000
		WarnTargetPct=0.200000	
		Heat=0.3
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.15000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//Green
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams_Green
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall_Green'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=6500.000000
		MaxSpeed=20000.000000
		AccelSpeed=150000.000000
		Damage=50
		HeadMult=3.25
		LimbMult=0.75
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		FlashScaleFactor=0.400000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=200.000000
		Chaos=0.025000
		WarnTargetPct=0.200000	
		Heat=0.3
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams_Green
		FireInterval=0.18000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams_Green'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.3
		ADSViewBindFactor=0.7
		YawFactor=0.100000
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.200000
		YRandFactor=0.200000
		ClimbTime=0.05
		DeclineDelay=0.300000
		DeclineTime=0.600000
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSViewBindFactor=0
		ADSMultiplier=0.35
		AimAdjustTime=0.8
		AimSpread=(Min=512,Max=2048)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams_Triple
		//Layout Core
		LayoutName="MK3 Tripleshot"
		Weight=30
		AllowedCamos(0)=1
		//Stats
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.55
		SightPivot=(Pitch=256)
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams_Triple'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams_Green'
	End Object
	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout Core
		LayoutName="MK5 Supershot"
		Weight=30
		AllowedCamos(0)=2
		//Stats
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.55
		SightPivot=(Pitch=256)
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Military
		LayoutName="E55 Plasma Cannon"
		LayoutTags="milspec"
		Weight=10
		AllowedCamos(0)=3
		//Stats
		InventorySize=6
		SightMoveSpeedFactor=0.45
		SightingTime=0.50 //
		SightPivot=(Pitch=256)
		DisplaceDurationMult=1
		MagAmmo=25 //
		PlayerSpeedFactor=0.95000 //
		PlayerJumpFactor=0.95000 //
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'TacticalParams_Triple'
	Layouts(1)=WeaponParams'TacticalParams'
	Layouts(2)=WeaponParams'TacticalParams_Military'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=HVPC_Proto
		Index=0
		CamoName="Prototype"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPC-MainProto",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPC-MiscProto",Index=2,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5,AIndex=-1,PIndex=5)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=HVPC_DeusEx
		Index=1
		CamoName="Green Core"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPCCamos.HVPC-Main",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPCCamos.HVPC-Misc",Index=2,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=3,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5,AIndex=-1,PIndex=5)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=HVPC_Standard
		Index=2
		CamoName="Red Core"
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=HVPC_Black
		Index=3
		CamoName="Mil-Spec"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPC-MainBlack",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_SKC_Tex.HVPC.HVPC-MiscBlack",Index=2,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDot',Index=3,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5,AIndex=-1,PIndex=5)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'HVPC_Proto'
	Camos(1)=WeaponCamo'HVPC_DeusEx'
	Camos(2)=WeaponCamo'HVPC_Standard'
	Camos(3)=WeaponCamo'HVPC_Black'
}
class HVPCMk5WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	//Single
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=5000.000000
		MaxSpeed=8000.000000
		AccelSpeed=90000.000000
		Damage=120
		DamageRadius=512.000000
		MomentumTransfer=65000.000000
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=700.000000
		Chaos=0.400000
		WarnTargetPct=0.200000	
		Inaccuracy=(X=6,Y=6)
		Heat=1.5
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		TargetState="SingleShot"
		FireInterval=0.800000
		AmmoPerFire=5
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Triple
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Triple
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileTriple'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=5000.000000
		MaxSpeed=8000.000000
		AccelSpeed=90000.000000
		Damage=80
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

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Triple
		TargetState="SpreadShot"
		FireInterval=0.800000
		AmmoPerFire=5
		FireAnim="FireAlt"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Triple'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Red
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=4000.000000
		MaxSpeed=11000.000000
		AccelSpeed=150000.000000
		Damage=60
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.175000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	//Green
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams_Green
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall_Green'
		SpawnOffset=(X=25.000000,Y=3.000000,Z=-6.000000)
		Speed=4000.000000
		MaxSpeed=11000.000000
		AccelSpeed=150000.000000
		Damage=60
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

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams_Green
		FireInterval=0.195000
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams_Green'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.3
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
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=32,Max=896)
		SprintOffset=(Pitch=-3072,Yaw=-5000)
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		AimAdjustTime=0.400000
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=3000.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams_Triple
		//Layout Core
		LayoutName="MK3 Tripleshot"
		AllowedCamos(0)=1
		Weight=30
		//Stats
		InventorySize=6
		SightMoveSpeedFactor=0.7
		SightingTime=0.350000
	 	SightPivot=(Pitch=256)		
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Triple'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams_Green'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout Core
		LayoutName="MK5 Supershot"
		AllowedCamos(0)=2
		Weight=30
		//Stats
		InventorySize=6
		SightMoveSpeedFactor=0.7
		SightingTime=0.350000
	 	SightPivot=(Pitch=256)		
		DisplaceDurationMult=1
		MagAmmo=200
		PlayerSpeedFactor=0.90000
		PlayerJumpFactor=0.90000
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	
	Begin Object Class=WeaponParams Name=ArenaParams_Military
		LayoutName="E55 Plasma Cannon"
		LayoutTags="milspec"
		AllowedCamos(0)=3
		Weight=10
		//Stats
		MagAmmo=25 //
		InventorySize=6
		SightMoveSpeedFactor=0.7
		SightingTime=0.320000 //
	 	SightPivot=(Pitch=256)		
		DisplaceDurationMult=1
		PlayerSpeedFactor=0.95000 //
		PlayerJumpFactor=0.95000 //
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams_Triple'
	Layouts(1)=WeaponParams'ArenaParams'
	Layouts(2)=WeaponParams'ArenaParams_Military'
	
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
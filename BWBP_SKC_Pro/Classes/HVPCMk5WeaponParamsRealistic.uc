// Strong and fast, one shot instead of the spread of 3
class HVPCMk5WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	//Single
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5Projectile'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=1350.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		MomentumTransfer=65000.000000
		Damage=160
		DamageRadius=512.000000
		HeadMult=2.0
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=270.000000
		Chaos=0.150000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000	
		Heat=1.5
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		TargetState="SingleShot"
		FireInterval=0.720000
		AmmoPerFire=5
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Triple
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Triple
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileTriple'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=1350.000000
		MaxSpeed=9000.000000
		AccelSpeed=90000.000000
		MomentumTransfer=65000.000000
		Damage=85
		DamageRadius=278.000000
		HeadMult=2.0
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Fire',Volume=2.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=270.000000
		Chaos=0.150000
		Inaccuracy=(X=256,Y=256)
		WarnTargetPct=0.200000	
		Heat=3.0
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Triple
		TargetState="SpreadShot"
		FireInterval=0.720000
		AmmoPerFire=5
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Triple'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.0
		LimbMult=0.65
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=10.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000	
		Heat=0.3
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.160000
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	//Green
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Green
		ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk5ProjectileSmall_Green'
		SpawnOffset=(X=0.000000,Y=0.000000,Z=-9.000000)
		Speed=200.000000
		MaxSpeed=2000000.000000
		AccelSpeed=150000.000000
		Damage=30
		DamageRadius=122.000000
		MomentumTransfer=12500.000000
		HeadMult=2.0
		LimbMult=0.65
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-FireAlt',Volume=1.750000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=10.000000
		Chaos=0.050000
		Inaccuracy=(X=12,Y=12)
		WarnTargetPct=0.200000	
		Heat=0.3
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Green
		FireInterval=0.185000
		BurstFireRateFactor=1.00
		FireAnim="Fire"
		AimedFireAnim="SightFire"
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Green'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.60000,OutVal=0.400000),(InVal=0.80000,OutVal=0.500000),(InVal=1.000000,OutVal=0.5000000)))
		YawFactor=0.200000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=2048.000000
		DeclineTime=1.750000
		ViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=3072)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffset=(Pitch=-3000,Yaw=-5000)
		JumpChaos=0.400000
		JumpOffset=(Pitch=-4000,Yaw=-3000)
		FallingChaos=0.400000
		ChaosDeclineTime=1.600000
		ChaosSpeedThreshold=375
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams_Triple
		//Layout Core
		LayoutName="MK3 Tripleshot"
		AllowedCamos(0)=1
		Weight=30
		//Stats
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
	 	SightPivot=(Pitch=256)		
		WeaponName="HVM Experimental Plasma Cannon Mk5"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Triple'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Green'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout Core
		LayoutName="MK5 Supershot"
		AllowedCamos(0)=2
		Weight=30
		//Stats
		PlayerSpeedFactor=0.800000
		PlayerJumpFactor=0.700000
		InventorySize=10
		SightMoveSpeedFactor=0.500000
	 	SightPivot=(Pitch=256)		
		WeaponName="HVM Experimental Plasma Cannon Mk3"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Military
		LayoutName="E55 Plasma Cannon"
		LayoutTags="milspec"
		AllowedCamos(0)=3
		Weight=10
		//Stats
		MagAmmo=40 //
		PlayerSpeedFactor=0.850000 //
		PlayerJumpFactor=0.850000 //
		InventorySize=10
		SightMoveSpeedFactor=0.500000
	 	SightPivot=(Pitch=256)		
		WeaponName="HVM E55 Plasma Cannon"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams_Triple'
	Layouts(1)=WeaponParams'RealisticParams'
	Layouts(2)=WeaponParams'RealisticParams_Military'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=HVPC_Proto
		Index=0
		CamoName="Prototype"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MainProto",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MiscProto",Index=2,AIndex=1,PIndex=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.Misc.Invisible',Index=3,AIndex=2,PIndex=3)
		WeaponMaterialSwaps(4)=(Material=Texture'BWBP_SKC_Tex.Stim.Stim-Glass',Index=4,AIndex=3,PIndex=4)
		WeaponMaterialSwaps(5)=(Material=TexPanner'BWBP_SKC_Tex.X82.X82MeatPan',Index=5,AIndex=-1,PIndex=5)
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=HVPC_DeusEx
		Index=1
		CamoName="Green Core"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-Main",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-Misc",Index=2,AIndex=1,PIndex=2)
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
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MainBlack",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.HVPCCamos.HVPC-MiscBlack",Index=2,AIndex=1,PIndex=2)
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
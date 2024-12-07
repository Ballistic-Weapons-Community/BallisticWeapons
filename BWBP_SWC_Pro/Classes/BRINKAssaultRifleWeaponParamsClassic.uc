class BRINKAssaultRifleWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=12000.000000)
		WaterTraceRange=12000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=24.0
		HeadMult=3.5
		LimbMult=0.45
		DamageType=Class'BWBP_SWC_Pro.DTBRINKAssault'
		DamageTypeHead=Class'BWBP_SWC_Pro.DTBRINKAssaultHead'
		DamageTypeArm=Class'BWBP_SWC_Pro.DTBRINKAssault'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BWBP_SWC_Pro.BRINKFlashEmitter'
		FlashScaleFactor=0.500000
		FireSound=(Sound=Sound'BWBP_SWC_Sounds.BR1NK.BR1NK-Fire',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=140.000000
		Chaos=0.02000
		Inaccuracy=(X=32,Y=4)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.080000
		BurstFireRateFactor=0.1
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=0.85	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.BRINKRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=600.000000
		MaxSpeed=14000.000000
		Damage=100
		DamageRadius=500.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.500000
		SplashDamage=True
		RecommendSplashDamage=True
		BotRefireRate=0.300000
		WarnTargetPct=0.600000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.800000
		PreFireTime=0.450000
		PreFireAnim="GrenadePrep"
		FireAnim="GrenadeFire"	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.150000),(InVal=0.4800000,OutVal=0.20000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=0.0500000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.3)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=0.500000
		DeclineDelay=0.140000
		ViewBindFactor=0.4
		CrouchMultiplier=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Heavy Rifle
		AimSpread=(Min=32,Max=3048)
		CrouchMultiplier=0.500000
		ADSMultiplier=0.700000
		ViewBindFactor=0.300000
		SprintChaos=0.450000
		SprintOffset=(Pitch=-3000,Yaw=-4096)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-1000,Yaw=-3096)
		FallingChaos=0.450000
		ChaosDeclineTime=1.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.950000
		InventorySize=6
		SightingTime=0.400000
		SightMoveSpeedFactor=0.5
		DisplaceDurationMult=1
		MagAmmo=60
		ViewOffset=(X=8,Y=5.5,Z=-11.5)
		SightOffset=(X=-20.000000,Y=-0.400000,Z=16.20000)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=BRINK_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=BRINK_Jungle
		Index=1
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BRINKCamos.BrinkMat1Shine",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.BRINKCamos.BrinkMat2Shine",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=BRINK_Winter
		Index=2
		CamoName="Winter"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BRINKCamos.SnowBrinkMat1Shine",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.BRINKCamos.SnowBrinkMat2Shine",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'BRINK_Blue'
	Camos(1)=WeaponCamo'BRINK_Jungle'
	Camos(2)=WeaponCamo'BRINK_Winter'
}

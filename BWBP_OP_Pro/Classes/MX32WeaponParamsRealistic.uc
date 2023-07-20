class MX32WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Very Short Barrel
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=43.0
		HeadMult=2.139534
		LimbMult=0.651162
		DamageType=Class'BWBP_OP_Pro.DTMX32Primary'
		DamageTypeHead=Class'BWBP_OP_Pro.DTMX32PrimaryHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTMX32PrimaryLimb'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.100000
		Recoil=496
		Chaos=-0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.120000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticFastRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7500.000000
		MaxSpeed=10000.000000
		AccelSpeed=2000.000000
		Damage=80.000000
		DamageRadius=270.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=256
		Chaos=0.06
		Inaccuracy=(X=96,Y=48)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticFastRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticFastRocketEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=RealisticGuidedRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32SeekerRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7500.000000
		MaxSpeed=10000.000000
		AccelSpeed=2000.000000
		Damage=80.000000
		DamageRadius=270.000000
		MomentumTransfer=20000.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=256
		Chaos=0.04
		Inaccuracy=(X=80,Y=40)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=RealisticGuidedRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'RealisticGuidedRocketEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		ViewBindFactor=0.200000
		XCurve=(Points=(,(InVal=0.450000,OutVal=-0.3500000),(InVal=0.650000,OutVal=-0.300000),(InVal=1.000000,OutVal=-0.200000)))
		YCurve=(Points=(,(InVal=0.50000,OutVal=0.350000),(InVal=0.750000,OutVal=0.450000),(InVal=1.000000,OutVal=0.400000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=2890.000000
		DeclineTime=0.750000
		DeclineDelay=0.250000
		ADSViewBindFactor=0.060000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		ADSMultiplier=0.700000
		CrouchMultiplier=0.700000
		AimSpread=(Min=680,Max=2792)
		AimAdjustTime=0.550000
		ViewBindFactor=0.060000
		ChaosDeclineTime=1.600000
		ChaosDeclineDelay=0.600000
		ChaosSpeedThreshold=500.000000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-4000,Yaw=1500)
		FallingChaos=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=RealisticParams
		//ViewOffset=(X=1.000000,Y=6.000000,Z=-18.000000)
		//SightOffset=(X=-5.000000,Y=-0.330000,Z=22.800000)
		PlayerSpeedFactor=0.870000
        PlayerJumpFactor=0.870000
        SightMoveSpeedFactor=0.75
		MagAmmo=30
		bMagPlusOne=True
		SightingTime=0.55
		DisplaceDurationMult=1.4
        InventorySize=6
		WeaponName="MX32 Guided Missile System"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticFastRocketFireParams'
		AltFireParams(1)=FireParams'RealisticGuidedRocketFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=MX32_White
		Index=0
		CamoName="White"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MX32_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Weapon_S2",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Attach_S2",Index=2,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=MX32_Ruby
		Index=2
		CamoName="Ruby"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Weapon_S3",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Attach_S3",Index=2,AIndex=1,PIndex=1)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=MX32_Gold
		Index=3
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Weapon_S1",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.MX32Camos.MX32_Attach_S1",Index=2,AIndex=1,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'MX32_White'
	Camos(1)=WeaponCamo'MX32_Desert'
	Camos(2)=WeaponCamo'MX32_Ruby'
	Camos(3)=WeaponCamo'MX32_Gold'
}
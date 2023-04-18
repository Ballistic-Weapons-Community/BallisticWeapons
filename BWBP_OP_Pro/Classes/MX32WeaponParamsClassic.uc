class MX32WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		RangeAtten=0.900000
		Damage=24
		HeadMult=3.125
		LimbMult=0.5
		DamageType=Class'BWBP_OP_Pro.DTMX32Primary'
		DamageTypeHead=Class'BWBP_OP_Pro.DTMX32PrimaryHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTMX32PrimaryLimb'
		PenetrationEnergy=32.000000
		PenetrateForce=150
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.100000
		Recoil=128
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.MX32.MX32-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.120000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicFastRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=50.000000
		DamageRadius=192.000000
		MomentumTransfer=20000.000000
		HeadMult=1.0
		LimbMult=1.0
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=256
		Chaos=0.06
		Inaccuracy=(X=96,Y=48)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=ClassicFastRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicFastRocketEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=ClassicGuidedRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32SeekerRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		MaxSpeed=10000.000000
		AccelSpeed=1000.000000
		Damage=50.000000
		DamageRadius=192.000000
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

	Begin Object Class=FireParams Name=ClassicGuidedRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicGuidedRocketEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.200000
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		DeclineTime=0.800000
		DeclineDelay=0.500000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Heavy Rifle handling
		ADSMultiplier=0.700000
		CrouchMultiplier=0.700000
		AimSpread=(Min=64,Max=3096)
		AimAdjustTime=0.550000
		ChaosDeclineTime=1.400000
		ChaosDeclineDelay=0.600000
		ChaosSpeedThreshold=7000.000000
		SprintChaos=0.450000
		SprintOffSet=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.450000
		JumpOffset=(Pitch=-4000,Yaw=1500)
		FallingChaos=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		//ViewOffset=(X=1.000000,Y=8.000000,Z=-15.000000)
		//SightOffset=(X=-5.000000,Y=-0.330000,Z=22.800000)
		PlayerSpeedFactor=0.870000
        PlayerJumpFactor=0.870000
        SightMoveSpeedFactor=0.75
		bNeedCock=True
		MagAmmo=30
		SightingTime=0.55
		DisplaceDurationMult=1.4
        InventorySize=7
		ViewOffset=(X=8,Y=8,Z=-4)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicFastRocketFireParams'
		AltFireParams(1)=FireParams'ClassicGuidedRocketFireParams'
    End Object
	
    Layouts(0)=WeaponParams'ClassicParams'
	
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
	Camos(3)=WeaponCamo'MX32_White'
}
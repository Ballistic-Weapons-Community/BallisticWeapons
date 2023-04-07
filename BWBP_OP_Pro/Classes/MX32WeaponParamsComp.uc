class MX32WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=18
		DamageType=Class'BWBP_OP_Pro.DTMX32Primary'
		DamageTypeHead=Class'BWBP_OP_Pro.DTMX32PrimaryHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DTMX32PrimaryLimb'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.300000
		Recoil=128
		Chaos=0.03
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M51.M51-Fire444',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.113000
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaFastRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32Rocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=500.000000
		MaxSpeed=30000.000000
		AccelSpeed=10000.000000
		Damage=32
		DamageRadius=150.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=192
		Chaos=0.06
		Inaccuracy=(X=96,Y=48)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaFastRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaFastRocketEffectParams'
	End Object

	Begin Object Class=ProjectileEffectParams Name=ArenaGuidedRocketEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.MX32SeekerRocket'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=500.000000
		MaxSpeed=30000.000000
		AccelSpeed=10000.000000
		Damage=32
		DamageRadius=150.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=96
		Chaos=0.04
		Inaccuracy=(X=80,Y=40)
		BotRefireRate=0.600000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.AIMS-Fire2',Volume=1.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaGuidedRocketFireParams
		FireInterval=0.125000
		FireAnim="RocketFire"
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaGuidedRocketEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.200000
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		ClimbTime=0.04
		DeclineDelay=0.16
		DeclineTime=1.5
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.500000
		CrouchMultiplier=0.750000
		AimSpread=(Min=64,Max=1024)
		AimAdjustTime=0.550000
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-4000,Yaw=1500)
		ChaosDeclineTime=0.800000
		ChaosDeclineDelay=0.600000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		ReloadAnimRate=0.800000
		//SightOffset=(X=16.000000,Y=-0.340000,Z=22.720000)
		PlayerSpeedFactor=0.95
        SightMoveSpeedFactor=0.7
		MagAmmo=50
		SightingTime=0.55
		DisplaceDurationMult=1.4
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaFastRocketFireParams'
		AltFireParams(1)=FireParams'ArenaGuidedRocketFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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
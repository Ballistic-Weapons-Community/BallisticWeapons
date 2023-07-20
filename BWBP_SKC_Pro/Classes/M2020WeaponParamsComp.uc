class M2020WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE - Recharge
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaRechargeEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=65
        HeadMult=1.75
        LimbMult=0.85
		PenetrationEnergy=64
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		PushbackForce=120.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.200000
		Recoil=400.000000
		Chaos=0.600000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFire',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaRechargeFireParams
		FireInterval=0.325000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaRechargeEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Power
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaPowerEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
        HeadMult=1.50
        LimbMult=0.90
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		PenetrationEnergy=96
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.600000
		Recoil=2048.000000
		Chaos=1.000000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireSuper',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaPowerFireParams
		FireAnim="FirePowered"
		FireInterval=1.000000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPowerEffectParams'
	End Object

	//=================================================================
    // PRIMARY FIRE - Offline
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaOfflineEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=40
        HeadMult=2.00
        LimbMult=0.75
		DamageType=Class'BWBP_SKC_Pro.DT_M2020Pwr'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_M2020HeadPwr'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_M2020LimbPwr'
		PenetrateForce=600
		PenetrationEnergy=48
		bPenetrate=True
		PDamageFactor=0.750000
		WallPDamageFactor=0.750000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.M2020FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=150.000000
		Chaos=0.050000
		BotRefireRate=0.500000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M2020.M2020-GaussFireLow',Volume=6.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaOfflineFireParams
		FireAnim="FireUnPowered"
		FireInterval=0.200000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaOfflineEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRechargeRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.040000),(InVal=0.380000,OutVal=-0.0500000),(InVal=0.550000,OutVal=0.07000),(InVal=0.720000,OutVal=-0.10000),(InVal=1.000000,OutVal=-0.15)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.06
		DeclineDelay=0.5
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
	End Object

	Begin Object Class=RecoilParams Name=ArenaPowerRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=1.000000,OutVal=0.16)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.2
		YRandFactor=0.2
		ClimbTime=0.125
		DeclineDelay=0.7
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.5
	End Object

	Begin Object Class=RecoilParams Name=ArenaOfflineRecoilParams
		ViewBindFactor=0.2
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.030000),(InVal=0.400000,OutVal=0.050000),(InVal=0.800000,OutVal=0.010000),(InVal=1.000000,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.180000),(InVal=0.400000,OutVal=0.50000),(InVal=0.600000,OutVal=0.750000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.0500000
		YRandFactor=0.0500000
		ClimbTime=0.04
		DeclineDelay=0.22
		DeclineTime=1.00000
		CrouchMultiplier=0.750000
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1536)
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-2048,Yaw=512)
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		//SightOffset=(X=26,Y=-2.500000,Z=18.000000)
		PlayerSpeedFactor=0.95
		InventorySize=7
		SightMoveSpeedFactor=0.6
		SightingTime=0.45	
		ScopeScale=0.75	
		DisplaceDurationMult=1
		MagAmmo=10
        ZoomType=ZT_Logarithmic
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		RecoilParams(0)=RecoilParams'ArenaRechargeRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaPowerRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaOfflineRecoilParams'
		RecoilParams(3)=RecoilParams'ArenaOfflineRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaRechargeFireParams'
		FireParams(1)=FireParams'ArenaPowerFireParams'
		FireParams(2)=FireParams'ArenaOfflineFireParams'
		FireParams(3)=FireParams'ArenaOfflineFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M2020_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Aliens
		Index=1
		CamoName="Corporate"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainAlien",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainDesert",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Winter
		Index=3
		CamoName="Winter Hex"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainWinter",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Blue
		Index=4
		CamoName="Blue Hex"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainBlueHex",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M2020_Red
		Index=5
		CamoName="Red Tiger"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MiscMetal",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M2020Camos.M2020-MainRedTiger",Index=2,AIndex=2,PIndex=2)
	End Object
	
	Camos(0)=WeaponCamo'M2020_Black'
	Camos(1)=WeaponCamo'M2020_Aliens'
	Camos(2)=WeaponCamo'M2020_Desert'
	Camos(3)=WeaponCamo'M2020_Winter'
	Camos(4)=WeaponCamo'M2020_Blue'
	Camos(5)=WeaponCamo'M2020_Red'
}
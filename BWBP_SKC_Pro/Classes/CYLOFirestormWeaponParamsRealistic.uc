class CYLOFirestormWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1200.000000,Max=4800.000000) //5.56mm Short Barrel
		WaterTraceRange=4800.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.050000
		Damage=43.0
		HeadMult=2.139534
		LimbMult=0.651162
		DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		PenetrationEnergy=16.000000
		PenetrateForce=50
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
		FlashScaleFactor=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
		Recoil=350.000000
		Chaos=0.020000
		Inaccuracy=(X=64,Y=64)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.085500
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Dragon's Breath
	Begin Object Class=ShotgunEffectParams Name=RealisticSecondaryEffectParams_Flame
		TraceRange=(Min=3072.000000,Max=3072.000000)
		RangeAtten=0.15000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=10
		DamageType=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgunHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_CYLOFirestormShotgun'
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.000000
		Recoil=768.000000
		Chaos=0.30000
		BotRefireRate=0.7
		WarnTargetPct=0.5	
		SpreadMode=FSM_Rectangle
		Inaccuracy=(X=200,Y=200)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Flame
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="FireShot"
	FireEffectParams(0)=ShotgunEffectParams'RealisticSecondaryEffectParams_Flame'
	End Object
	
	//BOOM
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
		SpawnOffset=(Y=20.000000,Z=-20.000000)
        Speed=10000.000000
        MaxSpeed=15000.000000
        AccelSpeed=3000.000000
        Damage=80
        DamageRadius=256.000000
        MomentumTransfer=100000.000000
        MuzzleFlashClass=Class'BWBP_SKC_Pro.SK410HeatEmitter'
		FlashScaleFactor=1.000000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000,Radius=256.000000)
		Recoil=640.000000
		Chaos=-1.0
		Inaccuracy=(X=128,Y=128)
        BotRefireRate=0.6
        WarnTargetPct=0.4	
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="HESlug"
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		//XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.500000),(InVal=0.600000,OutVal=0.300000)))
		//YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.200000,OutVal=0.080000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.300000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MinRandFactor=0.300000
		MaxRecoil=3840.000000
		DeclineDelay=0.000000
		DeclineTime=1.200000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.500000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=32,Max=2560)
		AimAdjustTime=0.400000
		ADSMultiplier=0.700000
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-3000,Yaw=-8000)
		JumpChaos=0.300000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=1.000000
		ChaosSpeedThreshold=1200.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		InventorySize=10
		SightMoveSpeedFactor=0.500000
		SightingTime=0.23
		MagAmmo=50
		//ViewOffset=(X=0,Y=-5,Z=-14)
		//SightOffset=(X=-3.000000,Y=13.565000,Z=24.785000)
		SightPivot=(Pitch=900)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		WeaponName="CYLO-V 5.56mm Incendiary Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Flame'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=CYLOFS_Orange
		Index=0
		CamoName="Orange"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainRed",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Blue
		Index=2
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainBlue",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Yellow
		Index=3
		CamoName="Yellow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainYellow",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_OrangeFancy
		Index=4
		CamoName="Custom Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainStripes",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainGold",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'CYLOFS_Orange'
	Camos(1)=WeaponCamo'CYLOFS_Red'
	Camos(2)=WeaponCamo'CYLOFS_Blue'
	Camos(3)=WeaponCamo'CYLOFS_Yellow'
	Camos(4)=WeaponCamo'CYLOFS_OrangeFancy'
	Camos(5)=WeaponCamo'CYLOFS_Gold'
}
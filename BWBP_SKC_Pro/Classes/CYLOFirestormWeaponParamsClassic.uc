class CYLOFirestormWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=10000.000000,Max=12000.000000)
		WaterTraceRange=2400.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.550000
		Damage=22
		HeadMult=2.0
		LimbMult=0.7
		DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
		PenetrationEnergy=20.000000
		PenetrateForce=180
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
		Recoil=110.000000
		Chaos=0.020000
		Inaccuracy=(X=128,Y=128)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.085500
		BurstFireRateFactor=1.00
		PreFireAnim=
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	//Flame
	Begin Object Class=ShotgunEffectParams Name=ClassicSecondaryEffectParams_Flame
		TraceRange=(Min=1572.000000,Max=1572.000000)
		RangeAtten=0.200000
		TraceCount=4
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_ShotgunFlameLight'
		ImpactManager=Class'BWBP_SKC_Pro.IM_ShellHE'
		Damage=15
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
		Inaccuracy=(X=1250,Y=1250)
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.CYLO.CYLO-FlameFire',Volume=1.300000)
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams_Flame
		FireInterval=0.4
		AmmoPerFire=0
		FireAnim="FireSG"
		FireEndAnim=	
		TargetState="FireShot"
	FireEffectParams(0)=ShotgunEffectParams'ClassicSecondaryEffectParams_Flame'
	End Object
	
	//BOOM
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.CYLOFirestormHEProjectile'
		SpawnOffset=(Y=20.000000,Z=-20.000000)
        Speed=6300.000000
        MaxSpeed=6300.000000
        AccelSpeed=3000.000000
        Damage=65
        DamageRadius=200.000000
        MomentumTransfer=10000.000000
		RadiusFallOffType=RFO_Linear
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

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=0.060000),(InVal=0.150000,OutVal=-0.060000),(InVal=0.200000),(InVal=0.400000,OutVal=-0.200000),(InVal=0.600000,OutVal=0.300000),(InVal=0.800000,OutVal=-0.300000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=(,(InVal=0.050000,OutVal=0.050000),(InVal=0.100000,OutVal=-0.050000),(InVal=0.150000),(InVal=0.200000,OutVal=0.300000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.250000
		YRandFactor=0.250000
		MaxRecoil=3840.000000
		DeclineTime=0.800000
		ViewBindFactor=0.200000
		CrouchMultiplier=0.800000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
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
	
	Begin Object Class=WeaponParams Name=ClassicParams
		InventorySize=6
		SightMoveSpeedFactor=0.500000
		bNeedCock=True
		MagAmmo=35
		//SightOffset=(X=-3.000000,Y=13.565000,Z=24.785000)
		SightPivot=(Pitch=900)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams_Flame'
	End Object
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=CYLOFS_Orange
		Index=0
		CamoName="Orange"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Red
		Index=2
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainRed",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Blue
		Index=3
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainBlue",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Yellow
		Index=4
		CamoName="Yellow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainYellow",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_OrangeFancy
		Index=5
		CamoName="Custom Orange"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.CYLOFSCamos.CYLOFS-MainStripes",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=CYLOFS_Gold
		Index=6
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
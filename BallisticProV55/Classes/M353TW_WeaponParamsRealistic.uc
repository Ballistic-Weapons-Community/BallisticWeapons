class M353TW_WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
		TraceRange=(Min=1600.000000,Max=8000.000000)
		WaterTraceRange=5000.0
		DecayRange=(Min=0.0,Max=0.0)
		Damage=45.0
		HeadMult=2.26
		LimbMult=0.66
		DamageType=Class'BallisticProV55.DTM353MG'
		DamageTypeHead=Class'BallisticProV55.DTM353MGHead'
		DamageTypeArm=Class'BallisticProV55.DTM353MG'
		PenetrationEnergy=18.000000
		PenetrateForce=55
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.M353FlashEmitter'
		FlashScaleFactor=0.850000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Fire1',Volume=0.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=32.000000
		//Chaos=0.080000
		Inaccuracy=(X=16,Y=16)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.075000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=RealisticSecondaryEffectParams
		BotRefireRate=0.300000
	End Object
	
	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireAnim="Undeploy"
		FireEffectParams(0)=FireEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=((InVal=0.000000,OutVal=0.000000),(InVal=1.000000,OutVal=1.000000)))
		YCurve=(Points=((InVal=0.000000,OutVal=0.000000),(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.100000
		YawFactor=0.100000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=256.000000
		DeclineTime=1.000000
		DeclineDelay=0.500000
		ViewBindFactor=0.000000
		ADSViewBindFactor=0.350000
		HipMultiplier=1.000000
		CrouchMultiplier=1.000000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=256,Max=3072)
		CrouchMultiplier=1.000000
		ADSMultiplier=0.700000
		ViewBindFactor=0.000000
		SprintChaos=0.400000
		ChaosDeclineTime=1.500000
		ChaosSpeedThreshold=400
		AimDamageThreshold=2000.000000
	End Object
	
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		PlayerSpeedFactor=0.875000
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=150
		//ViewOffset=(X=11.000000,Y=-1.000000,Z=-14.000000)
		//SightOffset=(X=-5.000000,Y=0.000000,Z=4.500000)
		SightPivot=(Pitch=0,Roll=0)
		//CockAnimRate=0.900000
		//ReloadAnimRate=0.900000
        WeaponName="Mounted M353 Squad Machinegun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=M353_Gray
		Index=0
		CamoName="Gray"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Jungle
		Index=1
		CamoName="Jungle"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S2",Index=2,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S2",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S2",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Arctic
		Index=2
		CamoName="Arctic"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S1",Index=2,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S1",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S1",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Ocean
		Index=3
		CamoName="Ocean"
		Weight=5
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S3",Index=2,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S3",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S3",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M353_Gold
		Index=4
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD2_S4",Index=2,AIndex=1,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_SD1_S4",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M353Camos.M353_Ammo_S4",Index=3,AIndex=2,PIndex=2)
	End Object
	
	Camos(0)=WeaponCamo'M353_Gray'
    Camos(1)=WeaponCamo'M353_Jungle'
    Camos(2)=WeaponCamo'M353_Arctic'
    Camos(3)=WeaponCamo'M353_Ocean'
    Camos(4)=WeaponCamo'M353_Gold'
}
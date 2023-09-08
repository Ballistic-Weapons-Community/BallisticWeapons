class RS04WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryEffectParams
	TraceRange=(Min=800.000000,Max=4000.000000)  //.45
		WaterTraceRange=3300.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=40
		HeadMult=2.65
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM1911Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=30
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire2',Volume=1.200000)
		Recoil=1200.000000
		Chaos=0.060000
		Inaccuracy=(X=25,Y=25)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.070000
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=RealisticPrimaryBurstEffectParams
	TraceRange=(Min=800.000000,Max=4000.000000)  //.45
		WaterTraceRange=3300.0
		DecayRange=(Min=0.0,Max=0.0)
		RangeAtten=0.900000
		Damage=45
		HeadMult=2.65
		LimbMult=0.6
		DamageType=Class'BWBP_SKC_Pro.DTM1911Pistol'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTM1911PistolHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTM1911Pistol'
		PenetrationEnergy=32.000000
		PenetrateForce=30
		bPenetrate=True
		PDamageFactor=0.6
		WallPDamageFactor=0.4
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.M1911.M1911-Fire2',Volume=1.200000)
		Recoil=1000.000000
		Chaos=0.060000
		Inaccuracy=(X=20,Y=20)
		BotRefireRate=0.300000
		WarnTargetPct=0.100000
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryBurstFireParams
		FireInterval=0.030000
		FireAnim="FireDual"
		AimedFireAnim="Fire"
		BurstFireRateFactor=0.02
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'RealisticPrimaryBurstEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		PitchFactor=0.650000
		YawFactor=0.100000
		XRandFactor=0.450000
		YRandFactor=0.450000
		MaxRecoil=1768.000000
		DeclineTime=0.300000
		DeclineDelay=0.100000
		ViewBindFactor=0.050000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=512,Max=768)
		AimAdjustTime=0.400000
		CrouchMultiplier=0.820000
		ADSMultiplier=0.770000
		AimDamageThreshold=300
		ViewBindFactor=0.050000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4608,Yaw=-512)
		JumpChaos=0.200000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=0.500000
		ChaosSpeedThreshold=750.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		Weight=30
		LayoutName="Default"
		//Attachments
		//Function
		InventorySize=2
		WeaponPrice=700
		SightMoveSpeedFactor=0.500000
		SightingTime=0.110000
		MagAmmo=10
		bMagPlusOne=True
		ViewOffset=(X=0.00,Y=6.00,Z=-6.00)
		//SightOffset=(X=-20.000000,Y=-1.9500000,Z=17.000000)
		SightPivot=(Roll=-256)
		WeaponName="RS4 .45 Compact Handgun"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimaryBurstFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=RS04_Tan
		Index=0
		CamoName="Tan"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-MainShineX1",Index=1,AIndex=0,PIndex=0)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_TwoTone
		Index=2
		CamoName="Two-Tone"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-MainShineX2",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Jungle
		Index=3
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-UC-CamoJungle",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Hunter
		Index=4
		CamoName="Hunter"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-R-CamoHunter",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_Autumn
		Index=5
		CamoName="Autumn"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-R-CamoAutumn",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=RS04_RedTiger
		Index=6
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RS04Camos.RS04-X-CamoTiger",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'RS04_Tan'
	Camos(1)=WeaponCamo'RS04_Black'
	Camos(2)=WeaponCamo'RS04_TwoTone'
	Camos(3)=WeaponCamo'RS04_Jungle'
	Camos(4)=WeaponCamo'RS04_Hunter'
	Camos(5)=WeaponCamo'RS04_Autumn'
	Camos(6)=WeaponCamo'RS04_RedTiger'
	//Camos(7)=WeaponCamo'RS04_Gold'
}
class MD24WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		Inaccuracy=(X=128,Y=128)
		RangeAtten=0.5
		Damage=24
        HeadMult=3.0f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
        PenetrationEnergy=16
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=512.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.13000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.15
		ADSViewBindFactor=0.4
		EscapeMultiplier=1.1
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.06
		DeclineDelay=0.250000
		DeclineTime=0.35
		CrouchMultiplier=1
		HipMultiplier=1
		MaxMoveMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=128,Max=512)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ADSMultiplier=0.5
		AimAdjustTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Default"
		Weight=30
		//Attachments
		//Function
		//SightOffset=(X=-8.000000,Y=-0.030000,Z=7.400000)
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=0.6
		MagAmmo=16
        InventorySize=2
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ==========================================
	Begin Object Class=WeaponCamo Name=MD24_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Black
		Index=1
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlackShine",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Desert
		Index=2
		CamoName="Desert"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24DesertShine",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Blue
		Index=3
		CamoName="Blue"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlueShine",Index=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=MD24_Red
		Index=4
		CamoName="Red"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,PIndex=-1,AIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24RedShine",Index=1)
	End Object
	
	Camos(0)=WeaponCamo'MD24_Green'
    Camos(1)=WeaponCamo'MD24_Black'
    Camos(2)=WeaponCamo'MD24_Desert'
    Camos(3)=WeaponCamo'MD24_Blue'
    Camos(4)=WeaponCamo'MD24_Red'
}
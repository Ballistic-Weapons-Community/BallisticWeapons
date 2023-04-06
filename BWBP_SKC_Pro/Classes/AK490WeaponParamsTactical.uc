class AK490WeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=2363,Max=6000)
		RangeAtten=0.75
		Damage=45
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_AK490Bullet'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK490BulletHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK490Bullet'
        PenetrationEnergy=48
		PenetrateForce=180
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'AK490FlashEmitter'
		FlashScaleFactor=0.9
		Recoil=260.000000
		Chaos=0.04000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.11000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK490Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=75
        HeadMult=2.75f
        LimbMult=0.75f
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=0.20000,Radius=256) // stealth
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.25
		ADSViewBindFactor=0.85
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.5,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.35000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.15
		DeclineTime=1.25
		MaxRecoil=6144
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=256,Max=1024)
		AimAdjustTime=0.6
        ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		Weight=30
		LayoutName="Standard"
		//Attachments
		//Function
		InventorySize=7
        SightMoveSpeedFactor=0.6
		SightingTime=0.35
		SightPivot=(Pitch=64)
		DisplaceDurationMult=1
		MagAmmo=20
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ===================================
	Begin Object Class=WeaponCamo Name=AK_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-C-CamoDesert",Index=1,AIndex=1,PIndex=1)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Flecktarn
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoGerman",Index=1,AIndex=1,PIndex=1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blood
		Index=3
		CamoName="Bloodied"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-UC-CamoBlood",Index=1,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Blue
		Index=4
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoBlue",Index=1,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_Red
		Index=5
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.AK490-R-CamoRed",Index=1,AIndex=1,PIndex=1)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=AK_AU
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AK490Camos.GoldAK-Shine",Index=1,AIndex=1,PIndex=1)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'AK_Black' //Black
	Camos(1)=WeaponCamo'AK_Desert'
	Camos(2)=WeaponCamo'AK_Flecktarn'
	Camos(3)=WeaponCamo'AK_Blood'
	Camos(4)=WeaponCamo'AK_Blue'
	Camos(5)=WeaponCamo'AK_Red'
	Camos(6)=WeaponCamo'AK_AU'
}
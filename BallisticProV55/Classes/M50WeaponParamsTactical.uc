class M50WeaponParamsTactical extends BallisticWeaponParams;

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
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		RangeAtten=0.67
		Damage=34
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
        PenetrationEnergy=32
		PenetrateForce=150
		bPenetrate=True
		Inaccuracy=(X=32,Y=32)
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=134.000000
		Chaos=0.02
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.0825 // 800 rpm
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4200.000000 // 80 m/s
		MaxSpeed=4200.000000
		Damage=150
        ImpactDamage=200
		DamageRadius=1050.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.800000
		PreFireTime=0.450000
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		ADSViewBindFactor=0.85
		CrouchMultiplier=0.850000
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.06),(InVal=0.40000,OutVal=0.21000),(InVal=0.6500000,OutVal=0.25000),(InVal=0.800000,OutVal=0.050000),(InVal=1.00000,OutVal=0.150000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		DeclineDelay=0.120000     
		DeclineTime=0.75
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=256,Max=1024)
		AimAdjustTime=0.6
		ChaosDeclineTime=0.75
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Standard"
		Weight=30
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
        MagAmmo=30
        InventorySize=6
		SightPivot=(Pitch=200)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
	
	//Camos
	Begin Object Class=WeaponCamo Name=M50_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Black
		Index=1
		CamoName="Black"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinA-D',Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50SkinB-D',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.M50.M50Laser',Index=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.M50A3.M50Gren-D',Index=5)
		WeaponMaterialSwaps(5)=(Material=Texture'BW_Core_WeaponTex.M50.M900Grenade',Index=6)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Jungle
		Index=2
		CamoName="Jungle"
		Weight=3
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SATiger",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M30A2-SBTiger",Index=2)
	End Object
	
	Begin Object Class=WeaponCamo Name=M50_Gold
		Index=3
		CamoName="Gold"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main1_S1",Index=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main2_S1",Index=2)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Laser_S1",Index=4)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.M50Camos.M50_Main3_S1",Index=5)
	End Object
	
    Layouts(0)=WeaponParams'TacticalParams'
	
	Camos(0)=WeaponCamo'M50_Silver'
	Camos(1)=WeaponCamo'M50_Black'
	Camos(2)=WeaponCamo'M50_Jungle'
	Camos(3)=WeaponCamo'M50_Gold'
	Camos(4)=WeaponCamo'M50A3_Black'
	Camos(5)=WeaponCamo'M50A3_Desert'
}
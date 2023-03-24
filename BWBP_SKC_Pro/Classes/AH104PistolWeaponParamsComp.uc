class AH104PistolWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
    Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
        DecayRange=(Min=1536,Max=2560)
        PenetrationEnergy=64
        Damage=80.000000
        HeadMult=2.0f
        LimbMult=0.75f
        RangeAtten=0.5
        DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
        DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
        DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
        PenetrateForce=200
        bPenetrate=True
        MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
        FlashScaleFactor=0.900000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=7.100000)
        Recoil=1024.000000
        Chaos=0.2
        Inaccuracy=(X=16,Y=16)
        WarnTargetPct=0.400000
        BotRefireRate=0.7
    End Object

    Begin Object Class=FireParams Name=ArenaPrimaryFireParams
        AimedFireAnim="SightFire"
        FireEndAnim=
        FireInterval=0.39
    FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
    End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
    Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
        Recoil=0.01
        Chaos=0.05
        Damage=12.000000
        DamageRadius=192
        Inaccuracy=(X=0,Y=0)
        BotRefireRate=0.300000
    End Object
    
    Begin Object Class=FireParams Name=ArenaSecondaryFireParams
        FireInterval=0.090000
        AmmoPerFire=0
        BurstFireRateFactor=1.00
        FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.500000,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=8192.000000
		DeclineTime=1.000000
		DeclineDelay=0.400000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=40,Max=1024)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.7000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=1250.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		Weight=30
		LayoutName="Iron Sights"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
		SightOffset=(X=-30.000000,Y=-0.800000,Z=23.000000)
		//Function
		InventorySize=5
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.900000
		MagAmmo=9
		ViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Holo
		//Layout core
		Weight=10
		LayoutName="Holosight"
		//Attachments
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=1f)
		WeaponMaterialSwaps(0)=(Material=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex',Index=3,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.TechSawnOff.DoubleBarrel_Main1_Tex',Index=4,AIndex=-1,PIndex=-1)
		SightOffset=(X=-30.000000,Y=-0.700000,Z=26.730000)
		//Function
		InventorySize=5
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.900000
		MagAmmo=9
		ViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Holo'

	//Camos ===================================
	Begin Object Class=WeaponCamo Name=AH_Black
		Index=0
		CamoName="Black"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=AH_Red
		Index=1
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-MainRed",Index=1,AIndex=0,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.AH104Camos.AH104-Misc",Index=2,AIndex=1,PIndex=2)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'AH_Black'
	Camos(1)=WeaponCamo'AH_Red'
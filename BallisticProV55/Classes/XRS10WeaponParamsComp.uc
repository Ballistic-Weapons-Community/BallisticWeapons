class XRS10WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaPriEffectParams
     	TraceRange=(Min=3072,Max=3072)
        DecayRange=(Min=525,Max=1225)
		RangeAtten=0.5
     	PenetrationEnergy=16
		PenetrateForce=135
		bPenetrate=True
     	Damage=20.000000
        HeadMult=2.00f
        LimbMult=0.75
     	DamageType=Class'BallisticProV55.DTXRS10SMG'
     	DamageTypeHead=Class'BallisticProV55.DTXRS10SMGHead'
    	DamageTypeArm=Class'BallisticProV55.DTXRS10SMG'
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		Recoil=220.000000
     	Inaccuracy=(X=64,Y=64)
		FireSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Fire',Volume=0.900000,Radius=384.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPriFireParams
		AimedFireAnim="SightFire"
		FireInterval=0.066
		FireEffectParams(0)=InstantEffectParams'ArenaPriEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=ArenaSecEffectParams
        BotRefireRate=0.3
        EffectString="Laser sight"
    End Object

	Begin Object Class=FireParams Name=ArenaSecFireParams
		FireInterval=0.700000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecEffectParams'
	End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		XCurve=(Points=(,(InVal=0.150000,OutVal=0.05),(InVal=0.30000,OutVal=-0.07000),(InVal=0.5500000,OutVal=0.090000),(InVal=0.800000,OutVal=-0.15000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.220000),(InVal=0.400000,OutVal=0.400000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05
		YRandFactor=0.05
		MaxRecoil=6144.000000
		ClimbTime=0.04
		DeclineDelay=0.13
		DeclineTime=0.75
		HipMultiplier=1.5
		CrouchMultiplier=1
	End Object

    //=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
    	AimSpread=(Min=64,Max=256)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.450000
		ADSMultiplier=0.5
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		bDualBlocked=True
		//SightOffset=(X=-15.000000,Z=9.500000)
		DisplaceDurationMult=0.5
		ReloadAnimRate=1.250000
		CockAnimRate=1.250000
		MagAmmo=30
		SightingTime=0.200000
        InventorySize=3
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPriFireParams'
        AltFireParams(0)=FireParams'ArenaSecFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XRS_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainBlack",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Desert
		Index=2
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainDesert",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-SuppDesert",Index=3,AIndex=2,PIndex=5)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Purple
		Index=3
		CamoName="Purple"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainPurple",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_CandyCane
		Index=4
		CamoName="Candy Cane"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10RS-Main-Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10RS-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_GoldTiger
		Index=5
		CamoName="Tiger"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Main-Shine",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-LAM-Shine",Index=2,AIndex=1,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=1
	End Object
	
	Begin Object Class=WeaponCamo Name=XRS_Gold
		Index=6
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS-MainGold",Index=1,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-LAM-Shine",Index=2,AIndex=1,PIndex=3)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XRS10Camos.XRS10Gold-Sil-Shine",Index=3,AIndex=2,PIndex=5)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XRS_Silver'
	Camos(1)=WeaponCamo'XRS_Black'
	Camos(2)=WeaponCamo'XRS_Desert'
	Camos(3)=WeaponCamo'XRS_Purple'
	Camos(4)=WeaponCamo'XRS_CandyCane'
	Camos(5)=WeaponCamo'XRS_GoldTiger'
	Camos(6)=WeaponCamo'XRS_Gold'
}
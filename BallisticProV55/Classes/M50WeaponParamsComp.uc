class M50WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=15000.000000)
        DecayRange=(Min=1575,Max=3675)
		PenetrationEnergy=32
		RangeAtten=0.67
		Damage=23
		DamageType=Class'BallisticProV55.DTM50Assault'
		DamageTypeHead=Class'BallisticProV55.DTM50AssaultHead'
		DamageTypeArm=Class'BallisticProV55.DTM50AssaultLimb'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
		FlashScaleFactor=1.25
		Recoil=150.000000
		Chaos=0.02
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Fire2',Volume=0.900000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.0825
		FireEndAnim=
		FireAnim="AimedFire"
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.M50Grenade'
		SpawnOffset=(X=35.000000,Y=5.000000,Z=-15.000000)
		Speed=4200.000000 // 80 m/s
		MaxSpeed=4200.000000
		Damage=100
        ImpactDamage=150
		DamageRadius=1050.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		BotRefireRate=0.3
		WarnTargetPct=0.5	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50GrenFire')
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.800000
		PreFireTime=0.450000
		PreFireAnim="GrenadePrepFire"
		FireAnim="GrenadeFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=((InVal=0,OutVal=0),(InVal=0.150000,OutVal=0.03),(InVal=0.30000,OutVal=0.04),(InVal=0.40000,OutVal=0.01),(InVal=0.600000,OutVal=-0.04000),(InVal=0.800000,OutVal=0.070000),(InVal=1.00000,OutVal=0.00000)))
		YCurve=(Points=((InVal=0,OutVal=0),(InVal=0.200000,OutVal=0.210000),(InVal=0.400000,OutVal=0.350000),(InVal=0.600000,OutVal=0.600000),(InVal=0.800000,OutVal=0.7500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.04
		DeclineDelay=0.120000     
		DeclineTime=0.75
		CrouchMultiplier=0.850000
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.35
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimSpread=(Min=64,Max=512)
		ChaosDeclineTime=0.5
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		//Layout core
		LayoutName="Standard"
		Weight=30
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
        SightingTime=0.35
		SightMoveSpeedFactor=0.9
		SightPivot=(Pitch=200)
        MagAmmo=30
        InventorySize=6
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
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
	
    Layouts(0)=WeaponParams'ArenaParams'
	Camos(0)=WeaponCamo'M50_Silver'
	Camos(1)=WeaponCamo'M50_Black'
	Camos(2)=WeaponCamo'M50_Jungle'
	Camos(3)=WeaponCamo'M50_Gold'
}
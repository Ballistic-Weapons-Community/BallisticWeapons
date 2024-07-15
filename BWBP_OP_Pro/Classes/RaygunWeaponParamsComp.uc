class RaygunWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RaygunProjectile'
		SpawnOffset=(X=40.000000,Y=3.000000,Z=-15.000000)
		Speed=4500.000000
		MaxSpeed=10000.000000
		AccelSpeed=80000.000000
		Damage=50
		MaxDamageGainFactor=0.5
		DamageGainStartTime=0.05
		DamageGainEndTime=0.2
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlashAlt'
		FlashScaleFactor=2.500000
		Recoil=260.000000
		Chaos=0.070000
		BotRefireRate=0.70000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.185000
		FireAnim="FireSmall"
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		Damage=30
		DamageType=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeHead=Class'BWBP_OP_Pro.DTRaygunCharged'
		DamageTypeArm=Class'BWBP_OP_Pro.DTRaygunCharged'
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlash'
		FlashScaleFactor=4.000000
		Recoil=960.000000
		Chaos=0.320000
		BotRefireRate=0.250000
		WarnTargetPct=0.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-FireBig',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=8
		MaxHoldTime=2.50000
		FireAnim="ChargedFire"
		FireEndAnim=
		AimedFireAnim="Fire"	
		FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.140000),(InVal=0.600000,OutVal=0.120000),(InVal=0.700000,OutVal=0.120000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=0.320000),(InVal=0.450000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		ClimbTime=0.06
		DeclineDelay=0.180000
		DeclineTime=1
		HipMultiplier=1.25
 	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=1
        AimSpread=(Min=64,Max=378)
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.250000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		SightPivot=(Pitch=450)
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=Raygun_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=Raygun_Blue
		Index=1
		CamoName="Blue"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RaygunCamos.Raygun_Blue_S",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=Raygun_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RaygunCamos.Raygun_Black_S",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=Raygun_Wood
		Index=3
		CamoName="Wood"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RaygunCamos.Raygun_Wooden_S",Index=1,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=Raygun_Emerald
		Index=4
		CamoName="Emerald"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RaygunCamos.Raygun_Emerald_S",Index=1,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=Raygun_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.RaygunCamos.Raygun_GnB_S",Index=1,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'Raygun_Silver'
	//Camos(1)=WeaponCamo'Raygun_Blue'
	//Camos(2)=WeaponCamo'Raygun_Black'
	//Camos(3)=WeaponCamo'Raygun_Wood'
	//Camos(4)=WeaponCamo'Raygun_Emerald'
	//Camos(5)=WeaponCamo'Raygun_Gold'
}
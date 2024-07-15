class RaygunWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RaygunBlastProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		DamageRadius=150
		Speed=100.000000
		AccelSpeed=20000.000000
		MaxSpeed=10000.000000
		Damage=50
		MomentumTransfer=65000.000000
		MaxDamageGainFactor=0.5
		DamageGainStartTime=0.05
		DamageGainEndTime=0.2
		MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlashAlt'
		FlashScaleFactor=2.500000
		Recoil=108.000000
		Chaos=0.070000
		BotRefireRate=0.70000
		WarnTargetPct=0.200000	
		FireSound=(Sound=Sound'BWBP_OP_Sounds.Raygun.Raygun-BlastFireHeavy',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.330000
		FireAnim="FireSmall"
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ClassicSecondaryEffectParams
		Damage=10
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

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.200000
		AmmoPerFire=8
		MaxHoldTime=2.50000
		FireAnim="ChargedFire"
		FireEndAnim=
		AimedFireAnim="Fire"	
		FireEffectParams(0)=InstantEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.140000),(InVal=0.600000,OutVal=0.120000),(InVal=0.700000,OutVal=0.120000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.150000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=0.320000),(InVal=0.450000,OutVal=0.40000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.050000
		YRandFactor=0.050000
		DeclineTime=1.500000
		DeclineDelay=0.230000
 	End Object
	 
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams //Heavy SMG Handling
		ADSMultiplier=1
		AimAdjustTime=0.600000
		SprintChaos=0.300000
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		JumpChaos=0.750000
		JumpOffSet=(Pitch=1000,Yaw=-500)
		FallingChaos=0.400000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=800.000000
		ChaosTurnThreshold=185000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		SightPivot=(Pitch=450)
		//SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		//ViewOffset=(X=5.000000,Z=-5.000000)
		//ViewOffset=(X=10.000000,Y=6,Z=-1.500000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=7
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
		ViewOffset=(X=10,Y=8.00,Z=-0.5)
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
    Layouts(0)=WeaponParams'ClassicParams'
	
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
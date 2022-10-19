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

	Begin Object Class=AimParams Name=ClassicAimParams
		ADSMultiplier=1
		SprintOffset=(Pitch=-3000,Yaw=-4000)
		AimAdjustTime=0.600000
		ChaosDeclineTime=1.250000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ClassicParams
		Weight=30
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Blue
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=7)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Raygun.Raygun_Blue_S',Index=0)
		Weight=20
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Black
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=7)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Raygun.Raygun_Black_S',Index=0)
		Weight=10
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Wooden
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=7)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Raygun.Raygun_Wooden_S',Index=0)
		Weight=10
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Emerald
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=7)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Raygun.Raygun_Emerald_S',Index=0)
		Weight=3
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Gold
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=7)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_CC_Tex.Raygun.Raygun_GnB_S',Index=0)
		Weight=1
		SightPivot=(Pitch=450)
		SightOffset=(X=0.000000,Y=7.350000,Z=7.550000)
		ViewOffset=(X=5.000000,Z=-5.000000)
		PlayerSpeedFactor=1
		PlayerJumpFactor=1
        DisplaceDurationMult=0.75
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.250000
		MagAmmo=24
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
    End Object
	
    Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Blue'
	Layouts(2)=WeaponParams'ClassicParams-Black'
	Layouts(3)=WeaponParams'ClassicParams-Wooden'
	Layouts(4)=WeaponParams'ClassicParams-Emerald'
	Layouts(5)=WeaponParams'ClassicParams-Gold'
}
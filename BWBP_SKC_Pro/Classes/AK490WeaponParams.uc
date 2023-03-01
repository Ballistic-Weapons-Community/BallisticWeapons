class AK490WeaponParams extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
        DecayRange=(Min=2000,Max=6000)
		RangeAtten=0.40000
		Damage=28
		HeadMult=1.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_AK47Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Assault'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'AK47FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=192.000000
		Chaos=0.04000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.11000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//=================================================================
    // PRIMARY FIRE - AU
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryGoldEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.40000
		Damage=45
		HeadMult=1.5f
		LimbMult=0.75f
		DamageType=Class'BWBP_SKC_Pro.DT_AK47Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Assault'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'AK47FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=100.000000
		Chaos=0.04000
		WarnTargetPct=0.200000
		FireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.AK47.AK47-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryGoldFireParams
		FireInterval=0.05000
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryGoldEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.AK47Knife'
		SpawnOffset=(X=12.000000,Y=10.000000,Z=-15.000000)
		Speed=8500.000000
		MaxSpeed=8500.000000
		Damage=90
		BotRefireRate=0.300000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-KnifeFire',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.650000
		PreFireTime=0.450000
		PreFireAnim="PreKnifeFire"
		FireAnim="KnifeFire"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.25
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.05000),(InVal=0.200000,OutVal=0.060000),(InVal=0.300000,OutVal=0.10000),(InVal=0.400000,OutVal=0.150000),(InVal=0.500000,OutVal=0.170000),(InVal=0.65000000,OutVal=0.100000),(InVal=0.75.000000,OutVal=0.05000),(InVal=1.000000,OutVal=0.080000)))
		YCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.300000,OutVal=0.35000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.750000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=0.15
		DeclineTime=0.65	
	End Object
	
	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=24,Max=1024)
		SprintOffset=(Pitch=-1000,Yaw=-2048)
		ChaosDeclineTime=1.250000
		ChaosSpeedThreshold=5000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams //Standard
		Weight=20
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
	//=================================================================
	// CAMO PARAMS
	//=================================================================
	
	Begin Object Class=WeaponParams Name=ArenaParams_D //Desert
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.AK490.AK490-C-CamoDesert',Index=1)
		Weight=20
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_DE //Flecktarn
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.AK490.AK490-UC-CamoGerman',Index=1)
		Weight=10
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_V //Veteran Bloody
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.AK490.AK490-UC-CamoBlood',Index=1)
		Weight=3
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_R //Red
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.AK490.AK490-R-CamoRed',Index=1)
		Weight=3
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_B //Blue
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_TexExp.AK490.AK490-R-CamoBlue',Index=1)
		Weight=3
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object

	Begin Object Class=WeaponParams Name=ArenaParams_AU //Gold
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Shader'BWBP_SKC_TexExp.AK490.GoldAK-Shine',Index=1)
		Weight=1
		ReloadAnimRate=1.250000
		PlayerSpeedFactor=1.000000
		PlayerJumpFactor=1.000000
		InventorySize=12
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=25
		SightPivot=(Pitch=64)
		SightOffset=(X=10.000000,Y=-10.020000,Z=20.600000)
		ViewOffset=(X=-4.000000,Y=13.000000,Z=-16.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryGoldFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	
    Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_D' //Desert Camo
    Layouts(2)=WeaponParams'ArenaParams_DE' //Flecktarn Camo
    Layouts(3)=WeaponParams'ArenaParams_V' //Veteran Bloody
    Layouts(4)=WeaponParams'ArenaParams_B' //Blue Camo
    Layouts(5)=WeaponParams'ArenaParams_R' //Red Camo
    Layouts(6)=WeaponParams'ArenaParams_AU' //Gold
}
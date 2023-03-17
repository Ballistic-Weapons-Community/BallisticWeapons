class MD24WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=4000.000000)
        DecayRange=(Min=525,Max=1225)
		RangeAtten=0.5
		Damage=25
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=Class'BallisticProV55.DTMD24Pistol'
		DamageTypeHead=Class'BallisticProV55.DTMD24PistolHead'
		DamageTypeArm=Class'BallisticProV55.DTMD24Pistol'
		PenetrateForce=150
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
		FlashScaleFactor=0.750000
		Recoil=140.000000
		Chaos=0.200000
		BotRefireRate=0.900000
		WarnTargetPct=0.300000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Fire',Volume=4.000000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.13000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=1.450000	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.65
		XRandFactor=0.03000
		YRandFactor=0.03000
		DeclineTime=0.500000
		DeclineDelay=0.220000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=2
		AimAdjustTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		Weight=30
		ReloadAnimRate=1.350000
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=1
		MagAmmo=16
        InventorySize=2
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Black
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlackShine",Index=1)
		Weight=10
		ReloadAnimRate=1.350000
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=1
		MagAmmo=16
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Desert
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24DesertShine",Index=1)
		Weight=10
		ReloadAnimRate=1.350000
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=1
		MagAmmo=16
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Blue
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24BlueShine",Index=1)
		Weight=3
		ReloadAnimRate=1.350000
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=1
		MagAmmo=16
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
	
	Begin Object Class=WeaponParams Name=ArenaParams_Red
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.MD24Camos.MD24RedShine",Index=1)
		Weight=3
		ReloadAnimRate=1.350000
		SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
		ViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
		PlayerSpeedFactor=1.05
		SightingTime=0.200000
        DisplaceDurationMult=0.33
        SightMoveSpeedFactor=1
		MagAmmo=16
        InventorySize=3
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
    End Object
    
	Layouts(0)=WeaponParams'ArenaParams'
	Layouts(1)=WeaponParams'ArenaParams_Black'
	Layouts(2)=WeaponParams'ArenaParams_Desert'
	Layouts(3)=WeaponParams'ArenaParams_Blue'
	Layouts(4)=WeaponParams'ArenaParams_Red'
	
}
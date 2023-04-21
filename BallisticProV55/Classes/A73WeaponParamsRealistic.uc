class A73WeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A73Projectile'
		SpawnOffset=(X=-5.000000,Y=6.000000,Z=-4.000000)
		Speed=1350.000000
		MaxSpeed=6000.000000
		AccelSpeed=18000.000000
		Damage=67.0
		DamageRadius=72.000000
		MomentumTransfer=200.000000
		bLimitMomentumZ=False
		HeadMult=2.089552
		LimbMult=0.626865
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.300000,Slot=SLOT_Interact,bNoOverride=false)
		Recoil=000.000000
		Chaos=0.00000
		Inaccuracy=(X=72,Y=72)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.250000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	//Rapid fire for layout 2
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Rapid
		ProjectileClass=Class'BallisticProV55.A73ProjectileBal'
		SpawnOffset=(X=-5.000000,Y=6.000000,Z=-4.000000)
		Speed=850.000000
		MaxSpeed=5000.000000
		AccelSpeed=13000.000000
		Damage=37.0
		DamageRadius=72.000000
		MomentumTransfer=200.000000
		bLimitMomentumZ=False
		HeadMult=2.089552
		LimbMult=0.626865
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Pitch=1.1,Volume=1.300000,Slot=SLOT_Interact,bNoOverride=false)
		Recoil=000.000000
		Chaos=0.00000
		Inaccuracy=(X=72,Y=72)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Rapid
		FireInterval=0.110000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.000000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Rapid'
	End Object
	
	//Elite Layout, slow, powerful
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams_Elite
		ProjectileClass=Class'BallisticProV55.A73ProjectileB'
		SpawnOffset=(X=-5.000000,Y=6.000000,Z=-4.000000)
		Speed=1850.000000
		MaxSpeed=10000.000000
		AccelSpeed=18000.000000
		Damage=87.0
		DamageRadius=72.000000
		MomentumTransfer=200.000000
		bLimitMomentumZ=False
		HeadMult=2.089552
		LimbMult=0.626865
		SpreadMode=FSM_Rectangle
		FlashScaleFactor=0.700000
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=000.000000
		Chaos=0.00000
		Inaccuracy=(X=72,Y=72)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams_Elite
		AmmoPerFire=2
		FireInterval=0.135000
		BurstFireRateFactor=1.00
		FireEndAnim=
		FireAnimRate=1.100000	
	FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams_Elite'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=5.000000,Y=6.000000,Z=-4.000000)
        Speed=400.000000
        AccelSpeed=8000.000000
        MaxSpeed=4200.000000
        Damage=150.000000
        DamageRadius=200.000000
        MomentumTransfer=100000.000000
		bLimitMomentumZ=False
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.1
        Recoil=960.000000
        Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectile'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams
        AmmoPerFire=6
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=1.000000
		FireAnimRate=0.90000	
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
    End Object

	//pink layout alt
    Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Rapid
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterBal'
        SpawnOffset=(X=5.000000,Y=6.000000,Z=-4.000000)
        Speed=400.000000
        AccelSpeed=8000.000000
        MaxSpeed=4200.000000
        Damage=150.000000
        DamageRadius=200.000000
        MomentumTransfer=100000.000000
		bLimitMomentumZ=False
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.1
        Recoil=960.000000
        Chaos=0.250000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectileBal'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Rapid
        AmmoPerFire=6
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=1.000000
		FireAnimRate=0.90000	
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Rapid'
    End Object
	
	//Elite layout alt
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams_Elite
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=1500.000000
        AccelSpeed=0.000000
        MaxSpeed=2000.000000
        Damage=165.000000
        DamageRadius=280.000000
        MomentumTransfer=2000.000000
		SplashDamage=True
		RecommendSplashDamage=True
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=1460.000000
        Chaos=0.020000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power',Volume=1.400000,Slot=SLOT_Interact,bNoOverride=False)
		ProjectileClass=Class'BallisticProV55.A73PowerProjectileB'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=RealisticSecondaryFireParams_Elite
        AmmoPerFire=16
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.850000
        FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams_Elite'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.600000,OutVal=0.400000),(InVal=1.000000,OutVal=0.200000)))
		YCurve=(Points=(,(InVal=0.500000,OutVal=0.300000),(InVal=0.700000,OutVal=0.500000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.500000
		YawFactor=0.200000
		XRandFactor=0.270000
		YRandFactor=0.270000
		MaxRecoil=1280.000000
		DeclineTime=0.500000
		DeclineDelay=0.100000
		ViewBindFactor=0.200000
		ADSViewBindFactor=0.200000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=768,Max=1792)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.100000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-4096,Yaw=-2048)
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		JumpChaos=0.400000
		FallingChaos=0.400000
		ChaosDeclineTime=1.400000
		ChaosSpeedThreshold=525.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		//Layout core
		LayoutName="Standard"
		Weight=30
		AllowedCamos(0)=0
		//Attachments
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=48
		//ViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
		//SightOffset=(X=-1-.000000,Z=14.300000)
		SightPivot=(Pitch=450)
		WeaponName="A77 Plasma Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_CQC
		//Layout core
		LayoutName="CQC"
		Weight=10
		AllowedCamos(0)=1
		//Attachments
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=48
		//ViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
		//SightOffset=(X=-1-.000000,Z=14.300000)
		SightPivot=(Pitch=450)
		WeaponName="A77 Plasma Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Rapid'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Rapid'
	End Object
	
	Begin Object Class=WeaponParams Name=RealisticParams_Elite
		//Layout core
		LayoutName="Elite"
		Weight=10
		AllowedCamos(0)=2
		//Attachments
		//Function
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.21
		MagAmmo=48
		//ViewOffset=(X=-4.000000,Y=6.000000,Z=-11.000000)
		//SightOffset=(X=-1-.000000,Z=14.300000)
		SightPivot=(Pitch=450)
		WeaponName="A77 Plasma Rifle"
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams_Elite'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams_Elite'
	End Object
	
	Layouts(0)=WeaponParams'RealisticParams'
	Layouts(1)=WeaponParams'RealisticParams_CQC'
	Layouts(2)=WeaponParams'RealisticParams_Elite'
	
	//Camos =========================================
	Begin Object Class=WeaponCamo Name=A73_Blue
		Index=0
		CamoName="Blue"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=A73_Pink
		Index=1
		CamoName="Pink"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73AmmoSkin',Index=1,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2,AIndex=-1,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73SkinB',Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.A73.A73BladeShader',Index=4,AIndex=1,PIndex=1)
	End Object
	
	Begin Object Class=WeaponCamo Name=A73_Orange
		Index=2
		CamoName="Orange"
		Weight=30
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BAmmoSkin',Index=1,AIndex=3,PIndex=3)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BSkin_SD',Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BSkin_SD',Index=2,AIndex=-1,PIndex=4)
		WeaponMaterialSwaps(4)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BSkinB0',Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(5)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BBladeShader',Index=4,AIndex=1,PIndex=1)
	End Object
	
	Camos(0)=WeaponCamo'A73_Blue'
	Camos(1)=WeaponCamo'A73_Pink'
	Camos(2)=WeaponCamo'A73_Orange'
}
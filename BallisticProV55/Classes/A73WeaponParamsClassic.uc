class A73WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A73Projectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=2500.000000
		MaxSpeed=9000.000000
		AccelSpeed=60000.000000
		Damage=27.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=2.1
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=40.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.100000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams-Pink
		ProjectileClass=Class'BallisticProV55.A73ProjectileBal'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=50.000000
		MaxSpeed=3000.000000
		AccelSpeed=60000.000000
		Damage=20.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=2.0
		LimbMult=0.45
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterBal'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=40.000000
		Chaos=-1.0
		Inaccuracy=(X=8,Y=4)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams-Pink
		FireInterval=0.080000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams-Pink'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams-Orange
		ProjectileClass=Class'BallisticProV55.A73ProjectileB'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=85.000000
		MaxSpeed=4500.000000
		AccelSpeed=100000.000000
		Damage=40.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=2.5
		LimbMult=0.5
		SpreadMode=FSM_Rectangle
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=102.000000
		Chaos=-1.0
		Inaccuracy=(X=9,Y=6)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams-Orange
		AmmoPerFire=2
		FireInterval=0.157500
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams-Orange'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=70.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
		RadiusFallOffType=RFO_Linear
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=960.000000
        Chaos=0.500000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectile'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
    End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams-Pink
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterBal'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=70.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
		RadiusFallOffType=RFO_Linear
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=960.000000
        Chaos=0.500000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectileBal'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams-Pink
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams-Pink'
    End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams-Orange
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=1500.000000
        AccelSpeed=0.000000 //is this working?
        MaxSpeed=2000.000000
        Damage=90.000000
        DamageRadius=270.000000
        MomentumTransfer=2000.000000
		RadiusFallOffType=RFO_Linear
		SplashDamage=True
		RecommendSplashDamage=True
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=241.000000
        Chaos=0.020000
        FireSound=(Sound=Sound'BWBP_SKC_SoundsExp.A73E.A73E-Power',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		ProjectileClass=Class'BallisticProV55.A73PowerProjectileB'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=ClassicSecondaryFireParams-Orange
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.850000
        FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams-Orange'
    End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.270000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.170000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.100000),(InVal=1.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.200000
		YRandFactor=0.200000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.250000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.150000
		SprintChaos=0.400000
		SprintOffSet=(Pitch=-500,Yaw=-1024)
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		JumpChaos=0.400000
		FallingChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Infantry Blue"
		Weight=30
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		MagAmmo=40
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Pink
		LayoutName="Fabulous Pink"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_KBP_Tex.A73Purple.A73AmmoSkin',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_KBP_Tex.A73Purple.A73Skin_SD',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_KBP_Tex.A73Purple.A73SkinB',Index=3)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		MagAmmo=25
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		ReloadAnimRate=1.000000
		CockAnimRate=1.000000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams-Pink'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams-Pink'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-Orange
		LayoutName="Elite Orange"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BWBP_SKC_Tex.A73b.A73BAmmoSkin',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BWBP_SKC_Tex.A73b.A73BSkin_SD',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BWBP_SKC_Tex.A73b.A73BSkinB0',Index=3)
		WeaponMaterialSwaps(4)=(Material=Shader'BWBP_SKC_Tex.A73b.A73BBladeShader',Index=4)
		InventorySize=12
		SightMoveSpeedFactor=0.500000
		MagAmmo=40
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=768)
		ReloadAnimRate=0.800000
		CockAnimRate=0.800000
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams-Orange'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams-Orange'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	Layouts(1)=WeaponParams'ClassicParams-Pink'
	Layouts(2)=WeaponParams'ClassicParams-Orange'
	//Layouts(3)=WeaponParams'ClassicParams-Purple'

}
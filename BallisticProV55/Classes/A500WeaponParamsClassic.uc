class A500WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.A500Projectile'
		Speed=6000.000000
		MaxSpeed=6000.000000
		Damage=16.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=1.875
		LimbMult=0.4375
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_Fire1',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=950,Y=600)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams-E
		ProjectileClass=Class'BallisticProV55.A500EProjectile'
		Speed=6000.000000
		MaxSpeed=6000.000000
		Damage=16.0
		DamageRadius=64.000000
		MomentumTransfer=100.000000
		HeadMult=1.875
		LimbMult=0.4375
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A500EFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_Fire1',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=256.000000
		Chaos=-1.0
		Inaccuracy=(X=950,Y=600)
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams-E
		FireInterval=0.800000
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams-E'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.A500AltProjectile'
        Speed=1000.000000
        MaxSpeed=6000.000000
		Damage=80.000000
		DamageRadius=96.000000
		MomentumTransfer=1000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A500FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=0.0
		Chaos=-1.0
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.800000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams-E
		ProjectileClass=Class'BallisticProV55.A500EAltProjectile'
        Speed=1000.000000
        MaxSpeed=6000.000000
		Damage=80.000000
		DamageRadius=96.000000
		MomentumTransfer=1000.000000
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BallisticProV55.A500EFlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Reptile.Rep_AltFire',Volume=1.800000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=0.0
		Chaos=-1.0
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams-E
		FireInterval=0.800000
		AmmoPerFire=2
		BurstFireRateFactor=1.00
		FireEndAnim=	
	FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams-E'
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
		JumpChaos=0.400000
		JumpOffSet=(Pitch=-5000,Yaw=-1000)
		FallingChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=650.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Caustic Green"
		WeaponBoneScales(0)=(BoneName="Diamond",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SuperCharger",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Stands",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Glass",Slot=4,Scale=0f)
		Weight=30
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		MagAmmo=10
		ViewOffset=(X=10,Y=15,Z=-8)
		//SightOffset=(X=4.000000,Y=0.100000,Z=30.250000)
		SightPivot=(Pitch=1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-B
		LayoutName="Burning Tar"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.A500Camos.SkrithRocketLauncher_Main",Index=1)
		WeaponBoneScales(0)=(BoneName="Diamond",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SuperCharger",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Stands",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Glass",Slot=4,Scale=0f)
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		MagAmmo=10
		//SightOffset=(X=4.000000,Y=0.100000,Z=30.250000)
		SightPivot=(Pitch=1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-E
		LayoutName="Ablating Orange"
		Weight=10
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.A500Camos.Dragon_Main",Index=1)
		WeaponBoneScales(0)=(BoneName="Diamond",Slot=1,Scale=0f)
		WeaponBoneScales(1)=(BoneName="SuperCharger",Slot=2,Scale=0f)
		WeaponBoneScales(2)=(BoneName="Stands",Slot=3,Scale=0f)
		WeaponBoneScales(3)=(BoneName="Glass",Slot=4,Scale=0f)
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		SightingTime=0.30000
		MagAmmo=10
		//SightOffset=(X=4.000000,Y=0.100000,Z=30.250000)
		SightPivot=(Pitch=1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams-E'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams-E'
	End Object
	
	Begin Object Class=WeaponParams Name=ClassicParams-SSS
		LayoutName="Reverse Engineered"
		Weight=1
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.A500Camos.SSW_Main",Index=1)
		WeaponMaterialSwaps(2)=(Material=Texture'BW_Core_WeaponTex.Lighter.LightGunSkin',Index=2)
		WeaponMaterialSwaps(3)=(Material=Shader'BW_Core_WeaponTex.Lighter.LightGlassShader',Index=3)
		WeaponMaterialSwaps(4)=(Material=Shader'BW_Core_WeaponTex.DarkStar.DarkStarDiamond_SD',Index=4)
		InventorySize=7
		SightMoveSpeedFactor=0.500000
		MagAmmo=20
		ViewOffset=(X=10,Y=15,Z=-8)
		//SightOffset=(X=4.000000,Y=0.100000,Z=33.500000)
		SightPivot=(Pitch=1024)
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	//Layouts(1)=WeaponParams'ClassicParams-B'
	//Layouts(2)=WeaponParams'ClassicParams-E'
	//Layouts(3)=WeaponParams'ClassicParams-SSS'

}

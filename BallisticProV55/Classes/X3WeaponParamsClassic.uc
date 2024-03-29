class X3WeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicPrimaryEffectParams
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=35.0
		HeadMult=2.5
		LimbMult=0.6
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.300000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.250000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Slice1"
		FireAnimRate=2.500000
		FireEffectParams(0)=MeleeEffectParams'ClassicPrimaryEffectParams'
	End Object

	//Projectile
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryProjEffectParams
		Speed=3000
		Damage=35.0
		HeadMult=2.5
		LimbMult=0.6
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifeThrow',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=ClassicPrimaryFireProjParams
		FireInterval=0.250000
		AmmoPerFire=1
		BurstFireRateFactor=1.00
		FireAnimRate=2.500000
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryProjEffectParams'
	End Object
	
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=ClassicSecondaryEffectParams
		TraceRange=(Min=96.000000,Max=96.000000)
		WaterTraceRange=5000.0
		Damage=75.0
		HeadMult=1.5
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Radius=32.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.050000
	End Object
	
	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=0.300000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="BigBack1"
		FireAnim="BigStab1"
		FireEffectParams(0)=MeleeEffectParams'ClassicSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=2048.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=16,Max=2560)
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.500000
		SprintChaos=0.400000
		ChaosDeclineTime=2.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ClassicParams
		LayoutName="Silver"
		Weight=30
		
		PlayerSpeedFactor=1.150000
        InventorySize=1
		SightMoveSpeedFactor=0.500000
		MagAmmo=1
		RecoilParams(0)=RecoilParams'ClassicRecoilParams'
		AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimaryFireProjParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicPrimaryFireProjParams'
	End Object
	
	Layouts(0)=WeaponParams'ClassicParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=X3_Silver
		Index=0
		CamoName="Silver"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=X3_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.X3Camos.KnifeA1Shine",Index=1,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Camos(0)=WeaponCamo'X3_Silver'
	Camos(1)=WeaponCamo'X3_Black'

}
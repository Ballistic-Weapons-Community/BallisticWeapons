class X3WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    

    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=130.000000,Max=130.000000)
		Damage=55.0
		HeadMult=1
		LimbMult=1
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Volume=0.5,Radius=12.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.990000
		WarnTargetPct=0.300000
	End Object
	
	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.250000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		FireAnim="Slice1"
		FireAnimRate=1.800000
		FireEffectParams(0)=MeleeEffectParams'TacticalPrimaryEffectParams'
	End Object

	//Projectile
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryProjEffectParams
		Speed=3000
		Damage=55.0
		HeadMult=2.5
		LimbMult=0.6
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=Sound'BW_Core_WeaponSound.Knife.KnifeThrow',Volume=0.5,Radius=12.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.800000
		WarnTargetPct=0.100000
	End Object
	
	Begin Object Class=FireParams Name=TacticalPrimaryFireProjParams
		FireInterval=0.250000
		AmmoPerFire=1
		BurstFireRateFactor=1.00
		FireAnimRate=2.500000
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryProjEffectParams'
	End Object

	//=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=MeleeEffectParams Name=TacticalSecondaryEffectParams
		TraceRange=(Min=130.000000,Max=130.000000)
		Damage=75.0
		HeadMult=1.75
		LimbMult=0.5
		DamageType=Class'BallisticProV55.DTX3Knife'
		DamageTypeHead=Class'BallisticProV55.DTX3KnifeHead'
		DamageTypeArm=Class'BallisticProV55.DTX3KnifeLimb'
		ChargeDamageBonusFactor=1
		PenetrationEnergy=0.000000
		HookStopFactor=1.700000
		HookPullForce=100.000000
		SpreadMode=FSM_Rectangle
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.Knife.KnifeSlash',Volume=0.5,Radius=12.000000,bAtten=True)
		Recoil=0.0
		Chaos=-1.0
		BotRefireRate=0.5
		WarnTargetPct=0.5
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.750000
		AmmoPerFire=0
		BurstFireRateFactor=1.00
		PreFireAnim="BigBack1"
		FireAnim="BigStab1"
		FireEffectParams(0)=MeleeEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	//=================================================================
	// RECOIL
	//=================================================================
	
    Begin Object Class=RecoilParams Name=UniversalRecoilParams
        ViewBindFactor=0.00
        PitchFactor=0
        YawFactor=0
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=UniversalAimParams
        ViewBindFactor=0.00
        AimSpread=(Min=0,Max=0)
        ChaosDeclineTime=0.320000
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=UniversalParams
        DisplaceDurationMult=0.25
        MagAmmo=1
        InventorySize=1
        RecoilParams(0)=RecoilParams'UniversalRecoilParams'
        AimParams(0)=AimParams'UniversalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimaryFireProjParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalPrimaryFireProjParams'
    End Object 
    Layouts(0)=WeaponParams'UniversalParams'
	
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
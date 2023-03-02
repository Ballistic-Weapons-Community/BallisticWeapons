class TrenchGunWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{ 
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalExploPrimaryEffectParams
		TraceRange=(Min=2048.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.25
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		MaxHits=14 // inflict maximum of 156 damage to a single target
		Damage=12
        HeadMult=2
        LimbMult=0.67f
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		PenetrateForce=0
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=TacticalExploPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000
		TargetState="Shotgun"
	FireEffectParams(0)=ShotgunEffectParams'TacticalExploPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=TacticalElectroPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=5120.000000)
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		MaxHits=0
		Damage=7
        HeadMult=1
        LimbMult=1
		Inaccuracy=(X=150,Y=150)
		DamageType=Class'DT_TrenchGunElectro'
		DamageTypeArm=Class'DT_TrenchGunElectro'
		DamageTypeHead=Class'DT_TrenchGunElectro'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_OP_Sounds.TechGun.electro_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.5	
	End Object

	Begin Object Class=FireParams Name=TacticalElectroPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
		TargetState="Shotgun"
	FireEffectParams(0)=ShotgunEffectParams'TacticalElectroPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="WrenchPoint"
		FireAnimRate=1.25
	FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.65
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.200000
		MaxRecoil=16384.000000
		DeclineTime=0.900000
		DeclineDelay=0.400000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ViewOffset=(X=-50.000000,Y=20.000000,Z=-30.000000)
		SightOffset=(X=50.000000,Y=11.500000,Z=43.500000)
		SightPivot=(Pitch=256)
		InventorySize=20
		SightMoveSpeedFactor=0.9
		SightingTime=0.2
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Explosive Shot",Value=1.000000)
		WeaponModes(1)=(ModeName="Electro Shot",Value=1.000000)
		WeaponModes(2)=(ModeName="Ice Shot",Value=1.000000,bUnavailable=True)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalExploPrimaryFireParams'
		FireParams(1)=FireParams'TacticalElectroPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
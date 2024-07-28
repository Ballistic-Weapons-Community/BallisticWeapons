class TrenchGunWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{ 
	//=================================================================
	// PRIMARY FIRE - Explosive
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaExploPrimaryEffectParams
		TraceRange=(Min=2048.000000,Max=2560.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.250000
		TraceCount=10
		TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
		ImpactManager=Class'BallisticProV55.IM_IncendiaryBullet'
		MaxHits=14 // inflict maximum of 156 damage to a single target
		Damage=15
		Inaccuracy=(X=220,Y=220)
		DamageType=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_TrenchGunExplosive'
		PenetrateForce=0
		bPenetrate=False
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.frost_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=1024.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaExploPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000
		TargetState="ShotgunHE"
	FireEffectParams(0)=ShotgunEffectParams'ArenaExploPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE - Electric
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaElectroPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=5120.000000)
		RangeAtten=1.000000
		TraceCount=10
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
		MaxHits=0
		Damage=9
		Inaccuracy=(X=150,Y=150)
		DamageType=Class'DT_TrenchGunElectro'
		DamageTypeArm=Class'DT_TrenchGunElectro'
		DamageTypeHead=Class'DT_TrenchGunElectro'
		PenetrateForce=500
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
		FlashScaleFactor=1.500000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.TechGun.electro_Shot',Volume=1.000000,Radius=384.000000,Pitch=1.400000)	FireAnim="FireCombined"
		Recoil=512.000000
		Chaos=1.000000
		PushbackForce=1200.000000
		BotRefireRate=0.60000
		WarnTargetPct=0.500000	
	End Object

	Begin Object Class=FireParams Name=ArenaElectroPrimaryFireParams
		FireInterval=0.100000
		MaxHoldTime=0.0
		FireAnim="FireCombined"
		AimedFireAnim="SightFireCombined"
		FireAnimRate=0.800000	
		TargetState="ShotgunZap"
	FireEffectParams(0)=ShotgunEffectParams'ArenaElectroPrimaryEffectParams'
	End Object
	
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
	End Object
		
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.000000
		AmmoPerFire=0
		FireAnim="WrenchPoint"
		FireAnimRate=1.25
	FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================
	
	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.65
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.100000),(InVal=0.300000,OutVal=0.200000),(InVal=1.000000,OutVal=0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.200000
		MaxRecoil=8192.000000
		ClimbTime=0.06
		DeclineDelay=0.300000
		DeclineTime=1.5
		CrouchMultiplier=0.85
		HipMultiplier=1.25
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams	
		PlayerJumpFactor=1
		InventorySize=5
		SightMoveSpeedFactor=0.9
		SightingTime=0.350000
		DisplaceDurationMult=1
		MagAmmo=2
		WeaponModes(0)=(ModeName="Explosive Shot",Value=1.000000)
		WeaponModes(1)=(ModeName="Electro Shot",Value=1.000000)
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaExploPrimaryFireParams'
		FireParams(1)=FireParams'ArenaElectroPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
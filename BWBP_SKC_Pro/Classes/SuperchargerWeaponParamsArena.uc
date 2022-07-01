class SuperchargerWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=12000.000000,Max=13000.000000)
		RangeAtten=0.950000
		Damage=30
		DamageType=Class'BWBP_SKC_Pro.DT_AK47Assault'
		DamageTypeHead=Class'BWBP_SKC_Pro.DT_AK47AssaultHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DT_AK47Assault'
		PenetrateForce=180
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
		FlashScaleFactor=0.400000
		FireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.rpk940.rpk-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
		WarnTargetPct=0.200000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.140000
		FireEndAnim=	
		AimedFireAnim="SightFire"
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaSecondaryEffectParams
		//TracerChance=1.000000
		TraceRange=(Min=600.000000,Max=600.000000)
		RangeAtten=0.200000
		TraceCount=3
		TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
		ImpactManager=Class'BWBP_SKC_Pro.IM_GRSXXLaser'
		Damage=5
		DamageType=Class'BWBP_SKC_Pro.DTA49Shockwave'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTA49Shockwave'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTA49Shockwave'
		PenetrateForce=100
		bPenetrate=True
		MuzzleFlashClass=Class'A49FlashEmitter'
		FlashScaleFactor=1.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-SecFire',Volume=1.000000)
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.100000	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.700000
		AmmoPerFire=0
		FireAnim="FireAlt"	
	FireEffectParams(0)=ShotgunEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.000000
		CrouchMultiplier=0.800000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=256,Max=256)
		ViewBindFactor=0.200000
		ChaosDeclineTime=1.500000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		SightingTime=0.300000
		SightOffset=(X=-10.000000,Y=-0.050000,Z=16.500000)
		SightPivot=(Pitch=64)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=61,Scale=0f)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}
class HMCBeamCannonWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=50000.000000,Max=50000.000000)
		Damage=145
		DamageType=Class'BWBP_SKC_Pro.DTHMCBlast'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBlastHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBlast'
		PenetrateForce=400
		bPenetrate=True
		HookStopFactor=2.500000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Fire',Volume=1.700000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.005000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.080000
		AmmoPerFire=40
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaSecondaryEffectParams
		TraceRange=(Min=6000.000000,Max=6000.000000)
		RangeAtten=0.750000
		Damage=6
		DamageType=Class'BWBP_SKC_Pro.DTHMCBeam'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBeamHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBeam'
		PenetrateForce=200
		bPenetrate=True
		HookStopFactor=0.300000
		HookPullForce=240.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
		FlashScaleFactor=0.700000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
		Chaos=0.000000
		BotRefireRate=0.999000
		WarnTargetPct=0.010000
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.080000
		FireAnim="FireLoop"
		FireEndAnim=	
	FireEffectParams(0)=InstantEffectParams'ArenaSecondaryEffectParams'
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
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=ArenaParams
		MagAmmo=500
		SightOffset=(X=-12.000000,Z=14.300000)
		SightPivot=(Pitch=748)
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'ArenaParams'


}
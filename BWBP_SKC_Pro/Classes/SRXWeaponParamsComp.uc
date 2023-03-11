class SRXWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

	Begin Object Class=InstantEffectParams Name=ArenaStandardEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=34
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=Class'BWBP_SKC_Pro.DTSRXRifle'
		DamageTypeHead=Class'BWBP_SKC_Pro.DTSRXRifleHead'
		DamageTypeArm=Class'BWBP_SKC_Pro.DTSRXRifle'
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.2000000
		Recoil=200.000000
		Chaos=0.100000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaStandardFireParams
		FireInterval=0.185000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaStandardEffectParams'
	End Object

	Begin Object Class=InstantEffectParams Name=ArenaExplosiveEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=45
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=class'DTSRXRifle_Incendiary';
		DamageTypeHead=class'DTSRXRifleHead_Incendiary';
		DamageTypeArm=class'DTSRXRifle_Incendiary';
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=1.1000000
		Recoil=320.000000
		Chaos=0.450000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-LoudFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaExplosiveFireParams
		FireInterval=0.280000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaExplosiveEffectParams'
	End Object
	
	Begin Object Class=InstantEffectParams Name=ArenaAcidEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
        DecayRange=(Min=3000,Max=6000)
		RangeAtten=0.75
		Damage=25
        HeadMult=2.0f
        LimbMult=0.67f
		DamageType=class'DTSRXRifle_Corrosive';
		DamageTypeHead=class'DTSRXRifleHead_Corrosive';
		DamageTypeArm=class'DTSRXRifle_Corrosive';
		PenetrateForce=120
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.SRXFlashEmitter'
		FlashScaleFactor=0.4000000
		Recoil=64.000000
		Chaos=0.150000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SRSM2.SRSM2-SpecialFire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False,bAtten=True)
	End Object

	Begin Object Class=FireParams Name=ArenaAcidFireParams
		FireInterval=0.160000
		BurstFireRateFactor=0.30
		FireEndAnim=
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaAcidEffectParams'
	End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

	Begin Object Class=FireEffectParams Name=ArenaSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Attach AMP"
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'ArenaSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.12),(InVal=0.85,OutVal=0.1),(InVal=1,OutVal=0.3)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		XRandFactor=0.15
		YRandFactor=0.15
		MaxRecoil=3072.000000
		DeclineTime=0.60000
		DeclineDelay=0.400000
	End Object

	Begin Object Class=RecoilParams Name=ArenaExplosiveRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.2
		MaxRecoil=3072.000000
		DeclineTime=1.20000
		DeclineDelay=1.000000
	End Object

	Begin Object Class=RecoilParams Name=ArenaAcidRecoilParams
		ViewBindFactor=0.1
		XCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.3),(InVal=0.4,OutVal=0.25),(InVal=0.5,OutVal=0.16),(InVal=0.7,OutVal=0.3),(InVal=0.85,OutVal=-0.1),(InVal=1,OutVal=-0.4)))
		YCurve=(Points=(,(InVal=0.1,OutVal=0.18),(InVal=0.2,OutVal=0.45),(InVal=0.4,OutVal=0.32),(InVal=0.5,OutVal=0.6),(InVal=0.7,OutVal=0.75),(InVal=0.85,OutVal=0.85),(InVal=1,OutVal=0.88)))
		YRandFactor=0.08
		MaxRecoil=3072.000000
		DeclineTime=0.30000
		DeclineDelay=0.300000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimSpread=(Min=64,Max=768)
		ChaosDeclineTime=0.75
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.200000
		SightPivot=(Pitch=-128,Yaw=16)
		SightOffset=(X=-10.000000,Y=-0.670000,Z=27.200000)
		ViewOffset=(X=-2.000000,Y=10.000000,Z=-20.000000)
		MagAmmo=20
        InventorySize=6
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		RecoilParams(1)=RecoilParams'ArenaExplosiveRecoilParams'
		RecoilParams(2)=RecoilParams'ArenaAcidRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaStandardFireParams'
		FireParams(1)=FireParams'ArenaExplosiveFireParams'
		FireParams(2)=FireParams'ArenaAcidFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
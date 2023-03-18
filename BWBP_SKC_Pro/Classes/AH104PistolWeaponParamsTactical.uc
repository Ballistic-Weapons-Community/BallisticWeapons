class AH104PistolWeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{
   //=================================================================
    // PRIMARY FIRE
    //=================================================================	
		Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
			DecayRange=(Min=1575,Max=2560)
			PenetrationEnergy=48 
			Damage=80.000000
            HeadMult=2f
            LimbMult=0.67f
			RangeAtten=0.5
			DamageType=Class'BWBP_SKC_Pro.DT_AH104Pistol'
			DamageTypeHead=Class'BWBP_SKC_Pro.DT_AH104PistolHead'
			DamageTypeArm=Class'BWBP_SKC_Pro.DT_AH104Pistol'
			PenetrateForce=200
			bPenetrate=True
			MuzzleFlashClass=Class'BallisticProV55.M925FlashEmitter'
			FlashScaleFactor=0.900000
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-Super',Volume=7.100000)
			Recoil=1024.000000
			Chaos=0.2
			Inaccuracy=(X=16,Y=16)
			WarnTargetPct=0.400000
			BotRefireRate=0.7
		End Object

		Begin Object Class=FireParams Name=TacticalPrimaryFireParams
			AimedFireAnim="SightFire"
			FireEndAnim=
			FireInterval=0.35
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
		End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
		Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
			FireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
			Recoil=0.01
			Chaos=0.05
			Damage=20.000000
			DamageRadius=192
			Inaccuracy=(X=0,Y=0)
			BotRefireRate=0.300000
		End Object
		
		Begin Object Class=FireParams Name=TacticalSecondaryFireParams
			FireInterval=0.090000
			AmmoPerFire=0
			BurstFireRateFactor=1.00
			FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
		End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.1,OutVal=0.05),(InVal=0.2,OutVal=0.12),(InVal=0.3,OutVal=0.08),(InVal=0.40000,OutVal=0.05),(InVal=0.50000,OutVal=0.10000),(InVal=0.600000,OutVal=0.170000),(InVal=0.700000,OutVal=0.24),(InVal=0.800000,OutVal=0.30000),(InVal=1.000000,OutVal=0.4)))
        YCurve=(Points=(,(InVal=0.1,OutVal=0.1),(InVal=0.2,OutVal=0.220000),(InVal=0.300000,OutVal=0.300000),(InVal=0.400000,OutVal=0.4500),(InVal=0.5,OutVal=0.5500),(InVal=0.600000,OutVal=0.620000),(InVal=0.750000,OutVal=0.770000),(InVal=1.000000,OutVal=1.00000)))
		XRandFactor=0.150000
		YRandFactor=0.150000
		MaxRecoil=8192.000000
		DeclineTime=1.000000
		DeclineDelay=0.400000
		ViewBindFactor=0.300000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=1024)
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.7000
		ViewBindFactor=0.300000
		SprintChaos=0.400000
		ChaosDeclineTime=0.450000
		ChaosSpeedThreshold=300.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="RDS",Slot=50,Scale=0f)
		InventorySize=5
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.6
		MagAmmo=9
		ViewOffset=(X=10.000000,Y=10.000000,Z=-18.000000)
		SightOffset=(X=-30.000000,Y=-0.800000,Z=23.000000)
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'TacticalParams'
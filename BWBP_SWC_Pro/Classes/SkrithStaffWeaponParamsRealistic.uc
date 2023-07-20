class SkrithStaffWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{

	//=================================================================
	// PRIMARY FIRE PARAMS WEAPON MODE 0 - RAPID FIRE
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticRapidPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.SkrithStaffProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=85.000000
		MaxSpeed=4500.000000
		AccelSpeed=100000.000000
		Damage=40
		HeadMult=2.2f
		LimbMult=0.5f
		DamageRadius=96.000000
		MomentumTransfer=150.000000
		MuzzleFlashClass=Class'BWBP_SWC_Pro.SkrithStaffBoltFlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=102.000000
		Chaos=0.005000
		WarnTargetPct=0.200000	
	End Object

	Begin Object Class=FireParams Name=RealisticRapidPrimaryFireParams
		FireInterval=0.157000
		AmmoPerFire=2
		FireEndAnim=
		AimedFireAnim="FireSight"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticRapidPrimaryEffectParams'
	End Object
	
	//=================================================================
	// PRIMARY FIRE PARAMS WEAPON MODE 1 - BOMBS
	//=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSlowPrimaryEffectParams
		ProjectileClass=Class'BWBP_SWC_Pro.SkrithStaffPower'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
		Speed=90.000000
		MaxSpeed=2000.000000
		AccelSpeed=16000.000000
		Damage=90
		DamageRadius=270.000000
		MomentumTransfer=150.000000
		MuzzleFlashClass=Class'BWBP_SWC_Pro.SkrithStaffBoltFlashEmitter'
		FlashScaleFactor=0.200000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=241.000000
		Chaos=0.020000
		WarnTargetPct=0.200000	
		RadiusFallOffType=RFO_Linear
	End Object

	Begin Object Class=FireParams Name=RealisticSlowPrimaryFireParams
		FireInterval=0.850000
		AmmoPerFire=8
		FireEndAnim=
		FireAnim="FireBomb"
		AimedFireAnim="FireSight"	
	FireEffectParams(0)=ProjectileEffectParams'RealisticSlowPrimaryEffectParams'
	End Object
		
	//=================================================================
	// SECONDARY FIRE
	//=================================================================	
	
	Begin Object Class=InstantEffectParams Name=RealisticSecondaryEffectParams
		TraceRange=(Min=10000.000000,Max=10000.000000)
		Damage=8
		DamageType=Class'BWBP_SWC_Pro.DT_SkrithStaff'
		DamageTypeHead=Class'BWBP_SWC_Pro.DT_SkrithStaffHead'
		DamageTypeArm=Class'BWBP_SWC_Pro.DT_SkrithStaff'
		PenetrateForce=200
		bPenetrate=True
		MuzzleFlashClass=Class'BWBP_SKC_Pro.XM20FlashEmitter'
		FlashScaleFactor=0.100000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1.000000
		Chaos=0.010000
		BotRefireRate=0.99
		WarnTargetPct=0.2
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=0.085000
		FireAnim=
		FireLoopAnim="SecFireLoop"
		FireEndAnim="SecFireEnd"
		AimedFireAnim="SecFireLoopSight"	
	FireEffectParams(0)=InstantEffectParams'RealisticSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.200000),(InVal=0.600000,OutVal=-0.200000),(InVal=0.700000,OutVal=-0.250000),(InVal=1.000000,OutVal=0.100000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.090000),(InVal=0.150000,OutVal=0.150000),(InVal=0.250000,OutVal=0.120000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.050000),(InVal=500000.000000,OutVal=0.500000)))
		PitchFactor=0.800000
		YawFactor=0.800000
		XRandFactor=0.300000
		YRandFactor=0.300000
		MaxRecoil=1024.000000
		DeclineTime=1.500000
		ViewBindFactor=0.450000
		HipMultiplier=1.000000
		CrouchMultiplier=0.600000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=16,Max=2048)
		CrouchMultiplier=0.600000
		ADSMultiplier=0.700000
		ViewBindFactor=0.350000
		SprintChaos=0.400000
		AimDamageThreshold=75.000000
		ChaosDeclineTime=2.000000
		ChaosSpeedThreshold=600.000000
	End Object
    
	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=RealisticParams
		SightingTime=0.550000	 
        MagAmmo=80       
        InventorySize=7
        SightMoveSpeedFactor=0.8
		SightOffset=(X=-20.000000,Y=0.310000,Z=12.500000)
		SightPivot=(Pitch=450)
		ViewOffset=(X=9.000000,Y=4.000000,Z=-7.000000)
		RecoilParams(0)=RecoilParams'RealisticRecoilParams'
		AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticRapidPrimaryFireParams'
		FireParams(1)=FireParams'RealisticSlowPrimaryFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
	End Object
	Layouts(0)=WeaponParams'RealisticParams'


}
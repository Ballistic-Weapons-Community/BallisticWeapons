class HydraWeaponParamsClassic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=140.000000
		DamageRadius=400.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=ClassicPrimaryFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicPrimarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=140.000000
		DamageRadius=400.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ClassicPrimarySFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicPrimarySEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSwoopRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=140.000000
		DamageRadius=400.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondaryFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ClassicSecondarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=140.000000
		DamageRadius=400.000000
		MomentumTransfer=90000.000000
		bLimitMomentumZ=False
		HeadMult=1.0
		LimbMult=1.0
		SpreadMode=FSM_Rectangle
		RadiusFallOffType=RFO_Linear
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ClassicSecondarySFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ClassicSecondarySEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ClassicRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=8192.000000
		DeclineTime=3.000000
		ViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ClassicAimParams
		AimSpread=(Min=512,Max=2560)
		AimAdjustTime=1.000000
		OffsetAdjustTime=0.650000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.400000
		ViewBindFactor=0.400000
		SprintChaos=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpChaos=0.500000
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		FallingChaos=0.500000
		ChaosDeclineTime=5.000000
		ChaosSpeedThreshold=320.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ClassicParams
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
	    SightOffset=(X=-30.000000,Y=-0.750000,Z=16.000000)
		SightPivot=(Pitch=512)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=100,Scale=0f)
		SightingTime=0.650000	
        DisplaceDurationMult=1.25
        MagAmmo=6
		InventorySize=14
		SightMoveSpeedFactor=0.5
        RecoilParams(0)=RecoilParams'ClassicRecoilParams'
        AimParams(0)=AimParams'ClassicAimParams'
		FireParams(0)=FireParams'ClassicPrimaryFireParams'
		FireParams(1)=FireParams'ClassicPrimarySFireParams'
		AltFireParams(0)=FireParams'ClassicSecondaryFireParams'
		AltFireParams(1)=FireParams'ClassicSecondarySFireParams'
    End Object 
    Layouts(0)=WeaponParams'ClassicParams'
}
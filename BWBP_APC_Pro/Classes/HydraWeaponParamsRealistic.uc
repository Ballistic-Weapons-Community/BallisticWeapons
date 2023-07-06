class HydraWeaponParamsRealistic extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=8000.000000
		MaxSpeed=45000.000000
		AccelSpeed=10000.000000
		Damage=240
		DamageRadius=340.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=RealisticPrimaryFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=RealisticPrimarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=8000.000000
		MaxSpeed=45000.000000
		AccelSpeed=10000.000000
		Damage=240
		DamageRadius=340.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=RealisticPrimarySFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticPrimarySEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSwoopRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=8000.000000
		MaxSpeed=45000.000000
		AccelSpeed=10000.000000
		Damage=240
		DamageRadius=340.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=RealisticSecondaryFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=RealisticSecondarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=8000.000000
		MaxSpeed=45000.000000
		AccelSpeed=10000.000000
		Damage=240
		DamageRadius=340.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=512.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=RealisticSecondarySFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'RealisticSecondarySEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=RealisticRecoilParams
		XCurve=(Points=(,(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.200000
		XRandFactor=0.500000
		YRandFactor=0.500000
		MaxRecoil=8192.000000
		ViewBindFactor=0.500000
		ADSViewBindFactor=0.500000
		HipMultiplier=1.000000
		CrouchMultiplier=0.700000
		bViewDecline=True
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=RealisticAimParams
		AimSpread=(Min=1536,Max=3072) //Super Heavy
		AimAdjustTime=0.600000
		CrouchMultiplier=0.700000
		ADSMultiplier=0.700000
		ViewBindFactor=0.400000
		SprintChaos=0.500000
		SprintOffSet=(Pitch=-7000,Yaw=-3500)
		JumpChaos=0.500000
		JumpOffSet=(Pitch=-7000)
		FallingChaos=0.500000
		ChaosDeclineTime=4.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=RealisticParams
	    SightOffset=(X=-30.000000,Y=-0.750000,Z=16.000000)
		SightPivot=(Pitch=512)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=100,Scale=0f)
		SightingTime=0.650000	
        DisplaceDurationMult=1.25
        MagAmmo=6
		InventorySize=10
		SightMoveSpeedFactor=0.5
		PlayerSpeedFactor=0.750000
		PlayerJumpFactor=0.750000
		WeaponName="M11-X Hydra 90mm Multiple Missile Launcher"
        RecoilParams(0)=RecoilParams'RealisticRecoilParams'
        AimParams(0)=AimParams'RealisticAimParams'
		FireParams(0)=FireParams'RealisticPrimaryFireParams'
		FireParams(1)=FireParams'RealisticPrimarySFireParams'
		AltFireParams(0)=FireParams'RealisticSecondaryFireParams'
		AltFireParams(1)=FireParams'RealisticSecondarySFireParams'
    End Object 
    Layouts(0)=WeaponParams'RealisticParams'
}
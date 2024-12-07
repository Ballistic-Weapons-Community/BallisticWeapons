class HydraWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=120
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=120
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimarySFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimarySEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSwoopRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=120
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=120
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_APC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=TacticalSecondarySFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondarySEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
     	YawFactor=0.000000
     	DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.4
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=512,Max=2560)
		ChaosSpeedThreshold=1000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
	    SightOffset=(X=-30.000000,Y=-0.750000,Z=16.000000)
		SightPivot=(Pitch=512)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=100,Scale=0f)
		SightingTime=0.650000	
        DisplaceDurationMult=1.25
        MagAmmo=6
		InventorySize=8
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.8
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		FireParams(1)=FireParams'TacticalPrimarySFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
		AltFireParams(1)=FireParams'TacticalSecondarySFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
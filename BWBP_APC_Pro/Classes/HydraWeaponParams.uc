class HydraWeaponParams extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
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
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire',Volume=1.700000)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=120
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=384.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimarySFireParams
		FireInterval=0.800000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimarySEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSwoopRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=90
		DamageRadius=448.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondarySEffectParams
		ProjectileClass=Class'BWBP_APC_Pro.HydraSeekerRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=90
		DamageRadius=448.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BWBP_APC_Pro.HydraFlashEmitter'
		Recoil=64.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=SoundGroup'BWBP_CC_Sounds.Launcher.Launcher-Fire')
	End Object

	Begin Object Class=FireParams Name=ArenaSecondarySFireParams
		FireInterval=1.200000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondarySEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
     	YawFactor=0.000000
     	DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
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

    Begin Object Class=WeaponParams Name=ArenaParams
	    SightOffset=(X=-10.000000,Y=-10.000000,Z=15.000000)
		ViewOffset=(X=7.000000,Y=11.000000,Z=-7.000000)
		WeaponBoneScales(0)=(BoneName="Scope",Slot=100,Scale=0f)
		SightingTime=0.650000	
        DisplaceDurationMult=1.25
        MagAmmo=6
		InventorySize=8
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.8
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		FireParams(1)=FireParams'ArenaPrimarySFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
		AltFireParams(1)=FireParams'ArenaSecondarySFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
}
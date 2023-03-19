class G5WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BallisticProV55.G5Rocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=25000.000000
		AccelSpeed=5000.000000
		Damage=150
		DamageRadius=768.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=64.000000
		Chaos=0.5
		BotRefireRate=0.5
		WarnTargetPct=0.8	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Fire1')
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.800000
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=FireEffectParams Name=TacticalSecondaryEffectParams
		BotRefireRate=0.300000
        EffectString="Detonate"
	End Object
	
	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.200000
		AmmoPerFire=0
		FireEffectParams(0)=FireEffectParams'TacticalSecondaryEffectParams'
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
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=256,Max=2048)
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
		SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		ViewOffset=(X=10.000000,Y=10.5,Z=-6.000000)
		SightingTime=0.5
        DisplaceDurationMult=1.25
        MagAmmo=2        
		InventorySize=8
		PlayerSpeedFactor=0.9
        PlayerJumpFactor=0.9
		SightMoveSpeedFactor=0.4
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
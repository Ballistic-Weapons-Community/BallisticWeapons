class MGLWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		Damage=200
        ImpactDamage=200
		DamageRadius=768.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=768.000000
		Chaos=0.650000
		BotRefireRate=0.5
		WarnTargetPct=0.75	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-Fire',Volume=9.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.850000
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=GrenadeEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.MGLGrenadeRemote'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=4500.000000
		Damage=200
        ImpactDamage=200
		DamageRadius=768.000000
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=768.000000
		Chaos=0.650000
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.MGL.MGL-Fire',Volume=9.200000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		AimedFireAnim="SightFire"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		XCurve=(Points=(,(InVal=0.200000,OutVal=-0.100000),(InVal=0.300000,OutVal=-0.200000),(InVal=1.000000,OutVal=-0.300000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.5),(InVal=1.000000,OutVal=1.000000)))
		YawFactor=0.000000
		XRandFactor=0.400000
		YRandFactor=0.400000
		MaxRecoil=6144.000000
		DeclineDelay=0.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=1024)
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		ChaosDeclineTime=1.000000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		SightPivot=(Pitch=512)
		SightOffset=(X=-30.000000,Y=12.450000,Z=14.850000)
		ViewOffset=(X=5.000000,Y=-1.000000,Z=-7.000000)
		PlayerSpeedFactor=0.9
		InventorySize=24
		SightMoveSpeedFactor=0.9
		SightingTime=0.3
		DisplaceDurationMult=1
		MagAmmo=6
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
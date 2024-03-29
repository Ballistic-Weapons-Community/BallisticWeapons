class KF8XWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.KF8XToxicBolt'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=7000.000000
		MaxSpeed=7000.000000
		Damage=30.000000
		HeadMult=3.25
		LimbMult=0.75
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XBow.XBow-Fire',Volume=1.000000,Radius=32.000000)
		Recoil=0.0
		Chaos=0.15
		BotRefireRate=0.500000
		WarnTargetPct=0.150000	
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.500000
		PreFireAnim=
		FireAnim="FireCycleRotate"
		FireAnimRate=1.00000	
		FireEffectParams(0)=TacticalPrimaryEffectParams
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.5
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=4096.000000
		DeclineTime=1.500000
		DeclineDelay=0.5
		MaxMoveMultiplier=1
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=384,Max=1280)
		SprintOffset=(Pitch=-2048,Yaw=-1024)
		ADSMultiplier=0.7
		JumpChaos=0.200000
		AimAdjustTime=0.60
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		InventorySize=5
		SightMoveSpeedFactor=0.35
		SightingTime=0.4	
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=8
		// adjustable 2-4-8x
		ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=8
		ZoomStages=2
        RecoilParams(0)=TacticalRecoilParams
        AimParams(0)=TacticalAimParams
		FireParams(0)=TacticalPrimaryFireParams
    End Object 
    Layouts(0)=TacticalParams
}
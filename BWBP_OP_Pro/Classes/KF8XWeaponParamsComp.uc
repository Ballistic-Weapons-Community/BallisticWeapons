class KF8XWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.KF8XToxicBolt'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=9000.000000
		MaxSpeed=9000.000000
		Damage=40.000000
		HeadMult=2.00
		LimbMult=0.85
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XBow.XBow-Fire',Volume=1.000000,Radius=32.000000)
		Recoil=0.0
		Chaos=0.15
		BotRefireRate=0.500000
		WarnTargetPct=0.150000	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=1.500000
		PreFireAnim=
		FireAnim="FireCycleRotate"
		FireAnimRate=1.00000	
		FireEffectParams(0)=ArenaPrimaryEffectParams
	End Object

	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.5
		XRandFactor=0.050000
		YRandFactor=0.050000
		MaxRecoil=4096.000000
		DeclineTime=1.500000
		DeclineDelay=0.500000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.25
		JumpChaos=0.200000
		AimAdjustTime=0.450000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerJumpFactor=1
		InventorySize=5
		SightMoveSpeedFactor=0.6
		SightingTime=0.4	
		ScopeScale=0.7
		DisplaceDurationMult=1
		MagAmmo=8
		// variable 2-4-8x
		ZoomType=ZT_Logarithmic
		MinZoom=2
		MaxZoom=8
		ZoomStages=2
        RecoilParams(0)=ArenaRecoilParams
        AimParams(0)=ArenaAimParams
		FireParams(0)=ArenaPrimaryFireParams
    End Object 
    Layouts(0)=ArenaParams
}
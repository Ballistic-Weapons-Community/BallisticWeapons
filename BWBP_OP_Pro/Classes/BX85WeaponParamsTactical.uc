class BX85WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
	//=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=90
        HeadMult=2.5
        LimbMult=0.67f
		DamageType=Class'DTBX85Bolt'
		DamageTypeHead=Class'DTBX85BoltHead'
		DamageTypeArm=Class'DTBX85Bolt'
		Chaos=0.150000
		BotRefireRate=0.5
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BWBP_OP_Sounds.XBow.XBow-Fire',Volume=1.000000,Radius=64.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.500000
		PreFireAnim=
		FireAnim="FireCycleRotate"
		FireAnimRate=2.00000	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
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
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=64,Max=512)
		ADSMultiplier=0.35
		JumpChaos=0.200000
		AimAdjustTime=0.450000
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		InventorySize=5
		SightMoveSpeedFactor=0.5
		SightingTime=0.5
		DisplaceDurationMult=1
		MagAmmo=8
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
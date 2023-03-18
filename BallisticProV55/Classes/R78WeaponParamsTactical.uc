class R78WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=30000.000000,Max=30000.000000)
		Damage=100
        HeadMult=2.25
        LimbMult=0.85f
		DamageType=Class'BallisticProV55.DTR78Rifle'
		DamageTypeHead=Class'BallisticProV55.DTR78RifleHead'
		DamageTypeArm=Class'BallisticProV55.DTR78Rifle'
		PDamageFactor=0.800000
		MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
		Recoil=378.000000
		Chaos=0.5
		BotRefireRate=0.4
		WarnTargetPct=0.5
		FireSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Fire',Volume=2.000000,Radius=1024.000000)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=1.1
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.2
		CrouchMultiplier=0.600000
		XCurve=(Points=(,(InVal=0.1,OutVal=0.12),(InVal=0.2,OutVal=0.16),(InVal=0.40000,OutVal=0.250000),(InVal=0.50000,OutVal=0.30000),(InVal=0.600000,OutVal=0.370000),(InVal=0.700000,OutVal=0.4),(InVal=0.800000,OutVal=0.50000),(InVal=1.000000,OutVal=0.55)))
		XRandFactor=0.10000
		YRandFactor=0.10000
		DeclineDelay=1.25
		DeclineTime=1.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.600000
		AimSpread=(Min=256,Max=2048)
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	
	
	Begin Object Class=WeaponParams Name=TacticalParams
		ReloadAnimRate=1.250000
		ViewOffset=(X=6.000000,Y=8.000000,Z=-11.500000)
		SightPivot=(Roll=-1024)
		SightOffset=(X=10.000000,Y=-1.600000,Z=17.000000)
		SightingTime=0.45
		SightMoveSpeedFactor=0.5
		MagAmmo=7
        InventorySize=5
        ZoomType=ZT_Logarithmic
		WeaponBoneScales(0)=(BoneName="Silencer",Slot=78,Scale=0f)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
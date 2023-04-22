class RCS715WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ShotgunEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4000.000000,Max=6000.000000)
        DecayRange=(Min=788,Max=1838)
		RangeAtten=0.3
		TraceCount=7
		TracerClass=Class'BWBP_OP_Pro.TraceEmitter_RCSShotgun'
		ImpactManager=Class'BallisticProV55.IM_Shell'
		Damage=10
		DamageType=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		DamageTypeHead=Class'BWBP_OP_Pro.DT_RCS715ShotgunHead'
		DamageTypeArm=Class'BWBP_OP_Pro.DT_RCS715Shotgun'
		PenetrateForce=100
		bPenetrate=True
		PushbackForce=150.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=1.000000
		Recoil=256.000000
		Chaos=0.500000
		BotRefireRate=0.900000
		WarnTargetPct=0.500000	
		Inaccuracy=(X=256,Y=256)
		FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.XMV-850.XMV-Fire-3')
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.200000
		FireEndAnim=
		AimedFireAnim="SightFire"
		FireAnimRate=2.50000	
		FireEffectParams(0)=ShotgunEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_OP_Pro.RCS715Projectile'
		SpawnOffset=(X=20.000000,Y=9.000000,Z=-9.000000)
		Speed=4200.000000
		MaxSpeed=15000.000000
		AccelSpeed=3000.000000
		Damage=60
		DamageRadius=256.000000
		MomentumTransfer=0.000000
		PushbackForce=180.000000
		MuzzleFlashClass=Class'BWBP_SKC_Pro.MK781FlashEmitter'
		FlashScaleFactor=0.500000
		Recoil=650.000000
		Chaos=0.450000
		BotRefireRate=0.600000
		WarnTargetPct=0.400000
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.GL-Fire',Volume=1.300000)	
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=0.650000
		AmmoPerFire=0
		FireAnim="GLFire"
		FireAnimRate=1.250000	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.4
		XCurve=(Points=(,(InVal=0.200000,OutVal=0.070000),(InVal=0.300000,OutVal=0.150000),(InVal=0.500000,OutVal=0.250000),(InVal=0.750000,OutVal=0.30000),(InVal=1.000000,OutVal=0.350000)))
		YCurve=(Points=(,(InVal=0.300000,OutVal=0.500000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.100000
		YRandFactor=0.100000
		MaxRecoil=8192.000000
		ClimbTime=0.05
		DeclineDelay=0.25
		DeclineTime=1.0	
		CrouchMultiplier=0.85
		HipMultiplier=1.5
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=768)
        ADSMultiplier=0.6
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		JumpOffset=(Pitch=-1024,Yaw=-1024)
        ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ReloadAnimRate=1.25
		CockAnimRate=1.25
		PlayerSpeedFactor=0.95
		InventorySize=6
		SightMoveSpeedFactor=0.8
		SightingTime=0.550000
		DisplaceDurationMult=1
		MagAmmo=15
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=RCS_Red
		Index=0
		CamoName="Red"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Yellow
		Index=1
		CamoName="Yellow"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainYellowShine",Index=1,AIndex=0,PIndex=39)
		Weight=20
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainJungleShine",Index=1,AIndex=0,PIndex=39)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Arctic
		Index=3
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainArcticShine",Index=1,AIndex=0,PIndex=39)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=RCS_Clown
		Index=4
		CamoName="Clown"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.BusterCamos.Blaster-MainClownShine",Index=1,AIndex=0,PIndex=39)
		Weight=3
	End Object
	
	Camos(0)=WeaponCamo'RCS_Red'
	Camos(1)=WeaponCamo'RCS_Yellow'
	Camos(2)=WeaponCamo'RCS_Jungle'
	Camos(3)=WeaponCamo'RCS_Arctic'
	Camos(4)=WeaponCamo'RCS_Clown'
	//Camos(5)=WeaponCamo'RCS_Gold'
}
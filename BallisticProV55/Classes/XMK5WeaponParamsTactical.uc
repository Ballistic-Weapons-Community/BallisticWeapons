class XMK5WeaponParamsTactical extends BallisticWeaponParams;

static simulated function SetAttachmentParams(BallisticAttachment BWA)
{
	BWA.ModeInfos[0].TracerChance = 0;
}

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=TacticalPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		Inaccuracy=(X=72,Y=72)
		RangeAtten=0.5
		Damage=24
        HeadMult=2.75f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
        PenetrationEnergy=16
		PenetrateForce=175
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=190.000000
		Chaos=0.035000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.XMK5Dart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		Damage=30
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim=
		FireAnim="Fire2"	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.35
		ADSViewBindFactor=0.5
		EscapeMultiplier=1.5
		XCurve=(Points=(,(InVal=0.12,OutVal=0.00),(InVal=0.33,OutVal=0.04),(InVal=0.45,OutVal=-0.06),(InVal=0.58,OutVal=0.00),(InVal=0.8,OutVal=-0.04),(InVal=1.0,OutVal=0.0)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.250000),(InVal=0.30000,OutVal=0.350000),(InVal=0.450000,OutVal=0.5),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		ClimbTime=0.04
		DeclineTime=0.75
		DeclineDelay=0.13
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.50000
		AimSpread=(Min=256,Max=1024)
        ADSMultiplier=0.5
		AimDamageThreshold=190.000000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		DisplaceDurationMult=0.75
        SightMoveSpeedFactor=0.6
		MagAmmo=32
		SightingTime=0.25
        InventorySize=4
		RecoilParams(0)=RecoilParams'TacticalRecoilParams'
		AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=XMK5_Tan
		Index=0
		CamoName="Brown"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Desert
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainDesert",Index=1,AIndex=1,PIndex=1)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Jungle
		Index=2
		CamoName="Jungle"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainJungle",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-ShieldDark",Index=2,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Red
		Index=3
		CamoName="Red"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGMain",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGShield",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGClip",Index=3,AIndex=2,PIndex=2)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Blast
		Index=4
		CamoName="Blast"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainOrk",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGShield",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.SMGClip",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-DarterOrk",Index=4,AIndex=3,PIndex=3) //aka dOrk
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=XMK5_Gold
		Index=5
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MainGold",Index=1,AIndex=1,PIndex=1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-ShieldDark",Index=2,AIndex=0,PIndex=0)
		WeaponMaterialSwaps(3)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-MagDark",Index=3,AIndex=2,PIndex=2)
		WeaponMaterialSwaps(4)=(MaterialName="BWBP_Camos_Tex.XMk5Camos.XMK5-DarterDark",Index=4,AIndex=3,PIndex=3)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'XMK5_Tan'
	Camos(1)=WeaponCamo'XMK5_Jungle'
	Camos(2)=WeaponCamo'XMK5_Desert'
	Camos(3)=WeaponCamo'XMK5_Red'
	Camos(4)=WeaponCamo'XMK5_Blast'
	Camos(5)=WeaponCamo'XMK5_Gold'
}
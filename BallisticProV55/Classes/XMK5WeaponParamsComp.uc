class XMK5WeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=InstantEffectParams Name=ArenaPrimaryEffectParams
		TraceRange=(Min=4096.000000,Max=4096.000000)
        DecayRange=(Min=788,Max=1838)
		PenetrationEnergy=16
		RangeAtten=0.5
		Damage=16
        HeadMult=2.25f
        LimbMult=0.75f
		DamageType=Class'BallisticProV55.DTXMK5SubMachinegun'
		DamageTypeHead=Class'BallisticProV55.DTXMK5SubMachinegunHead'
		DamageTypeArm=Class'BallisticProV55.DTXMK5SubMachinegun'
		PenetrateForce=175
		bPenetrate=True
		MuzzleFlashClass=Class'BallisticProV55.XMk5FlashEmitter'
		FlashScaleFactor=0.800000
		Recoil=110.000000
		Chaos=0.035000
		WarnTargetPct=0.200000
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Fire1',Volume=1.350000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.08000
		FireEndAnim=
		AimedFireAnim="AimedFire"	
		FireEffectParams(0)=InstantEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BallisticProV55.XMK5Dart'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=10000.000000
		Damage=30
		BotRefireRate=0.300000
		WarnTargetPct=0.300000	
		FireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=2.000000
		PreFireAnim=
		FireAnim="Fire2"	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
		ViewBindFactor=0.35
		XCurve=(Points=(,(InVal=0.15,OutVal=0.08),(InVal=0.3,OutVal=0.18),(InVal=0.4,OutVal=0.22),(InVal=0.6,OutVal=0.27),(InVal=0.8,OutVal=0.28),(InVal=1.0,OutVal=0.35)))
		YCurve=(Points=(,(InVal=0.150000,OutVal=0.250000),(InVal=0.30000,OutVal=0.350000),(InVal=0.450000,OutVal=0.500000),(InVal=0.600000,OutVal=0.600000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.05000
		YRandFactor=0.05000
		DeclineTime=0.5
		DeclineDelay=0.125000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		AimAdjustTime=0.350000
		AimSpread=(Min=64,Max=378)
        ADSMultiplier=0.4
		AimDamageThreshold=190.000000
		ChaosDeclineTime=0.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		WeaponBoneScales(0)=(BoneName="SightFront",Slot=18,Scale=0f)
		SightPivot=(Pitch=200)
		SightOffset=(X=1.000000,Z=17.750000)
		ViewOffset=(X=2.000000,Y=8.000000,Z=-10.000000)
		DisplaceDurationMult=0.75
		SightMoveSpeedFactor=0.9
		MagAmmo=32
		SightingTime=0.250000
        InventorySize=4
		RecoilParams(0)=RecoilParams'ArenaRecoilParams'
		AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
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
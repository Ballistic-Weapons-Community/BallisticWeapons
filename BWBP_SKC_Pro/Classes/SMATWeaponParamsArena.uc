class SMATWeaponParamsArena extends BallisticWeaponParams;

defaultproperties
{    
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.SMATRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=55000.000000
		AccelSpeed=55000.000000
		Damage=400
		DamageRadius=160.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-FireOld',Volume=7.600000)
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.800000
		bCockAfterFire=False
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
	
	//Ice
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams_Ice
		ProjectileClass=Class'BWBP_SKC_Pro.SMATRocketIce'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=2000.000000
		MaxSpeed=55000.000000
		AccelSpeed=55000.000000
		Damage=120
		DamageRadius=1024.000000
		MomentumTransfer=75000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-FireIce',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=1024.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams_Ice
		FireInterval=0.800000
		bCockAfterFire=False
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams_Ice'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.SMATGrenade'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=100.000000
		MaxSpeed=100.000000
		AccelSpeed=100.000000
		Damage=1512.000000
		DamageRadius=768.000000
		MomentumTransfer=90000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		FireSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Jump',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
		Recoil=2048.000000
		Chaos=0.500000
		BotRefireRate=0.5
		WarnTargetPct=0.8	
	End Object
	
	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=1.500000
		bCockAfterFire=True
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
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
		SprintOffset=(Pitch=-6000,Yaw=-1000)
		JumpOffset=(Pitch=-6000,Yaw=-1500)
		AimAdjustTime=1.000000
		AimSpread=(Min=1024,Max=3048)
		ChaosSpeedThreshold=1000.000000
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=ArenaParams
		LayoutName="HEDP Warhead"
		Weight=30
		
	    CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		//SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		//ViewOffset=(X=20.000000,Y=15.000000,Z=-10.000000)
		SightingTime=0.550000	
        DisplaceDurationMult=1.25
        MagAmmo=1        
		InventorySize=8
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 

    Begin Object Class=WeaponParams Name=ArenaParams_Ice
		LayoutName="CRYO Warhead"
		Weight=10
		
	    CockAnimRate=1.250000
		ReloadAnimRate=1.250000
		//SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
		//ViewOffset=(X=20.000000,Y=15.000000,Z=-10.000000)
		SightingTime=0.550000	
        DisplaceDurationMult=1.25
        MagAmmo=1        
		InventorySize=8
		PlayerSpeedFactor=0.95
		SightMoveSpeedFactor=0.6
        ZoomType=ZT_Logarithmic
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams_Ice'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
	
    Layouts(0)=WeaponParams'ArenaParams'
    Layouts(1)=WeaponParams'ArenaParams_Ice'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=SMAT_Green
		Index=0
		CamoName="Olive Drab"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Urban
		Index=1
		CamoName="Urban"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainUrban",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscUrban",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Ocean
		Index=2
		CamoName="Ocean"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainWater",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscWater",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=SMAT_Orange
		Index=3
		CamoName="Orange"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MainOrange",Index=1,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(2)=(MaterialName="BWBP_Camos_Tex.SMATCamos.SMAT-MiscOrange",Index=2,AIndex=-1,PIndex=-1)
		Weight=10
	End Object
	
	Camos(0)=WeaponCamo'SMAT_Green'
	Camos(1)=WeaponCamo'SMAT_Urban'
	Camos(2)=WeaponCamo'SMAT_Ocean'
	Camos(3)=WeaponCamo'SMAT_Orange'
}
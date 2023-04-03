class LAWWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWRocket'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=3500.000000
		MaxSpeed=7500.000000
		AccelSpeed=10000.000000
		Damage=300
		DamageRadius=2048.000000
		MomentumTransfer=300000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.300000
		WarnTargetPct=1	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-FireLoud',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalPrimaryFireParams
		FireInterval=0.950000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'TacticalPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=TacticalSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.LAWGrenade'
		SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
		Speed=3500.000000
		Damage=100
		MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.300000
		WarnTargetPct=1.000000	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.LAW.LAW-Fire',Volume=4.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=TacticalSecondaryFireParams
		FireInterval=0.600000	
		FireEffectParams(0)=ProjectileEffectParams'TacticalSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		YawFactor=0.000000
		DeclineTime=1.000000
		DeclineDelay=0.000000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		AimSpread=(Min=768,Max=4096)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-3072,Yaw=-4096)
		JumpOffset=(Pitch=-7000)
		AimAdjustTime=0.750000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=TacticalParams
		PlayerSpeedFactor=0.9
		PlayerJumpFactor=0.9
		InventorySize=8
		SightMoveSpeedFactor=0.35
		SightingTime=0.65	
		ScopeScale=0.7
		DisplaceDurationMult=1.25
		MagAmmo=1
        ZoomType=ZT_Logarithmic
		SightOffset=(Y=6.000000,Z=15.000000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
		FireParams(0)=FireParams'TacticalPrimaryFireParams'
		AltFireParams(0)=FireParams'TacticalSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
	
	//Camos ====================================
	Begin Object Class=WeaponCamo Name=LAW_Green
		Index=0
		CamoName="OD Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Tan
		Index=1
		CamoName="Desert"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainTan",Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Black
		Index=2
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainBlack",Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_RedTiger
		Index=3
		CamoName="Red Tiger"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainRedTiger",Index=2,AIndex=0,PIndex=0)
		Weight=5
	End Object
	
	Begin Object Class=WeaponCamo Name=LAW_Gold
		Index=4
		CamoName="Gold"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.LAWCamos.LAW-MainGold",Index=2,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'LAW_Green'
	Camos(1)=WeaponCamo'LAW_Tan'
	Camos(2)=WeaponCamo'LAW_Black'
	Camos(3)=WeaponCamo'LAW_RedTiger'
	Camos(4)=WeaponCamo'LAW_Gold'
}
class FLASHWeaponParamsComp extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaPrimaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=4500.000000
		Damage=80
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.700000
		WarnTargetPct=1
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaPrimaryFireParams
		FireInterval=0.700000
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaPrimaryEffectParams'
	End Object
		
    //=================================================================
    // SECONDARY FIRE
    //=================================================================	
	
	Begin Object Class=ProjectileEffectParams Name=ArenaSecondaryEffectParams
		ProjectileClass=Class'BWBP_SKC_Pro.FLASHProjectile'
		SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
		Speed=4500.000000
		Damage=80
		DamageRadius=300.000000
		MomentumTransfer=10000.000000
		MuzzleFlashClass=Class'BallisticProV55.G5FlashEmitter'
		Recoil=1024.000000
		BotRefireRate=0.300000
		WarnTargetPct=1	
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.Flash.M202-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	End Object

	Begin Object Class=FireParams Name=ArenaSecondaryFireParams
		FireInterval=3.500000
		FireAnim="Fireall"
		FireEndAnim=	
		FireEffectParams(0)=ProjectileEffectParams'ArenaSecondaryEffectParams'
	End Object
		
	//=================================================================
	// RECOIL
	//=================================================================

	Begin Object Class=RecoilParams Name=ArenaRecoilParams
	 	DeclineTime=0.750000
	End Object

	//=================================================================
	// AIM
	//=================================================================

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=64,Max=1536)
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		AimDamageThreshold=300.000000
		ChaosDeclineTime=0.750000
		ChaosSpeedThreshold=300
	End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

	Begin Object Class=WeaponParams Name=ArenaParams
		ViewOffset=(X=10.000000,Z=-12.000000)
		SightOffset=(Y=5.300000,Z=23.299999)
		PlayerSpeedFactor=0.95
        DisplaceDurationMult=1.25
		InventorySize=8
		SightMoveSpeedFactor=0.8
		SightingTime=0.350000		
		MagAmmo=4
        ZoomType=ZT_Fixed
        RecoilParams(0)=RecoilParams'ArenaRecoilParams'
        AimParams(0)=AimParams'ArenaAimParams'
		FireParams(0)=FireParams'ArenaPrimaryFireParams'
		AltFireParams(0)=FireParams'ArenaSecondaryFireParams'
    End Object 
    Layouts(0)=WeaponParams'ArenaParams'
	
	//Camos =====================================
	Begin Object Class=WeaponCamo Name=FLASH_Green
		Index=0
		CamoName="Green"
		Weight=30
	End Object
	
	Begin Object Class=WeaponCamo Name=FLASH_Black
		Index=1
		CamoName="Black"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FLASHCamos.FLASH-CamoBlack",Index=2,AIndex=0,PIndex=0)
		Weight=15
	End Object
	
	Begin Object Class=WeaponCamo Name=FLASH_Winter
		Index=2
		CamoName="Arctic"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FLASHCamos.FLASH-CamoWhite",Index=2,AIndex=0,PIndex=0)
		Weight=10
	End Object
	
	Begin Object Class=WeaponCamo Name=FLASH_Pink
		Index=3
		CamoName="Pink"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FLASHCamos.FLASH-CamoFAB",Index=2,AIndex=0,PIndex=0)
		Weight=3
	End Object
	
	Begin Object Class=WeaponCamo Name=FLASH_Glitch
		Index=4
		CamoName="11011"
		WeaponMaterialSwaps(0)=(MaterialName="BW_Core_WeaponTex.Hands.Hands-Shiny",Index=0,AIndex=-1,PIndex=-1)
		WeaponMaterialSwaps(1)=(MaterialName="BWBP_Camos_Tex.FLASHCamos.FLASH-Charged",Index=2,AIndex=0,PIndex=0)
		Weight=1
	End Object
	
	Camos(0)=WeaponCamo'FLASH_Green'
	Camos(1)=WeaponCamo'FLASH_Black'
	Camos(2)=WeaponCamo'FLASH_Winter'
	Camos(3)=WeaponCamo'FLASH_Pink'
	Camos(4)=WeaponCamo'FLASH_Glitch'
}
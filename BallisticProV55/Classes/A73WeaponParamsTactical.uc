//=============================================================================
// A73WeaponParams
//=============================================================================
class A73WeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
    	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=14000.000000
        Damage=50.000000
        HeadMult=2.25
        LimbMult=0.75f
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=130.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.A73Projectile'
        WarnTargetPct=0.200000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.125000
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams'
    End Object

	//Rapid fire
    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams_Rapid
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
    	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=5500.000000
        AccelSpeed=100000.000000
        MaxSpeed=14000.000000
        Damage=30.000000
        HeadMult=2.25
        LimbMult=0.75f
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=130.000000
	    Chaos=0.020000
        FireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Pitch=1.1,Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	    ProjectileClass=Class'BallisticProV55.A73ProjectileBal'
        WarnTargetPct=0.200000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams_Rapid
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.100000
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams_Rapid'
    End Object

	//Elite, slow powerful
    Begin Object Class=ProjectileEffectParams Name=TacticalProjEffectParams_Elite
		ProjectileClass=Class'BallisticProV55.A73ProjectileB'
    	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=7500.000000
        AccelSpeed=150000.000000
        MaxSpeed=14000.000000
        Damage=70.000000
        HeadMult=2.25
        LimbMult=0.75f
        MaxDamageGainFactor=0.75
        DamageGainStartTime=0.05
        DamageGainEndTime=0.25
    	Recoil=160.000000
	    Chaos=0.020000
		MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
		FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        WarnTargetPct=0.200000
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalProjFireParams_Elite
		AmmoPerFire=2
	    FireEndAnim=
        AimedFireAnim="SightFire"
	    FireInterval=0.150000
        FireEffectParams(0)=ProjectileEffectParams'TacticalProjEffectParams_Elite'
    End Object

    //=================================================================
    // SECONDARY FIRE
    //=================================================================

    Begin Object Class=ProjectileEffectParams Name=TacticalPowerEffectParams
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=105.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=960.000000
        Chaos=0.5
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectile'
        WarnTargetPct=0.5
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalPowerFireParams
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'TacticalPowerEffectParams'
    End Object

	//Pink alt for layout 2
    Begin Object Class=ProjectileEffectParams Name=TacticalPowerEffectParams_Rapid
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterBal'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=3000.000000
        AccelSpeed=8000.000000
        MaxSpeed=7000.000000
        Damage=105.000000
        DamageRadius=100.000000
        MomentumTransfer=2000.000000
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=960.000000
        Chaos=0.5
        FireSound=(Sound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
        ProjectileClass=Class'BallisticProV55.A73PowerProjectileBal'
        WarnTargetPct=0.5
        BotRefireRate=0.5
    End Object

    Begin Object Class=FireParams Name=TacticalPowerFireParams_Rapid
        AmmoPerFire=8
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.800000
        FireEffectParams(0)=ProjectileEffectParams'TacticalPowerEffectParams_Rapid'
    End Object
	
	//Elite layout alt orb
	Begin Object Class=ProjectileEffectParams Name=TacticalPowerEffectParams_Elite
    	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitterB'
        SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
        Speed=1500.000000
        AccelSpeed=0.000000
        MaxSpeed=2000.000000
        Damage=105.000000
        DamageRadius=200.000000
        MomentumTransfer=2000.000000
		SplashDamage=True
		RecommendSplashDamage=True
        MaxDamageGainFactor=1.00
        DamageGainStartTime=0.05
        DamageGainEndTime=0.7
        Recoil=1460.000000
        Chaos=0.020000
        FireSound=(Sound=Sound'BWBP_SKC_Sounds.A73E.A73E-Power',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
		ProjectileClass=Class'BallisticProV55.A73PowerProjectileB'
        WarnTargetPct=0.500000
    End Object

    Begin Object Class=FireParams Name=TacticalPowerFireParams_Elite
        AmmoPerFire=16
	    FireEndAnim=
        AimedFireAnim="Fire"
	    FireInterval=0.850000
        FireEffectParams(0)=ProjectileEffectParams'TacticalPowerEffectParams_Elite'
    End Object

    //=================================================================
    // RECOIL
    //=================================================================

	Begin Object Class=RecoilParams Name=TacticalRecoilParams
		ViewBindFactor=0.3
		ADSViewBindFactor=0.9
		XCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.050000),(InVal=0.300000,OutVal=0.070000),(InVal=0.600000,OutVal=-0.060000),(InVal=0.700000,OutVal=-0.060000),(InVal=1.000000)))
		YCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=0.300000),(InVal=0.300000,OutVal=0.350000),(InVal=0.450000,OutVal=0.550000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
		XRandFactor=0.1
		YRandFactor=0.1
		ClimbTime=0.05
		DeclineDelay=0.125000
		DeclineTime=0.75
		CrouchMultiplier=0.85
		HipMultiplier=1.25
		MaxMoveMultiplier=2
 	End Object

    //=================================================================
    // AIM
    //=================================================================

	Begin Object Class=AimParams Name=TacticalAimParams
		ADSMultiplier=0.5
		SprintOffset=(Pitch=-2048,Yaw=-2048)
		AimAdjustTime=0.600000
		AimSpread=(Min=256,Max=1024)
		AimDamageThreshold=75.000000
		ChaosDeclineTime=1.350000
		ChaosDeclineDelay=0.300000
		ChaosSpeedThreshold=300
	End Object

    //=================================================================
    // WEAPON
    //=================================================================

    Begin Object Class=WeaponParams Name=TacticalParams
		//Layout core
		LayoutName="Infantry"
		Weight=30
		//Attachments
		//Function
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
		InventorySize=6
	    RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams'
        AltFireParams(0)=FireParams'TacticalPowerFireParams'
    End Object 
	
	Begin Object Class=WeaponParams Name=TacticalParams_CQC
		//Layout core
		LayoutName="CQC"
		Weight=10
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73AmmoSkin',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73PurpleLayout.A73Skin_SD',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.A73PurpleLayout.A73SkinB',Index=3)
		WeaponMaterialSwaps(4)=(Material=Shader'BW_Core_WeaponTex.A73.A73BladeShader',Index=4)
		//Function
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
		InventorySize=6
	    RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams_Rapid'
        AltFireParams(0)=FireParams'TacticalPowerFireParams_Rapid'
	End Object
	
	Begin Object Class=WeaponParams Name=TacticalParams_Elite //slow, powerful
		//Layout core
		LayoutName="Elite"
		Weight=10
		//Attachments
		WeaponMaterialSwaps(0)=(Material=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny',Index=0)
		WeaponMaterialSwaps(1)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BAmmoSkin',Index=1)
		WeaponMaterialSwaps(2)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BSkin_SD',Index=2)
		WeaponMaterialSwaps(3)=(Material=Texture'BW_Core_WeaponTex.A73RedLayout.A73BSkinB0',Index=3)
		WeaponMaterialSwaps(4)=(Material=Shader'BW_Core_WeaponTex.A73RedLayout.A73BBladeShader',Index=4)
		//Function
		MagAmmo=32
		SightPivot=(Pitch=450)
		//SightOffset=(X=10.000000,Z=11.90000)
        SightingTime=0.35
        SightMoveSpeedFactor=0.6
		InventorySize=6
	    RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalProjFireParams_Elite'
        AltFireParams(0)=FireParams'TacticalPowerFireParams_Elite'
	End Object
	
    Layouts(0)=WeaponParams'TacticalParams'
    Layouts(1)=WeaponParams'TacticalParams_CQC'
    Layouts(2)=WeaponParams'TacticalParams_Elite'
}
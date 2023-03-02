class BOGPWeaponParamsTactical extends BallisticWeaponParams;

defaultproperties
{
    //=================================================================
    // PRIMARY FIRE
    //=================================================================	

    Begin Object Class=ProjectileEffectParams Name=TacticalGrenadeEffectParams
        ProjectileClass=Class'BallisticProV55.BOGPGrenade'
        SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
        MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
        Speed=3500.000000
        Damage=120.000000
        DamageRadius=512.000000
        Chaos=0.700000
        Inaccuracy=(X=64,Y=64)
        FireSound=(Sound=SoundGroup'BW_Core_WeaponSound.BOGP.BOGP_Fire',Volume=1.750000)
        SplashDamage=True
        RecommendSplashDamage=True
        WarnTargetPct=0.300000
		BotRefireRate=0.300000	
    End Object

    Begin Object Class=FireParams Name=TacticalGrenadeFireParams
        PreFireAnim=
        FireEffectParams(0)=ProjectileEffectParams'TacticalGrenadeEffectParams'
        bCockAfterFire=True
    End Object 

    Begin Object Class=ProjectileEffectParams Name=TacticalFlareEffectParams
        ProjectileClass=Class'BallisticProV55.BOGPFlare'
        SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
        Speed=5500.000000
        MaxSpeed=7500.000000
        AccelSpeed=100000.000000
        Damage=40.000000
        DamageRadius=64.000000
        MomentumTransfer=0.000000
        MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
        Chaos=0.700000
        Inaccuracy=(X=64,Y=64)
        FireSound=(Sound=Sound'BW_Core_WeaponSound.BOGP.BOGP_FlareFire',Volume=2.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
        WarnTargetPct=0.100000
        BotRefireRate=0.300000
    End Object

    Begin Object Class=FireParams Name=TacticalFlareFireParams
        PreFireAnim=
        FireEffectParams(0)=ProjectileEffectParams'TacticalFlareEffectParams'
        bCockAfterFire=True
    End Object 

    //=================================================================
    // SECONDARY FIRE
    //=================================================================	

    Begin Object Class=FireEffectParams Name=TacticalAltEffectParams
        EffectString="Switch grenade"
    End Object

    Begin Object Class=FireParams Name=TacticalAltFireParams
        AmmoPerFire=0
        FireInterval=0.200000
        FireEffectParams(0)=FireEffectParams'TacticalAltEffectParams'
    End Object

	//=================================================================
	// RECOIL
	//=================================================================

    Begin Object Class=RecoilParams Name=TacticalRecoilParams
        ViewBindFactor=0.6
        YawFactor=0.000000
        XRandFactor=0.250000
        YRandFactor=0.250000
        DeclineTime=1.000000
        DeclineDelay=0.800000
    End Object

	//=================================================================
	// AIM
	//=================================================================

    Begin Object Class=AimParams Name=TacticalAimParams
        AimSpread=(Min=64,Max=378)
        JumpChaos=0.750000
        ADSMultiplier=0.5
        ChaosDeclineTime=1.000000
        ChaosSpeedThreshold=300
    End Object

	//=================================================================
	// BASIC PARAMS
	//=================================================================	

    Begin Object Class=WeaponParams Name=TacticalParams
        CockAnimRate=1.50000
		ReloadAnimRate=1.250000
        DisplaceDurationMult=0.75
        MagAmmo=1
        SightingTime=0.2
        InventorySize=20
		SightPivot=(Pitch=300)
		SightOffset=(X=-24.000000,Y=0.080000,Z=8.550000)
        RecoilParams(0)=RecoilParams'TacticalRecoilParams'
        AimParams(0)=AimParams'TacticalAimParams'
        FireParams(0)=FireParams'TacticalGrenadeFireParams'
        FireParams(1)=FireParams'TacticalFlareFireParams'
        AltFireParams(0)=FireParams'TacticalAltFireParams'
    End Object 
    Layouts(0)=WeaponParams'TacticalParams'
}
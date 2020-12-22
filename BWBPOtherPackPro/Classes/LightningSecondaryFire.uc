class LightningSecondaryFire extends BallisticProjectileFire;

defaultproperties
{
    MuzzleFlashClass=Class'BWBPOtherPackPro.LightningFlashEmitter'
    FlashScaleFactor=0.600000
    BrassClass=Class'BallisticProV55.Brass_Rifle'
    bBrassOnCock=True
    BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
    FireRecoil=400.000000
    FirePushbackForce=255.000000
    FireChaos=0.800000
    BallisticFireSound=(Sound=Sound'PackageSounds4Pro.Misc.LS14-EnergyRocket',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
    FireEndAnim=
    FireRate=0.600000
    AmmoClass=Class'BWBPOtherPackPro.Ammo_LightningRifle'
    ShakeRotMag=(X=400.000000,Y=32.000000)
    ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
    ShakeRotTime=2.000000
    ShakeOffsetMag=(X=-5.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=2.000000
    ProjectileClass=Class'BWBPOtherPackPro.LightningProjectile'
    BotRefireRate=0.400000
    WarnTargetPct=0.500000
    aimerror=800.000000
}

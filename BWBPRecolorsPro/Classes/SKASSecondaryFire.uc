//=============================================================================
// M763PrimaryFire.
//
// Powerful shotgun blast with moderate spread and fair range for a shotgun.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SKASSecondaryFire extends BallisticProShotgunFire;

var   float RailPower;
var   float ChargeRate;
var   float PowerLevel;
var   float MaxCharge;
var   sound	ChargeSound;
var   sound	UltraChargeSound;
var() sound		UltraFireSound;

simulated event ModeDoFire()
{
    if (RailPower + 0.01 >= PowerLevel)
    {
        super.ModeDoFire();
        SKASShotgun(BW).CoolRate = SKASShotgun(BW).default.CoolRate;
    }
    else
    {
        SKASShotgun(BW).CoolRate = SKASShotgun(BW).default.CoolRate * 3;
    }

    SKASShotgun(BW).Heat += RailPower;
    RailPower = 0;
}

simulated function StopFiring()
{
	HoldTime = 0;
	Super.StopFiring();
}

simulated function PlayStartHold()
{
    Weapon.PlayAnim('ChargeUp', 1.0, 0.1);
}

function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	return super.GetDamage (Other, HitLocation, Dir, Victim, DT) * RailPower;
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

    if (SKASShotgun(BW).Heat <= 0)
    {
        MaxCharge = RailPower;
        if (HoldTime > 0)
        {
            RailPower = FMin(RailPower + ChargeRate*DT, PowerLevel);
            Instigator.AmbientSound = ChargeSound;
        }
        else
            Instigator.AmbientSound = BW.UsedAmbientSound;

    }
    else
        Instigator.AmbientSound = BW.UsedAmbientSound;
		
    if (!bIsFiring)
        return;

    if (RailPower >= PowerLevel)
        Weapon.StopFire(ThisModeNum);
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	SKASAttachment(Weapon.ThirdPersonActor).SKASUpdateHit(Other, HitLocation, HitNormal, Surf);
}

simulated function DestroyEffects()
{
    if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	Super.DestroyEffects();
}

defaultproperties
{
     ChargeRate=1.000000
     PowerLevel=1.000000
     ChargeSound=Sound'PackageSounds4Pro.SKAS.SKAS-TriCharge'
     UltraChargeSound=Sound'PackageSounds4Pro.SKAS.SKAS-UltraCharge'
     UltraFireSound=Sound'PackageSounds4Pro.SKAS.SKAS-Ultra'
     CutOffDistance=1536.000000
     CutOffStartRange=1024.000000
     TraceCount=30
     TracerClass=Class'BallisticProV55.TraceEmitter_Shotgun'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=4096.000000,Max=5000.000000)
     Damage=10.000000
     DamageHead=15.000000
     DamageLimb=10.000000
     RangeAtten=0.600000
     DamageType=Class'BWBPRecolorsPro.DTSKASShotgunAlt'
     DamageTypeHead=Class'BWBPRecolorsPro.DTSKASShotgunHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DTSKASShotgunAlt'
     KickForce=20000
     PenetrateForce=100
     bPenetrate=True
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.M763FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_MRS138Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     FireRecoil=1500.000000
     FirePushbackForce=850.000000
     FireChaos=1.000000
     XInaccuracy=378.000000
     YInaccuracy=378.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.SKAS.SKAS-Triple',Volume=2.200000)
     bFireOnRelease=True
     bWaitForRelease=True
     FireAnim="FireBig"
     FireEndAnim=
     FireRate=1.700000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_SKASShells'
     AmmoPerFire=3
     ShakeRotMag=(X=256.000000,Y=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.500000
     ShakeOffsetMag=(X=-50.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.500000
     BotRefireRate=0.900000
     WarnTargetPct=0.100000
}

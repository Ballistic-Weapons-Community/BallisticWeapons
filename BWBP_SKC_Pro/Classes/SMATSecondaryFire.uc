//=============================================================================
// SMATSecondaryFire.
//
// Suicide alt fire! Charges before exploding.
// This is well known to be the best method of close range combat.
//
// by SK
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SMATSecondaryFire extends BallisticProjectileFire;

var   float RailPower;
var   float ChargeRate;
var   float PowerLevel;
var   int SoundAdjust;
var   float MaxCharge;
var   sound	ChargeSound;


simulated function bool AllowFire()
{
    if (SMATLauncher(BW).Heat > 0 || SMATLauncher(Weapon).bInUse)
	{
        return false;
	        //log("Fire Failure: RailPower = "$RailPower$", HoldTime = "$HoldTime$" PowerLevel = "$PowerLevel);
	}
    return super.AllowFire();
}

simulated event ModeDoFire()
{
    if (!AllowFire())
	  return;

    if (RailPower + 0.05 >= PowerLevel)
    {
		BallisticFireSound.Volume=0.7+RailPower*0.8;
		BallisticFireSound.Radius=(280.0+RailPower*350.0);
		SMATLauncher(BW).CoolRate = SMATLauncher(BW).default.CoolRate;
		Instigator.AmbientSound = BW.UsedAmbientSound;
		SMATLauncher(BW).PickupClass = None;
		SMATLauncher(BW).bExploded = true;
		
		super.ModeDoFire();
	  	Super.DoFireEffect();
		
	 	if (level.Netmode == NM_DedicatedServer)
		{
	 		class'BallisticDamageType'.static.GenericHurt (Instigator, 200, Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTSMATSuicide');
       		super.ModeDoFire();
			//SMATLauncher(BW).Destroy();
		}
	 	//SMATLauncher(BW).Destroy();
    }
    else
    {
		SMATLauncher(BW).Heat = 0;
		RailPower=0;
    }

    SMATLauncher(BW).Heat += RailPower;
    RailPower = 0;
//	return;
}


simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);

    if (SMATLauncher(Weapon).bInUse || SMATLauncher(BW).MagAmmo==0)
	{
		Instigator.AmbientSound = BW.UsedAmbientSound;
		return;
	}

    if (SMATLauncher(BW).Heat <= 0)
    {
        MaxCharge = RailPower;
        if (bIsFiring)
        {
            RailPower = FMin(RailPower + ChargeRate*DT, PowerLevel);
            Instigator.AmbientSound = ChargeSound;
        }
        else
        {
            Instigator.AmbientSound = BW.UsedAmbientSound;
        }
    }

    if (!bIsFiring)
        return;

    if (RailPower >= PowerLevel)
    {
		class'BallisticDamageType'.static.GenericHurt (Instigator, 400, Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTSMATSuicide');
        if (Weapon != None)
			Weapon.ClientStopFire(ThisModeNum);
    }
}

defaultproperties
{
     ChargeRate=0.700000
     PowerLevel=1.000000
     ChargeSound=Sound'BWBP_SKC_Sounds.SMAA.SMAT-Charge'
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-3.000000)
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     //RecoilPerShot=768.000000
     XInaccuracy=4.000000
     YInaccuracy=4.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.BX5.BX5-Jump',Volume=9.600000,Slot=SLOT_Interact,bNoOverride=False)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     bWaitForRelease=True
     bModeExclusive=False
     FireEndAnim=
     TweenTime=0.000000
     FireRate=0.800000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_SMAT'
     ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-8.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_SKC_Pro.SMATGrenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}

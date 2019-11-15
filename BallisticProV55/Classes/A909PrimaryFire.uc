//=============================================================================
// A909PrimaryFire.
//
// Rapid, two handed jabs with reasonable range. Everything is timed by notifys
// from the anims
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A909PrimaryFire extends BallisticMeleeFire;

var() Array<name> 	SliceAnims;
var   int			SliceAnim;
var   bool			bFireNotified;

function PlayFiring()
{
    if (BW.FireCount > 0)
		FireAnim = SliceAnims[Rand(2)+1];
    else
        FireAnim = SliceAnims[0];
	Weapon.PlayAnim(FireAnim, FireAnimRate / (1 + BW.MeleeFatigue * 0.75), TweenTime);

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
}

event ModeDoFire()
{
    if (!AllowFire())
        return;

	if (!bFireNotified)
	{
		if (BW.FireCount < 1)
		{
			NextFireTime += FireRate;
			NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
			PlayFiring();
			BW.FireCount++;
		}
		return;
	}
	bFireNotified=false;
	BW.FireCount++;

    if (MaxHoldTime > 0.0)
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if (Weapon.Role == ROLE_Authority)
    {
        DoFireEffect();
        if ( (Instigator == None) || (Instigator.Controller == None) )
			return;
        if ( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, true);
        Instigator.DeactivateSpawnProtection();
    }
	else
	{
		FireRecoil();
	}


	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
    // client
    if (Instigator.IsLocallyControlled())
    {
        ShakeView();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else
    {
    }

	BW.MeleeFatigue = FMin(BW.MeleeFatigue + FatiguePerStrike, 1);
	
    Load = AmmoPerFire;
    HoldTime = 0;

    if (Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None)
    {
        bIsFiring = false;
        Weapon.PutDown();
    }
}

simulated function bool HasAmmo()
{
	return true;
}

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = default.Damage;
	FS.Damage = String(FS.DamageInt);
	FS.DPS = default.Damage * 2 / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.Damage) - 1);
	FS.RPM = 1/default.FireRate@"attacks/second";
	FS.Range = "Max:"@(default.TraceRange.Max / 52.5)@"metres";
	
	return FS;
}

defaultproperties
{
     SliceAnims(0)="PrepHack"
     SliceAnims(1)="HackLoop1"
     SliceAnims(2)="HackLoop2"
     SwipePoints(0)=(offset=(Yaw=-1280))
     SwipePoints(1)=(offset=(Yaw=0))
     SwipePoints(2)=(offset=(Yaw=1280))
     WallHitPoint=1
     NumSwipePoints=3
     FatiguePerStrike=0.060000
     bCanBackstab=False
     TraceRange=(Min=170.000000,Max=170.000000)
     Damage=35.000000
     DamageHead=35.000000
     DamageLimb=35.000000
     DamageType=Class'BallisticProV55.DTA909Blades'
     DamageTypeHead=Class'BallisticProV55.DTA909Head'
     DamageTypeArm=Class'BallisticProV55.DTA909Limb'
     KickForce=100
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.A909.A909Slash',Radius=378.000000,bAtten=True)
     bAISilent=True
     FireAnim="PrepHack"
     FireAnimRate=1.200000
     FireRate=0.350000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.300000
}

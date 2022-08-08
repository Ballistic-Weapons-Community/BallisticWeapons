//=============================================================================
// A42PrimaryFire.
//
// Rapid fire projectiles. Ammo regen timer is also here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_SecondaryFire extends BallisticProjectileFire;

var   float		StopFireTime;
var() sound		XR4FireSound;

simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode == 0)
	{
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		FireRate=default.FireRate;
		AmmoPerFire=Default.AmmoPerFire;
 		ProjectileClass=Default.ProjectileClass;
	}
	else if (NewMode == 1)
	{
		BallisticFireSound.Sound=XR4FireSound;
     		FireRate=2.100000;
		AmmoPerFire=25;
 		ProjectileClass=Class'BWBP_SKC_Pro.Supercharger_EMPTorpedo';
	}
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.Sound;
		AmmoPerFire=Default.AmmoPerFire;
		FireRate=default.FireRate;
 		ProjectileClass=Default.ProjectileClass;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

function StartBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
   	FireRate *= 0.75;
    FireAnimRate = default.FireAnimRate/0.75;
    ReloadAnimRate = default.ReloadAnimRate/0.75;
}

function StopBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
    FireAnimRate = default.FireAnimRate;
    ReloadAnimRate = default.ReloadAnimRate;
}

function StartSuperBerserk()
{

	if (BW.CurrentWeaponMode == 1)
    	FireRate = 0.85;
	else
    	FireRate = 0.15;
    FireRate /= Level.GRI.WeaponBerserk;
    FireAnimRate = default.FireAnimRate * Level.GRI.WeaponBerserk;
    ReloadAnimRate = default.ReloadAnimRate * Level.GRI.WeaponBerserk;
}


function DoFireEffect()
{
    local Vector StartTrace, StartProj, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local actor Other2;

    Weapon.GetViewAxes(X,Y,Z);
	
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

    // Inserted Epic code segment.
    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Trace (HitLocation, HitNormal, StartTrace, Start, true);
	
	if (Other != None)
       StartProj = HitLocation;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other2 = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other == None)
	{
		if (Other2 != None)
			Aim = Rotator(HitLocation-StartTrace);
		SpawnProjectile(StartTrace, Aim);
	}
	else //If too close, fire at wall instead.
		SpawnProjectile(StartProj, Aim);


	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
}

defaultproperties
{
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=20
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.LS14-EnergyRocket',Volume=1.000000,Slot=SLOT_Interact,bNoOverride=False)
     FireChaos=0.600000
	 FireAnim=""
     FireEndAnim=
     FireRate=0.900000
     FlashScaleFactor=0.750000
     MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
     ProjectileClass=Class'BWBP_SKC_Pro.Supercharger_ProtonTorpedo'
     //RecoilPerShot=820.000000
     ShakeOffsetMag=(X=-4.000000)
     ShakeOffsetRate=(X=-1200.000000)
     ShakeOffsetTime=1.500000
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     SpawnOffset=(X=100.000000,Y=10.000000,Z=9.000000)
     TweenTime=0.000000
     WarnTargetPct=0.200000
     XInaccuracy=4.000000
     XR4FireSound=Sound'BWBP_SKC_Sounds.Misc.LS14-EnergyRocket2'
     YInaccuracy=4.000000
}

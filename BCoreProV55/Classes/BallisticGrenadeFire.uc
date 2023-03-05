//=============================================================================
// BallisticGrenadeFire.
//
// Fire class for hand grenades with prefire, clips, pins, handexploding, etc...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticGrenadeFire extends BallisticProjectileFire;

var() name				NoClipPreFireAnim;

function FlashMuzzleFlash()
{
	if (BallisticHandGrenade(Weapon).ClipReleaseTime == 0.0)
		EjectBrass();
}

function PlayPreFire()
{
	Weapon.SetBoneScale (0, 1.0, BallisticHandGrenade(Weapon).GrenadeBone);
	Weapon.SetBoneScale (1, 0.0, BallisticHandGrenade(Weapon).PinBone);
	if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0)
		Weapon.SetBoneScale (2, 0.0, BallisticHandGrenade(Weapon).ClipBone);
	else
		Weapon.SetBoneScale (2, 1.0, BallisticHandGrenade(Weapon).ClipBone);
	Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);
}

//Do the spread on the client side
function PlayFiring()
{
	super.PlayFiring();
}

simulated function bool AllowFire()
{
	if (level.TimeSeconds < BallisticHandGrenade(Weapon).HandExplodeTime)
		return false;
	return Super(WeaponFire).AllowFire();
}

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;

	if (BallisticHandGrenade(Weapon).ClipReleaseTime == 0)
	    class'BUtil'.static.PlayFullSound(weapon, BallisticHandGrenade(Weapon).ClipReleaseSound);

	BallisticHandGrenade(Weapon).KillSmoke();

	Super.ModeDoFire();
    
	if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0)
		BallisticHandGrenade(Weapon).ClipReleaseTime=-1.0;
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float Speed, DetonateDelay;
	local vector EnemyDir;

	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;

	if (BallisticPineapple(Proj) != None)
	{
		if (AIController(Instigator.Controller) == None)
		{
			if (BW != None && BW.WeaponModes[BW.CurrentWeaponMode].Value == 0)
				Speed = Proj.Speed * FClamp(HoldTime-0.5, 0, 2) / 2;
			else if (BW != None)
				Speed = Proj.Speed / BW.WeaponModes[BW.CurrentWeaponMode].Value;
		}
		else if (Instigator.Controller.Enemy != None)
		{
			EnemyDir = Instigator.Controller.Enemy.Location - Instigator.Location;
			Speed = FMin( Proj.Speed, (1+Normal(EnemyDir).Z) * (VSize(EnemyDir)/1.5) + VSize(Instigator.Controller.Enemy.Velocity) * (Normal(Instigator.Controller.Enemy.Velocity) Dot Normal(EnemyDir)) );
		}
		else
			Speed = Proj.Speed;
		if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
			DetonateDelay = BallisticPineapple(Proj).DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
		else
			DetonateDelay = BallisticPineapple(Proj).DetonateDelay;
		BallisticPineapple(Proj).InitPineapple(Speed, DetonateDelay);
	}
}

defaultproperties
{
     bAISilent=True
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bFireOnRelease=True
     FireRate=1.200000
     BotRefireRate=0.500000
}

//=============================================================================
// BallisticHandGrenadeFire.
//
// Fire class for hand grenades with prefire, clips, pins, handexploding, etc...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticHandGrenadeFire extends BallisticProjectileFire;

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

function float CalculateThrowPower()
{
	if (BW == None)
		return 1f;

	if (BW.WeaponModes[BW.CurrentWeaponMode].Value > 0)
		return 1f / BW.WeaponModes[BW.CurrentWeaponMode].Value;

	return 0.2 + FClamp(HoldTime - 0.2, 0, 1) / 0.8;
}

function float CalculateThrowSpeed(float ProjSpeed)
{
	local vector EnemyDir;

	if (PlayerController(Instigator.Controller) != None)
		return ProjSpeed * CalculateThrowPower();

	if (Instigator.Controller.Enemy != None)
	{
		EnemyDir = Instigator.Controller.Enemy.Location - Instigator.Location;
		return FMin( ProjSpeed, (1+Normal(EnemyDir).Z) * (VSize(EnemyDir)/1.5) + VSize(Instigator.Controller.Enemy.Velocity) * (Normal(Instigator.Controller.Enemy.Velocity) Dot Normal(EnemyDir)) );
	}
	
	return ProjSpeed;
}

function float CalculateDetonateDelay(float DetonateDelay)
{
	if (BallisticHandGrenade(Weapon).ClipReleaseTime > 0.0)
		return DetonateDelay - (Level.TimeSeconds - BallisticHandGrenade(Weapon).ClipReleaseTime);
		
	return DetonateDelay;
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	local float Speed, DetonateDelay;


	Proj = Spawn (ProjectileClass,,, Start, Dir);
	Proj.Instigator = Instigator;

	if (BallisticHandGrenadeProjectile(Proj) == None)
		return;

	BallisticHandGrenadeProjectile(Proj).SetSpeedAndDelay
	(
		CalculateThrowSpeed(Proj.Speed), 
		CalculateDetonateDelay(BallisticHandGrenadeProjectile(Proj).DetonateDelay)
	);
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

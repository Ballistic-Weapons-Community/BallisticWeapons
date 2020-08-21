//=============================================================================
// BOGPPrimaryFire.
//
// Fires either an explode on impact grenade, or a burning hot flare to set players ablaze!
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright© 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class BOGPPrimaryFire extends BallisticProProjectileFire;

var() BUtil.FullSound			FlareFireSound;

simulated event ModeDoFire()
{
	if (!AllowFire())
		return;
	if (!BOGPPistol(BW).CheckGrenade())
		return;
	Super.ModeDoFire();
}

function SpawnProjectile(Vector Start, Rotator Dir)
{
	if(!BOGPPistol(Weapon).bUseFlare)
		Proj = Spawn (ProjectileClass,,, Start, Dir);
	else
		Proj = Spawn (Class'BOGPFlare',,, Start, Dir);

	if (Proj != None)
		Proj.Instigator = Instigator;
}

function ServerPlayFiring()
{
	if(BOGPPistol(Weapon).bUseFlare)
		BallisticFireSound = FlareFireSound;
	else
		BallisticFireSound = Default.BallisticFireSound;

	Super.ServerPlayFiring();
}

function PlayFiring()
{
	if(BOGPPistol(Weapon).bUseFlare)
		BallisticFireSound = FlareFireSound;
	else
		BallisticFireSound = Default.BallisticFireSound;
		
	BOGPPistol(Weapon).bHideHead = true;

	Super.PlayFiring();
}

defaultproperties
{
     FlareFireSound=(Sound=Sound'BallisticSounds_25.BOGP.BOGP_FlareFire',Volume=2.000000,Radius=255.000000,Pitch=1.000000,bNoOverride=True)
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     bCockAfterFire=True
     bUseWeaponMag=False
     MuzzleFlashClass=Class'BallisticProV55.M50M900FlashEmitter'
     FlashBone="Muzzle"
     FireChaos=0.700000
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds_25.BOGP.BOGP_Fire',Volume=1.750000)
     bSplashDamage=True
     bRecommendSplashDamage=True
     bTossed=True
     bModeExclusive=False
     PreFireAnim=
     FireForce="AssaultRifleAltFire"
     AmmoClass=Class'BallisticProV55.Ammo_BOGPGrenades'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BallisticProV55.BOGPGrenade'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}

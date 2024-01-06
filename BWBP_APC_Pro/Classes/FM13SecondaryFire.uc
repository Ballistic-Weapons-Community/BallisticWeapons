//=============================================================================
// M763 Secondary Fire
//
// Loads then fires a gas shell.
//
// by Azarael
//=============================================================================
class FM13SecondaryFire extends BallisticProjectileFire;

var()     BUtil.FullSound            DragonSound;    //ROAR sound to play

simulated function ServerPlayFiring()
{
	super.ServerPlayFiring();
	if (DragonSound.Sound != None)
		Weapon.PlayOwnedSound(DragonSound.Sound,DragonSound.Slot,DragonSound.Volume,DragonSound.bNoOverride,DragonSound.Radius,DragonSound.Pitch,DragonSound.bAtten);
}

simulated function PlayFiring()
{
	super.PlayFiring();
	if (DragonSound.Sound != None)
		Weapon.PlayOwnedSound(DragonSound.Sound,DragonSound.Slot,DragonSound.Volume,DragonSound.bNoOverride,DragonSound.Radius,DragonSound.Pitch,DragonSound.bAtten);
}

//===========================================================================
// AllowFire
//
// Handles cocking
//===========================================================================
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (!FM13Shotgun(BW).bAltLoaded)
		return false;
    return true;
}

simulated function ModeDoFire()
{
	Super.ModeDoFire();
	FM13Shotgun(BW).bAltLoaded=False;
	FM13Shotgun(BW).PrepPriFire();
}

function SpawnProjectile (Vector Start, Rotator Dir)
{
	Proj = Spawn (ProjectileClass,,, Start, Dir);
	if (FM13Grenade(Proj) != None)
	{
		Proj.Instigator = Instigator;
		FM13Grenade(Proj).FireControl = FM13Shotgun(Weapon).FireControl;
	}
}

defaultproperties
{
     bUseWeaponMag=False
     FlashScaleFactor=2.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="SightFire"
     FireRecoil=1280.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-Fire',Volume=1.300000)
     FireAnim="Fire"
     FireEndAnim=
     FireAnimRate=1.100000
     FireRate=0.750000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_FM13Gas'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 ProjectileClass=Class'BWBP_APC_Pro.FM13Grenade'
	 DragonSound=(Sound=Sound'BWBP_OP_Sounds.FM13.FM13-RoarBig',Volume=1.800000,Radius=1024.000000,Pitch=0.500000,bNoOverride=True)
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
     WarnTargetPct=0.75
}

//=============================================================================
// A73PrimaryFire.
//
// A73 primary fire is a fast moving projectile that goes through enemies and
// isn't hard to spot
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A73PrimaryFire extends BallisticProProjectileFire;

var float HeatPerShot, HeatDeclineDelay;

simulated function bool AllowFire()
{
	if ((A73SkrithRifle(Weapon).HeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);
	
	if (NewMode == 0)
		HeatPerShot = default.HeatPerShot;
	
	else
		HeatPerShot = default.HeatPerShot * 1.25;
}

function PlayFiring()
{
	Super.PlayFiring();
	A73SkrithRifle(BW).AddHeat(HeatPerShot, HeatDeclineDelay);
	//Weapon.SoundPitch = Min(150, Weapon.SoundPitch + 8);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		A73SkrithRifle(BW).AddHeat(HeatPerShot, HeatDeclineDelay);
}


//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

    FS = Super.GetStats();
	FS.RangeOpt = "Max damage: 0.6s";
	
	return FS;
}

defaultproperties
{
	HeatPerShot=0.600000
	HeatDeclineDelay=0.2
	SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
	MuzzleFlashClass=Class'BallisticProV55.A73FlashEmitter'
	AimedFireAnim="SightFire"
	FireRecoil=130.000000
	FireChaos=0.020000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Fire',Volume=1.200000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	FireEndAnim=
	FireRate=0.125000
	AmmoClass=Class'BallisticProV55.Ammo_Cells'
	ShakeRotMag=(X=32.000000,Y=8.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=1.500000
	ShakeOffsetMag=(X=-3.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=1.500000
	ProjectileClass=Class'BallisticProV55.A73Projectile'
	 
	//AI info - bot aid for close-range A73 - it's fast and they won't dodge it if it's too close
    bLeadTarget=True
    bInstantHit=True
	AimError=600
    WarnTargetPct=0.200000
}

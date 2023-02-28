//=============================================================================
// FP7PrimaryFire.
//
// FP7 Grenade thrown overhand
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7PrimaryFire extends BallisticProGrenadeFire;

/*
FIXME: Needs to report damage from control instead. Needs its own fire params or fire effect params class to do that.

//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;

	FS.DamageInt = class'FP7FireControl'.default.Damage;
	FS.Damage = String(FS.DamageInt)@"+"@class'FP7FireControl'.default.BaseDamage@"initial";

    FS.HeadMult = 1;
    FS.LimbMult = 1;

	FS.DPS = FS.DamageInt / 0.2;
	FS.TTK = 0.2 * (Ceil(175/FS.DamageInt ) - 1);
	FS.RPM = 5@"checks/second";
	FS.RPShot = 0;
	FS.RPS = 0;
	FS.FCPShot = 0;
	FS.FCPS = 0;
	FS.RangeOpt = "-";
	
	return FS;
}
*/

defaultproperties
{
     NoClipPreFireAnim="ThrowNoClip"
     SpawnOffset=(X=25.000000,Y=10.000000,Z=2.000000)
     BrassClass=Class'BallisticProV55.Brass_FP7Clip'
     BrassBone="tip"
     BrassOffset=(X=-20.000000,Z=-2.000000)
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Throw',Radius=32.000000,bAtten=True)
     PreFireAnim="PrepThrow"
     FireAnim="Throw"
     AmmoClass=Class'BallisticProV55.Ammo_FP7Grenades'
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BallisticProV55.FP7Thrown'
	 WarnTargetPct=0.9
}

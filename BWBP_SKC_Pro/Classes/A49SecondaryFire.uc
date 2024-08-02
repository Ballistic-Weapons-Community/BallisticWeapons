//=============================================================================
// A49 Secondary Fire.
//
// Reworked. Blasts enemies away in a cone. Can no longer be used as a mobility enhancer.
//
// - Azarael
//=============================================================================

class A49SecondaryFire extends BallisticFire;

var float	ForceMag;
var float	Damage;

simulated function bool AllowFire()
{
	if ((A49SkrithBlaster(Weapon).HeatLevel >= 12) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

function DoFireEffect()
{
	local Vector Start;
	local Rotator Aim;
	
	Start = Instigator.Location + Instigator.EyePosition();
	
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);
	
	A49SkrithBlaster(BW).ConicalBlast(Damage, 512, Vector(Aim));
	
	if (Level.NetMode == NM_DedicatedServer)
		A49SkrithBlaster(BW).AddHeat(HeatPerShot);
}

//Now we fly into space!
/*
simulated function ApplyRecoil()
{
	if (class'BallisticReplicationInfo'.static.IsClassic())
	{
		if (BW != None)
			BW.AddRecoil(FireRecoil, FireChaos, ThisModeNum);
		if (FirePushbackForce != 0 && Instigator!= None)
		{
			if (Instigator.Physics == PHYS_Falling)
				Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * FirePushbackForce * 0.25;
			else
				Instigator.Velocity -= Vector(Instigator.GetViewRotation()) * FirePushbackForce;
		}
	}
	else
	{
		super.ApplyRecoil();
	}
}*/

/*
FIXME: Special fire. Needs its own fire effect params class to do that.
//Accessor for stats
static function FireModeStats GetStats() 
{
	local FireModeStats FS;
	
	FS.DamageInt = default.Damage;
	FS.Damage = String(FS.DamageInt);

    FS.HeadMult = 1;
    FS.LimbMult = 1;

	FS.DPS = default.Damage / default.FireRate;
	FS.TTK = default.FireRate * (Ceil(175/default.Damage) - 1);
	FS.RPM = 1/default.FireRate@"blasts/second";
	FS.RangeOpt = "Max:"@(512/ 52.5)@"metres";
	
	return FS;
}
*/

defaultproperties
{
    FirePushbackForce=1500.000000
	Damage=35.000000
    forceMag=1000.000000
	HeatPerShot=9
    AmmoClass=Class'BallisticProV55.Ammo_Cells'
    ShakeRotMag=(X=128.000000,Y=64.000000)
    ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
    ShakeRotTime=2.000000
    ShakeOffsetMag=(X=-12.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=2.000000
    BotRefireRate=0.900000
}

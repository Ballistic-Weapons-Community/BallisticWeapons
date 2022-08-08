//=============================================================================
// A42PrimaryFireSpread.
//
// Rapid fire projectiles. Shoots a ring of 3
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A42PrimaryFireSpread extends BallisticProProjectileFire;

var byte Shots;
var byte Cycle;
var() float HeatPerShot;
var() int FireSpread;

simulated function bool AllowFire()
{
    if (!super.AllowFire() /*|| A48SkrithPistolBal(BW).bIsCharging || A48SkrithPistolBal(BW).bOverheat*/)
    {
        return false;
    }
    return true;
}
simulated event ModeDoFire()
{
    if (FRand() > 0.5)
		FireAnim = 'Fire1';
	else
		FireAnim = 'Fire2';


    super.ModeDoFire();

    if (BW.MagAmmo == 0)
       BW.ServerStartReload();

}
function DoFireEffect()
{
	Super.DoFireEffect();
    //A48SkrithPistolBal(Weapon).AddHeat(HeatPerShot * Shots);
}
function SpawnProjectile (Vector Start, Rotator Dir)
{
	local int i;
	local rotator R;

    Shots = FMin(default.Shots, BW.MagAmmo);

	ConsumedLoad = (AmmoPerFire * Shots);
	for (i=0;i<Shots;i++)
	{
        R.Roll = (65536.0 / 3) * Cycle + (65536.0 / 12);
        Dir = Rotator(GetFireSpread() >> Dir);

		Proj = Spawn (ProjectileClass,,, Start, rotator((Vector(rot(0,1,0)*FireSpread) >> R) >> Dir) );
		Proj.Instigator = Instigator;

        //log("SkrithPistol PrimaryFire: isSlave: "$BallisticHandgun(BW).IsSlave()$" Cycle: "$Cycle$" Shot: "$i$" Heat Added: "$(HeatPerShot*ConsumedLoad)$" Current Heat: "$A48SkrithPistolBal(BW).Heat);
        Cycle++;
		if (Cycle > 3)
            Cycle = 1;
	}
}
function PlayFiring()
{
    if (level.NetMode == NM_Client)
	{
		//A48SkrithPistolBal(Weapon).AddHeat(HeatPerShot * Shots);
	}
	super.PlayFiring();
}
defaultproperties
{
     Cycle=1
     Shots=3
     HeatPerShot=0.081000
     FireSpread=120
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-7.000000)
     bPawnRapidFireAnim=True
     FireEndAnim=
     TweenTime=0.000000
	AmmoClass=Class'BallisticProV55.Ammo_A42Charge'
     AmmoPerFire=1
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.300000
}

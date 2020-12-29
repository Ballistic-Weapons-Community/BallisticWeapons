//=============================================================================
// E-V PC Mk66 Secondary
//
// Spam of death.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk66SecondaryFire extends BallisticProProjectileFire;

simulated function bool AllowFire()
{
	if ((HVPCMk66PlasmaCannon(Weapon).HeatLevel >= 10.50) || HVPCMk66PlasmaCannon(Weapon).bIsVenting || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
 	HVPCmk66PlasmaCannon(BW).AddHeat(0.25);
 	if (Instigator == None || Weapon == None || Instigator.Health < 1)
 		 return;
	Super.PlayFiring();
}

function DoFireEffect()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
    local int SpawnCount;
    
    if (level.Netmode == NM_DedicatedServer)
    	 HVPCmk66PlasmaCannon(BW).AddHeat(0.25);
     
	 if (Instigator == None || Weapon == None || Instigator.Health < 1)
 		 return;

    Weapon.GetViewAxes(X,Y,Z);
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartTrace, Start, false);
    if (Other != None)
    {
        StartTrace = HitLocation;
    }

    SpawnCount = 1;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);
    SpawnProjectile(StartTrace, Aim);
    
    if(InStr(Level.Game.GameName, "Freon") != -1 && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(load, 1);

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
}

defaultproperties
{
     SpawnOffset=(X=10.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BallisticProV55.RSNovaFastMuzzleFlash'
     FireRecoil=100.000000
     FireChaos=0.050000
     XInaccuracy=2.000000
     YInaccuracy=2.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4Pro.BFG.BFG-SmallFire',Volume=2.000000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="Fire2"
     FireEndAnim=
     FireRate=0.110000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_HVPCCells'
     AmmoPerFire=4
     ShakeRotMag=(X=16.000000,Y=4.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-4.000000)
     ShakeOffsetRate=(X=-1200.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBPRecolorsPro.HVPCMk66ProjectileSmall'
     WarnTargetPct=0.200000
}

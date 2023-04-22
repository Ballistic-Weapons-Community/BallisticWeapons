//=============================================================================
// Extreme Voltage PC Primary Fire
//
// Balls of death
//=============================================================================
class HVPCMk66PrimaryFire extends BallisticProProjectileFire;

var   float		StopFireTime;
var() Sound			FailSound;

simulated function bool AllowFire()
{
	if ((HVPCMk66PlasmaCannon(Weapon).HeatLevel >= 9.5) || HVPCMk66PlasmaCannon(Weapon).bIsVenting || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	HVPCMk66PlasmaCannon(BW).AddHeat(5.00);
}

function StopFiring()
{
	bIsFiring=false;
	StopFireTime = level.TimeSeconds;
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
   {
       StartProj = HitLocation;
	 Weapon.PlaySound(FailSound, SLOT_Misc, 1.3);
   }

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
		
	if (Weapon.Role == ROLE_Authority  && class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(xPawn(Weapon.Owner).PlayerReplicationInfo).AddFireStat(1, 1);

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
	if (level.Netmode == NM_DedicatedServer)
		HVPCMk66PlasmaCannon(BW).AddHeat(5.00);
}

defaultproperties
{
     FailSound=Sound'BWBP_SKC_Sounds.HyperBeamCannon.343Primary-Fail'
     SpawnOffset=(X=100.000000,Y=10.000000,Z=-9.000000)
     MuzzleFlashClass=Class'BWBP_SKC_Pro.BFGFlashEmitter'
     FireRecoil=820.000000
     FireChaos=0.600000
     XInaccuracy=8.000000
     YInaccuracy=4.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.BFG.BFG-Fire',Volume=4.500000,Slot=SLOT_Interact,bNoOverride=False)
     FireAnim="Fire2"
     FireEndAnim=
     FireRate=2.500000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=100
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1200.000000)
     ShakeOffsetTime=1.500000
     ProjectileClass=Class'BWBP_SKC_Pro.HVPCMk66Projectile'
     WarnTargetPct=0.200000
}

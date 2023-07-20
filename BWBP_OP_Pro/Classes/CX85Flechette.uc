//=============================================================================
// CX85Flechette.
//
// Rapid spike that deals impact damage and causes bleed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class CX85Flechette extends BallisticProjectile;

var   actor		Target;				// The actor we are trying to anihilate
var   vector	LastLoc;			// Place where target was last seen, used to guide the rocket
var() float		TurnRate;			// Rate of rotation towards target. Rotator units per seconds.
var() bool		bSeeking;			// Seeking mode on. Trying to get to our target point
var() float		LastSendTargetTime; // Time when a target location has been set, used for difference formula

var() CX85AssaultWeapon  Master;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		Target, LastLoc;

}

//===========================================================================
// Tracking Code
//===========================================================================
function SetFlechetteTarget(Actor Targ)
{
	local vector HitLoc, HitNorm, Start, End;
	local Actor T;

	Target = Targ;
	if (Target != None)
		LastLoc = Target.Location;
	else
	{
 		Start = Instigator.Location + Instigator.EyePosition();
		End = Start + Vector(Instigator.GetViewRotation()) * 20000;
		T = Instigator.Trace(HitLoc, HitNorm, End, Start, true);
		if (T != None)
			LastLoc = HitLoc;
		else
			LastLoc = End;
	}
}

function SetFlechetteDestination()
{
	if (Master != None && Master.StuckDarts.Length != 0)
	{
		LastLoc = Master.GetFlechetteTarget();
		if (LastLoc != vect(0,0,0))
			bSeeking = true;
	}
}

simulated event Tick(float DT)
{
	local vector V, X,Y,Z, ScrewCenter;
	local Rotator R, AxisDir;
	local float TurnNeeded;
	
	// Query the master weapon for a target lock
	if (Role == ROLE_Authority && level.TimeSeconds - LastSendTargetTime > 0.04)
	{
		LastSendTargetTime = level.TimeSeconds;
		SetFlechetteDestination();
	}
	
	if (bSeeking)  // Guide the projectile if the previous call returned a valid lock
	{
		V = LastLoc - Location;

		// Align velocity towards target, but limit how fast rocket can turn. Use a tricky units per second rate limit.
		X = Normal(Velocity);
		Y = Normal(V cross Velocity);
		Z = Normal(X cross Y);
		AxisDir = OrthoRotation(X,Y,Z);

		TurnNeeded = acos(Normal(V) Dot Normal(Velocity)) * (32768 / Pi);

		R.Pitch = FMin( TurnRate*DT, TurnNeeded );
		GetAxes(R,X,Y,Z);
		X = X >> AxisDir;
		Y = Y >> AxisDir;
		Z = Z >> AxisDir;
        R = OrthoRotation(X,Y,Z);
		Velocity = Normal(Vector(R)) * Speed;

		if (Normal(Velocity) Dot Normal (V) > 0.6 && VSize(V) < Speed * 0.1)
			bSeeking = false;
	}
	
}

simulated event Landed( vector HitNormal )
{
	HitWall( HitNormal, Level );
}

defaultproperties
{
    WeaponClass=Class'BWBP_OP_Pro.CX85AssaultWeapon'
     TurnRate=32768.000000
     ImpactManager=Class'BallisticProV55.IM_XMK5Dart'
     TrailClass=Class'BallisticProV55.PineappleTrail'
     //bRandomStartRotaion=False
     TrailOffset=(X=-4.000000)
     MyRadiusDamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=10000.000000
    AccelSpeed=1000.000000
     MaxSpeed=10000.000000
     Damage=85.000000
     DamageRadius=192.000000
     MomentumTransfer=20000.000000
     MyDamageType=Class'BWBP_OP_Pro.DTCX85Bullet'
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.MRL.MRLRocket'
     AmbientSound=Sound'BW_Core_WeaponSound.MRL.MRL-RocketFly'
     SoundVolume=64
     //Physics=PHYS_Falling
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}

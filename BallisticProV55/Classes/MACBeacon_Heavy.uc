//=============================================================================
// MACBeacon.
//
// Used to simulated the path of a HAMR artillery shell
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACBeacon_Heavy extends MACBeacon;

simulated function PostBeginPlay()
{
	super(BallisticProjectile).PostBeginPlay();
}

simulated function InitEffects ()
{
	local rotator LR;

	super.InitEffects();

	if (Owner != None && MACWeapon(Owner) != None)
	{
		if (Owner.Instigator != None)
			LR = Owner.Instigator.GetViewRotation();
		else
			LR = Rotation;
		if (Trail != None)
			MacWeapon(Owner).AddBeacon(self, Location, LR, MACBeaconTrail(Trail));
		else
			MacWeapon(Owner).AddBeacon(self, Location, LR, None);
	}
}

simulated function ProcessTouch (Actor Other, vector HitLocation);

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local MacExplodeSphere Sphere;

	Sphere = Spawn(class'MacExplodeSphere', self, , HitLocation);
	if (Owner != None && MACWeapon(Owner) != None)
		MACWeapon(Owner).BeaconHit(self, HitLocation, Sphere);

	Destroy();
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Emitters[1].Disabled=true;
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     Damage=135.000000
     DamageRadius=256.000000
}

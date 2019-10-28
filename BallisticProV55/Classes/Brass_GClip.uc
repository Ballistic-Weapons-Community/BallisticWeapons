//=============================================================================
// Brass_GClip.
//
// The detatchable clip from the NRP57 grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_GClip extends BWBrass_Default;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	RotationRate.Pitch = 32768 + 32768*FRand();
}

defaultproperties
{
     StartVelocity=(X=20.000000,Y=0.000000)
     bHitSounds=False
     StaticMesh=StaticMesh'BallisticHardware2.Brass.GrenadeClip'
     DrawScale=0.300000
}

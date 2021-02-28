//=============================================================================
// Brass_XClip.
//
// The detatchable clip from the XM84 grenade
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_XClip extends BWBrass_Default;

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
	RotationRate.Pitch = 32768 + 32768*FRand();
}

defaultproperties
{
     StartVelocity=(X=20.000000,Y=0.000000)
     bHitSounds=False
     StaticMesh=StaticMesh'BWBP_SKC_Static.XM84.XM84Clip'
     DrawScale=1.500000
}

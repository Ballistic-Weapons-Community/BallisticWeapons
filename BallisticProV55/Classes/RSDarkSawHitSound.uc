//=============================================================================
// RSDarkSawHitSound.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkSawHitSound extends Actor;

function SetNoise (Sound NewSound)
{
	AmbientSound = NewSound;

	SetTimer(0.15, false);
}

event Timer()
{
	AmbientSound = None;
}

defaultproperties
{
     bHidden=True
     RemoteRole=ROLE_None
     bFullVolume=True
     SoundVolume=255
     SoundRadius=32.000000
}

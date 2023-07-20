//=============================================================================
// Brass_SAR.
//
// A rifle shell casing that flies out left
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Brass_M7A3AR extends BWBrass_Default;

defaultproperties
{
     RandomDir=(Pitch=1024,Yaw=1024,Roll=1024)
     StartVelocity=(X=10.000000,Y=-60.000000,Z=20.000000)
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Brass.EmptyRifleRound'
     DrawScale=0.090000
     RotationRate=(Pitch=16384,Yaw=32768)
}

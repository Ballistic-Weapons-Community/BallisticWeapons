//=============================================================================
// BallisticStump.
//
// An stump actor attached to corpses where limbs have been severed
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticStump extends Effects;

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BWGoreHardwarePro.Stumps.LimbStump'
     AmbientGlow=16
     bUnlit=False
     bHardAttach=True
}

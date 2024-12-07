//=============================================================================
// Augment_3XScope.
//
// Gen 1 IR scope. Has the purple overlay, inferior to integrated IRNV and xray
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Augment_IRScope extends BallisticGunAugment;

defaultproperties
{
     DrawType=DT_StaticMesh
     bOnlyDrawIfAttached=True
     RemoteRole=ROLE_None
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Attach_IRScope'
     DrawScale=0.060000
}

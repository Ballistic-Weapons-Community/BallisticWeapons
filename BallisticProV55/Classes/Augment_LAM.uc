//=============================================================================
// Augment_LAM.
//
// Laser Aiming Module with laser + torch
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Augment_LAM extends BallisticGunAugment;

defaultproperties
{
     DrawType=DT_StaticMesh
     bOnlyDrawIfAttached=True
     RemoteRole=ROLE_None
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Attach_LAM'
     DrawScale=0.060000
}

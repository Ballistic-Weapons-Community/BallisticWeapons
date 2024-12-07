//=============================================================================
// Augment_Tazer.
//
// A bit that shoots a zappy thing, or maybe a tracky thing?
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Augment_Tazer extends BallisticGunAugment;

defaultproperties
{
     DrawType=DT_StaticMesh
     bOnlyDrawIfAttached=True
     RemoteRole=ROLE_None
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Attach_Tazer'
     DrawScale=0.060000
}

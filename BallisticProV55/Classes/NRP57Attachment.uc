//=============================================================================
// NRP57Attachment.
//
// 3rd person weapon attachment for NRP57 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class NRP57Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BallisticProV55.IM_NRP57Grenade'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.NRPGrenade_TPm'
     DrawScale=0.100000
}

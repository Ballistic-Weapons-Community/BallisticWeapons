//=============================================================================
// ScarabAttachment.
//
// 3rd person weapon attachment for NRP57 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ScarabAttachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BallisticProV55.IM_NRP57Grenade'
     GrenadeSmokeClass=Class'BWBP_APC_Pro.ScarabTrail'
     Mesh=SkeletalMesh'BWBP_CC_Anim.CruGren_TPm'
     DrawScale=0.250000
}

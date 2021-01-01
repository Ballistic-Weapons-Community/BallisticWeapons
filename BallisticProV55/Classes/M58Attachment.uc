//=============================================================================
// M58Attachment.
//
// 3rd person weapon attachment for M58 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M58Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
     ExplodeManager=Class'BallisticProV55.IM_Grenade'
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.T10_TPm'
     DrawScale=0.175000
	 Skins(0)=Texture'BW_Core_WeaponTex.M58.M58GrenadeSkin'
}

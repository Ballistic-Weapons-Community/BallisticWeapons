//=============================================================================
// T10Attachment.
//
// 3rd person weapon attachment for T10 Grenade.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class G28Attachment extends BallisticGrenadeAttachment;

defaultproperties
{
	WeaponClass=class'G28Grenade'
	ExplodeManager=class'IM_Grenade'
	Mesh=SkeletalMesh'BWBP_SKC_Anim.G28_TPm'
	RelativeLocation=(X=0.000000,Y=-3.000000,Z=4.000000)
	RelativeRotation=(Pitch=32768)
	DrawScale=0.350000
}

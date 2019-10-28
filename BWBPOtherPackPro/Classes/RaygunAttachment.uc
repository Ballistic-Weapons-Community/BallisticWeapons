//=============================================================================
// A73Attachment.
//
// 3rd person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RaygunAttachment extends HandgunAttachment;

defaultproperties
{
     MuzzleFlashClass=Class'BWBPOtherPackPro.RaygunMuzzleFlash'
     AltMuzzleFlashClass=Class'BWBPOtherPackPro.RaygunMuzzleFlashAlt'
     FlashScale=2.000000
     BrassMode=MU_None
     FlashMode=MU_Both
     ReloadAnim="Reload_MG"
     ReloadAnimRate=2.000000
     bAltRapidFire=True
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Raygun_TP'
     RelativeLocation=(Z=7.000000)
     DrawScale=0.350000
     SoundRadius=256.000000
}

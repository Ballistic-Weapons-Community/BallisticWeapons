//=============================================================================
// A73Attachment.
//
// 3rd person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RaygunAttachment extends BallisticAttachment;

simulated function Vector GetTipLocation()
{
    local Coords C;

	if (Instigator.IsFirstPerson())
		C = Instigator.Weapon.GetBoneCoords('tip');
	else
		C = GetBoneCoords('tip');
    return C.Origin;
}

defaultproperties
{
     TracerClass=Class'TraceEmitter_Raygun'
	 TracerChance=1
	 ImpactManager=Class'IM_Raygun'
     MuzzleFlashClass=Class'BWBPOtherPackPro.RaygunMuzzleFlash'
     AltMuzzleFlashClass=Class'BWBPOtherPackPro.RaygunMuzzleFlashAlt'
     FlashScale=2.000000
	 TracerMode=MU_Secondary
     InstantMode=MU_Secondary
	 LightMode=MU_Secondary
     BrassMode=MU_None
     FlashMode=MU_Both
     ReloadAnim="Reload_MG"
     ReloadAnimRate=2.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBPOtherPackAnim.Raygun_TP'
     RelativeLocation=(Z=7.000000)
     DrawScale=0.350000
     SoundRadius=256.000000
}

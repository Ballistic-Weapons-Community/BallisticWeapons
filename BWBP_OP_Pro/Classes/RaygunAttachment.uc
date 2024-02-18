//=============================================================================
// A73Attachment.
//
// 3rd person weapon attachment for A73 Skrith Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RaygunAttachment extends BallisticAttachment;

// Return the location of the muzzle.
simulated function Vector GetModeTipLocation(optional byte Mode)
{
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return Instigator.Weapon.GetEffectStart();
		
	return GetBoneCoords('tip').Origin;
}

defaultproperties
{
	WeaponClass=class'Raygun'
     TracerClass=Class'TraceEmitter_Raygun'
	 TracerChance=1
	 ImpactManager=Class'IM_Raygun'
     MuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlash'
     AltMuzzleFlashClass=Class'BWBP_OP_Pro.RaygunMuzzleFlashAlt'
     FlashScale=2.000000
	 TracerMode=MU_Secondary
     InstantMode=MU_Secondary
	 LightMode=MU_Secondary
     BrassMode=MU_None
     FlashMode=MU_Both
     ReloadAnim="Reload_MG"
     ReloadAnimRate=2.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.TPm_Raygun'
     RelativeLocation=(Z=7.000000)
     DrawScale=0.350000
     SoundRadius=256.000000
}

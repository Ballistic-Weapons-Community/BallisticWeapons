//=============================================================================
// MJ51Attachment.
//
// 3rd person weapon attachment for MJ51 Carbine
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class SRKSmgAttachment extends BallisticAttachment;

var bool		bGrenadier;
var bool		bOldGrenadier;

replication
{
	reliable if ( Role==ROLE_Authority )
		 bGrenadier;
}

simulated event PostNetReceive()
{
	if (bGrenadier != bOldGrenadier)
	{
		bOldGrenadier = bGrenadier;
		if (bGrenadier)
			SetBoneScale (5, 1.0, 'Grenade');
		else
			SetBoneScale (5, 0.0, 'Grenade');
	}
	Super.PostNetReceive();
}

function IAOverride(bool bGrenadier)
{
	if (bGrenadier)
		SetBoneScale (5, 1.0, 'Grenade');
	else
		SetBoneScale (5, 0.0, 'Grenade');
}

defaultproperties
{
	 WeaponClass=class'SRKSubMachinegun'
     MuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     AltMuzzleFlashClass=Class'BallisticProV55.M50FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     FlashScale=0.100000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     InstantMode=MU_Both
     FlashMode=MU_Both
     LightMode=MU_Both
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Both
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_OP_Anim.TPm_SRK'
     DrawScale=1.00000
     PrePivot=(Y=-1.000000,Z=-5.000000)
}

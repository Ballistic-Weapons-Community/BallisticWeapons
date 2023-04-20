//=============================================================================
// XMK5Attachment.
//
// 3rd person weapon attachment for XMK5 SubMachinegun
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5Attachment extends BallisticAttachment;

defaultproperties
{
	WeaponClass=class'XMK5SubMachinegun'
     MuzzleFlashClass=class'XK2FlashEmitter'
     ImpactManager=class'IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=class'Brass_XMK5SMG'
     TracerClass=class'TraceEmitter_Default'
     WaterTracerClass=class'TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.XMK5_TPm'
     DrawScale=0.325000
}

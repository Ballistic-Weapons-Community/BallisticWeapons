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
     MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_Bullet'
     AltFlashBone="tip2"
     BrassClass=Class'BallisticProV55.Brass_XMK5SMG'
     TracerClass=Class'BallisticProV55.TraceEmitter_Default'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_AR"
     ReloadAnimRate=1.250000
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.XMK5_TPm'
     DrawScale=0.325000
}

//=============================================================================
// AH208Attachment.
//
// 3rd person weapon attachment for AH208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH208Attachment extends HandgunAttachment;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, 'Scope');
	SetBoneScale (1, 0.0, 'Compensator');
	SetBoneScale (2, 0.0, 'LAM');
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.D49FlashEmitter'
     ImpactManager=Class'BallisticProV55.IM_BigBullet'
     MeleeImpactManager=Class'BallisticProV55.IM_GunHit'
     FlashScale=0.250000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassBone="Scope"
     TracerClass=Class'BallisticProV55.TraceEmitter_Pistol'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     FlyBySound=(Sound=SoundGroup'BallisticSounds2.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.850000
     CockAnimRate=0.900000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.TP_Eagle'
     RelativeLocation=(Z=6.000000)
     DrawScale=0.220000
     Skins(0)=Shader'BallisticRecolors4TexPro.Eagle.Eagle-GoldShine'
     Skins(1)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-Misc'
     Skins(2)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-ScopeGold'
     Skins(3)=Texture'BallisticRecolors4TexPro.Eagle.Eagle-FrontSilver'
}

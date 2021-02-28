//=============================================================================
// AH250Attachment.
//
// 3rd person weapon attachment for AH208 Pistol
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AH250Attachment extends HandgunAttachment;
var Vector		SpawnOffset;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	SetBoneScale (0, 0.0, 'RedDotSight');
	SetBoneScale (1, 0.0, 'LAM');
}

simulated function Vector GetTipLocation()
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (AH250Pistol(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			Loc = Instigator.Location + Instigator.EyePosition() + X*20 + Z*-10;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;

    return Loc;
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
     FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
     ReloadAnim="Reload_Pistol"
     CockingAnim="Cock_RearPull"
     ReloadAnimRate=0.850000
     CockAnimRate=0.900000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.AHDeagle_TPm'
     RelativeLocation=(Z=6.000000)
     DrawScale=0.220000
     Skins(0)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MainBlack'
	 Skins(1)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MainBlack'
     Skins(2)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack'
     Skins(3)=Texture'BWBP_SKC_Tex.Eagle.Eagle-Scope'
     Skins(4)=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontBlack'
}

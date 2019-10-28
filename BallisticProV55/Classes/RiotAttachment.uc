//=============================================================================
// RiotAttachment
//
// Attachment for the riot shield.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RiotAttachment extends BallisticMeleeAttachment;

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_Katana'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     IdleHeavyAnim="RifleHip_Idle"
     IdleRifleAnim="RifleHip_Idle"
     bHeavy=True
     AttachmentBone="bip01 l hand"
     Mesh=SkeletalMesh'BallisticProAnims.Riot_3rd'
     RelativeLocation=(X=-5.000000,Y=-17.000000,Z=20.000000)
     RelativeRotation=(Pitch=30000,Yaw=30000,Roll=12000)
     DrawScale=0.175000
}

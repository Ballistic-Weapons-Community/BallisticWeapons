//=============================================================================
// FP9Attachment.
//
// _TPm person weapon attachment for FP9 Explosive.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP9Attachment extends BallisticAttachment;

var Actor LeftOne;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Instigator != None)
	{
		LeftOne = Spawn(class'FP9LeftBombAttach');
		Instigator.AttachToBone(LeftOne,'lfarm');
	}
}

simulated function  Destroyed()
{
	if (LeftOne != None)
		LeftOne.Destroy();
	super.Destroyed();
}

defaultproperties
{
     BrassMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Primary
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FP9Det_TPm'
     DrawScale=0.200000
}

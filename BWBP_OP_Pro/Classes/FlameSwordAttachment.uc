//=============================================================================
// DragonsToothAttachment.
//
// Attachment for the Dragon's Tooth Sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FlameSwordAttachment extends BallisticMeleeAttachment;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	if (Instigator != None)
	{
		if (Owner == None || Instigator == Owner)
		LightType = LT_None;
	}
}

defaultproperties
{
	WeaponClass=class'FlameSword'
     ImpactManager=Class'BWBP_SKC_Pro.IM_DTS'
     BrassMode=MU_None
     InstantMode=MU_Both
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=64
     LightBrightness=150.000000
     LightRadius=64.000000
     bDynamicLight=True
     AmbientSound=Sound'BWBP_OP_Sounds.FlameSword.FlameSword-IdleLite'
     Mesh=SkeletalMesh'BWBP_OP_Anim.FlameSword_TPm'
     RelativeLocation=(Z=6.000000)
	 RelativeRotation=(Pitch=32768)
     DrawScale=0.700000
     bFullVolume=True
     SoundVolume=255
     SoundRadius=256.000000
     TransientSoundVolume=2.000000
     TransientSoundRadius=256.000000
}

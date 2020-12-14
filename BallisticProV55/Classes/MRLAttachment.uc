//=============================================================================
// MRLAttachment.
//
// _TPm person weapon attachment for MRL
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLAttachment extends BallisticAttachment;

var byte BarrelIndex;

simulated function FlashMuzzleFlash(byte Mode)
{
	if (FlashMode == MU_None || (FlashMode == MU_Secondary && Mode == 0) || (FlashMode == MU_Primary && Mode != 0))
		return;
	if (Instigator != None && Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (Mode == 0 && MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
		{
			class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, DrawScale*FlashScale, self, FlashBone);
	    	MRLFlashEmitter(MuzzleFlash).InitMRLFlash(MuzzleFlash.DrawScale);
		}
		MRLFlashEmitter(MuzzleFlash).SetBarrelIndex(BarrelIndex);
		BarrelIndex++;
		if (BarrelIndex > 17)
			BarrelIndex = 0;
		MuzzleFlash.Trigger(self, Instigator);
	}
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.MRLFlashEmitter'
     BrassMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_Both
     bRapidFire=True
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.MRL_TPm'
     DrawScale=0.250000
}

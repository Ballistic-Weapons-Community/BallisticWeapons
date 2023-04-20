//=============================================================================
// AT40's third person attachment.
//
// Since it doesn't much matter which bones flash in TPV as long as the back and front positions match
// and it's a different position every time the weapon's fired, this attachment cycles through available 
// outlets in order.
//
// TODO: Make this attachment fire off the corresponding number of times when the altfire is used.
//=============================================================================
class FLASHAttachment extends BallisticAttachment;

var name BackBones[4];
var name FrontBones[4];
var byte Index;

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (AltMuzzleFlash == None)
		{
			AltMuzzleFlash = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(AltMuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(AltMuzzleFlash), DrawScale*FlashScale);
			AltMuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(AltMuzzleFlash) != None)
				DGVEmitter(AltMuzzleFlash).InitDGV();

			AttachToBone(AltMuzzleFlash, BackBones[Index]);
		}
		AltMuzzleFlash.Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{
		if (MuzzleFlash == None)
		{
			MuzzleFlash = Spawn(MuzzleFlashClass, self);
			if (Emitter(MuzzleFlash) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(MuzzleFlash), DrawScale*FlashScale);
			MuzzleFlash.SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(MuzzleFlash) != None)
				DGVEmitter(MuzzleFlash).InitDGV();
				
			AttachToBone(MuzzleFlash, FrontBones[Index]);
		}
		MuzzleFlash.Trigger(self, Instigator);
	}
	
	Index++;
	if (Index > 3)
		Index = 0;
}

defaultproperties
{
	WeaponClass=class'FLASHLauncher'
     BackBones(0)="back1"
     BackBones(1)="back2"
     BackBones(2)="back3"
     BackBones(3)="back4"
     FrontBones(0)="tip"
     FrontBones(1)="tip2"
     FrontBones(2)="tip3"
     FrontBones(3)="tip4"
     MuzzleFlashClass=class'G5FlashEmitter'
     AltMuzzleFlashClass=class'G5BackFlashEmitter'
     ImpactManager=class'IM_Bullet'
     AltFlashBone="back1"
     FlashScale=1.200000
     BrassMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_Both
	 ReloadAnim="Reload_MG"
	 ReloadAnimRate=1.00000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FLASH_TPm'
     DrawScale=0.600000
     PrePivot=(Z=5.000000)
}

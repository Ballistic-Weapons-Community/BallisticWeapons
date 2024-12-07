//=============================================================================
// G5Attachment.
//
// 3rd person weapon attachment for G5 Bazooka
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AkeronAttachment extends BallisticAttachment;

var name BackBones[3];
var name FrontBones[3];
var byte Index;

var array<Actor> BackFlashes[3];
var array<Actor> FrontFlashes[3];

// This assumes flash actors are triggered to make them work
// Override this in subclassed for better control
simulated function FlashMuzzleFlash(byte Mode)
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;

	if (AltMuzzleFlashClass != None)
	{
		if (BackFlashes[Index] == None)
		{
			BackFlashes[Index] = Spawn(AltMuzzleFlashClass, self);
			if (Emitter(BackFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(BackFlashes[Index]), DrawScale*FlashScale);
			BackFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(BackFlashes[Index]) != None)
				DGVEmitter(BackFlashes[Index]).InitDGV();

			AttachToBone(BackFlashes[Index], BackBones[Index]);
		}
		BackFlashes[Index].Trigger(self, Instigator);
	}
	if (MuzzleFlashClass != None)
	{
		if (FrontFlashes[Index] == None)
		{
			FrontFlashes[Index] = Spawn(MuzzleFlashClass, self);
			if (Emitter(FrontFlashes[Index]) != None)
				class'BallisticEmitter'.static.ScaleEmitter(Emitter(FrontFlashes[Index]), DrawScale*FlashScale);
			FrontFlashes[Index].SetDrawScale(DrawScale*FlashScale);
			if (DGVEmitter(FrontFlashes[Index]) != None)
				DGVEmitter(FrontFlashes[Index]).InitDGV();
				
			AttachToBone(FrontFlashes[Index], FrontBones[Index]);
		}
		FrontFlashes[Index].Trigger(self, Instigator);
	}
	
	Index++;
	if (Index > 2)
		Index = 0;
}

simulated event Destroyed()
{
	local int i;

	for (i=0; i<3; i++)
	{
		class'BUtil'.static.KillEmitterEffect (FrontFlashes[i]);
		class'BUtil'.static.KillEmitterEffect (BackFlashes[i]);
	}

	Super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'AkeronLauncher'
    BackBones(0)="backblast"
    BackBones(1)="backblast2"
    BackBones(2)="backblast3"
    FrontBones(0)="tip"
    FrontBones(1)="tip2"
    FrontBones(2)="tip3"
    MuzzleFlashClass=class'G5FlashEmitter'
    AltMuzzleFlashClass=class'G5BackFlashEmitter'
    ImpactManager=class'IM_Bullet'
    FlashScale=0.750000
    BrassMode=MU_None
    InstantMode=MU_None
	ReloadAnimRate=0.460000
    Mesh=SkeletalMesh'BWBP_OP_Anim.Akeron_TPm'
    RelativeLocation=(Z=5.000000)
    RelativeRotation=(Pitch=-32768)
    DrawScale=0.280000
}

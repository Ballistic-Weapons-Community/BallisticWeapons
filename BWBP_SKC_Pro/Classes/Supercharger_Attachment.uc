//=============================================================================
// Supercharger_Attachment.
//
// by SK based on code by DC
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_Attachment extends BallisticAttachment;

var Actor 		Pack;			// The Backpack To Add


simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	Pack = Spawn(class'HVCMk9Pack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
}

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
}

simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'Supercharger_AssaultWeapon'
	MuzzleFlashClass=class'PlasmaFlashEmitter'
	ImpactManager=Class'BWBP_SKC_Pro.IM_Supercharge'
	AltFlashBone="tip"
	BrassMode=MU_Neither
	InstantMode=MU_Both
	TracerMode=MU_Primary
	FlashMode=MU_Both
	TracerClass=Class'BWBP_SKC_Pro.TraceEmitter_Supercharge'
	FlashScale=0.200000
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Primary
	FlyBySound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FlyBy',Volume=0.300000)
	bRapidFire=True
	bAltRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.SuperCharger_TPm'
	RelativeRotation=(Pitch=32768)
	DrawScale=1.100000
}

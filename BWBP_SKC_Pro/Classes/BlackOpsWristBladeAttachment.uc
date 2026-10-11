//=============================================================================
// EKS43Attachment.
//
// Attachment for EKS43 sword.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BlackOpsWristBladeAttachment extends BallisticMeleeAttachment;

var Actor LeftOne;

// The blade on the other arm, unless the layout is the single blade
simulated function ApplyModel()
{
	Super.ApplyModel();

	if (LeftOne != None || Instigator == None || level.NetMode == NM_DedicatedServer
		|| LayoutIndex >= WeaponClass.static.GetParams().default.Layouts.Length)
		return;

	if (InStr(WeaponClass.static.GetParams().default.Layouts[LayoutIndex].LayoutTags, "single") == -1)
	{
		LeftOne = Spawn(class'BlackOpsWristBladeLeft');
		Instigator.AttachToBone(LeftOne,'bip01 l hand');
	}
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (LeftOne != None)
		LeftOne.bHidden = NewbHidden;
}

// The left blade is an actor of its own and has to be given the overlays (invisibility, UDamage) this blade gets
simulated event Tick(float DT)
{
	Super.Tick(DT);

	if (LeftOne != None && LeftOne.OverlayMaterial != OverlayMaterial)
		LeftOne.SetOverlayMaterial(OverlayMaterial, ClientOverlayCounter, true);
}

simulated function Destroyed()
{
	if (LeftOne != None)
		LeftOne.Destroy();

	super.Destroyed();
}

defaultproperties
{
	WeaponClass=class'BlackOpsWristBlade'
	ImpactManager=class'IM_Katana'
	BrassMode=MU_None
	InstantMode=MU_Both
	FlashMode=MU_None
	LightMode=MU_None
	TrackAnimMode=MU_Both
	bHeavy=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.BOB_TPm'
	RelativeLocation=(X=-12.000000,Y=-3.000000,Z=16.000000)
	DrawScale=0.500000
}

//=============================================================================
// LightningAttachment.
//
// 3rd person weapon attachment for HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5Attachment extends BallisticAttachment;

var Actor 		Pack;			// The Backpack

var bool		bDischarge, bDischargeOld;
var bool		bMilSpec;			// No backpack

var() Sound DischargeSound;			// Sound of water discharge

replication
{
	reliable if (Role == ROLE_Authority)
		bDischarge;
}
simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( Pack != None )
		Pack.SetOverlayMaterial(mat, time, bOverride);
}

function InitFor(Inventory I)
{
	Super.InitFor(I);

	if (HVPCMk5PlasmaCannon(I) != None && HVPCMk5PlasmaCannon(I).bMilSpec)
	{
		if (Pack != None)
			Pack.bHidden = true;
	}
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack != None)
		Pack.bHidden = NewbHidden;
}
simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (bMilSpec && Pack != None)
	{
		Pack.bHidden = true;
	}
}

simulated event PostNetReceive()
{
	if (bDischarge != bDischargeOld)
	{	
		bDischargeOld = bDischarge;
		DoWaterDischarge();
	}

	super.PostNetReceive();
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (bMilSpec)
		return;

	Pack = Spawn(class'HVPCPack');

	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');

	Pack.SetBoneScale(0, 0.0001, 'Bone03');
}
simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();

	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();

	super.Destroyed();
}

simulated function DoWaterDischarge()
{
	if (Role == ROLE_Authority)
		bDischarge = !bDischarge;
	if (level.NetMode == NM_DedicatedServer)
		return;
	spawn(class'IE_HVCDischarge', Instigator,, Instigator.Location);
	Instigator.PlaySound(DischargeSound, SLOT_None, 1.8, , 192, 1.0 , false);
}

defaultproperties
{
	WeaponClass=class'HVPCMk5PlasmaCannon'
	DischargeSound=Sound'BW_Core_WeaponSound.LightningGun.LG-WaterDischarge'
	AltMuzzleFlashClass=Class'BWBP_SKC_Pro.HVPCMuzzleFlash'
	ImpactManager=class'IM_HVCRedLightning'
	bDoWaterSplash=False
	FlashScale=2.500000
	TracerClass=class'TraceEmitter_HVCRedLightning'
	bHeavy=True
	bRapidFire=True
	Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_HVPC'
	DrawScale=1.000000
	RelativeRotation=(Pitch=32768)
}

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

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (Pack!= None)
		Pack.bHidden = NewbHidden;
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
     DischargeSound=Sound'BW_Core_WeaponSound.LightningGun.LG-WaterDischarge'
     AltMuzzleFlashClass=Class'BWBP_SKC_Pro.HVPCMuzzleFlash'
     ImpactManager=Class'BallisticProV55.IM_HVCRedLightning'
     bDoWaterSplash=False
     FlashScale=2.500000
     TracerClass=Class'BallisticProV55.TraceEmitter_HVCRedLightning'
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.HVPC_TPm'
     DrawScale=1.000000
	 RelativeRotation=(Pitch=32768)
}

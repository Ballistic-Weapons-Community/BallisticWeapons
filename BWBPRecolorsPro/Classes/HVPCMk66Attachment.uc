//=============================================================================
// LightningAttachment.
//
// 3rd person weapon attachment for HVC-Mk9 Lightning Gun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCmk66Attachment extends BallisticAttachment;



var Actor 		Pack;			// The Backpack

var bool		bDischarge, bDischargeOld;
var byte		ChargePower;						// Power of secondary zap sent from server
var HVPCmk66PlasmaCannon	LG;							// Access to the lightning gun itself (only available to owner)

var Actor	Arc1;			// Decorative arc effects
var Actor	Arc2;
var Actor	Arc3;

var() Sound DischargeSound;			// Sound of water discharge

replication
{
	reliable if (Role==ROLE_Authority && bNetDirty)
		bDischarge, ChargePower;
	reliable if (Role==ROLE_Authority && bNetOwner && bNetInitial)
		LG;
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

function InitFor(Inventory I)
{
	Super.InitFor(I);
	if (I != None && HVPCmk66PlasmaCannon(I) != None)
		LG = HVPCmk66PlasmaCannon(I);
}

simulated function StartMuzzleZap()
{
	if (MuzzleFlash == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, class'HVPCMuzzleFlash', DrawScale*FlashScale, self, 'tip');
}
simulated function StopMuzzleZap()
{
	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	Pack = Spawn(class'HVPCPack');
	if (Instigator != None)
		Instigator.AttachToBone(Pack,'Spine');
	Pack.SetBoneScale(0, 0.0001, 'Bone03');
	if (level.DetailMode>DM_High)
	{
		if (Arc1 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc1, class'HVPCMk5_SideArc', DrawScale, self, 'Arc1');
		if (Arc2 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc2, class'HVPCMk66_TopArc',  DrawScale, self, 'Arc2');
		if (Arc3 == None)
			class'bUtil'.static.InitMuzzleFlash(Arc3, class'HVPCMk66_TopArc',  DrawScale, self, 'Arc3');
	}
}
simulated function Destroyed()
{
	if (Pack != None)
		Pack.Destroy();
	if (MuzzleFlash != None)
		MuzzleFlash.Destroy();
	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
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

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;

	if (Mode == 0)
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	SpawnTracer(Mode, mHitLocation);
	if (VSize(mHitLocation) < 2)
		return;
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		bTraceWater=true;
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir*10, mHitLocation - Dir*10, false,, HitMat);
		bTraceWater=false;

		if (mHitActor == None)
		{	HitLocation = mHitLocation; mHitNormal = -Dir;	}
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
     DischargeSound=Sound'BWBP2-Sounds.LightningGun.LG-WaterDischarge'
     AltMuzzleFlashClass=Class'BWBPRecolorsPro.HVPCMuzzleFlash'
     ImpactManager=Class'BallisticProV55.IM_HVCRedLightning'
     bDoWaterSplash=False
     FlashScale=2.500000
     TracerClass=Class'BallisticProV55.TraceEmitter_HVCRedLightning'
     bHeavy=True
     bRapidFire=True
     Mesh=SkeletalMesh'BWBP2b-Anims.HVC-3rd'
     DrawScale=0.150000
     Skins(0)=Texture'BallisticRecolors3TexPro.BFG.BFG-Skin'
     Skins(1)=FinalBlend'BWBP2-Tex.Lighter.LightGlassFinal'
}

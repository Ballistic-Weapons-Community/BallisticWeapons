//=============================================================================
// BallisticDecal.
//
// Improved base class for various types of decals
// Features:
// -DecalTextures allows random projector tex
// -Random rotation of projector
// -Random scale variance
// -ZoomDist to move projector closer or further away from surface
// -"Painted" decals designed to be projected onto actors, especially skeletal ones
// -Expanding settings make the decal change size over time
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticDecal extends Projector
	abstract;

// General Variables ----------------------------------------------------------
var(Decal) Array<Texture>	DecalTextures;		// Array of different possible textures to use for projection
var(Decal) bool				bRandomRotate;		// Randomly rotate the projection
var(Decal) float			StayTime;			// How long it stays for
var(Decal) float			ZoomDist;			// Move the projector closer or further from wall. Improves decal on rough geometry or painted player
var(Decal) float			DrawScaleVariance;	// Adds random amount to DrawScale. DrawScale = DrawScale * (1 + DrawScaleVariance * Random)
var(Decal) bool				bDynamicDecal;		// Reattaches each tick
var(Decal) bool				bOwnerOnly;			// Only appear on owner
var(Decal) bool				bWaitForInit;		// Prevents init of decal which must be started manually (prevents auto running of PostBeginPlay)
// ----------------------------------------------------------------------------

// Painting Variables ---------------------------------------------------------
// These vars are set when the decal is "painted" on players or similar actors
var   name					PaintBone;			// Bone to use for positioning and rotating
var	  Vector				PaintDir;			// Normal used for position of projector (relative to bone)
var   Rotator				PaintAngle;			// Angle used for rotation of projector (relative to bone)
var   bool					bPaintToBone;		// This decal is being painted on a player. Enables paining calculation. Set in InitPaintedDecal()
var   Actor					PaintedActor;		// Actor that is being painted
// ----------------------------------------------------------------------------

// Expanding Pool Vars --------------------------------------------------------
// These vars are used for decals that expand as time passes. Min and Max drawscale are multiplied by normal drawscale
var(DecalEx) float			MaxDrawScale;		// DrawScale when decal is finished expanding
var(DecalEx) float			MinDrawScale;		// DrawScale when decal first spawns
var(DecalEx) float			ExpandTime;			// How much time it takes for pool to get from min to max drawscale
var(DecalEx) bool			bAbandonOnFinish;	// Abandon decal when at max drawscale
var(DecalEx) bool			bExpandingDecal;	// Decal spawns at MinDrawScale and expands until it reaches MaxDrawScale
var			 float			ExpandTimePassed;	// How much time has passed since it began expanding
var			 float			InitialDrawScale;	// DrawScale before expansion
// ----------------------------------------------------------------------------

simulated event PreBeginPlay()
{
    if (Level.NetMode == NM_DedicatedServer || Level.DecalStayScale == 0.f)
    {
        Destroy();
        return;
    }

	if (DecalTextures.Length < 1)
	{
		 if (ProjTexture == None)
		 {
			log ("BallisticDecal:"$Self$" no ProjTexture", 'Warning');
			Destroy();
			return;
		 }
	}
	else
		ProjTexture = DecalTextures[Rand(DecalTextures.Length)];
	Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
	local Rotator Rot;

	// Don't init now, allow changing of properties first
	if (bWaitForInit)
		return;
	if (bRandomRotate)
	{
		Rot.Roll = Rand(65536);
		SetRotation (Rotation + Rot);
	}
	if (ZoomDist != 0)
		SetLocation (Location + Vector(Rotation) * ZoomDist);

	if (DrawScaleVariance != 0)
		SetDrawScale (DrawScale * (1 + DrawScaleVariance * FRand()) );

	if (bExpandingDecal)
	{
		InitialDrawScale=DrawScale;
		SetDrawScale (DrawScale * MinDrawScale);
	}

    Super.PostBeginPlay();

	if (bDynamicDecal || bExpandingDecal)
		return;

    AbandonProjector(StayTime*Level.DecalStayScale);
	Destroy();
}

// When using bWaitForInit, this must be called manually.
simulated function InitDecal()
{
	bWaitForInit=false;
	PostBeginPlay();
}

event Tick (float DT)
{
	local Rotator BoneRot, TRot;
	local Vector BoneLoc, X, Y, Z;

	Super.Tick(DT);

	if (bWaitForInit)
		return;
	if (!bDynamicDecal && !bExpandingDecal)
		return;

//	DetachProjector(true);
	DetachProjector();
	if (bExpandingDecal)
	{
		if (ExpandTimePassed > ExpandTime)
		{
			bExpandingDecal = False;
			LifeSpan = StayTime;
		}
		SetDrawScale (InitialDrawScale * (MinDrawScale + (MaxDrawScale - MinDrawScale) * (ExpandTimePassed / ExpandTime) ));
		ExpandTimePassed += DT;
	}

	if (bPaintToBone)
	{
		if (PaintedActor == None)
		{
			Destroy();
			return;
		}

		BoneLoc = PaintedActor.GetBoneCoords(PaintBone).Origin;
		BoneRot = PaintedActor.GetBoneRotation (PaintBone);

		TRot = PaintAngle;
		GetAxes (TRot,X,Y,Z);
		X = X >> BoneRot;
		Y = Y >> BoneRot;
		Z = Z >> BoneRot;
		TRot = OrthoRotation (X,Y,Z);
		SetRotation (TRot);

		if (ZoomDist != 0)
			SetLocation ((Vector(Rotation) * ZoomDist) + BoneLoc + (PaintDir >> BoneRot));
		else
			SetLocation (BoneLoc + (PaintDir >> BoneRot));
	}
	AttachProjector();
}

function StopExpanding ()
{
	bExpandingDecal = False;
	LifeSpan = StayTime;
}

function InitPaintedDecal (Vector Loc, Rotator Rot, name HitBone, Actor Other)
{
	local Rotator BoneRot, TRot;
	local Vector X, Y, Z;

	bPaintToBone = True;
	BoneRot = Other.GetBoneRotation(HitBone);
	PaintDir = (Loc - Other.GetBoneCoords(HitBone).Origin) << BoneRot;

	TRot = Rot;
	GetAxes (TRot,X,Y,Z);
	X = X << BoneRot;
	Y = Y << BoneRot;
	Z = Z << BoneRot;
	TRot = OrthoRotation (X,Y,Z);
	PaintAngle = TRot;

	PaintBone = HitBone;
	PaintedActor = Other;
}

simulated event Touch (Actor Other)
{
	if (!bDynamicDecal)
		return;
	if (!bOwnerOnly)
	{
		Super.Touch (Other);
		return;
	}
	if (Owner == None)
		return;
	if (Other == Owner && Other.bAcceptsProjectors)
		AttachActor(Other);
}

defaultproperties
{
     bProjectOnAlpha=True
     GradientTexture=Texture'Engine.GRADIENT_Clip'
}

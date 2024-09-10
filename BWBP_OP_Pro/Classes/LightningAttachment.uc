//=============================================================================
// R78Attachment.
//
// 3rd person weapon attachment for R78 Sniper Rifle
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningAttachment extends BallisticAttachment;

var Vector		SpawnOffset;

simulated function Vector GetModeTipLocation(optional byte Mode)
{
    local Vector X, Y, Z, Loc;

	if (Instigator.IsFirstPerson())
	{
		if (LightningRifle(Instigator.Weapon).bScopeView)
		{
			Instigator.Weapon.GetViewAxes(X,Y,Z);
			return Instigator.Location + X*20 + Z*5;
		}
		else
			Loc = Instigator.Weapon.GetBoneCoords('tip').Origin + class'BUtil'.static.AlignedOffset(Instigator.GetViewRotation(), SpawnOffset);
	}
	else
		Loc = GetBoneCoords('tip').Origin;
		
    return Loc;
}

// Does all the effects for an instant-hit kind of fire.
// On the client, this uses mHitLocation to find all the other info needed.
simulated function InstantFireEffects(byte Mode)
{
	local Vector HitLocation, Dir, Start;
	local Material HitMat;
	
	if (InstantMode == MU_None || (InstantMode == MU_Secondary && Mode == 0) || (InstantMode == MU_Primary && Mode != 0))
		return;
	if (mHitLocation == vect(0,0,0))
		return;
	if (Instigator == none)
		return;
		
	SpawnTracer(Mode, mHitLocation);
	
	FlyByEffects(Mode, mHitLocation);
	// Client, trace for hitnormal, hitmaterial and hitactor
	if (Level.NetMode == NM_Client)
	{
		mHitActor = None;
		Start = Instigator.Location + Instigator.EyePosition();

		if (WallPenetrates != 0)				{
			WallPenetrates = 0;
			DoWallPenetrate(Mode, Start, mHitLocation);	}

		Dir = Normal(mHitLocation - Start);
		mHitActor = Trace (HitLocation, mHitNormal, mHitLocation + Dir * 10, mHitLocation - Dir * 10, true,, HitMat); // CYLO needs to trace actors to find Pawns 
		// Check for water and spawn splash
		if (ImpactManager!= None && bDoWaterSplash)
			DoWaterTrace(Mode, Start, mHitLocation);

		if (mHitActor == None)
		{
			log("No HitActor");
			return;
		}
		// Set the hit surface type
		if (Vehicle(mHitActor) != None)
			mHitSurf = 3;
		else if (HitMat == None)
			mHitSurf = int(mHitActor.SurfaceType);
		else
			mHitSurf = int(HitMat.SurfaceType);
	}
	// Server has all the info already...
 	else
		HitLocation = mHitLocation;

	if (level.NetMode != NM_Client && ImpactManager!= None && WaterHitLocation != vect(0,0,0) && bDoWaterSplash && Level.DetailMode >= DM_High && class'BallisticMod'.default.EffectsDetailMode > 0)
		ImpactManager.static.StartSpawn(WaterHitLocation, Normal((Instigator.Location + Instigator.EyePosition()) - WaterHitLocation), 9, Instigator);
	if (mHitActor == None)
		return;
	if (!mHitActor.bWorldGeometry && Mover(mHitActor) == None && mHitActor.bProjTarget)
	{
		Spawn (class'IE_IncBulletMetal', ,, HitLocation,);
		return;
	}
	if (ImpactManager != None)
		ImpactManager.static.StartSpawn(HitLocation, mHitNormal, mHitSurf, instigator);
}

defaultproperties
{
	WeaponClass=class'LightningRifle'
	SpawnOffset=(X=-200.000000)
	InstantMode=MU_Both
	TracerMode=MU_Both
	MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
	FlashScale=0.800000
	ImpactManager=Class'BWBP_OP_Pro.IM_Lightning'
	BrassClass=class'Brass_Rifle'
	TracerClass=Class'BWBP_OP_Pro.TraceEmitter_Lightning'
	WaterTracerClass=class'TraceEmitter_WaterBullet'
	WaterTracerMode=MU_Both
	FlyBySound=(Sound=SoundGroup'BW_Core_WeaponSound.FlyBys.Bullet-Whizz',Volume=0.700000)
	CockAnimRate=1.400000
	Mesh=SkeletalMesh'BWBP_OP_Anim.TPm_LightningRifle'
	DrawScale=0.600000
}
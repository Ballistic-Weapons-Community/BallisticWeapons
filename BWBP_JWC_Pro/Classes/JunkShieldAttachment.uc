//=============================================================================
// JunkShieldAttachment.
//
// FIXME
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JunkShieldAttachment extends InventoryAttachment;

var() rotator			FArmRot;			// Rotation of ForeArm when shield down
var() rotator			UArmRot;			// Rotation of Upperarm when shield down

var   byte				BlockHitCount;		// Counter for block events
var	  vector			BlockHitLocation;	// Location of LastBlockHit
var   class<DamageType>	BlockHitType;		// DamageType of attackers weapon for last block hit
var   bool		bShieldDown, bOldShieldDown;// Shield state
var() byte				ShieldSurfaceType;	// The surfacetype of this shield
var() bUtil.FullSound	ShieldHitSound;		// Extra sound to play when shield is hit

replication
{
	reliable if (Role == ROLE_Authority)
		bShieldDown, BlockHitCount, BlockHitLocation, BlockHitType;
}

simulated function PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bShieldDown != bOldShieldDown)
	{
		bOldShieldDown = bShieldDown;
		SetShieldAnim();
	}
	if (BlockHitCount != default.BlockHitCount)
	{
		default.BlockHitCount = BlockHitCount;
		PlayBlocking();
	}
}

simulated function PlayBlocking()
{
	if (class<BallisticDamageType>(BlockHitType) != None && class<BallisticDamageType>(BlockHitType).default.ImpactManager != None)
		class<BallisticDamageType>(BlockHitType).default.ImpactManager.static.StartSpawn(BlockHitLocation, normal(BlockHitLocation - Instigator.Location), ShieldSurfaceType, Instigator, /*HF_NoDecals*/4);
	if (ShieldHitSound.Sound != None)
		class'bUtil'.static.PlayFullSound(self, ShieldHitSound);
}

function BlockHit(vector HitLocation, class<DamageType> DamageType)
{
	BlockHitType = DamageType;
	BlockHitLocation = HitLocation;
	BlockHitCount++;
	PlayBlocking();
}

function SetBlocking (bool bBlocking)
{
	bShieldDown = !bBlocking;
	if (level.NetMode != NM_DedicatedServer)
		SetShieldAnim();
}
simulated function SetShieldAnim()
{
	if (Instigator==None)
		return;
	if (bShieldDown)
	{
		Instigator.SetBoneRotation('lfarm',FArmRot,,1);
		Instigator.SetBoneRotation('Bip01 L UpperArm',UArmRot,,1);
	}
	else
	{
		Instigator.SetBoneRotation('lfarm',rot(0,0,0),,0);
		Instigator.SetBoneRotation('Bip01 L UpperArm',rot(0,0,0),,0);
	}
}
simulated function Destroyed()
{
	bShieldDown=false;
	SetShieldAnim();
	super.Destroyed();
}

defaultproperties
{
     FArmRot=(Yaw=8192)
     UArmRot=(Yaw=4096,Roll=4096)
     ShieldSurfaceType=3
     DrawType=DT_StaticMesh
     CullDistance=4000.000000
     bActorShadows=True
     bReplicateInstigator=True
     RelativeLocation=(X=-10.000000)
     RelativeRotation=(Pitch=-16000,Roll=16384)
     DrawScale=0.230000
     bNetNotify=True
}

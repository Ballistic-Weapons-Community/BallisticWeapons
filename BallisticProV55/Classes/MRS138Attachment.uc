//=============================================================================
// MRS138Attachment.
//
// Third person attachment for MRS138 Shotgun
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138Attachment extends BallisticShotgunAttachment;

var bool		bLightsOn, bLightsOnOld, bTazerOn, bTazerOnOld;
var Projector	FlashLightProj;
var Emitter		FlashLightEmitter;
var Emitter		TazerEffect;

var   byte					TazerHitCount;
var   vector				TazerHitLocation;

var Pawn TazerHit, OldTazerHit;
var MRS138TazerLineEffect TazerLineEffect;

replication
{
	reliable if ( Role==ROLE_Authority )
		bLightsOn, bTazerOn, TazerHit;
	unreliable if (bNetDirty && Role==Role_Authority)
		TazerHitLocation, TazerHitCount;
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	SwitchFlashLight();
	if (NewbHidden)
	{
		KillProjector();
		if (FlashLightEmitter!=None)
			FlashLightEmitter.Destroy();
	}
	else if (bLightsOn)
	{
		SwitchFlashLight();
	}
}

simulated event PostNetReceive()
{
	super.PostNetReceive();

	if (TazerHitCount != default.TazerHitCount)		{	default.TazerHitCount = TazerHitCount;
		TazerHitEffects();
	}
	if (TazerHit != OldTazerHit)
	{
		OldTazerHit = TazerHit;
		if (TazerHit != None)
			GotTarget(TazerHit);
		else
		{
			TazerLineEffect.Kill();
			TazerLineEffect = None;
			if (MRS138Shotgun(Instigator.Weapon) != None)
				MRS138Shotgun(Instigator.Weapon).TazerLineEffect = None;
		}
	}
}

//===========================================================================
 // GotTarget
 //
 // Called from secondary fire on tazer hit.
//===========================================================================
simulated function GotTarget(Pawn A)
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = A;
	if (TazerLineEffect == None)
	{
		TazerLineEffect = spawn(class'MRS138TazerLineEffect', self, ,,rot(0,0,0));
		if (MRS138Shotgun(Instigator.Weapon) != None)
			MRS138Shotgun(Instigator.Weapon).TazerLineEffect = TazerLineEffect;
		//AttachToBone(TazerLineEffect, 'tip2');
		TazerLineEffect.SetTarget(A);
		TazerLineEffect.Instigator = Instigator;
		TazerLineEffect.UpdateTargets();
	}
	else
		TazerLineEffect.SetTarget(A);
}

//===========================================================================
 // TazeEnd
 //
 // Called from secondary fire on release of altfire key or from tazereffect on loss of target.
//===========================================================================
simulated function PlayerTazeEnd()
{
	if (level.NetMode == NM_DedicatedServer || level.NetMode == NM_ListenServer)
		TazerHit = None;
	if (TazerLineEffect != None)
	{
		TazerLineEffect.SetTarget(None);
		TazerLineEffect.KillFlashes();
		TazerLineEffect.SetTimer(0.0, false);
		TazerLineEffect.Kill();

		if (MRS138Shotgun(Instigator.Weapon) != None)
			MRS138Shotgun(Instigator.Weapon).TazerLineEffect = None;
	}
}

function TazerHitActor(vector HitLocation)
{
	TazerHitLocation = HitLocation;
	TazerHitCount++;

	NetUpdateTime = Level.TimeSeconds - 1;
	if (level.NetMode != NM_DedicatedServer)
		TazerHitEffects();
//		class'IM_JunkTazerHit'.static.StartSpawn(HitLocation, HitNormal, 0, instigator);
}

simulated function TazerHitEffects()
{
	class'IM_MRS138TazerHit'.static.StartSpawn(TazerHitLocation, Normal(TazerHitLocation - Instigator.Location+Instigator.EyePosition()), 0, instigator);
}

simulated function StartProjector()
{
	if (FlashLightProj == None)
		FlashLightProj = Spawn(class'MRS138TorchProjector',self,,location);
	AttachToBone(FlashLightProj, 'tip2');
	FlashLightProj.SetRelativeLocation(vect(-32,0,0));
}

simulated function KillProjector()
{
	if (FlashLightProj != None)
	{
		FlashLightProj.Destroy();
		FlashLightProj = None;
	}
}

simulated function SwitchFlashLight ()
{
	if (bLightsOn)
	{
		if (FlashLightEmitter == None)
		{
			FlashLightEmitter = Spawn(class'MRS138TorchEffect',self,,location);
			class'BallisticEmitter'.static.ScaleEmitter(FlashLightEmitter, DrawScale);
			AttachToBone(FlashLightEmitter, 'tip2');
			FlashLightEmitter.bHidden = false;
			FlashLightEmitter.bCorona = true;
		}
		if (!Instigator.IsFirstPerson())
			StartProjector();
	}
	else
	{
		FlashLightEmitter.Destroy();
		KillProjector();
	}
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (Level.NetMode == NM_DedicatedServer)
		return;

	if (bLightsOn != bLightsOnOld)	{
		SwitchFlashLight();
		bLightsOnOld = bLightsOn;	}
	if (bTazerOn != bTazerOnOld)	{
		SwitchTazer();
		bTazerOnOld = bTazerOn;	}
		
	if (TazerLineEffect != None && !Instigator.IsFirstPerson())
		TazerLineEffect.SetLocation(GetBoneCoords('tip2').Origin);

	if (!bLightsOn)
		return;

	if (Instigator.IsFirstPerson())
	{
		KillProjector();
		if (FlashLightEmitter != None && FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = false;
	}
	else
	{
		if (FlashLightProj == None)
			StartProjector();
		if (FlashLightEmitter != None && !FlashLightEmitter.bCorona)
			FlashLightEmitter.bCorona = true;
	}
}

simulated function SwitchTazer ()
{
	if (bTazerOn)
		StartTazer();
	else
		KillTazer();
}

simulated function StartTazer()
{
	if (TazerEffect == None)
		TazerEffect = Spawn(class'MRS138TazerEffect',self,,location);
	class'BallisticEmitter'.static.ScaleEmitter(TazerEffect, DrawScale);
	AttachToBone(TazerEffect, 'tip2');
	TazerEffect.bHidden=false;
}

simulated function KillTazer()
{
	if (TazerEffect != None)
		TazerEffect.Kill();
}

simulated function Destroyed()
{
	if (FlashLightEmitter != None)
		FlashLightEmitter.Destroy();
	KillProjector();
	KillTazer();
	
	if (TazerLineEffect != None)
	{
		TazerLineEffect.KillFlashes();
		TazerLineEffect.SetTimer(0.0, false);
		TazerLineEffect.Kill();
	}
	
	super.Destroyed();
}

defaultproperties
{
    WeaponClass=class'MRS138Shotgun'
	MuzzleFlashClass=class'MRS138FlashEmitter'
	ImpactManager=class'IM_Shell'
	MeleeImpactManager=class'IM_MRS138TazerHit'
	BrassClass=class'Brass_MRS138Shotgun'
	TracerClass=class'TraceEmitter_Shotgun'
	TracerChance=0.500000
	SingleFireAnim="RifleHip_FireCock"
	SingleAimedFireAnim="RifleAimed_FireCock"
	CockAnimRate=1.600000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.MRS138_TPm'
	DrawScale=0.090000
}

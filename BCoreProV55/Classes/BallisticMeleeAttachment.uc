//=============================================================================
// BallisticMeleeAttachment.
//
// Attachment for melee weapons that can be used to block the attacks of enemy
// weapons.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticMeleeAttachment extends BallisticAttachment;

var   bool					BlockNotify;		//Bool used to inform attachment of hand explode
var	name					MeleeOffhandStrikeAnim, MeleeAltStrikeAnim;

replication
{
	reliable if ( Role==ROLE_Authority )
		BlockNotify;
}

/*function SetAimed(bool bNewAimed)
{
	bIsAimed = bNewAimed;
	if (bIsAimed)
	{
		IdleRifleAnim=MeleeBlockAnim;
		Instigator.SetAnimAction('Raise');
	}
	else 
	{
		IdleRifleAnim=IdleHeavyAnim;
		Instigator.SetAnimAction('Lower');
	}
}*/

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	bHeavy=True;
}

function SetBlocked(bool bNewAimed)
{
	bIsAimed = bNewAimed;
	if (bIsAimed)
	{	
		Instigator.SetAnimAction('Raise');
	}
	else 
	{
		Instigator.SetAnimAction('Lower');
	}
}

// Check if being notified of hand explosion
simulated event PostNetReceive()
{
	if (BlockNotify != default.BlockNotify)
	{
		default.BlockNotify = BlockNotify;
		BlockHitEffects();
	}
	super.PostNetReceive();
}

simulated function BlockHitEffects()
{
	local Rotator R;
	R = Instigator.GetViewRotation();
	R.Pitch += -4000 + Rand(8000);
	R.Yaw += -5000 + Rand(10000);
	if (level.NetMode != NM_DedicatedServer && ImpactManager != None)
		ImpactManager.static.StartSpawn(Instigator.Location + Instigator.EyePosition() + Vector(R)*12, Vector(Instigator.Rotation), 3, instigator);
}

// Play firing anims on pawn holding weapon
simulated function PlayPawnFiring(byte Mode)
{
	if ( xPawn(Instigator) == None )
		return;
	if (!Instigator.IsA('BallisticPawn'))
	{
		if (TrackAnimMode == MU_Both || (TrackAnimMode == MU_Primary && Mode == 0) || (TrackAnimMode == MU_Secondary && Mode == 1))
			PlayPawnTrackAnim(Mode);
		else
		{
			if (FiringMode == 0)
				xPawn(Instigator).StartFiring(True, bRapidFire);
			else 
				xPawn(Instigator).StartFiring(True, bAltRapidFire);
			SetTimer(WeaponLightTime, false);
		}
	}
	//This is a hack. If the BallisticPawn detects that there's a BallisticMeleeAttachment, it will use the melee anims
	//sent to it by this pawn. I really should insert a BCPawn class to make this work correctly...
	else
		xPawn(Instigator).StartFiring(Mode == 1, false);
}

function UpdateBlockHit()
{
	BlockNotify=!BlockNotify;
	BlockHitEffects();
}

defaultproperties
{
     MeleeAltStrikeAnim="Blade_Smash"
     IdleHeavyAnim="Blade_Idle"
     IdleRifleAnim="Blade_Idle"
     MeleeStrikeAnim="Blade_Swing"
	 MeleeBlockAnim="Blade_Block"
}

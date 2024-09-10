//=============================================================================
// PumaAttachment.
//
// Yeah this is the shield gun's.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PumaAttachment extends BallisticAttachment;

var ForceRing ForceRing3rd;
var PumaShieldEffect3rd PumaShieldEffect3rd;

replication
{
    	reliable if (bNetInitial && Role == ROLE_Authority)
       		PumaShieldEffect3rd;
}

//Do your camo changes here

simulated function Destroyed()
{
	local int i;
    if (PumaShieldEffect3rd != None)
        PumaShieldEffect3rd.Destroy();

    if (ForceRing3rd != None)
        ForceRing3rd.Destroy();


	if (Instigator != None && level.TimeSeconds <= TrackEndTime)
	{
		for(i=0;i<GetTrackCount(ActiveTrack);i++)
			Instigator.SetBoneRotation(GetTrack(ActiveTrack,i).Bone, rot(0,0,0), 0, 1.0);
	}

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (AltMuzzleFlash);

    Super.Destroyed();
}

function InitFor(Inventory I)
{
    Super.InitFor(I);

	if ( (Instigator.PlayerReplicationInfo == None) || (Instigator.PlayerReplicationInfo.Team == None)
		|| (Instigator.PlayerReplicationInfo.Team.TeamIndex > 1) )
		PumaShieldEffect3rd = Spawn(class'PumaShieldEffect3rd', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		PumaShieldEffect3rd = Spawn(class'PumaShieldEffect3rdRED', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
		PumaShieldEffect3rd = Spawn(class'PumaShieldEffect3rd', I.Instigator);
    PumaShieldEffect3rd.SetBase(I.Instigator);
}

simulated event ThirdPersonEffects()
{
    	if ( Level.NetMode != NM_DedicatedServer && Instigator != None)
	{
		//Spawn impacts, streaks, etc
		InstantFireEffects(FiringMode);
		//Flash muzzle flash
		FlashMuzzleFlash (FiringMode);
		//Weapon light
		FlashWeaponLight(FiringMode);
		//Play pawn anims
		PlayPawnFiring(FiringMode);
		//Eject Brass
		EjectBrass(FiringMode);
    	}

    	Super.ThirdPersonEffects();
}

function SetBrightness(int b, bool hit)
{
    if (PumaShieldEffect3rd != None)
        PumaShieldEffect3rd.SetBrightness(b, hit);
}

defaultproperties
{
	WeaponClass=class'PumaRepeater'
     MuzzleFlashClass=class'M50M900FlashEmitter'
	 BrassClass=Class'BWBP_SKC_Pro.Brass_PUMA'
     bHeavy=True
     Mesh=SkeletalMesh'BWBP_SKC_Anim.TPm_PUMA'
     DrawScale=0.210000
     PrePivot=(X=2.000000,Z=-1.000000)
}

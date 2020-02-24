//=============================================================================
// LS14Attachment.
//
// Third person actor for the LS-14 Laser Carbine.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class XM20Attachment extends BallisticAttachment;

var ForceRing ForceRing3rd;
var XM20ShieldEffect3rd XM20ShieldEffect3rd;

replication
{
	reliable if (bNetInitial && Role == ROLE_Authority)
		XM20ShieldEffect3rd;
}

simulated function EjectBrass(byte Mode);

simulated function Destroyed()
{
	local int i;
    if (XM20ShieldEffect3rd != None)
        XM20ShieldEffect3rd.Destroy();

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
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rd', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rdRED', I.Instigator);
	else if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
		XM20ShieldEffect3rd = Spawn(class'XM20ShieldEffect3rd', I.Instigator);
    XM20ShieldEffect3rd.SetBase(I.Instigator);
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
    if (XM20ShieldEffect3rd != None)
        XM20ShieldEffect3rd.SetBrightness(b, hit);
}

defaultproperties
{
     MuzzleFlashClass=Class'BWBPSomeOtherPack.XM20FlashEmitter'
     AltMuzzleFlashClass=Class'BWBPSomeOtherPack.XM20FlashEmitter'
     ImpactManager=Class'BWBPSomeOtherPack.IM_XM20Impacted'
     BrassClass=Class'BallisticProV55.Brass_Railgun'
     FlashMode=MU_Primary
     LightMode=MU_Both
	 InstantMode=MU_Primary
	 TracerMode=MU_Primary
     TracerClass=Class'BWBPSomeOtherPack.TraceEmitter_XM20Las'
     WaterTracerClass=Class'BallisticProV55.TraceEmitter_WaterBullet'
     WaterTracerMode=MU_Primary
     FlyBySound=(Sound=Sound'PackageSounds4Pro.XM20.XM20-FlyBy',Volume=0.700000)
     FlyByBulletSpeed=-1.000000
     bRapidFire=True
     Mesh=SkeletalMesh'BWBPSomeOtherPackAnims.XM20Third'
     RelativeLocation=(X=-3.000000,Z=2.000000)
     RelativeRotation=(Pitch=32768)
     DrawScale=0.200000
}

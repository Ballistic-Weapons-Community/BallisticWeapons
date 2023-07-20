//=============================================================================
// JO_EmptyCapacitor.
//
// A discharged capacitor bearing only blunt force damage capabilities.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_GardenGnome extends JunkObject;

simulated function JunkReload()
//simulated function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo)
{
	if (FRand() < 0.12)
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnomeWar';
	}
	else if (FRand() > 0.94)
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnomeDaemon';
	}
	else
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnome';
	}
}

simulated function Uninitialize (JunkObject NewJunkObject)
{
	if (MorphedJunk == Class'BWBP_JWC_Pro.JO_GardenGnomeWar')
		Weapon.GiveJunk(MorphedJunk,1,,true);	
	super.Uninitialize(NewJunkObject);	
}

simulated function PostInitialize (Actor JunkActor)
{
	if (FRand() < 0.25)
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnomeWar';
	}
	else if (FRand() > 0.75)
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnomeDaemon';
	}
	else
	{
		MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnome';
	}
}

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Weapons.Gnome_ground'
     PickupDrawScale=0.300000
     SpawnPivot=(Roll=0)
     PickupMessage="You got a Garden Gnome."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Weapons.Gnome'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Y=-2.500000)
     AttachPivot=(Pitch=-2048)
     bCanThrow=True
     MaxAmmo=6
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         MorphOn=BT_HitActor
         Damage=(head=64,Limb=33,Misc=43)
         KickForce=4000
         DamageType=Class'BWBP_JWC_Pro.DTJunkGnome'
         RefireTime=0.600000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="WideHit3"
         Anims(1)="StabHit1"
         Anims(2)="StabHit2"
         Anims(3)="WideHit2"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_GardenGnome.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         MorphOn=BT_HitActor
         Damage=(head=78,Limb=39,Misc=52)
		 KickForce=4500
         DamageType=Class'BWBP_JWC_Pro.DTJunkGnome'
         RefireTime=0.700000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="StabAttack"
         PreFireAnims(0)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_GardenGnome.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2500
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Weapons.Gnome_thrown'
         ProjScale=0.250000
         WallImpactType=IT_Stick
         ActorImpactType=IT_Stick
         SpinRates=(Roll=-150000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         bCanBePickedUp=True
         Damage=(head=63,Limb=33,Misc=43)
         KickForce=6000
         DamageType=Class'BWBP_JWC_Pro.DTJunkGnome'
         RefireTime=0.600000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing',Pitch=1.200000)
         Anims(0)="StabThrow"
         PreFireAnims(0)="StabPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_GardenGnome.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Garden Gnome"
     InventoryGroup=6
     MeleeRating=30.000000
     RangeRating=20.000000
     SpawnWeight=0.900000
     PainThreshold=16
     NoUseThreshold=34
     StaticMesh=StaticMesh'BWBP_JW_Static.Weapons.Gnome'
}

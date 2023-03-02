//=============================================================================
// JO_EmptyCapacitor.
//
// A discharged capacitor bearing only blunt force damage capabilities.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_GardenGnomeWar extends JunkObject;

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Weapons.GnomeWar_Ground'
     PickupDrawScale=0.300000
     SpawnPivot=(Roll=0)
     PickupMessage="You got a Grizzled Gnome."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Weapons.GnomeWar'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Y=-2.500000)
     AttachPivot=(Pitch=-2048)
     bCanThrow=True
     MaxAmmo=12
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         Damage=(head=69,Limb=38,Misc=48)
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
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_GardenGnomeWar.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         Damage=(head=83,Limb=44,Misc=57)
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
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_GardenGnomeWar.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=2500
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Weapons.GnomeWar_Thrown'
         ProjScale=0.250000
         SpinRates=(Roll=-150000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         ExplodeManager=Class'BallisticProV55.IM_Bomb'
         DamageRadius=400.000000
         bCanBePickedUp=True
         Damage=(head=68,Limb=38,Misc=60)
         KickForce=100000
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
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_GardenGnomeWar.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Grizzled Gnome"
     InventoryGroup=6
     MeleeRating=30.000000
     RangeRating=20.000000
     MorphedJunk=Class'BWBP_JWC_Pro.JO_GardenGnome'
     SpawnWeight=0.900000
     PainThreshold=16
     NoUseThreshold=34
     StaticMesh=StaticMesh'BWBP_JW_Static.Weapons.GnomeWar'
}

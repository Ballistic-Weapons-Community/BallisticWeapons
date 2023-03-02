//=============================================================================
// JO_EmptyCapacitor.
//
// A discharged capacitor bearing only blunt force damage capabilities.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_EmptyCapacitor extends JunkObject;

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.CapacitorLD'
     PickupDrawScale=0.400000
     PickupMessage="You got an empty Capacitor"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Capacitor'
     RightGripStyle=GS_Capacitor
     AttachOffset=(Y=-2.500000)
     AttachPivot=(Pitch=-2048)
     bCanThrow=True
     MaxAmmo=5
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkEmptyCapacitor'
         Damage=(head=75,Limb=12,Misc=30)
         KickForce=4000
         DamageType=Class'BWBP_JWC_Pro.DTJunkEmptyCapacitor'
         RefireTime=0.600000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.200000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_EmptyCapacitor.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkEmptyCapacitor'
         Damage=(head=82,Limb=15,Misc=32)
         KickForce=4500
         DamageType=Class'BWBP_JWC_Pro.DTJunkEmptyCapacitor'
         RefireTime=0.700000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.200000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_EmptyCapacitor.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1800
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.CapacitorLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.150000
         SpinRates=(Pitch=80000)
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkEmptyCapacitor'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=62,Limb=11,Misc=22)
         KickForce=6000
         DamageType=Class'BWBP_JWC_Pro.DTJunkEmptyCapacitor'
         RefireTime=0.600000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing',Pitch=1.200000)
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_EmptyCapacitor.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Empty Capacitor"
     InventoryGroup=6
     MeleeRating=30.000000
     RangeRating=20.000000
     SpawnWeight=0.900000
     PainThreshold=16
     NoUseThreshold=34
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Capacitor'
}

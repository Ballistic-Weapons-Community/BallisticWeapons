//=============================================================================
// JO_PipeTap.
//
// A pipe with other various attached pieces of pipe, and tap.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_PipeTap extends JunkObject;

defaultproperties
{
     HandOffset=(X=5.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.PipeTapLD'
     PickupDrawScale=0.400000
     SpawnPivot=(Roll=-16384)
     PickupPrePivot=(Y=16.000000)
     PickupMessage="You got the Pipe and Tap"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.PipeTap'
     AttachOffset=(Y=-0.250000,Z=4.000000)
     AttachPivot=(Yaw=-4096,Roll=-1000)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=145.000000,Max=145.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeTap'
         HookStopFactor=1.200000
         HookPullForce=50.000000
         Damage=(head=100,Limb=20,Misc=37)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkPipeTap'
         RefireTime=0.600000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="HeavyHit1"
         Anims(1)="HeavyHit2"
         Anims(2)="HeavyHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_PipeTap.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=150.000000,Max=150.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeTap'
         HookStopFactor=1.200000
         HookPullForce=50.000000
         Damage=(head=112,Limb=22,Misc=47)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkPipeTap'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="HeavyAttack"
         PreFireAnims(0)="HeavyPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_PipeTap.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Heavy')
     FriendlyName="Pipe and Tap"
     InventoryGroup=2
     MeleeRating=75.000000
     RangeRating=0.000000
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.PipeTap'
}

//=============================================================================
// JO_PipeCorner.
//
// An offcut of a failed plumbing operation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_PipeCorner extends JunkObject;

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Pipe Corner, time to plumb"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerA1'
     AttachOffset=(Y=-0.250000)
     AttachPivot=(Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
         HookStopFactor=1.200000
         Damage=(head=90,Limb=15,Misc=32)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkPipeCorner'
         RefireTime=0.500000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_PipeCorner.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=132.000000,Max=132.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=5000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3500))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-2000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3500))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
         HookStopFactor=1.200000
         Damage=(head=100,Limb=17,Misc=40)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkPipeCorner'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_PipeCorner.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.180000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkPipeCorner'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=80,Limb=17,Misc=30)
         KickForce=90000
         DamageType=Class'BWBP_JWC_Pro.DTJunkPipeCorner'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_PipeCorner.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Pipe Corner"
     MeleeRating=52.000000
     RangeRating=20.000000
     PainThreshold=40
     NoUseThreshold=80
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.PipeCornerA1'
}

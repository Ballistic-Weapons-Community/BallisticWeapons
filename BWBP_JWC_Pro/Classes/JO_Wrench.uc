//=============================================================================
// JO_Wrench.
//
// A rusted plumbing tool.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_Wrench extends JunkObject;

defaultproperties
{
     HandOffset=(X=1.000000,Y=2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.WrenchLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Wrench, plumb some heads off"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Wrench'
     AttachOffset=(Y=-0.500000,Z=3.000000)
     AttachPivot=(Yaw=-2648,Roll=-600)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=135.000000,Max=135.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkWrench'
         HookStopFactor=1.000000
         Damage=(head=100,Limb=20,Misc=40)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkWrench'
         RefireTime=0.600000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Wrench.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=140.000000,Max=140.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkWrench'
         HookStopFactor=1.000000
         Damage=(head=112,Limb=22,Misc=50)
         KickForce=20000
         DamageType=Class'BWBP_JWC_Pro.DTJunkWrench'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Swing')
         Anims(0)="HeavyAttack"
         PreFireAnims(0)="HeavyPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_Wrench.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.WrenchLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.050000
         DampenFactorParallel=0.600000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkWrench'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=102,Limb=20,Misc=40)
         KickForce=25000
         DamageType=Class'BWBP_JWC_Pro.DTJunkWrench'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Wrench.Wrench-Swing')
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="HeavyPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_Wrench.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Wrench"
     MeleeRating=80.000000
     RangeRating=25.000000
     PainThreshold=40
     NoUseThreshold=80
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Wrench'
     DrawScale=1.200000
}

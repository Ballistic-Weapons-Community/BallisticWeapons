//=============================================================================
// JO_BPHammer.
//
// A throwing hammer with spherical end.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_BPHammer extends JunkObject;

defaultproperties
{
     HandOffset=(X=4.000000,Y=2.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.BPHammerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Ball Peen Hammer."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.BPHammer'
     RightGripStyle=GS_Axe
     AttachOffset=(Z=2.000000)
     AttachPivot=(Yaw=-1024,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=120.000000,Max=120.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClawHammer'
         HookStopFactor=1.000000
         Damage=(head=83,Limb=15,Misc=32)
         KickForce=6000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBPHammer'
         RefireTime=0.500000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BPHammer.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClawHammer'
         HookStopFactor=1.000000
         Damage=(head=100,Limb=17,Misc=45)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBPHammer'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BPHammer.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.BPHammerLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.200000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClawHammer'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=72,Limb=15,Misc=32)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBPHammer'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Crowbar.Crowbar-Swing')
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="HeavyPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_BPHammer.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Ball Peen Hammer"
     RangeRating=20.000000
     PainThreshold=35
     NoUseThreshold=60
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.BPHammer'
     DrawScale=1.350000
}

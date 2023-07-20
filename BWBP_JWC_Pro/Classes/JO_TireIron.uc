//=============================================================================
// JO_TireIron.
//
// A tool for tyre repairs. Car mechanics WOC.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_TireIron extends JunkObject;

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.TireIronLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Tire Iron"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.TireIron'
     RightGripStyle=GS_Crowbar
     AttachOffset=(Y=-0.350000,Z=2.000000)
     AttachPivot=(Yaw=-1500,Roll=-500)
     bCanThrow=True
     MaxAmmo=3
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=105.000000,Max=105.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTyreIron'
         Damage=(head=82,Limb=15,Misc=32)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTyreIron'
         RefireTime=0.500000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_TireIron.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=110.000000,Max=110.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=5000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3500))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-2000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3500))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTyreIron'
         Damage=(head=92,Limb=17,Misc=40)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTyreIron'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_TireIron.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.TireIronLD'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.150000
         DampenFactorParallel=0.750000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkTyreIron'
         StickRotation=(Pitch=16384,Roll=16384)
         bCanBePickedUp=True
         Damage=(head=72,Limb=17,Misc=35)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkTyreIron'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_TireIron.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Tire Iron"
     MeleeRating=45.000000
     RangeRating=20.000000
     PainThreshold=20
     NoUseThreshold=40
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.TireIron'
     DrawScale=1.400000
}

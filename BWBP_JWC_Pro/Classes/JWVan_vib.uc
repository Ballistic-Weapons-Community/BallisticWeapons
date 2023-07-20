//=============================================================================
// Vibrator.
//
// A woman's best friend!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_vib extends JunkObject;

defaultproperties
{
     HandOffset=(X=1.000000,Y=2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.vibLD'
     PickupDrawScale=0.090000
     PickupMessage="You got the Vibrator. Go, please some women!"
     ThirdPersonDrawScale=0.090000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.vib'
     RightGripStyle=GS_IcePick
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
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=2.000000
         Damage=(head=110,Limb=24,Misc=45)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTvib'
         RefireTime=0.600000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         Anims(3)="StabHit1"
         Anims(4)="StabHit2"
         Anims(5)="StabHit3"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_vib.JunkFireInfo0'

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
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         HookStopFactor=3.000000
         Damage=(head=125,Limb=25,Misc=60)
         KickForce=20000
         DamageType=Class'BWBP_JWC_Pro.DTvibsec'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="HeavyAttack"
         Anims(1)="StabAttack"
         PreFireAnims(0)="HeavyPrepAttack"
         PreFireAnims(1)="StabPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_vib.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1500
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.vibLD'
         ProjScale=0.150000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         DampenFactor=0.050000
         DampenFactorParallel=0.600000
         SpinRates=(Pitch=650000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkCrowbar'
         bAlignToVelocity=True
         bCanBePickedUp=True
         Damage=(head=110,Limb=25,Misc=50)
         KickForce=25000
         DamageType=Class'BWBP_JWC_Pro.DTvib'
         RefireTime=0.400000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="HeavyThrow"
         PreFireAnims(0)="LightPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_vib.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Vibrator"
     MeleeRating=80.000000
     RangeRating=25.000000
     PainThreshold=40
     NoUseThreshold=80
     StaticMesh=StaticMesh'BWBP_JW_Static.vib'
     DrawScale=0.500000
}

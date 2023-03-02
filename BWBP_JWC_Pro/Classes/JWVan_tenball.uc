//=============================================================================
// Tenball.
//
// A tennis ball.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_tenball extends JunkObject;

defaultproperties
{
     HandOffset=(X=3.000000,Z=-2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.tenball'
     PickupDrawScale=0.400000
     PickupMessage="You got a Tennis Ball. Well, it's something."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.tenball'
     RightGripStyle=GS_Bowl
     PullOutRate=2.000000
     IdleStyle=AS_Bowl
     PutAwayRate=2.000000
     AttachOffset=(X=2.000000,Z=1.000000)
     AttachPivot=(Roll=-1000)
     bCanThrow=True
     bSwapSecondary=True
     Ammo=5
     MaxAmmo=10
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=2
         SwipePoints(0)=(Weight=1,offset=(Pitch=500,Yaw=2000))
         SwipePoints(1)=(Weight=3,offset=(Yaw=1000))
         SwipePoints(2)=(Weight=5)
         SwipePoints(3)=(Weight=4,offset=(Yaw=-1000))
         SwipePoints(4)=(Weight=2,offset=(Pitch=-500,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
         HookStopFactor=1.500000
         HookPullForce=90.000000
         Damage=(head=15,Limb=10,Misc=8)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTtenball'
         RefireTime=0.450000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="SwingHit1"
         Anims(1)="SwingHit2"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_tenball.JunkFireInfo0'

     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_rock.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1300
         ProjMass=20
         ProjMesh=StaticMesh'BWBP_JW_Static.tenball'
         ProjScale=0.250000
         WallImpactType=IT_Bounce
         ActorImpactType=IT_Stick
         SpinRates=(Pitch=30000)
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkGearLever'
         bCanBePickedUp=True
         Damage=(head=25,Limb=10,Misc=15)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTtenball'
         RefireTime=0.300000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing')
         Anims(0)="SwingThrow"
         PreFireAnims(0)="SwingPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JWVan_tenball.JunkThrowFireInfo0'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Small')
     FriendlyName="Tennis Ball"
     InventoryGroup=3
     MeleeRating=8.000000
     RangeRating=30.000000
     SpawnWeight=1.050000
     PainThreshold=12
     NoUseThreshold=20
     StaticMesh=StaticMesh'BWBP_JW_Static.tenball'
     DrawScale=1.250000
}

//=============================================================================
// JO_ClubHammer.
//
// Large one-handed hammer. Excellent for destroying masonary and brittle heads.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_ClubHammer extends JunkObject;

defaultproperties
{
     HandOffset=(X=2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.ClubHammerLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Club Hammer"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.Clubhammer'
     RightGripStyle=GS_IcePick
     AttachOffset=(X=1.250000,Y=-1.000000,Z=1.500000)
     AttachPivot=(Yaw=-2500,Roll=-750)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=140.000000,Max=140.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=6000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=4000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-4000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         HookStopFactor=1.000000
         Damage=(head=120,Limb=30,Misc=55)
         KickForce=15000
         DamageType=Class'BWBP_JWC_Pro.DTJunkClubber'
         RefireTime=0.700000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="HeavyHit1"
         Anims(1)="HeavyHit2"
         Anims(2)="HeavyHit3"
         AnimTimedFire=ATS_Early
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_ClubHammer.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=145.000000,Max=145.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=5000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3500))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkClubHammer'
         HookStopFactor=1.000000
         Damage=(head=132,Limb=32,Misc=60)
         KickForce=20000
         DamageType=Class'BWBP_JWC_Pro.DTJunkClubber'
         RefireTime=0.900000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Clubhammer.Clubhammer-Swing')
         Anims(0)="HeavyAttack"
         PreFireAnims(0)="HeavyPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_ClubHammer.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Avg')
     FriendlyName="Club Hammer"
     InventoryGroup=2
     MeleeRating=95.000000
     RangeRating=0.000000
     PainThreshold=60
     NoUseThreshold=120
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.Clubhammer'
     DrawScale=1.350000
}

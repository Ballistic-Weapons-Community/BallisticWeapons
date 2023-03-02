//=============================================================================
// JO_lamp.
//
// A random lamp post.
//
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_lamp extends JunkObject;

defaultproperties
{
     HandOffset=(X=2.000000,Z=-6.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.lampLD'
     PickupDrawScale=0.800000
     SpawnPivot=(Pitch=768)
     SpawnOffset=(Z=2.000000)
     PickupMessage="You got the Lamp Post. The lights are going out. For your enemies."
     ThirdPersonDrawScale=0.400000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.lamp'
     HandStyle=HS_TwoHanded
     RightGripStyle=GS_DualBig
     LeftGripStyle=GS_DualBig
     PullOutRate=1.500000
     PullOutStyle=AS_DualBig
     IdleStyle=AS_DualBig
     PutAwayRate=1.500000
     PutAwayStyle=AS_DualBig
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=230.000000,Max=230.000000)
         SwipeHitWallPoint=6
         SwipePoints(0)=(offset=(Pitch=6000,Yaw=6000))
         SwipePoints(1)=(Weight=2,offset=(Pitch=5000,Yaw=5000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=4000,Yaw=4000))
         SwipePoints(3)=(Weight=6,offset=(Pitch=3000,Yaw=3000))
         SwipePoints(4)=(Weight=8,offset=(Pitch=2000,Yaw=2000))
         SwipePoints(5)=(Weight=10,offset=(Pitch=1000,Yaw=1000))
         SwipePoints(6)=(Weight=12)
         SwipePoints(7)=(Weight=11,offset=(Pitch=-500,Yaw=-1000))
         SwipePoints(8)=(Weight=9,offset=(Pitch=-800,Yaw=-2000))
         SwipePoints(9)=(Weight=7,offset=(Pitch=-1200,Yaw=-3000))
         SwipePoints(10)=(Weight=5,offset=(Pitch=-2400,Yaw=-4000))
         SwipePoints(11)=(Weight=3,offset=(Pitch=-3200,Yaw=-5000))
         SwipePoints(12)=(Weight=1,offset=(Pitch=-4000,Yaw=-6000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkConcretePole'
         HookStopFactor=1.500000
         Damage=(head=140,Limb=40,Misc=100)
         KickForce=20000
         DamageType=Class'BWBP_JWC_Pro.DTlamp'
         RefireTime=1.250000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Swing')
         Anims(0)="Big2Hit1"
         Anims(1)="Big2Hit2"
         AnimTimedFire=ATS_Early
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_lamp.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=240.000000,Max=240.000000)
         SwipeHitWallPoint=6
         SwipePoints(0)=(Weight=12,offset=(Pitch=7000,Yaw=2000))
         SwipePoints(1)=(Weight=11,offset=(Pitch=5500,Yaw=1600))
         SwipePoints(2)=(Weight=10,offset=(Pitch=4000,Yaw=1200))
         SwipePoints(3)=(Weight=9,offset=(Pitch=3000,Yaw=800))
         SwipePoints(4)=(Weight=8,offset=(Pitch=2000,Yaw=500))
         SwipePoints(5)=(Weight=7,offset=(Pitch=1000,Yaw=250))
         SwipePoints(6)=(Weight=6)
         SwipePoints(7)=(Weight=5,offset=(Pitch=-1000,Yaw=-250))
         SwipePoints(8)=(Weight=4,offset=(Pitch=-2000,Yaw=-500))
         SwipePoints(9)=(Weight=3,offset=(Pitch=-3000,Yaw=-800))
         SwipePoints(10)=(Weight=2,offset=(Pitch=-4000,Yaw=-1200))
         SwipePoints(11)=(Weight=1,offset=(Pitch=-5500,Yaw=-1600))
         SwipePoints(12)=(offset=(Pitch=-7000,Yaw=-2000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkConcretePole'
         HookStopFactor=1.500000
         Damage=(head=150,Limb=50,Misc=110)
         KickForce=35000
         DamageType=Class'BWBP_JWC_Pro.DTlamp'
         RefireTime=1.250000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Swing')
         Anims(0)="Big2Attack1"
         Anims(1)="Big2Attack2"
         PreFireAnims(0)="Big2PrepAttack1"
         PreFireAnims(1)="Big2PrepAttack2"
         bFireOnRelease=True
         AnimTimedFire=ATS_Early
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_lamp.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Heavy')
     FriendlyName="Lamp Post"
     InventoryGroup=5
     MeleeRating=140.000000
     RangeRating=0.000000
     SpawnWeight=0.900000
     bDisallowShield=True
     PainThreshold=85
     NoUseThreshold=170
     BlockLeftAnim="Big2BlockLeft"
     BlockRightAnim="Big2BlockRight"
     BlockStartAnim="Big2PrepBlock"
     BlockEndAnim="Big2EndBlock"
     BlockIdleAnim="Big2BlockIdle"
     StaticMesh=StaticMesh'BWBP_JW_Static.lamp'
     DrawScale=1.200000
}

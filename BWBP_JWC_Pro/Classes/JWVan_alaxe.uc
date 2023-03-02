//=============================================================================
// Alaxe.
//
// OH GOD WHAT.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_alaxe extends JunkObject;

var Effect_Al AlEffect;

function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo)
{
	if (FRand() > 0.15 || Other == None)
		return false;
	Weapon.MorphJunk();
	return true;
}

simulated function PostInitialize (Actor JunkActor)
{
	if (JunkActor == None)
		return;
	if (AlEffect == None)
	{
		AlEffect = Weapon.Instigator.Spawn(class'Effect_Al',Weapon.Instigator,,JunkActor.Location, JunkActor.Rotation);
		class'BallisticEmitter'.static.ScaleEmitter(AlEffect, DrawScale*Weapon.DrawScale);
	}
	AlEffect.SetBase(JunkActor);
}
simulated function Uninitialize(JunkObject NewJunk)
{
	if (AlEffect != None)
		AlEffect.Destroy();
}

defaultproperties
{
     HandOffset=(X=4.000000,Z=-6.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.alaxeLD'
     PickupDrawScale=0.400000
     SpawnOffset=(Z=2.000000)
     PickupMessage="You got the Extraterrestrial Uranium Axe. Zepzork Bwxaray?"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.alaxe'
     HandStyle=HS_TwoHanded
     RightGripStyle=GS_DualBig
     LeftGripStyle=GS_DualBig
     PullOutRate=1.500000
     PullOutStyle=AS_DualBig
     IdleStyle=AS_DualBig
     PutAwayRate=1.500000
     PutAwayStyle=AS_DualBig
     AttachOffset=(X=0.130000,Y=-0.700000,Z=9.500000)
     AttachPivot=(Yaw=-1500,Roll=-600)
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=212.000000,Max=212.000000)
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
         ImpactManager=Class'BWBP_JWC_Pro.IM_al'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=215,Limb=95,Misc=115)
         KickForce=40000
         DamageType=Class'BWBP_JWC_Pro.DTalaxe'
         RefireTime=1.100000
         AnimRate=1.400000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Swing',Pitch=1.200000)
         Anims(0)="Big2Hit1"
         Anims(1)="Big2Hit2"
         AnimStyle=ACS_Random
         AnimTimedFire=ATS_Timed
         bAnimTimedSound=True
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_alaxe.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=212.000000,Max=212.000000)
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
         ImpactManager=Class'BWBP_JWC_Pro.IM_al'
         HookStopFactor=1.600000
         HookPullForce=100.000000
         Damage=(head=235,Limb=115,Misc=125)
         KickForce=50000
         DamageType=Class'BWBP_JWC_Pro.DTalaxe'
         RefireTime=1.250000
         AnimRate=1.350000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Conpole.Conpole-Swing',Pitch=1.100000)
         Anims(0)="Big2Attack1"
         Anims(1)="Big2Attack2"
         PreFireAnims(0)="Big2PrepAttack1"
         PreFireAnims(1)="Big2PrepAttack2"
         AnimStyle=ACS_Random
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_alaxe.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Heavy')
     FriendlyName="Extraterrestrial Uranium Axe"
     InventoryGroup=5
     MeleeRating=150.000000
     RangeRating=0.000000
     MorphedJunk=Class'BWBP_JWC_Pro.JWVan_alaxecharged'
     SpawnWeight=0.900000
     bDisallowShield=True
     PainThreshold=80
     NoUseThreshold=150
     BlockLeftAnim="Big2BlockLeft"
     BlockRightAnim="Big2BlockRight"
     BlockStartAnim="Big2PrepBlock"
     BlockEndAnim="Big2EndBlock"
     BlockIdleAnim="Big2BlockIdle"
     StaticMesh=StaticMesh'BWBP_JW_Static.alaxe'
     DrawScale=0.800000
}

//=============================================================================
// Alaxe.
//
// OH GOD WHAT.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JWVan_alaxecharged extends JunkObject;

var Sound ExplodeSound;
var Emitter AlEffect;

simulated function PostInitialize (Actor JunkActor)
{
 if (JunkActor == None)
  return;
 if (AlEffect == None)
 {
  AlEffect = Weapon.Instigator.Spawn(class'Effect_Alcharge',Weapon.Instigator,,JunkActor.Location, JunkActor.Rotation);
  class'BallisticEmitter'.static.ScaleEmitter(AlEffect, DrawScale*Weapon.DrawScale);
 }
 AlEffect.SetBase(JunkActor);
}
simulated function Uninitialize(JunkObject NewJunk)
{
 if (AlEffect != None)
  AlEffect.Destroy();
 AlEffect = None;
}

//Hit the floor, blow up
function bool SendFireEffect(WeaponFire Fire, JunkFireInfo FI, Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
 PlaySound(ExplodeSound);
 Weapon.Spawn(class'IE_splosion',Weapon,,Weapon.Instigator.Location, Weapon.Instigator.Rotation);
 Weapon.HurtRadius(250, 1024, class'dtalaxecharged', 11000, Weapon.Instigator.Location);
 Instigator.TakeDamage(9999, Instigator, Instigator.Location, vect(0,0,1000), class'dtalaxecharged');
 return true;
}

defaultproperties
{
     HandOffset=(X=4.000000,Z=-6.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.alaxeLD'
     PickupDrawScale=0.400000
     SpawnOffset=(Z=2.000000)
     PickupMessage="You got the Overcharged Extraterrestrial Uranium Axe. Zepzork Bwxaray?"
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
         MeleeRange=(Min=1000.000000,Max=1000.000000)
         SwipePoints(0)=(Weight=1,offset=(Pitch=-16384))
         ImpactManager=Class'BWBP_JWC_Pro.IM_alaxecharged'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=30,Misc=45)
         KickForce=8000
         DamageType=Class'BWBP_JWC_Pro.DTalaxecharged'
         RefireTime=1.000000
         AnimRate=0.000001
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_alaxecharged.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=1000.000000,Max=1000.000000)
         SwipePoints(0)=(Weight=1,offset=(Pitch=-16384))
         ImpactManager=Class'BWBP_JWC_Pro.IM_alaxecharged'
         HookStopFactor=1.000000
         Damage=(head=110,Limb=30,Misc=45)
         KickForce=8000
         DamageType=Class'BWBP_JWC_Pro.DTalaxecharged'
         RefireTime=1.000000
         AnimRate=0.000001
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JWVan_alaxecharged.JunkFireInfo1'

     SelectSound=(Sound=SoundGroup'BWBP_JW_Sound.Misc.Pullout-Heavy')
     FriendlyName="Overcharged Extraterrestrial Uranium Axe"
     InventoryGroup=5
     MeleeRating=150.000000
     RangeRating=0.000000
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

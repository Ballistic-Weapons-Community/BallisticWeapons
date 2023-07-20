//=============================================================================
// JO_NeonLight.
//
// Every office has one of these.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_NeonLight extends JunkObject;

simulated function bool Initialize(JunkObject OldJunk)
{
	AttachPivot.Yaw = RandRange(-32768, 32768);
	return false;
}

function bool BlockDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	local class<BallisticDamageType> BDT;
	local float BlockFactor;

	// FIXME: Let damage do stuff if it gets blocked...

	BDT = class<BallisticDamageType>(DamageType);
	if (BDT!=None && BDT.default.bCanBeBlocked && (BDT.static.IsDamage(",Blunt,") || BDT.static.IsDamage(",Slash,") || BDT.static.IsDamage(",Stab,") || BDT.static.IsDamage(",Hack,")))
	{
		if (BDT.default.ShieldDamage >= NoUseThreshold)
			BlockFactor = 1.0;
		else if (BDT.default.ShieldDamage > PainThreshold)
			BlockFactor = float(BDT.default.ShieldDamage-PainThreshold) / (NoUseThreshold-PainThreshold);
		Damage *= BlockFactor;
		Momentum *= BlockFactor;
		if (BDT.default.ShieldDamage > PainThreshold / 2)
		{
			JunkWeaponAttachment(Weapon.ThirdPersonActor).JunkHitActor(Weapon.Instigator, HitLocation, normal(Momentum), 3, false);
			Weapon.MorphJunk();
		}
	}
	return true;
}

defaultproperties
{
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLightLD'
     PickupDrawScale=0.300000
     PickupMessage="You got the Neon Light"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLight'
     PullOutRate=1.500000
     PutAwayRate=1.500000
     AttachOffset=(Y=-0.100000)
     AttachPivot=(Yaw=673)
     Ammo=8
     MaxAmmo=8
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=128.000000,Max=128.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=4000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=3000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=1500))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-3000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-4000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkNeonLightBreak'
         MorphOn=BT_HitAnything
         Damage=(head=90,Limb=15,Misc=42)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkNeonLight'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="WideHit1"
         Anims(1)="WideHit2"
         Anims(2)="WideHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_NeonLight.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=140.000000,Max=140.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=5000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3500))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-4000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkNeonLightBreak'
         MorphOn=BT_HitAnything
         Damage=(head=110,Limb=20,Misc=50)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkNeonLight'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Pipe.Pipe-Swing')
         Anims(0)="WideAttack"
         PreFireAnims(0)="WidePrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_NeonLight.JunkFireInfo1'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Glass')
     FriendlyName="Neon Light"
     InventoryGroup=6
     MeleeRating=65.000000
     RangeRating=0.000000
     MorphedJunk=Class'BWBP_JWC_Pro.JO_NeonLightBroken'
     PainThreshold=15
     NoUseThreshold=25
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.NeonLight'
}

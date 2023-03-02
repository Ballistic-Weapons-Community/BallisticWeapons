//=============================================================================
// JO_LightBulb.
//
// Standard light bulb.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_LightBulb extends JunkObject;

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
			Weapon.ClientForceBlock(false);
			if (!Weapon.Instigator.IsLocallyControlled())
				Weapon.bBlocked=false;
			Weapon.BreakJunk();
		}
	}
	return true;
}

defaultproperties
{
     HandOffset=(Z=2.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.LightBulbLD'
     PickupDrawScale=0.400000
     PickupMessage="You got the Light Bulb, now find something else!"
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.LightBulb'
     AttachOffset=(Y=-0.500000)
     AttachPivot=(Yaw=-2048)
     bCanThrow=True
     bSwapSecondary=True
     Ammo=10
     MaxAmmo=20
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=84.000000,Max=84.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=3000,Yaw=3000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=2000,Yaw=2000))
         SwipePoints(2)=(Weight=5,offset=(Pitch=1000,Yaw=1000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-1000,Yaw=-1000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-2000,Yaw=-2000))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkLightBulb'
         DestroyOn=BT_HitAnything
         Damage=(head=40,Limb=10,Misc=22)
         KickForce=2000
         DamageType=Class'BWBP_JWC_Pro.DTJunkLightBulb'
         RefireTime=0.400000
         AnimRate=1.200000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing',Pitch=0.900000)
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_LightBulb.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=88.000000,Max=88.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=5000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4000,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkLightBulb'
         DestroyOn=BT_HitAnything
         Damage=(head=47,Limb=13,Misc=27)
         KickForce=3000
         DamageType=Class'BWBP_JWC_Pro.DTJunkLightBulb'
         RefireTime=0.800000
         AnimRate=1.000000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing',Pitch=0.900000)
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_LightBulb.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1800
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.LightBulbLD'
         ProjScale=0.250000
         SpinRates=(Pitch=80000)
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkLightBulb'
         Damage=(head=45,Limb=12,Misc=20)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkLightBulb'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.Spanner.Spanner-Swing',Pitch=0.900000)
         Anims(0)="LightThrow"
         PreFireAnims(0)="LightPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_LightBulb.JunkThrowFireInfo0'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Glass')
     FriendlyName="Light Bulb"
     InventoryGroup=3
     MeleeRating=5.000000
     RangeRating=30.000000
     SpawnWeight=1.100000
     PainThreshold=5
     NoUseThreshold=10
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.LightBulb'
}

//=============================================================================
// JO_BeerBottle.
//
// An empty beer-bottle; a trusty Lager brand beer at that.
// A favourite of every drunk bar-fighter
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class JO_BeerBottle extends JunkObject;

var bool bBottleBroke;

simulated function bool Initialize(JunkObject OldJunk)
{
	AttachPivot.Yaw = RandRange(-32768, 32768);
	return false;
}
// Primary fire sometimes breaks bottle... Implemented below
function bool HitActor (Actor Other, JunkMeleeFireInfo FireInfo)
{
	if (FireInfo != MeleeAFireInfo || !bBottleBroke	|| Other == None)
		return false;
	Weapon.MorphJunk();
	return true;
}

function bool SendDamageEffect(WeaponFire Fire, JunkFireInfo FI, int OldHealth, Actor Victim, float Damage, vector HitLocation, vector Dir, class<DamageType> DT)
{
	local int Surf;

	bBottleBroke=false;
	if (FI != MeleeAFireInfo || Victim == None || FRand() < 0.75)
		return false;

	bBottleBroke=true;
	if (Vehicle(Victim) != None)
		Surf = 3;//EST_Metal
	else
		Surf = 6;//EST_Flesh
	JunkWeaponAttachment(Weapon.ThirdPersonActor).JunkHitActor(Victim, HitLocation, -Normal(Dir), Surf, true);
	return true;
}

function bool SendFireEffect(WeaponFire Fire, JunkFireInfo FireInfo, Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	bBottleBroke=false;
	if (FireInfo != MeleeAFireInfo || FRand() < 0.75)
		return false;

	bBottleBroke=true;
	BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, true, WaterHitLoc);
	return true;
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
		if (BDT.default.ShieldDamage > PainThreshold)
		{
			JunkWeaponAttachment(Weapon.ThirdPersonActor).JunkHitActor(Weapon.Instigator, HitLocation, normal(Momentum), 3, true);
			Weapon.MorphJunk();
		}
	}
	return true;
}

defaultproperties
{
     HandOffset=(X=4.000000)
     PickupMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleLD'
     PickupDrawScale=0.300000
     PickupMessage="You got the Beer Bottles."
     ThirdPersonDrawScale=0.250000
     ThirdPersonMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottle'
     AttachOffset=(X=1.000000,Z=1.250000)
     bCanThrow=True
     bSwapSecondary=True
     Ammo=10
     MaxAmmo=20
     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo0
         MeleeRange=(Min=90.000000,Max=90.000000)
         SwipeHitWallPoint=3
         SwipePoints(0)=(Weight=1,offset=(Pitch=2000,Yaw=5000))
         SwipePoints(1)=(Weight=3,offset=(Pitch=1000,Yaw=3500))
         SwipePoints(2)=(Weight=5,offset=(Pitch=500,Yaw=2000))
         SwipePoints(3)=(Weight=6)
         SwipePoints(4)=(Weight=4,offset=(Pitch=-500,Yaw=-2000))
         SwipePoints(5)=(Weight=2,offset=(Pitch=-1000,Yaw=-3500))
         SwipePoints(6)=(offset=(Pitch=-2000,Yaw=-5000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottle'
         HookStopFactor=1.000000
         Damage=(head=57,Limb=14,Misc=25)
         KickForce=5000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottle'
         RefireTime=0.350000
         AnimRate=1.500000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="AvgHit1"
         Anims(1)="AvgHit2"
         Anims(2)="AvgHit3"
         AnimTimedFire=ATS_Timed
     End Object
     MeleeAFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BeerBottle.JunkFireInfo0'

     Begin Object Class=JunkMeleeFireInfo Name=JunkFireInfo1
         MeleeRange=(Min=100.000000,Max=100.000000)
         SwipeHitWallPoint=4
         SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
         SwipePoints(1)=(Weight=5,offset=(Pitch=4500,Yaw=3000))
         SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
         SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
         SwipePoints(4)=(Weight=2)
         SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
         SwipePoints(6)=(offset=(Pitch=-3000,Yaw=-3000))
         ImpactManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleBreak'
         MorphOn=BT_HitAnything
         HookStopFactor=1.000000
         Damage=(head=70,Limb=17,Misc=40)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottle'
         RefireTime=0.800000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="AvgAttack"
         PreFireAnims(0)="AvgPrepAttack"
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     MeleeBFireInfo=JunkMeleeFireInfo'BWBP_JWC_Pro.JO_BeerBottle.JunkFireInfo1'

     Begin Object Class=JunkThrowFireInfo Name=JunkThrowFireInfo0
         projSpeed=1800
         ProjMass=10
         ProjMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottleLD'
         ProjScale=0.250000
         SpinRates=(Pitch=40000)
         ExplodeManager=Class'BWBP_JWC_Pro.IM_JunkBeerBottleBreak'
         Damage=(head=50,Limb=12,Misc=27)
         KickForce=10000
         DamageType=Class'BWBP_JWC_Pro.DTJunkBeerBottle'
         RefireTime=0.500000
         AnimRate=1.250000
         Sound=(Sound=SoundGroup'BWBP_JW_Sound.BeerBottle.BeerB-Swing')
         Anims(0)="AvgThrow"
         PreFireAnims(0)="AvgPrepThrow"
         AmmoPerFire=1
         bFireOnRelease=True
         AnimTimedFire=ATS_Timed
     End Object
     ThrowFireInfo=JunkThrowFireInfo'BWBP_JWC_Pro.JO_BeerBottle.JunkThrowFireInfo0'

     SelectSound=(Sound=Sound'BWBP_JW_Sound.Misc.Pullout-Bottle')
     FriendlyName="Beer Bottle"
     InventoryGroup=3
     MeleeRating=35.000000
     RangeRating=35.000000
     MorphedJunk=Class'BWBP_JWC_Pro.JO_BeerBottleBroken'
     SpawnWeight=2.000000
     PainThreshold=10
     NoUseThreshold=25
     StaticMesh=StaticMesh'BWBP_JW_Static.Junk.BeerBottle'
}

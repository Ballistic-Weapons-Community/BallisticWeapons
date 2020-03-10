//=============================================================================
// DragonsToothPrimaryFire.
//
// Horizontalish swipe attack for the EKS43. Uses melee swpie system to do
// horizontal swipes. When the swipe traces find a player, the trace closest to
// the aim will be used to do the damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FlameSwordPrimaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
    local int i;
	local FlameSwordActorFire Burner;
	
	super.DoDamage (Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount);

	if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
	{
		for (i=0;i<Other.Attached.length;i++)
		{
			if (FlameSwordActorFire(Other.Attached[i])!=None)
			{
				FlameSwordActorFire(Other.Attached[i]).AddFuel(2);
				break;
			}
		}
		if (i>=Other.Attached.length)
		{
			Burner = Spawn(class'FlameSwordActorFire',Other,,Other.Location + vect(0,0,-30));
			Burner.Initialize(Other);
			if (Instigator!=None)
			{
				Burner.Instigator = Instigator;
				Burner.InstigatorController = Instigator.Controller;
			}
		}
	}
}
defaultproperties
{
     SliceAnims(0)="Swing1"
     SliceAnims(1)="Swing2"
     SliceAnims(2)="Swing3"
     SwipePoints(0)=(Weight=3,offset=(Yaw=2560))
     SwipePoints(1)=(Weight=5,offset=(Yaw=1280))
     SwipePoints(2)=(Weight=6)
     SwipePoints(3)=(Weight=4,offset=(Yaw=-1280))
     SwipePoints(4)=(Weight=2,offset=(Yaw=-2560))
     WallHitPoint=2
     NumSwipePoints=5
     FatiguePerStrike=0.100000
     bCanBackstab=False
     TraceRange=(Min=180.000000,Max=180.000000)
     Damage=80.000000
     DamageHead=80.000000
     DamageLimb=80.000000
     DamageType=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     DamageTypeHead=Class'BWBPSomeOtherPack.DT_FlameSwordHead'
     DamageTypeArm=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     KickForce=100
     BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Swing',Volume=4.000000,Radius=256.000000,bAtten=True)
     bAISilent=True
     FireAnim="Slash1"
	 FireRate=0.7
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=256.000000)
     ShakeRotRate=(X=3000.000000,Y=3000.000000,Z=3000.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.800000
}

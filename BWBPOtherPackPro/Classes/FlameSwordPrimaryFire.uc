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

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
    local int i, LastTargetHealth;
    local Pawn PawnTarget;
    local FlameSwordActorFire Burner;

    PawnTarget = Pawn(Target);
    
     if (PawnTarget != None)
        LastTargetHealth = PawnTarget.Health;
	
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
    if (PawnTarget != None && PawnTarget.Health > 0 && PawnTarget.Health < LastTargetHealth && Vehicle(Target) == None)
    {
		for (i=0;i<Target.Attached.length;i++)
		{
			if (FlameSwordActorFire(Target.Attached[i])!=None)
			{
				FlameSwordActorFire(Target.Attached[i]).AddFuel(2);
				break;
			}
		}
		if (i>=Target.Attached.length)
		{
			Burner = Spawn(class'FlameSwordActorFire',Target,,Target.Location + vect(0,0,-30));
			Burner.Initialize(Target);
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
     TraceRange=(Min=165.000000,Max=165.000000)
     Damage=70.000000
    
     DamageType=Class'BWBPOtherPackPro.DT_FlameSwordChest'
     DamageTypeHead=Class'BWBPOtherPackPro.DT_FlameSwordHead'
     DamageTypeArm=Class'BWBPOtherPackPro.DT_FlameSwordChest'
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

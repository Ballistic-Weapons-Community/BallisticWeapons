class FlameSwordMeleeFire extends BallisticMeleeFire;

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
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     SwipePoints(6)=(offset=(Pitch=-3000))
	 TraceRange=(Min=180.000000,Max=180.000000)
     WallHitPoint=4
     Damage=65.000000
     DamageHead=65.000000
     DamageLimb=65.000000
     DamageType=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     DamageTypeHead=Class'BWBPSomeOtherPack.DT_FlameSwordHead'
     DamageTypeArm=Class'BWBPSomeOtherPack.DT_FlameSwordChest'
     KickForce=2000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BWBPSomeOtherPackSounds.FlameSword.FlameSword-Swing',Volume=4.000000,Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSwing"
     FireAnim="Swing3"
     PreFireAnimRate=2.000000
     TweenTime=0.000000
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_Knife'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}

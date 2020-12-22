//=============================================================================
// ChaffSecondaryFire.
//
// Melee attack for grnade. Hit dem when primed for bomz
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class ChaffSecondaryFire extends BallisticMeleeFire;

// Do the trace to find out where bullet really goes
function MeleeDoTrace (Vector InitialStart, Rotator Dir, bool bWallHitter, int Weight)
{
	local int						i;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLocation;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLocation=End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			LastHitLocation=HitLocation;
			// Water
			if (bWallHitter && ((FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume)))
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}
			else
				LastHitLocation=HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				for(i=0;i<SwipeHits.length;i++)
					if (SwipeHits[i].Victim == Other)
					{
						if(SwipeHits[i].Weight < Weight)
						{
							SwipeHits.Remove(i, 1);
							i--;
						}
						else
							break;
					}
				if (i>=SwipeHits.length)
				{
					SwipeHits.Length = SwipeHits.length + 1;
					SwipeHits[SwipeHits.length-1].Victim = Other;
					SwipeHits[SwipeHits.length-1].Weight = Weight;
					SwipeHits[SwipeHits.length-1].HitLoc = HitLocation;
					SwipeHits[SwipeHits.length-1].HitDir = X;
					LastOther = Other;


					if (bWallHitter && Vehicle(Other) != None)
					{
//						bHitWall=true;
						bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					}
				}
				if (Mover(Other) == None)
					Break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
//				bHitWall=true;
				if (bWallHitter)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				}
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * Other.CollisionRadius * 2);
				End = Start + X * Dist;
				continue;
			}
			break;
		}
		else
			break;
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall && bWallHitter)
		NoHitEffect(X, InitialStart, LastHitLocation, WaterHitLoc);
	Weapon.bTraceWater=false;
}

simulated event ModeDoFire()
{
	super.ModeDoFire();
	BW.GunLength = BW.default.GunLength;
}
simulated event ModeHoldFire()
{
	super.ModeHoldFire();
	BW.GunLength=1;
}

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     WallHitPoint=4
     TraceRange=(Min=140.000000,Max=140.000000)
     Damage=50.000000
     DamageType=Class'BWBPRecolorsPro.DTChaffSmack'
     DamageTypeHead=Class'BWBPRecolorsPro.DTChaffSmack'
     DamageTypeArm=Class'BWBPRecolorsPro.DTChaffSmack'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,Pitch=0.800000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepSmack"
     FireAnim="Smack"
     PreFireAnimRate=2.000000
     FireAnimRate=1.500000
     TweenTime=0.000000
     FireRate=0.700000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_Chaff'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}

//=============================================================================
// M763 Secondary Fire
//
// Loads then fires a gas shell.
//
// by Azarael
//=============================================================================
class M763SecondaryFire extends BallisticProInstantFire;

//===========================================================================
// AllowFire
//
// Handles cocking
//===========================================================================
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
	if (!M763Shotgun(BW).bAltLoaded)
		return false;
    return true;
}

simulated function ModeDoFire()
{
	Super.ModeDoFire();
	M763Shotgun(BW).bAltLoaded=False;
	M763Shotgun(BW).PrepPriFire();
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				if (VSize(HitLocation - Start) > 1)
					WaterHitLoc=HitLocation;
				Start = HitLocation;
				Dist = Min(Dist, MaxWaterTraceRange);
				End = Start + X * Dist;
				Weapon.bTraceWater=false;
				continue;
			}

			LastHitLoc = HitLocation;
				
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{				
				OnTraceHit(Other, HitLocation, InitialStart, X, PenCount, WallCount, 0, WaterHitLoc);
			
				LastOther = Other;

				if (CanPenetrate(Other, HitLocation, X, PenCount))
				{
					PenCount++;
					Start = HitLocation + (X * Other.CollisionRadius * 2);
					End = Start + X * Dist;
					Weapon.bTraceWater=true;
					if (Vehicle(Other) != None)
						HitVehicleEffect (HitLocation, HitNormal, Other);
					continue;
				}
				else if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				WallCount++;
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
		
	M763Shotgun(BW).GC.SpawnColliders(InitialStart, LastHitLoc);
}

// Base deviation.
simulated function vector GetFireSpread()
{
	local float fX;
    local Rotator R;

	if (BW.bScopeView)
		return super(BallisticProInstantFire).GetFireSpread();

	fX = frand();
	R.Yaw =  512 * sin (FMin(sqrt(frand()), 1) * 1.5707963267948966) * sin(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Yaw = -R.Yaw;
	R.Pitch = 512 * sin (FMin(sqrt(frand()), 1)  * 1.5707963267948966) * cos(fX*1.5707963267948966);
	if (frand() > 0.5)
		R.Pitch = -R.Pitch;
	return Vector(R);
}

// Check if bullet should go through enemy
function bool CanPenetrate (Actor Other, vector HitLocation, vector Dir, int PenCount)
{
	return true;
}

defaultproperties
{
     TraceRange=(Min=768.000000,Max=768.000000)
     Damage=35.000000
     
     
     RangeAtten=0.250000
     DamageType=Class'BallisticProV55.DTM763Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTM763ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTM763Shotgun'
     KickForce=25000
	 PenetrateForce=100
	 
	 WallPenetrationForce=0
     bPenetrate=True
     bUseWeaponMag=False
     FlashScaleFactor=2.000000
     BrassClass=Class'BallisticProV55.Brass_Shotgun'
     BrassOffset=(X=-1.000000,Z=-1.000000)
     AimedFireAnim="FireCombinedSight"
     FireRecoil=1280.000000
     FireChaos=0.500000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.M763.M763Fire1',Volume=1.300000)
     FireAnim="FireCombined"
     FireEndAnim=
     FireAnimRate=1.100000
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_12GaugeGas'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=True
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
     WarnTargetPct=0.75
}

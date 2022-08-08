//=============================================================================
// CYLO "Firestorm" primary fire.
//
// Explosive rounds with longer range than normal, but overheats the weapon.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOFirestormPrimaryFire extends BallisticRangeAttenFire;

var   float		StopFireTime, HeatPerShot;
var() Sound			FailSound;

simulated function bool AllowFire()
{
	if ((CYLOFirestormAssaultWeapon(Weapon).HeatLevel >= 12) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
		Super.PlayFiring();
		CYLOFirestormAssaultWeapon(BW).AddHeat(HeatPerShot);
}

function StopFiring()
{
	Super.StopFiring();
	StopFireTime = level.TimeSeconds;
}

function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.Netmode == NM_DedicatedServer)
		CYLOFirestormAssaultWeapon(BW).AddHeat(HeatPerShot);
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(Damage, 210, class'DTCYLOFirestormExplosion', 200, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(Damage, 420, class'DTCYLOFirestormExplosion', 200, HitLocation, Pawn(Victim));
	}
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
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
				OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0, WaterHitLoc);
			
				LastOther = Other;

				if (Pawn(Other) != None)
				{
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
					break;
				}
				else if (Mover(Other) == None)
					break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
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
		
		//
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
		
	return true;
}

defaultproperties
{
     HeatPerShot=0.900000
     CutOffDistance=4096.000000
     CutOffStartRange=2048.000000
     TraceRange=(Min=10000.000000,Max=12000.000000)
	 
	 bPenetrate=False
     WallPenetrationForce=0.000000
     
     Damage=30.000000

     RangeAtten=0.350000
     WaterRangeAtten=0.200000
     DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormRifleHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormRifle'
     PenetrateForce=180
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter'
     FlashBone="Muzzle"
     FlashScaleFactor=0.250000
     AimedFireAnim="SightFire"
     FireRecoil=208.000000
     FireChaos=0.065000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
     XInaccuracy=48.000000
     YInaccuracy=48.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Slot=SLOT_Interact,Pitch=1.250000,bNoOverride=False)
     bPawnRapidFireAnim=True
     PreFireAnim=
     FireEndAnim=
     FireRate=0.125000
     UnjamMethod=UJM_Fire
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLOInc'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}

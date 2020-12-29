//=============================================================================
// FG50PrimaryFire.
//
// Very automatic, bullet style instant hit. Not kinda automatic. Very automatic.
// 50 cal fire. Stronger than M925. Hits like truck. Makes pretty effects.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FG50SecondaryFire extends BallisticProInstantFire;

var   float		HeatPerShot;

var() sound		SpecialFireSound;
var   Actor		Heater;

simulated function bool AllowFire()
{
	if ((FG50Machinegun(Weapon).HeatLevel >= 10) || !super.AllowFire())
	{
		StopFiring();
		return false;
	}
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	FG50Machinegun(BW).AddHeat(HeatPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		FG50Machinegun(BW).AddHeat(HeatPerShot);
}

simulated function SwitchCannonMode (byte NewMode)
{
	if (NewMode == 0)
	{
		BallisticFireSound.Sound=SpecialFireSound;
		FireAnim='CFire';
		BallisticFireSound.Pitch=1.0;
		FirePushbackForce=64.000000;
		FireRate=0.6;
		FireChaos=0.5;
	}
	
	else
	{
		BallisticFireSound.Sound=default.BallisticFireSound.sound;
		FireAnim='Fire';
		BallisticFireSound.Pitch=default.BallisticFireSound.pitch;
		FireRecoil=default.FireRecoil;
		FirePushbackForce=default.FirePushbackForce;
		FireRate = default.FireRate;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (Heater != None)
		Heater.Destroy();
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

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget)
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(Damage, 192, class'DT_FG50Explosion', 500, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(Damage, 512, class'DT_FG50Explosion', 500, HitLocation, Pawn(Victim));
	}
}

simulated function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
	if (Heater == None || Heater.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (Heater, class'FG50Heater', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip3');
	FG50Heater(Heater).SetHeat(0.0);
	FG50MachineGun(Weapon).Heater = FG50Heater(Heater);
	super.InitEffects();
}

defaultproperties
{
     HeatPerShot=1.200000
     SpecialFireSound=Sound'PackageSounds4Pro.X82.X82-Fire2'
     TraceRange=(Min=15000.000000,Max=15000.000000)
     WallPenetrationForce=72.000000
     
     Damage=65.000000
     
     
     WaterRangeAtten=0.800000
     DamageType=Class'BWBPRecolorsPro.DT_FG50Torso'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_FG50Head'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_FG50Limb'
     KickForce=20000
     PenetrateForce=150
     PDamageFactor=0.800000
     WallPDamageFactor=0.800000
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBPRecolorsPro.FG50FlashEmitter'
     FlashScaleFactor=1.500000
	 AimedFireAnim="SGCFireAimed"
     BrassClass=Class'BWBPRecolorsPro.Brass_BMGInc'
     BrassBone="tip"
     BrassOffset=(X=-80.000000,Y=1.000000)
     FireRecoil=512.000000
     FirePushbackForce=125.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AS50.FG50-Fire',Volume=7.100000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireAnim="CFire"
     FireEndAnim=
     FireAnimRate=2.400000
     FireRate=0.165000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_50IncDrum'
     ShakeRotMag=(X=512.000000,Y=512.000000)
     ShakeRotRate=(X=20000.000000,Y=20000.000000,Z=20000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
     ShakeOffsetRate=(X=-2000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.600000
     aimerror=900.000000
}

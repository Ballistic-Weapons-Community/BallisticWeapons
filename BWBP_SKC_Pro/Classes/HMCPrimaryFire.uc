//=============================================================================
// HMC Beam Cannon Primary
//
// A charging fire which damages enemies directly and near the impact point. Fires when released.
//
// Original code by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
// Modified by Kaboodles, Xavious, Sergeant Kelly and Azarael
//=============================================================================
class HMCPrimaryFire extends BallisticProInstantFire;

var()	Name		ChargeAnim;		//Animation to use when charging
var()   float 		ChargeRate;
var()   float 		RailPower;
var()   float 		PowerLevel;
var()   sound		ChargeSound;
var() 	sound		LowFireSound;
var() 	sound		PowerFireSound;
var() 	sound		RTeamFireSound;

simulated function bool AllowFire()
{
    if (HMCBeamCannon(BW).Heat > 0 || HMCBeamCannon(Weapon).bLaserOn)
        return false;
    return super.AllowFire();
}

simulated function PlayStartHold()
{	
	if (!HMCBeamCannon(BW).bGravitron)
		BW.SafeLoopAnim(ChargeAnim, 1.0, TweenTime, ,"IDLE");
}

simulated event ModeHoldFire()
{
	Super.ModeHoldFire();
	
	if(HoldTime == 0)
		Instigator.AmbientSound = ChargeSound;
}

function StopFiring()
{
    Instigator.AmbientSound = Instigator.default.AmbientSound;
    HoldTime = 0;
}	

simulated event ModeDoFire()
{
    if (!AllowFire())
        return;
    
    if (RailPower + 0.01 >= PowerLevel)
    {
        HMCBeamCannon(BW).CoolRate = HMCBeamCannon(BW).default.CoolRate;
        super.ModeDoFire();
    }
    
    else HMCBeamCannon(BW).CoolRate = HMCBeamCannon(BW).default.CoolRate * 3;
    
    if (BW != None)
    	HMCBeamCannon(BW).Heat += RailPower;
    RailPower = 0;
}

// Do the trace to find out where bullet really goes
function DoTrace (Vector InitialStart, Rotator Dir)
{
	local Vector					End, X, HitLocation, HitNormal, Start, LastHitLoc;
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
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				break;
			}
			LastHitLoc = HitLocation;
			// Got something interesting
			LastHitLoc = HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				OnTraceHit(Other, HitLocation, InitialStart, X, 0, 0, 0);

				if (Vehicle(Other) != None)
					bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
				else if (Mover(Other) == None)
				{
					bHitWall = true;
					if (HitMaterial != None)
						SendFireEffect(Other, HitLocation, HitNormal, HitMaterial.SurfaceType);
					else SendFireEffect(Other, HitLocation, HitNormal, 0);
					break;
				}
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other);
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
		NoHitEffect(X, InitialStart, LastHitLoc);
		
	//Radius damage or radius slow
	if (HMCBeamCannon(Weapon) != None && HMCBeamCannon(Weapon).bGravitron)
	{
		HMCBeamCannon(Weapon).TargetedSlowRadius(0.3, 8, 512, HitLocation, Pawn(Other));	
	}
	else
	{
		BallisticWeapon(Weapon).TargetedHurtRadius(90, 200, class'DTHMCBlast', 0, HitLocation, Pawn(Other));	
	}
	BallisticWeapon(Weapon).TargetedHurtRadius(30, 512, class'DTHMCBlast', 0, HitLocation, Pawn(Other));
}

simulated function ModeTick(float DT)
{
	Super.ModeTick(DT);
	
	if (HMCBeamCannon(BW).bLaserOn || !bIsFiring || HMCBeamCannon(BW).Heat > 0)
		return;
        
    RailPower = FMin(RailPower + ChargeRate*DT, PowerLevel);
    
    if (RailPower >= PowerLevel)
	{
		if (!HMCBeamCannon(BW).bGravitron) //standard models cant hold the charge
			Weapon.StopFire(ThisModeNum);
		else
			Instigator.AmbientSound = HMCBeamCannon(BW).FullyChargedSound;
	}
}

static function int GetDPSec() {return default.Damage / 3;}

defaultproperties
{
	ChargeRate=0.400000
	PowerLevel=1.000000
	ChargeAnim="ChargeAnim"
	ChargeSound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Charge'
	LowFireSound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-FireLow'
	PowerFireSound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Fire'
	RTeamFireSound=Sound'BWBP_SKC_Sounds.BeamCannon.RedBeam-Fire'
	TraceRange=(Min=50000.000000,Max=50000.000000)
	Damage=145.000000
	WaterRangeAtten=0.600000
	DamageType=Class'BWBP_SKC_Pro.DTHMCBlast'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTHMCBlastHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTHMCBlast'
	HookStopFactor=2.500000
	PenetrateForce=400
	bPenetrate=True
	MuzzleFlashClass=Class'BWBP_SKC_Pro.HMCFlashEmitter'
	FireChaos=0.005000
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Fire',Volume=1.700000,Radius=255.000000,Slot=SLOT_Interact,bNoOverride=False)
	bFireOnRelease=True
	bWaitForRelease=True
	bModeExclusive=False
	FireAnim="FireLoop"
	FireEndAnim=
	FireRate=0.080000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
	AmmoPerFire=40
	BotRefireRate=0.999000
	WarnTargetPct=0.010000
	aimerror=400.000000
}

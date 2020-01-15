//=============================================================================
// BallisticGrenadeAttachment.
//
// 3rd person weapon attachment for hand grenades.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticGrenadeAttachment extends BallisticAttachment;

var() class<BCImpactManager>ExplodeManager;			//Impact manager to spawn on final hit
var   bool					HandExplodeNotify;		//Bool used to inform attachment of hand explode
var   bool					HandSmokeNotify;		//Bool used to inform attachment of hand smoke
var() Class<Emitter>		GrenadeSmokeClass;		//Type of effect for when clip is released
var   Emitter				GrenadeSmoke;			//The smoke effect

replication
{
	reliable if ( Role==ROLE_Authority )
		HandExplodeNotify, HandSmokeNotify;
}

// Just play pawn anims
simulated event ThirdPersonEffects()
{
	//Play pawn anims
    if (Level.NetMode != NM_DedicatedServer)
		PlayPawnFiring(FiringMode);
	if (GrenadeSmoke != None)
		class'BallisticEmitter'.static.StopParticles(GrenadeSmoke);
}

// Check if being notified of hand explosion
simulated event PostNetReceive()
{
	if (HandExplodeNotify != default.HandExplodeNotify)
	{
		default.HandExplodeNotify = HandExplodeNotify;
		HandExplodeEffects();
	}
	if (HandSmokeNotify != default.HandSmokeNotify)
	{
		default.HandSmokeNotify = HandSmokeNotify;
		HandSmokeEffects();
	}
	Super.PostNetReceive();
}

// Spawn some hand explode effects
simulated function HandExplodeEffects()
{
	local Vector V;

	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		V = Instigator.Weapon.Location;
	else
		V = Location;
	if (ExplodeManager != None && EffectIsRelevant(V,false))
		ExplodeManager.static.StartSpawn(V, vect(0,0,1), 0, Instigator);
}

// This is called by the server from the weapon code
function HandExplode()
{
	HandExplodeNotify = !HandExplodeNotify;
	HandExplodeEffects();
}

// Spawn some in-hand smoking effects
simulated function HandSmokeEffects()
{
	if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
		return;
	if (GrenadeSmoke != None)
		class'BallisticEmitter'.static.ResumeParticles(GrenadeSmoke);
	else
	{
		GrenadeSmoke = Spawn(GrenadeSmokeClass,Instigator,,Location+vect(0,0,1)*3, Rotation);
		if (GrenadeSmoke != None)
		{
			GrenadeSmoke.SetBase(self);
//			AttachToBone(GrenadeSmoke, 'tip');
			class'BallisticEmitter'.static.ScaleEmitter(GrenadeSmoke, 0.4);
			DGVEmitter(GrenadeSmoke).InitDGV();
		}
	}
}

// This is called by the server from the weapon code
function HandSmoke()
{
	return;
	HandSmokeNotify = !HandSmokeNotify;
	HandSmokeEffects();
}
simulated event Destroyed()
{
	if (GrenadeSmoke != None)
		GrenadeSmoke.Destroy();
	Super.Destroyed();
}

// Play firing anims on pawn holding weapon
simulated function PlayPawnFiring(byte Mode)
{
	if ( xPawn(Instigator) == None )
		return;
	//Do this with a mask maybe? - Azarael
	if (Mode == 2)
		PlayMeleeFiring();
	else if (TrackAnimMode == MU_Both || (TrackAnimMode == MU_Primary && Mode == 0) || (TrackAnimMode == MU_Secondary && Mode == 1))
		PlayPawnTrackAnim(1);
	else
	{
		if (FiringMode == 0)
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bRapidFire);
		}
		else 
		{
			if (bIsAimed)
				xPawn(Instigator).StartFiring(False, bAltRapidFire);
			else
				xPawn(Instigator).StartFiring(True, bAltRapidFire);
		}
			SetTimer(WeaponLightTime, false);
	}
}

defaultproperties
{
     BrassMode=MU_None
     InstantMode=MU_None
     FlashMode=MU_None
     LightMode=MU_None
     TrackAnimMode=MU_Both
	 IdleHeavyAnim="Blade_Idle"
     IdleRifleAnim="Blade_Idle"
	 SingleFireAnim="Blade_Swing"
     SingleAimedFireAnim="Blade_Swing"
     RapidFireAnim="Blade_Swing"
     RapidAimedFireAnim="Blade_Swing"
}

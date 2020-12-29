//=============================================================================
// M50Camera.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M50Camera extends Actor;

var int				Health;			// HP
var bool			bBusted;		// Is it dead?
var Rotator			StartRotation;	// Rotation when spawned. This is the rotation of the walls mounting
var Rotator			OldRotation;	// Rotation before viewing from this camera
var Rotator			SwitchViewRot;	// Rotation of player before viewing from this camera
var M50CameraBase	CamBase;		// The mounting base actor
var() Sound			NoiseSound;		// Ambient sound when damaged
var() Sound			TrackSound;		// Sound to play when moving
var() Sound			DieSound;		// Sound to play when hit
var() Sound			PlaceSound;		// Sound when spawned
var() int			LastFOV;		// The FOV this camera was left with
var   Emitter		DeadEffect;		// Emitter for damaged effects
var   byte			HitCount;		// Used to send damage events to clients
var   Weapon		Weapon;			// The weapon using this camera
var	  Controller	InstigatorController;
var   M50CamTrigger	MyUseTrigger;	// Trigger for picking up this camera


replication
{
	unreliable if(Role == ROLE_Authority)
		Health, Weapon;
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	PlaySound(PlaceSound, SLOT_Misc, 0.5, ,32);
	StartRotation = Rotation;
	if (Weapon != None && M50AssaultRifle(Weapon) != None)
		M50AssaultRifle(Weapon).CamStart(self);
}

simulated event PostNetReceive()
{
	if (Health == 0)
	{
		bBusted=true;
		default.HitCount = HitCount;
		OnCameraDie();
		if (DeadEffect != None)
			DeadEffect.Trigger(self, Weapon.Instigator);
		else
			DeadEffect = Spawn(class'M50CamDieEmitter',self,,Location);
		AmbientSound=NoiseSound;
		PlaySound(DieSound, SLOT_Misc, 1.0,,64);
	}
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	// don't allow team members to destroy M50 cam
	if (InstigatorController != None && EventInstigator.Controller != None && EventInstigator.Controller.SameTeamAs(InstigatorController))
		return;
		
	// reject hits from gear-safe damagetypes
	if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).static.IsDamage(",GearSafe,"))
		return;
		
	// already destroyed
	if (Health == 0)
		return;
		
	if (Damage > Health)
		Health = 0; 
	else 
		Health -= Damage;

	if (Level.NetMode != NM_DedicatedServer)
		PostNetReceive();
}

simulated function PlayTracking()
{
	if (bBusted)
		return;
	if (AmbientSound == None)
		AmbientSound=TrackSound;
	SetTimer(0.15,false);
}

simulated event Timer()
{
	AmbientSound=None;
}

simulated event Destroyed()
{
	if (MyUseTrigger != None)
		MyUseTrigger.Destroy();
	if (DeadEffect != None)
		DeadEffect.Kill();
	if (CamBase != None)
		CamBase.Destroy();
	OnCameraDie();
	Super.Destroyed();
}

delegate OnCameraDie();

defaultproperties
{
	 Health=200
     NoiseSound=Sound'BallisticSounds2.M50.M50CamNoise'
     TrackSound=Sound'BallisticSounds2.M50.M50CamTurn'
     DieSound=Sound'BallisticSounds2.M50.M50CamDie'
     PlaceSound=Sound'BallisticSounds2.M50.M50CamPlace'
     LastFOV=90
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware2.M50.M50Camera'
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
     SoundVolume=192
     SoundRadius=0.100000
     CollisionRadius=30.000000
     CollisionHeight=30.000000
     bCollideActors=True
     bProjTarget=True
     bBlockNonZeroExtentTraces=False
     bNetNotify=True
}

//=============================================================================
// RX22ARogueTank.
//
// A damaged flamer tank that has become detached from its user.
// Flies around like a rocket until it explodes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ARogueTank extends Actor;

var vector		LeakDir, LeakLoc, ThrustDir;
var Emitter 	Flame;
var byte		DeathStage;

replication
{
	reliable if (Role == ROLE_Authority && bNetDirty)
		DeathStage;
}

function Reset()
{
	Destroy();
}

simulated event PostNetReceive()
{
	if (DeathStage != 0 && !GoneOff())	{
		GotoState('JetPack');			}
}

function InitRogue(byte Stage)
{
	DeathStage = Stage;
	GotoState('JetPack');
}

function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
}

simulated function bool GoneOff() { return IsInState('JetPack') || IsInState('RocketPack'); }

simulated function AddVelocity(vector Extra)
{
	Velocity += Extra;
}

simulated state JetPack
{
/*	event Timer()
	{
		Weapon.ConsumeAmmo(0,10);
		if (!Weapon.OutOfAmmo())
		{
			Item.PickupClass = None;
			Item.DropFrom(Item.Location);
			Destroy();
		}
	}
*/
Begin:
	if (DeathStage < 5){
		if (level.NetMode != NM_DedicatedServer)
		{
			class'IM_Bullet'.static.StartSpawn(LeakLoc, LeakDir, 3, Instigator);
			Flame = spawn(class'T10Spray',self,, LeakLoc, rotator(LeakDir));
			Flame.SetBase(self);
		}
		SetTimer(0.1, true);
	}
	if (DeathStage < 2){
		AddVelocity(vect(0,0,400) + vector(Rotation) * 300);
		Sleep(0.5);
	}
	if (DeathStage < 3){
		AddVelocity(vector(Rotation) * 400 + VRand() * 400);
		Sleep(0.5);
	}
	if (DeathStage < 4){
		AddVelocity(vect(0,0,400) + vector(Rotation) * 400 + VRand() * 400);
		Sleep(0.5);
	}
	if (DeathStage < 5){
		AddVelocity(vector(Rotation) * 400 + VRand() * 400);
		Sleep(0.5);
		if (Flame != None)
			Flame.Destroy();
	}
	GotoState('RocketPack');
}
simulated state RocketPack
{
	simulated event Tick (float DT)
	{
		AddVelocity(vect(0,0,1400) * DT);
		if (Flame != None)
		{
			Flame.SetLocation(location-vect(0,0,16));
			Flame.SetRotation( Flame.Rotation + (rotator( -(ThrustDir + vect(0,0,1400)*DT) ) - Flame.Rotation) * DT*2 );
		}
	}
/*	event Timer()
	{
		Weapon.ConsumeAmmo(0,12);
		if (!Weapon.HasAmmo())
		{
			Item.PickupClass = None;
			Item.DropFrom(Item.Location);
			Destroy();
		}
	}
*/
Begin:
	AmbientSound = Sound'BallisticSounds2.RX22A.RX22A-PackBurn';
	SoundVolume = 255;
	SoundRadius = 64;

	if (level.NetMode != NM_DedicatedServer)
	{
		Flame = spawn(class'RX22APackTrail',self,, location-vect(0,0,32), rot(-16384,0,0));
		class'BallisticEmitter'.static.ScaleEmitter(Flame, 0.5);
	}
	SetTimer(0.1, true);

	if (DeathStage < 7){
		PlaySound(sound'BallisticSounds2.RX22A.RX22A-PackIgnite', Slot_Interact, 0.8, , 128);
		ThrustDir = vect(0,0,1200);
		AddVelocity(ThrustDir);
		Sleep(0.5); //0.5
	}
	if (DeathStage < 8){
		ThrustDir = VRand() * 400;
		AddVelocity(ThrustDir);
		Sleep(0.5);	//1.0
	}
	if (DeathStage < 9){
		ThrustDir = VRand() * 400;
		AddVelocity(ThrustDir);
		Sleep(0.5);	//1.5
	}
	if (DeathStage < 10){
		ThrustDir = VRand() * 400;
		AddVelocity(ThrustDir);
		Sleep(0.5);	//2.0
	}
	if (DeathStage < 11){
		ThrustDir = VRand() * 400;
		AddVelocity(ThrustDir);
		Sleep(0.5);	//2.5
	}
	if (DeathStage < 12){
		ThrustDir = VRand() * 400;
		AddVelocity(ThrustDir);
		Sleep(0.5);	//3.0
	}
	class'IM_GasTankExplode'.static.StartSpawn(Location, vect(0,0,1), 0, self);
	if (Flame != None)
		Flame.Kill();
	HurtRadius(300, 512, class'DTRX22ATankExplode', 5000, location);
	bHidden=true;
	Velocity=vect(0,0,0);
	if (Role == ROLE_Authority)
	{
		Sleep(1.0);
		Destroy();
	}
}

simulated function Landed( vector HitNormal )
{
    HitWall( HitNormal, None );
}
simulated function HitWall( vector HitNormal, actor Wall )
{
    local Vector VNorm;
    local float Speed;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * 0.6 + (Velocity - VNorm) * 0.8;

	RotationRate = RotRand(true)*0.25;

	Speed = VSize(Velocity);
    if ( Speed < 50 )
    {
        bBounce = False;
		SetPhysics(PHYS_None);
		bCollideWorld = false;
    }
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.Kill();
	super.Destroyed();
}

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BallisticHardware2.RX22A.FlamerTank'
     Physics=PHYS_Falling
     RemoteRole=ROLE_SimulatedProxy
     RelativeLocation=(X=28.000000,Y=28.000000)
     RelativeRotation=(Yaw=-16384,Roll=16384)
     DrawScale=0.250000
     CollisionRadius=12.000000
     CollisionHeight=14.000000
     bCollideWorld=True
     bNetNotify=True
     bBounce=True
     bFixedRotationDir=True
     RotationRate=(Pitch=4096,Yaw=4096,Roll=2048)
}

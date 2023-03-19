//=============================================================================
// RX22A gas tank.
//
// Does not terminate the user when shot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22ATank extends Actor;

var int			Health;
var vector		LeakDir, LeakLoc, ThrustDir;

var Emitter 	Flame;
var BallisticWeapon	Weapon;

var byte		DeathStage;
var bool		bNetGoRocket;

var vector		HurtLoc;

replication
{
	reliable if (Role == ROLE_Authority && bNetDirty)
		LeakLoc, bNetGoRocket, HurtLoc;
}

simulated event PreBeginPlay()
{
	if (Owner != None && Pawn(Owner) != None)
		Instigator = Pawn(Owner);
	super.PreBeginPlay();
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (level.netMode != NM_DedicatedServer && Instigator!= None)
		Instigator.AttachToBone(self,'Spine');
}

simulated event PostNetReceive()
{
	if (HurtLoc != vect(0,0,0))
	{
		if (level.NetMode != NM_DedicatedServer)
			class'IM_Bullet'.static.StartSpawn(HurtLoc, normal(HurtLoc-Location), 3, Instigator);
		HurtLoc = vect(0,0,0);
	}
	if (LeakLoc != vect(0,0,0) && !GoneOff())	{
		if (Owner != None)
			LeakDir = Normal(Location-LeakLoc)<<Owner.Rotation;
		else
			LeakDir = Normal(Location-LeakLoc)<<Rotation;
		if (bNetGoRocket)
			GotoState('RocketPack');
		else
			GotoState('JetPack');				}
	if (bNetGoRocket && IsInState('JetPack'))
		GotoState('RocketPack');
}


function TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	local bool bFire;

    // this isn't realistic (unless the attack is fire-based), but I've added the dual check nonetheless
	if (!class'BallisticReplicationInfo'.static.IsClassicOrRealism())
		return;

	if (Role < ROLE_Authority)
		return;
	if (Instigator != None && (Instigator.InGodMode() ||
		(Instigator.Controller != None && InstigatedBy != None && InstigatedBy != Instigator && Instigator.Controller.SameTeamAs(InstigatedBy.Controller)) ||
		Normal(HitLocation-Location) Dot vector(Rotation) > 0.4))
		return;

	if (class<BallisticDamageType>(DamageType) != None)
	{
		// GearSafe damage does not harm the gear, just the guy inside...
		if (class<BallisticDamageType>(DamageType).static.IsDamage(",GearSafe,"))
			return;
		else if (/*class<BallisticDamageType>(DamageType).static.IsDamage(",Flame,") || */class<BallisticDamageType>(DamageType).default.bIgniteFires)
		{
			Damage = Max(1, Damage * 0.2);
			bFire=true;
		}
	}
	Health -= Damage;
	if (Health > 0)
	{
		if (level.NetMode != NM_DedicatedServer)
		{
			class'IM_Bullet'.static.StartSpawn(HitLocation, normal(HitLocation-Location), 3, Instigator);
			if (level.NetMode == NM_ListenServer)
				HurtLoc = HitLocation;
		}
		else
			HurtLoc = HitLocation;
		return;
	}
	if (!GoneOff())
	{
		Instigator = InstigatedBy;
		LeakLoc = HitLocation;
		LeakDir = Normal(Location-LeakLoc)<<Owner.Rotation;
		bAlwaysRelevant=True;
		if (bFire)
		{
			GotoState('RocketPack');
			bNetGoRocket=true;
		}
		else
			GotoState('JetPack');
	}
	else if (IsInState('JetPack') && bFire)
	{
		GotoState('RocketPack');
		bNetGoRocket=true;
	}
}

function AttachmentDestroyed()
{
	if (!GoneOff())
		Destroy();
}

function GoRogue()
{
    local RX22ARogueTank Tank;
	if (DeathStage < 12)
		Tank = Spawn(class'RX22ARogueTank',,, Location);
	if (Tank != None)
	{
		Tank.Instigator = Instigator;
		Tank.InitRogue(DeathStage);
	}
	GotoState('');
	Destroy();
}

simulated function bool GoneOff() { return IsInState('JetPack') || IsInState('RocketPack'); }

simulated function AddVelocity(Vector V)
{
	if (Owner != None && Pawn(Owner) != None)
		Pawn(Owner).AddVelocity(vect(0,0,400) + (LeakDir >> Owner.Rotation) * 300);
}

simulated state JetPack
{
	simulated event Tick (float DT)
	{
		Global.Tick(DT);

		if (Flame != None && level.NetMode == NM_Client && Owner == None)
		{
			Flame.SetLocation(Location-vect(0,0,16));
			Flame.SetRotation( rotator(LeakDir >> Rotation) );
		}
	}
	event Timer()
	{
		Weapon.ConsumeAmmo(0,10);
		if (!Weapon.HasAmmo())
		{
			Weapon.PickupClass = None;
			Weapon.DropFrom(Weapon.Location);
			SetTimer(0,false);
			GotoState('');
			Destroy();
		}
	}
Begin:
	AmbientSound = Sound'BW_Core_WeaponSound.RX22A.RX22A-FuelLoop';
	if (level.NetMode != NM_DedicatedServer)
	{
		class'IM_Bullet'.static.StartSpawn(LeakLoc, LeakDir, 3, Instigator);
		Flame = spawn(class'RX22A_TankLeak',self,, LeakLoc, rotator(LeakDir));
		if (Owner != None)
			Flame.SetBase(Owner);
	}
	SetTimer(0.1, true);
	DeathStage = 1;
	if (Owner != None)
		AddVelocity(vect(0,0,400) + (LeakDir >> Owner.Rotation) * 300);
	Sleep(0.5);
	DeathStage = 2;
	if (Owner != None)
		AddVelocity((LeakDir >> Owner.Rotation) * 400 + VRand() * 400);
	Sleep(0.5);
	DeathStage = 3;
	if (Owner != None)
		AddVelocity(vect(0,0,400) + (LeakDir >> Owner.Rotation) * 400 + VRand() * 400);
	Sleep(0.5);
	DeathStage = 4;
	if (Owner != None)
		AddVelocity((LeakDir >> Owner.Rotation) * 400 + VRand() * 400);
	Sleep(0.5);
	DeathStage = 5;
	if (Flame != None)
		Flame.Destroy();
	GotoState('RocketPack');
}
simulated state RocketPack
{
	simulated event Tick (float DT)
	{
		Global.Tick(DT);
		if (Owner != None && Pawn(Owner) != None)
			Pawn(Owner).AddVelocity(vect(0,0,1400) * DT);
		if (Flame != None)
		{
			if (level.NetMode == NM_Client && Owner != None)
				Flame.SetLocation(owner.location-vect(0,0,16)-vector(owner.rotation)*20);
			else
				Flame.SetLocation(Location-vect(0,0,16));
			Flame.SetRotation( Flame.Rotation + (rotator( -(ThrustDir + vect(0,0,1400)) ) - Flame.Rotation) * DT*2 );
		}
	}
	event Timer()
	{
		if (Weapon != None)
		{
			Weapon.ConsumeAmmo(0,12);
			if (!Weapon.HasAmmo())
			{
				Weapon.PickupClass = None;
				Weapon.DropFrom(Weapon.Location);
				SetTimer(0,false);
				GotoState('');
				Destroy();
			}
		}
	}
Begin:
	if (Owner != None)
		owner.PlaySound(sound'BW_Core_WeaponSound.RX22A.RX22A-PackIgnite', Slot_Interact, 0.8, , 128);
	else
		PlaySound(sound'BW_Core_WeaponSound.RX22A.RX22A-PackIgnite', Slot_Interact, 0.8, , 128);
//	AmbientSound = Sound'BW_Core_WeaponSound.RX22A.RX22A-FireLoop';
	AmbientSound = Sound'BW_Core_WeaponSound.RX22A.RX22A-PackBurn';
	SoundVolume = 255;
	SoundRadius = 64;

	if (Flame != None)
		Flame.Destroy();
	if (level.NetMode != NM_DedicatedServer)
	{
		Flame = spawn(class'RX22APackTrail',None,, location-vect(0,0,26), rot(-16384,0,0));
		class'BallisticEmitter'.static.ScaleEmitter(Flame, 0.5);
	}
	SetTimer(0.1, true);

	DeathStage = 6;
	ThrustDir = vect(0,0,1200);
	AddVelocity(ThrustDir);
	Sleep(0.5); //0.5

	DeathStage = 7;
	ThrustDir = VRand() * 400;
	AddVelocity(ThrustDir);
	Sleep(0.5);	//1.0

	DeathStage = 8;
	ThrustDir = VRand() * 400;
	AddVelocity(ThrustDir);
	Sleep(0.5);	//1.5

	DeathStage = 9;
	ThrustDir = VRand() * 400;
	AddVelocity(ThrustDir);
	Sleep(0.5);	//2.0

	DeathStage = 10;
	ThrustDir = VRand() * 400;
	AddVelocity(ThrustDir);
	Sleep(0.5);	//2.5

	DeathStage = 11;
	ThrustDir = VRand() * 400;
	AddVelocity(ThrustDir);
	Sleep(0.5);	//3.0

	DeathStage = 12;
	if (level.NetMode != NM_DedicatedServer)
	{
		if (Owner != None)
			class'IM_GasTankExplode'.static.StartSpawn(owner.Location-vector(owner.rotation)*20, vect(0,0,1), 0, level.GetLocalPlayerController());
		else
			class'IM_GasTankExplode'.static.StartSpawn(Location, vect(0,0,1), 0, level.GetLocalPlayerController());
	}
	if (Flame != None)
		Flame.Kill();
	Sleep(0.1);

	if (Role == ROLE_Authority)
	{
		if (Owner!=None)
			HurtRadius(300, 512, class'DTRX22ATankExplode', 5000, Owner.location);
		else
			HurtRadius(300, 512, class'DTRX22ATankExplode', 5000, location);
		if (Weapon != None)
		{
			Weapon.PickupClass = None;
			Weapon.DropFrom(Weapon.Location);
		}
	}
	bHidden=true;
	Sleep(0.3);	//3.3

	Destroy();
	GotoState('');
}

event Tick(float DT)
{
	super.Tick(DT);

	if (Owner == None)
	{
		GotoState('');
		Destroy();
		return;
	}
	if (Pawn(Owner).IsFirstPerson() && !Owner.bForceSkelUpdate)
		Owner.bForceSkelUpdate = true;
	else if (Owner.bForceSkelUpdate)
		Owner.bForceSkelUpdate = false;
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.Kill();
	if (Owner != None && Owner.bForceSkelUpdate)
		Owner.bForceSkelUpdate = false;
	super.Destroyed();
}

defaultproperties
{
     Health=35
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.RX22A.FlamerTank'
     bActorShadows=True
     bReplicateInstigator=True
     bReplicateMovement=False
     RemoteRole=ROLE_SimulatedProxy
     RelativeLocation=(X=28.000000,Y=28.000000)
     RelativeRotation=(Yaw=-16384,Roll=16384)
     DrawScale=0.250000
     CollisionHeight=24.000000
     bCollideActors=True
     bProjTarget=True
     bBlockNonZeroExtentTraces=False
     bUseCylinderCollision=True
     bNetNotify=True
}

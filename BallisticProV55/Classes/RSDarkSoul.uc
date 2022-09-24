//=============================================================================
// RSDarkSoul.
//
// A soul actor created when a player is killed by a darkstar.
// Souls can be collected by darkstar wielders to get super powers.
// Souls have some AI and try to follow the killer and run away from pain.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkSoul extends BallisticEmitter;

var float	Brakes;
var float	MaxSpeed;

var() Sound	CollectSound;

var Pawn	Assailant;
var vector	LassSeenLoc;
var actor	WanderTarget;
var actor	OldWanderTarget;

var vector	TerrorLocation;
var pawn	TerrorInstigator;

var byte	NetState;
var byte	StateNum;

var float	MySoulPower;

replication
{
	reliable if (Role == ROLE_Authority && bNetDirty)
		NetState, Assailant;
	unreliable if (Role == ROLE_Authority && bNetDirty)
		WanderTarget;
}

simulated event PostNetReceive()
{
	if (NetState != StateNum)
	{
		switch (NetState)
		{
		case 0:	GotoState('Spawning'); break;
		case 1:	GotoState('BackOff'); break;
		case 2:	GotoState('Follow'); break;
		case 3:	GotoState('Wander'); break;
		case 4:	GotoState('Terror'); break;
		}
	}
}


event Touch( Actor Other )
{
	local Inventory Inv;

	if ( (Pawn(Other) == None) || !Pawn(Other).bCanPickupInventory/* || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) */)
		return;

	if ( !FastTrace(Other.Location, Location) )
		return;

	for (Inv=Pawn(Other).Inventory;Inv!=None;Inv=Inv.Inventory)
	{
		if (RSDarkStar(Inv) != None)
		{
			if (CollectSound!=None)
				PlaySound( CollectSound,SLOT_Interact, 1.5 );
			RSDarkStar(Inv).AddSoul(MySoulPower);
			Destroy();
			return;
		}
	}
}

simulated singular event HitWall(vector HitNormal, actor Wall)
{
    local Vector VNorm;

    VNorm = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VNorm * 0.5 + (Velocity - VNorm) * 0.9;
//	Velocity = vect(0,0,0);
//	Acceleration = HitNormal * 20;
}

simulated event Tick(float DT)
{
	local vector V;

	if (VSize(Velocity) > MaxSpeed)
		Velocity = Normal(Velocity) * MaxSpeed;
	if (Acceleration == vect(0,0,0) && Brakes > 0)
		Velocity = Normal(Velocity) * FMax(0, VSize(Velocity)-Brakes*DT);

	if (level.netMode != NM_DedicatedServer)
	{
		V = Velocity * 0.3;
		Emitters[3].StartVelocityRange.X.Min = V.X;
		Emitters[3].StartVelocityRange.X.Max = V.X;
		Emitters[3].StartVelocityRange.Y.Min = V.Y;
		Emitters[3].StartVelocityRange.Y.Max = V.Y;
	}
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	if (HitLocation == Location)
	{
		if (Momentum != vect(0,0,0))
			TerrorLocation = Location - Momentum;
		else if (EventInstigator != None)
			TerrorLocation = EventInstigator.location;
		else
			TerrorLocation = Location + vrand();
	}
	else
		TerrorLocation = HitLocation;
	TerrorInstigator = EventInstigator;
	if (class<DT_RSBlackHoleSuck>(DamageType)!=None)
	{
		if (IsInState('BlackHoled'))
			BeginState();
		else
			GotoState('BlackHoled');
	}
	else
		GotoState('Terror');
}

auto state Spawning
{
	event Touch( Actor Other );
	event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex);
	simulated function BeginState()
	{
		NetState = 0;
		StateNum = 0;
		LassSeenLoc = Location;
		MaxSpeed = 200;
		Acceleration = vect(0,0,0);
		Velocity = vect(0,0,100) + VRand() * 50;
		Brakes = 250;
		SetTimer(0.5, false);
	}
	simulated event Timer()
	{
		SetCollisionSize(28, 28);
		GotoState('Follow');
	}
}

simulated state BackOff
{
	simulated function BeginState()
	{
		NetState = 1;
		StateNum = 1;
		MaxSpeed = 300;
		if (Assailant != None)
		{
			Acceleration = Normal(Location - Assailant.Location) * 80;
			Acceleration.Z *= 0.5;
			LassSeenLoc = Assailant.Location;
		}
		SetTimer(5, false);
	}
	simulated event Timer()
	{
		if (Assailant == None)
			GotoState('Wander');
		else
			GotoState('Follow');
//		else if (FastTrace(Assailant.Location ,Location))
//			GotoState('Follow');
//		else
//			SetTimer(2, false);
	}
}

simulated state Follow
{
	simulated function BeginState()
	{
		NetState = 2;
		StateNum = 2;
		MaxSpeed = 250;
		SetTimer(0.1, true);
	}
	simulated event Timer()
	{
		if (Assailant != None)
		{
			if (!FastTrace(Assailant.Location ,Location))
			{
				if (VSize(LassSeenLoc - Location) < 100)
					GotoState('Wander');
				else
					Acceleration = Normal(LassSeenLoc - Location) * 50;
			}
			else
			{
				LassSeenLoc = Assailant.Location;
				Acceleration = Normal(Assailant.Location - Location) * 50;
			}
		}
		else
		{
			if (LassSeenLoc == vect(0,0,0) || VSize(LassSeenLoc - Location) < 100)
				GotoState('Wander');
			else
				Acceleration = Normal(LassSeenLoc - Location) * 50;
		}
	}
}

simulated state Wander
{
	simulated function BeginState()
	{
		NetState = 3;
		StateNum = 3;
		MaxSpeed = 150;
		SetTimer(0.1, true);
	}

	simulated function FindDest ()
	{
		local NavigationPoint N, Best;
		local float Dist, BestDist;

		if (WanderTarget != None)
			OldWanderTarget = WanderTarget;
		if (NavigationPoint(WanderTarget) != None)
		{
			N = NavigationPoint(WanderTarget);
			if (N.PathList.length > 0)
				Best = N.PathList[Rand(N.PathList.length)].End;
			if (Best != None)
			{
				WanderTarget = Best;
				return;
			}
		}
		BestDist = 999999;
		for (N=level.NavigationPointList;N!=None;N=N.nextNavigationPoint)
		{
			if (N == OldWanderTarget)
				continue;
			Dist = VSize(N.Location - Location);
			if (Dist < BestDist && FastTrace(N.Location, Location))
			{
				Best = N;
				BestDist = Dist;
			}
		}
		WanderTarget = Best;
	}

	simulated event Timer()
	{
		if (Assailant != None && FastTrace(Assailant.Location, Location))
		{
			Acceleration = Normal(LassSeenLoc - Location) * 50;
			GotoState('Follow');
			return;
		}
		if (WanderTarget == None)
			FindDest();
		if (WanderTarget != None)
		{
			if (VSize(WanderTarget.Location - Location) < 100)
				FindDest();

			Acceleration = Normal(Location - WanderTarget.Location) * 50;
		}
		else
		{
			SetTimer(8.0, false);
			Acceleration = vrand() * 50;
		}
	}

Begin:
	Sleep(30);
TryKill:
	if (!PlayerCanSeeMe())
		Kill();
	else
	{
		Sleep(2);
		Goto('TryKill');
	}
}

simulated state Terror
{
	simulated function BeginState()
	{
		NetState = 4;
		StateNum = 4;
		MaxSpeed = 500;
		Acceleration = Normal(Location - TerrorLocation) * 250;
		SetTimer(5, false);
	}
	simulated event Timer()
	{
		if (Assailant == None)
			GotoState('Wander');
		else
			GotoState('Follow');
	}
}

simulated state BlackHoled
{
	event Touch( Actor Other );

	simulated function BeginState()
	{
		NetState = 4;
		StateNum = 4;
		MaxSpeed = 100;
		Acceleration = Normal(Location - TerrorLocation) * 150;
		SetTimer(2.5, false);
	}
	simulated event Timer()
	{
		if (TerrorInstigator != None && TerrorInstigator.Health > 0 && VSize(Location - TerrorInstigator.Location) < 500 && FastTrace(Location - TerrorInstigator.Location))
		{
			TerrorLocation = TerrorInstigator.Location;
			BeginState();
		}
		else if (Assailant == None)
			GotoState('Wander');
		else
			GotoState('Follow');
	}
}

static function RSDarkSoul SpawnSoul(vector StartLoc, Pawn Killer, Pawn Victim, actor ControlActor)
{
	local RSDarkSoul Soul;
	local vector HitLoc, HitNorm, SpawnLoc, HitLoc2;
	local actor T;

	if (ControlActor == None)
		return None;

	SpawnLoc = StartLoc;

	T = ControlActor.Trace(HitLoc, HitNorm, StartLoc-vect(0,0,1)*28, StartLoc, false, vect(16,16,0));
	if (T == None)
		HitLoc = StartLoc-vect(0,0,1)*28;
	T = ControlActor.Trace(HitLoc2, HitNorm, StartLoc+vect(0,0,1)*28, StartLoc, false, vect(16,16,0));
	if (T == None)
		HitLoc2 = StartLoc+vect(0,0,1)*28;
	SpawnLoc.Z = HitLoc.Z + (HitLoc2.Z-HitLoc.Z) * 0.5;

	T = ControlActor.Trace(HitLoc, HitNorm, StartLoc+vect(1,0,0)*28, StartLoc, false, vect(0,16,16));
	if (T == None)
		HitLoc = StartLoc+vect(1,0,0)*28;
	T = ControlActor.Trace(HitLoc2, HitNorm, StartLoc-vect(1,0,0)*28, StartLoc, false, vect(0,16,16));
	if (T == None)
		HitLoc2 = StartLoc-vect(1,0,0)*28;
	SpawnLoc.X = HitLoc.X + (HitLoc2.X-HitLoc.X) * 0.5;

	T = ControlActor.Trace(HitLoc, HitNorm, StartLoc+vect(0,1,0)*28, StartLoc, false, vect(16,0,16));
	if (T == None)
		HitLoc = StartLoc+vect(0,1,0)*28;
	T = ControlActor.Trace(HitLoc2, HitNorm, StartLoc-vect(0,1,0)*28, StartLoc, false, vect(16,0,16));
	if (T == None)
		HitLoc2 = StartLoc-vect(0,1,0)*28;
	SpawnLoc.Y = HitLoc.Y + (HitLoc2.Y-HitLoc.Y) * 0.5;


	Soul = ControlActor.Spawn(default.class, Victim,, SpawnLoc);
	if (Soul!=None)
		Soul.Assailant = Killer;
		
	if (Monster(Victim) != None)
		Soul.MySoulPower = Victim.HealthMax / 1000;

	return Soul;
}

defaultproperties
{
     CollectSound=Sound'BW_Core_WeaponSound.DarkStar.Dark-Soul'
     MySoulPower=1.000000
     Begin Object Class=TrailEmitter Name=TrailEmitter2
         TrailShadeType=PTTST_Linear
         TrailLocation=PTTL_FollowEmitter
         MaxPointsPerTrail=350
         DistanceThreshold=50.000000
         PointLifeTime=1.000000
         MaxParticles=1
         StartSizeRange=(X=(Min=25.000000,Max=30.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.DarkStar.DarkTrail'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=999999.000000,Max=999999.000000)
     End Object
     Emitters(0)=TrailEmitter'BallisticProV55.RSDarkSoul.TrailEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.700000
         FadeInEndTime=0.370000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSDarkSoul.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.720000
         FadeInEndTime=0.690000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Max=0.025000))
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         StartSizeRange=(X=(Min=48.000000,Max=50.000000),Y=(Min=48.000000,Max=50.000000),Z=(Min=48.000000,Max=50.000000))
         Texture=Texture'BW_Core_WeaponTex.DarkStar.EvilSoul'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkSoul.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(A=255))
         ColorScale(1)=(RelativeTime=0.346429,Color=(G=128,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.280000
         MaxParticles=50
         StartSpinRange=(X=(Min=0.500000,Max=0.500000))
         SizeScale(0)=(RelativeSize=1.100000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.AquaFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-100.000000,Max=-100.000000),Z=(Min=-300.000000,Max=-300.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSDarkSoul.SpriteEmitter5'

     AutoDestroy=True
     bUpdateSimulatedPosition=True
     bOnlyDirtyReplication=True
     bIgnoreVehicles=True
     Physics=PHYS_Flying
     RemoteRole=ROLE_SimulatedProxy
     NetUpdateFrequency=10.000000
     bCanBeDamaged=True
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
     bCollideWorld=True
     bUseCylinderCollision=True
     bNetNotify=True
     bNotOnDedServer=False
}

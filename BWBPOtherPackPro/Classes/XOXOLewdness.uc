class XOXOLewdness extends BallisticEmitter;

#exec OBJ LOAD File=BWBP4-Tex.utx

var float	Brakes;
var float	MaxSpeed;

var() Sound	CollectSound;

var Pawn	AttractTarget;
var vector	LastSeenLoc;
var actor	WanderTarget;
var actor	OldWanderTarget;

var byte	NetState;
var byte	StateNum;

var float 	MySoulPower;

replication
{
	reliable if (Role == ROLE_Authority && bNetDirty)
		NetState, AttractTarget;
}

simulated event PostNetReceive()
{
	if (NetState != StateNum)
	{
		switch (NetState)
		{
			case 0:	GotoState('Spawning'); break;
			case 1: GotoState('Wander'); break;
			case 2:	GotoState('Attracted'); break;
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
		if (XOXOStaff(Inv) != None)
		{
			if (CollectSound!=None)
				PlaySound( CollectSound,SLOT_Interact, 1.5 );
			XOXOStaff(Inv).AddLewd(MySoulPower);
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
}

simulated event Tick(float DT)
{
	if (VSize(Velocity) > MaxSpeed)
		Velocity = Normal(Velocity) * MaxSpeed;
	if (Acceleration == vect(0,0,0) && Brakes > 0)
		Velocity = Normal(Velocity) * FMax(0, VSize(Velocity)-Brakes*DT);
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (class<DT_RSBlackHoleSuck>(DamageType)!=None)
		Destroy();
}

auto state Spawning
{
	event Touch( Actor Other );
	event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType);
	simulated function BeginState()
	{
		NetState = 0;
		StateNum = 0;
		LastSeenLoc = Location;
		MaxSpeed = 200;
		Acceleration = vect(0,0,0);
		Velocity = vect(0,0,100) + VRand() * 50;
		Brakes = 250;
		SetTimer(0.5, false);
	}
	simulated event Timer()
	{
		SetCollisionSize(64, 64);
		GotoState('Attracted');
	}
}

simulated state Wander
{
	simulated function BeginState()
	{
		NetState = 1;
		StateNum = 1;
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
		if (AttractTarget != None && FastTrace(AttractTarget.Location, Location))
		{
			Acceleration = Normal(LastSeenLoc - Location) * 50;
			GotoState('Attracted');
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

simulated state Attracted
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
		if (AttractTarget != None)
		{
			if (!FastTrace(AttractTarget.Location,Location))
			{
				if (VSize(LastSeenLoc - Location) < 250)
					GotoState('Wander');
				else
					Acceleration = Normal(LastSeenLoc - Location) * 125;
			}
			else
			{
				LastSeenLoc = AttractTarget.Location;
				Acceleration = Normal(AttractTarget.Location - Location) * 125;
			}
		}
		else
		{
			if (LastSeenLoc == vect(0,0,0) || VSize(LastSeenLoc - Location) < 250)
				GotoState('Wander');
			else
				Acceleration = Normal(LastSeenLoc - Location) * 125;
		}
	}
}

static function XOXOLewdness DistributeLewd(vector StartLoc, Pawn Killer, Pawn Victim, actor ControlActor)
{
	local XOXOLewdness TheLewd;
	local vector HitLoc, HitNorm, SpawnLoc, HitLoc2;
	local actor T;

	if (ControlActor == None)
		return None;

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


	TheLewd = ControlActor.Spawn(default.class, Victim,, SpawnLoc, rot(0,0,0));
	if (TheLewd!=None)
		TheLewd.AttractTarget = Killer;
		
	if (Monster(Victim) != None)
		TheLewd.MySoulPower = Victim.HealthMax / 1000;

	return TheLewd;
}

defaultproperties
{
     CollectSound=Sound'BWBP4-Sounds.NovaStaff.Nova-Soul'
     MySoulPower=1.000000
     Begin Object Class=SpriteEmitter Name=LewdGlow
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=160,R=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=64,R=255))
         ColorScaleRepeats=1.000000
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.400000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=5
         DetailMode=DM_High
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=70.000000,Max=70.000000))
         ParticlesPerSecond=2.000000
         InitialParticlesPerSecond=2.000000
         Texture=Texture'BallisticEffects.Particles.FlareB1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
     End Object
     Emitters(0)=SpriteEmitter'BWBPOtherPackPro.XOXOLewdness.LewdGlow'

     Begin Object Class=SpriteEmitter Name=LewdHearts
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=-10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.500000))
         FadeOutStartTime=0.750000
         FadeInEndTime=0.750000
         MaxParticles=16
         SpinsPerSecondRange=(X=(Min=0.050000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
         Texture=Texture'BWBPOtherPackTex.XOXO.hearteffect'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBPOtherPackPro.XOXOLewdness.LewdHearts'

     Begin Object Class=MeshEmitter Name=BigHeart
         StaticMesh=StaticMesh'BWBPOtherPackStatic.XOXO.Heart'
         SpinParticles=True
         AutomaticInitialSpawning=False
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SpinCCWorCW=(X=1.000000,Y=1.000000,Z=1.000000)
         SpinsPerSecondRange=(X=(Min=0.500000,Max=0.500000))
         ParticlesPerSecond=1.000000
         InitialParticlesPerSecond=50000.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=MeshEmitter'BWBPOtherPackPro.XOXOLewdness.BigHeart'

     AutoDestroy=True
     bUpdateSimulatedPosition=True
     bOnlyDirtyReplication=True
     bIgnoreVehicles=True
     Physics=PHYS_Flying
     RemoteRole=ROLE_SimulatedProxy
     NetUpdateFrequency=10.000000
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
     bCollideWorld=True
     bUseCylinderCollision=True
     bNetNotify=True
     bNotOnDedServer=False
}

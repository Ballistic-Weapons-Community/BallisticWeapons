class FlameSwordPreconstructor extends BallisticEmitter;

#exec OBJ LOAD FILE=BWBP_OP_Sounds.uax

var float 	Health, MaxHealth;
var Vector GroundPoint;

var class<Actor>	myDeployable;
var class<Vehicle>  myVehicle;
var float				WarpingTime, WarpTime;
var FlameSword Master;
var bool bDie;

replication
{
	reliable if (Role == ROLE_Authority)
		Health, bDie, WarpTime;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	//PlaySound(Sound'BWBP_OP_Sounds.Wrench.electric_burst_6', ,1);
}

function Initialize(class<Actor> InClass, float ConstructionTime)
{
	if (class<Vehicle>(InClass) != None)
	{
		myVehicle = class<Vehicle>(InClass);
		Health = myVehicle.default.Health;
	}
	else 
	{
		myDeployable = InClass;
		if (class<Decoration>(myDeployable) != None)
			Health = class<Decoration>(myDeployable).default.Health;
		else Health = 500;
	}
	
	MaxHealth = Health;
	WarpTime = ConstructionTime;
	SetTimer(ConstructionTime, false);
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	if (EventInstigator != None && EventInstigator.Controller != None && EventInstigator.Controller.SameTeamAs(Instigator.Controller))
		return;
		
	if (Health < 1)
		return;
		
	Health -= Damage * 0.2;
	
	if (Health < 1)
	{
		PlaySound(Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Ignite', ,1);
		
		bDie=True;
		bTearOff=True;
		Kill();
	}
}

simulated function TornOff()
{
	SetCollision(false,false,false);
	if (!bDie)
		Spawn(class'IE_FireExplosion');
	PlaySound(Sound'BWBP_OP_Sounds.FlameSword.FlameSword-Ignite', ,1);
	Kill();
}

function Timer()
{
	bHidden=True;
	bAlwaysRelevant=True;
	bTearOff=True;
	GoToState('SpawnIn');
}

state SpawnIn
{
	function SpawnVehicle()
	{
		local Vehicle newVehicle;
		
		newVehicle = Spawn(myVehicle, , , GroundPoint + vect(0,0,1), Rotation);
		newVehicle.Health = Health;
		newVehicle.bTeamLocked = False;
	}
	
	function SpawnDeployable()
	{
		local WrenchDeployable W;

		W = WrenchDeployable(Spawn(myDeployable, Instigator, , GroundPoint, Rotation));
		W.Health = Health;
	}
	
	Begin:
		Sleep(0.3);
		SetCollision(false,false,false);
		if (myVehicle != None)
			SpawnVehicle();
		else SpawnDeployable();
		Sleep(0.5);
		Destroy();
}

simulated function Tick(float dt)
{
	if (Level.NetMode == NM_DedicatedServer)
		Disable('Tick');
	
	if (WarpTime == 0)
	{
		Emitters[0].Opacity = 0;
		Emitters[1].Opacity = 0;
		Emitters[2].Opacity = 0;
	}
	
	else
	{
		WarpingTime += dt;
		Emitters[0].Opacity = 0.58 * (WarpingTime / WarpTime);
		Emitters[1].Opacity = 0.5 * (WarpingTime / WarpTime);
		Emitters[2].Opacity = 0.33 * (WarpingTime / WarpTime);
	}
}

defaultproperties
{
     Health=100.000000
     MaxHealth=100.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=164,G=221,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(G=36,R=179,A=255))
         Opacity=0.580000
         FadeOutStartTime=0.560000
         FadeInEndTime=0.020000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=4.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=9.000000)
         StartSizeRange=(X=(Min=50.000000,Max=50.000000),Y=(Min=50.000000,Max=50.000000),Z=(Min=50.000000,Max=50.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(0)=SpriteEmitter'BWBP_OP_Pro.FlameSwordPreconstructor.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=178,G=178,R=178,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=65,G=128,R=190,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=100,G=91,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=0.200000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=25.000000,Max=50.000000)
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
         StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
         InitialParticlesPerSecond=500.000000
         Texture=Texture'AW-2004Particles.Energy.BurnFlare'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRadialRange=(Min=5.000000,Max=5.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(1)=SpriteEmitter'BWBP_OP_Pro.FlameSwordPreconstructor.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         FadeOut=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.330000
         FadeOutStartTime=0.040080
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
         InitialParticlesPerSecond=5000.000000
         Texture=Texture'AW-2004Particles.Energy.SmoothRing'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BWBP_OP_Pro.FlameSwordPreconstructor.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=36,G=30,R=108,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=152,G=197,R=252,A=255))
         Opacity=0.630000
         FadeOutStartTime=0.077500
         FadeInEndTime=0.027500
         MaxParticles=15
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=1.000000,Max=5.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeSize=7.000000)
         SizeScale(2)=(RelativeTime=1.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=12.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStar'
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRadialRange=(Min=30.000000,Max=370.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(3)=SpriteEmitter'BWBP_OP_Pro.FlameSwordPreconstructor.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.160000
         FadeInEndTime=0.090000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
         StartSizeRange=(X=(Min=25.000000,Max=25.000000))
         InitialParticlesPerSecond=50000.000000
         Texture=Texture'AW-2004Particles.Weapons.PlasmaStarRed'
         LifetimeRange=(Min=1.000000,Max=1.000000)
         WarmupTicksPerSecond=1.000000
         RelativeWarmupTime=2.000000
     End Object
     Emitters(4)=SpriteEmitter'BWBP_OP_Pro.FlameSwordPreconstructor.SpriteEmitter7'*/

     RemoteRole=ROLE_SimulatedProxy
//     AmbientSound=Sound'BWBP_OP_Sounds.Wrench.Hum10'
     bCanBeDamaged=True
     SoundVolume=255
     SoundRadius=128.000000
     CollisionRadius=48.000000
     CollisionHeight=30.000000
     bCollideActors=True
     bBlockActors=True
     bBlockProjectiles=True
     bProjTarget=True
}

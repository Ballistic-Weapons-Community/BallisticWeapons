//=============================================================================
// RSBlackHole.
//
// A black hole formed when ceratin darkstar and novastaff powers interact.
// Grows larger and more powerful as it takes more damage.
// Players can get sucked in and killed.
// If it gets too large, it explodes.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSBlackHole extends BallisticEmitter;

var float Charge;
var float PreviousCharge;
var bool  bExploded;
var bool InitScaled;

replication
{
	reliable if (Role == ROLE_Authority && bNetDirty)
		Charge;
}

simulated event PostNetReceive()
{
	if (Charge >= 20)
		BOOM();
	else if (PreviousCharge != Charge)
	{
		UpdateEffect();
		PreviousCharge = Charge;
	}
}

simulated event PostNetBeginPlay()
{
	super.PostBeginPlay();

	SetTimer(0.1, true);
	PreviousCharge = Charge;
	SetCollisionSize(Charge * 50, Charge * 50);
	if (level.netMode == NM_DedicatedServer)
	{
		Emitters[0].Disabled=true;
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
		Emitters[3].Disabled=true;
		Emitters[4].Disabled=true;
		Emitters[5].Disabled=true;
	}
	else
		UpdateEffect();
}

function AddCharge(float Amount)
{
	Charge += Amount;

	if (Charge >= 20)
		BOOM();
	else if (Charge < 0.1)
		Destroy();
	else
	{
		SetCollisionSize(Charge * 20, Charge * 20);
		UpdateEffect();
	}
	PreviousCharge = Charge;
}

simulated function UpdateEffect()
{
	if (level.netMode == NM_DedicatedServer || Charge < 0.1)
		return;
	if (!InitScaled)
	{
		class'BallisticEmitter'.static.ScaleEmitter(self, 0.075);
		InitScaled=true;
	}
	class'BallisticEmitter'.static.ScaleEmitter(self, (Charge / PreviousCharge));
}

simulated event Timer()
{
	local float Dist;
	local int i;
	local bool bWasAlive;

	local bool bLOS;

	if (level.netMode != NM_DedicatedServer)
	{
		bLOS = Level.GetLocalPlayerController().LineOfSightTo(self);
		for (i=0;i<Min(EmitterZTestSwitches.length, Emitters.length);i++)
		{
			if (bLOS)
				Emitters[i].ZTest = EmitterZTestSwitches[i] == ZM_OnWhenVisible;
			else
				Emitters[i].ZTest = EmitterZTestSwitches[i] == ZM_OffWhenVisible;
		}
	}
	if (Role < ROLE_Authority)
		return;

	for (i=0;i<Touching.length;i++)
	{
		if (Touching[i] == None || !Touching[i].bCanBeDamaged)
			continue;
		if (Projectile(Touching[i])!=None)
		{
			Charge += 0.5;
			Touching[i].Destroy();
		}
		else if (Pawn(Touching[i]) != None)
		{
			Dist = VSize(Touching[i].Location - Location);

			if (Dist < 80 + Touching[i].CollisionRadius)
			{
				if (xPawn(Touching[i])!=None && Pawn(Touching[i]).Health > 0)
					bWasAlive = true;
				else if (Vehicle(Touching[i]) != None && Vehicle(Touching[i]).Driver != None && Vehicle(Touching[i]).Driver.Health > 0)
					bWasAlive = true;
				class'BallisticDamageType'.static.GenericHurt (Touching[i], 300*(Charge/20), Instigator, Touching[i].Location, Normal((Touching[i].Location-Location)+vect(0,0,70))*160000, class'DT_RSBlackHoleSuck');
				if (bWasAlive && Touching[i]!= None && Pawn(Touching[i]).Health <= 0)
				{
					if (FRand() > 0.5)
						Spawn(class'RSDarkSoul',,, Location);
					else
						Spawn(class'RSNovaSoul',,, Location);
				}
                Charge += 0.5;
			}
			else if (Touching[i].Physics == PHYS_Karma)
				Touching[i].KAddImpulse(Normal(Location - Touching[i].Location) * 60000 * (1-Dist/500) * (Charge/20), Touching[i].Location);
			else
				Pawn(Touching[i]).AddVelocity( Normal(Location - Touching[i].Location) * (60000 / Touching[i].Mass) * (1-Dist/500));
		}
		else if (RSDarkSoul(Touching[i])!=None || RSNovaSoul(Touching[i])!=None)
		{
//			RSDarkSoul(Touching[i]).BlackHoleSuck(self);
			Touching[i].Velocity += Normal(Location - Touching[i].Location) * (40000 / Touching[i].Mass) * (1-Dist/500);
			class'BallisticDamageType'.static.GenericHurt (Touching[i], 100*(Charge/20), Instigator, Location, vect(0,0,10000), class'DT_RSBlackHoleSuck');
		}
	}
	AddCharge(-0.01);
}

simulated function BOOM()
{
	if (level.netMode != NM_DedicatedServer)
		class'IM_RSBlackHole'.static.StartSpawn(Location, vect(0,0,1), 0, self);
	if (Role == ROLE_Authority)
		GotoState('Exploding');
	else
		Kill();
//		Destroy();
}

function Reset()
{
	Destroy();
}

state Exploding
{
	function AddCharge(float Amount);

Begin:
	if (level.netMode != NM_DedicatedServer)
		Kill();
	HurtRadius(200, 512, class'DT_RSBlackHoleExplode', 10000, Location);
	Sleep(0.25);
	HurtRadius(200, 700, class'DT_RSBlackHoleExplode', 20000, Location);
	Sleep(0.25);
	HurtRadius(200, 900, class'DT_RSBlackHoleExplode', 50000, Location);
	if (level.netMode == NM_DedicatedServer)
		Destroy();
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	AddCharge(Damage/100.0);
}

defaultproperties
{
     Charge=1.000000
     PreviousCharge=1.000000
     EmitterZTestSwitches(0)=ZM_OffWhenVisible
     EmitterZTestSwitches(1)=ZM_OffWhenVisible
     EmitterZTestSwitches(2)=ZM_OffWhenVisible
     EmitterZTestSwitches(3)=ZM_OffWhenVisible
     EmitterZTestSwitches(4)=ZM_OffWhenVisible
     EmitterZTestSwitches(5)=ZM_OffWhenVisible
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.410000
         FadeInEndTime=0.150000
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=100.000000,Max=100.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.800000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
         StartSizeRange=(X=(Min=150.000000,Max=180.000000),Y=(Min=150.000000,Max=180.000000),Z=(Min=150.000000,Max=180.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartVelocityRadialRange=(Min=-100.000000,Max=-70.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RSBlackHole.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(G=200,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(G=200,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=0.430000
         FadeInEndTime=0.230000
         MaxParticles=2
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         SpinCCWorCW=(X=1.000000)
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.150000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=200.000000,Max=215.000000),Y=(Min=200.000000,Max=215.000000),Z=(Min=200.000000,Max=215.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterRing1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RSBlackHole.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.280000
         FadeInEndTime=0.560000
         MaxParticles=3
         SizeScale(0)=(RelativeSize=0.900000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.100000)
         StartSizeRange=(X=(Min=190.000000,Max=200.000000),Y=(Min=190.000000,Max=200.000000),Z=(Min=190.000000,Max=200.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.DarkStar.HotFlareA2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSBlackHole.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.290000
         FadeInEndTime=0.060000
         MaxParticles=4
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
         StartSizeRange=(X=(Min=35.000000,Max=50.000000),Y=(Min=35.000000,Max=50.000000),Z=(Min=35.000000,Max=50.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke7c'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RSBlackHole.SpriteEmitter9'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter10
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.750000),Z=(Min=0.400000,Max=0.600000))
         Opacity=0.150000
         FadeOutStartTime=0.270000
         FadeInEndTime=0.040000
         MaxParticles=3
         StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-15.000000,Max=15.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=25.000000,Max=75.000000),Y=(Min=25.000000,Max=75.000000),Z=(Min=25.000000,Max=75.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(4)=SpriteEmitter'BallisticProV55.RSBlackHole.SpriteEmitter10'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=128.000000,Max=512.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-48.000000,Max=48.000000),Y=(Min=-48.000000,Max=48.000000),Z=(Min=-48.000000,Max=48.000000))
         HighFrequencyNoiseRange=(X=(Min=-4.000000,Max=4.000000),Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
         HighFrequencyPoints=8
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.000000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.076000
         FadeInEndTime=0.020000
         MaxParticles=3
         StartLocationShape=PTLS_Sphere
         SphereRadiusRange=(Min=24.000000,Max=24.000000)
         SizeScale(0)=(RelativeSize=3.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.500000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=15.000000,Max=50.000000),Y=(Min=15.000000,Max=50.000000),Z=(Min=15.000000,Max=50.000000))
         InitialParticlesPerSecond=5.000000
         Texture=Texture'EpicParticles.Beams.HotBolt04aw'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRadialRange=(Min=-1.000000,Max=-1.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(5)=BeamEmitter'BallisticProV55.RSBlackHole.BeamEmitter0'

     AutoDestroy=True
     bIgnoreEncroachers=True
     bAlwaysRelevant=True
     bNetInitialRotation=True
     RemoteRole=ROLE_SimulatedProxy
     AmbientSound=Sound'BW_Core_WeaponSound.Misc.BH-Ambient'
     bCanBeDamaged=True
     bFullVolume=True
     SoundVolume=255
     SoundRadius=128.000000
     bCollideActors=True
     bProjTarget=True
     bUseCylinderCollision=True
     bNetNotify=True
     bNotOnDedServer=False
}

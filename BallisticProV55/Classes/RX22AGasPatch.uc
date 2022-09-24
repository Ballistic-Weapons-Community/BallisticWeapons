//=============================================================================
// RX22AGasPatch.
//
// A deposit of flamer fuel on a surface. Once ignited, it will burn until depleted.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AGasPatch extends BW_FuelPatch
	placeable;

var   RX22AFireControl	GasControl;
var   bool		bPendingIgnite;
var   Pawn		Ignitioneer;
var Controller	InstigatorController;

simulated function Ignite(Pawn EventInstigator)
{
	local RX22ASurfaceFire Temp;

	if(Role != ROLE_Authority)
		return;

	bIgnited = true;
	bPendingIgnite = false;

	Temp = Spawn(class'RX22ASurfaceFire',Instigator,,Location+vector(Rotation)*32, Rotation);
	if (InstigatorController == None && Instigator != None)
		Temp.InstigatorController = Instigator.Controller;
	else
		Temp.InstigatorController = InstigatorController;
	Temp.Ignitioneer = Ignitioneer;
	Temp.PlayIgnite();
	Temp.SetFuel(Fuel);
	Temp.GasControl = GasControl;
	Temp.SetBase(Base);

	GasControl.PatchReplace(self, Temp);

	Destroy();
}

function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional int HitIndex)
{
	if (class<BallisticDamageType>(DamageType)!=None && !class<BallisticDamageType>(DamageType).default.bIgniteFires/* && !class<BallisticDamageType>(DamageType).IsDamage(",Flame,")*/)
		return;
	Ignitioneer = EventInstigator;
	SetTimer(0.1, false);
	bPendingIgnite=true;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	Emitters[0].StartLocationOffset = vector(Rotation) * 10;
	if (Instigator == None && Owner != None)
		Instigator = Pawn(Owner);
	if (Instigator != None)
		InstigatorController = Instigator.Controller;
}

simulated singular event BaseChange()
{
	if (Mover(Base) != None)
		Destroy();
}

event Timer()
{
	local int i;

	if (bIgnited)
		return;
	if (bPendingIgnite)
	{
//		SetTimer(0.5,true);
		Ignite(none);
	}
	for (i=0;i<Touching.length;i++)
	{
		if (Touching[i] == None || Pawn(Touching[i]) == None)
			continue;
		if (GasControl != None)
			GasControl.SpraySoak(Touching[i], Instigator, 0.5);
		Fuel-=0.5;
	}
	super.Timer();
}

simulated function Destroyed()
{
	if (!bIgnited && GasControl!=None)
		GasControl.PatchRemove(self);
//		GasControl.PatchBurnOut(self);
	super.Destroyed();
}

defaultproperties
{
     Fuel=20.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.800000
         FadeOutStartTime=0.920000
         FadeInEndTime=0.780000
         MaxParticles=2
         StartLocationOffset=(X=10.000000)
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.600000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AGasPatch.SpriteEmitter20'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.440000
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=4.000000)
         StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke5'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AGasPatch.SpriteEmitter21'

     bNetInitialRotation=True
     RemoteRole=ROLE_SimulatedProxy
     bCanBeDamaged=True
     CollisionRadius=72.000000
     CollisionHeight=72.000000
     bCollideActors=True
     bUseCylinderCollision=True
}

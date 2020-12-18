//=============================================================================
// RX22AGasSoak.
//
// A fuel deposit attached to a player or similar actor. Ignited to turn into an attached fire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AGasSoak extends BW_FuelPatch
	placeable;

var   RX22AFireControl	GasControl;

function PreBeginPlay()
{
	super.PreBeginPlay();
	Instigator = Pawn(Owner);
}

function Ignite(Pawn EventInstigator)
{
	local RX22AActorFire PF;

	PF = Spawn(class'RX22AActorFire',Instigator,,Location, Rotation);
	PF.SetFuel(Fuel);
	PF.Ignitioneer = EventInstigator;
	PF.Initialize(Base);
	GasControl.PatchReplace(self, PF);
	PF.GasControl = GasControl;

	Destroy();
}

function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
	Ignite(EventInstigator);
}

simulated function Destroyed()
{
	if (GasControl != None)
		GasControl.PatchRemove(self);
	super.Destroyed();
}

defaultproperties
{
     Fuel=5.000000
     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=5.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.800000,Max=0.800000))
         Opacity=0.520000
         FadeOutStartTime=1.220000
         FadeInEndTime=0.780000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=10.000000)
         StartLocationRange=(Z=(Min=-30.000000,Max=30.000000))
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=40.000000,Max=40.000000),Y=(Min=40.000000,Max=40.000000),Z=(Min=40.000000,Max=40.000000))
         DrawStyle=PTDS_Darken
         Texture=Texture'BallisticEffects.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.RX22AGasSoak.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         ProjectionNormal=(X=1.000000,Z=0.000000)
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Z=(Min=0.200000,Max=0.200000))
         Opacity=0.410000
         FadeOutStartTime=0.540000
         FadeInEndTime=0.540000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         StartLocationOffset=(X=4.000000)
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=15.000000))
         SphereRadiusRange=(Min=40.000000,Max=40.000000)
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticEffects.Particles.DirtSprayAlpha'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-20.000000,Max=-20.000000))
         StartVelocityRadialRange=(Min=15.000000,Max=15.000000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AGasSoak.SpriteEmitter7'

     RemoteRole=ROLE_SimulatedProxy
     bCanBeDamaged=True
     CollisionRadius=128.000000
     CollisionHeight=128.000000
     bCollideActors=True
     bUseCylinderCollision=True
}

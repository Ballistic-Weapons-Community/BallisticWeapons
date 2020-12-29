//=============================================================================
// RSDarkHorns.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkHorns extends BallisticEmitter;

simulated event PostBeginPlay ()
{
	super.PostBeginPlay();
	SetTimer(0.25, true);
	Timer();
}

simulated event Timer ()
{
	if (!Level.GetLocalPlayerController().LineOfSightTo(self))
		Emitters[2].ZTest = true;
	else
		Emitters[2].ZTest = false;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.Horns'
         UseMeshBlendMode=False
         UseParticleColor=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.050000,Max=0.050000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.990000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=8.000000,Y=-1.000000,Z=1.000000)
         StartSpinRange=(X=(Min=-0.200000,Max=-0.200000),Z=(Min=0.240000,Max=0.240000))
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSDarkHorns.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.Horns'
         UseMeshBlendMode=False
         UseParticleColor=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.050000,Max=0.050000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=8.000000,Y=-1.000000,Z=-1.000000)
         StartSpinRange=(X=(Min=-0.200000,Max=-0.200000),Z=(Min=0.260000,Max=0.260000))
         StartSizeRange=(Y=(Min=-1.000000,Max=-1.000000))
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.RSDarkHorns.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.100000,Max=0.100000),Z=(Min=0.000000,Max=0.000000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationOffset=(X=6.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         Texture=Texture'BallisticEffects.Particles.FlareB2'
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSDarkHorns.SpriteEmitter0'

     Physics=PHYS_Trailer
     AmbientSound=Sound'BWBP4-Sounds.DarkStar.Dark-DemonWail'
     bFullVolume=True
     SoundVolume=255
     SoundRadius=32.000000
}

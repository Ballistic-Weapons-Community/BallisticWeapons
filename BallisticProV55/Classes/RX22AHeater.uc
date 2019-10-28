//=============================================================================
// The RX22A's muzzle heating effect.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AHeater extends BallisticEmitter;

simulated function SetHeat(float NewHeat)
{
	if (NewHeat == 0)
	{
		Emitters[0].Disabled = true;
		Emitters[1].Disabled = true;
	}
	else if (Emitters[0].Disabled)
	{
		Emitters[0].Disabled = false;
		Emitters[1].Disabled = false;
	}
	Emitters[0].Opacity = NewHeat;
	Emitters[1].Opacity = 0.4 * NewHeat;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BallisticHardware2.RX22A.FlamerCanHeater'
         UseMeshBlendMode=False
         UseParticleColor=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.300000,Max=0.300000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RX22AHeater.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.400000,Max=0.400000),Z=(Min=0.000000,Max=0.000000))
         Opacity=0.300000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-6.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
         Texture=Texture'BallisticEffects.Particles.AquaFlareA1'
         LifetimeRange=(Min=0.800000,Max=0.800000)
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AHeater.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(Z=60.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.370000
         FadeOutStartTime=0.195000
         FadeInEndTime=0.195000
         MaxParticles=5
         StartLocationOffset=(Z=12.000000)
         StartLocationRange=(X=(Min=-12.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=12.000000),Y=(Min=10.000000,Max=12.000000),Z=(Min=10.000000,Max=12.000000))
         DrawStyle=PTDS_Modulated
         Texture=Texture'BallisticWeapons2.RX22A.WarpSmoke'
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=-10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AHeater.SpriteEmitter6'

}

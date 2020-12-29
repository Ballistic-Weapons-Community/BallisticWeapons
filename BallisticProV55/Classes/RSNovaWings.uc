//=============================================================================
// RSNovaWings.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaWings extends BallisticEmitter;

function UpdateWings(float Phase)
{
	Emitters[0].StartSpinRange.Z.Min = 0.85 + Phase * 0.15;
	Emitters[0].StartSpinRange.Z.Max = Emitters[0].StartSpinRange.Z.Min;

	Emitters[1].StartSpinRange.Z.Min = -0.85 - Phase * 0.15;
	Emitters[1].StartSpinRange.Z.Max = Emitters[1].StartSpinRange.Z.Min;
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.Wing'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=240,R=240,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=240,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.900000))
         FadeOutStartTime=0.075000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-11.000000,Z=20.000000)
         SpinsPerSecondRange=(Z=(Max=0.010000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=0.950000,Max=0.950000))
         StartSizeRange=(Y=(Min=1.250000,Max=1.250000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.125000,Max=0.125000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RSNovaWings.MeshEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.Wing'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         ColorScale(0)=(Color=(B=255,G=240,R=240,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=240,G=255,R=255,A=255))
         ColorMultiplierRange=(Z=(Min=0.900000))
         FadeOutStartTime=0.075000
         FadeInEndTime=0.050000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-11.000000,Z=20.000000)
         SpinsPerSecondRange=(Z=(Max=0.010000))
         StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=-0.950000,Max=-0.950000))
         StartSizeRange=(Y=(Min=-1.250000,Max=-1.250000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.125000,Max=0.125000)
     End Object
     Emitters(1)=MeshEmitter'BallisticProV55.RSNovaWings.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.610000
         FadeOutStartTime=0.500000
         FadeInEndTime=0.390000
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         StartLocationOffset=(X=-16.000000,Z=20.000000)
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=80.000000,Max=90.000000),Y=(Min=80.000000,Max=90.000000),Z=(Min=80.000000,Max=90.000000))
         Texture=Texture'BW_Core_WeaponTex.NovaStaff.NovaAura'
         LifetimeRange=(Min=1.000000,Max=1.000000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RSNovaWings.SpriteEmitter2'

     Physics=PHYS_Trailer
     AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Flight'
     bOwnerNoSee=True
}

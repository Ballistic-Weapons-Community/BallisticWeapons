//=============================================================================
// MRLFlashEmitter.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLFlashEmitter extends BallisticEmitter;

var() vector	TubeOffsets[18];

/*
                 ___             ___
                /c11\    ___    /C14\
                \___/   /B13\   \___/
                        \___/
               ___    ___   ___    ___
              /B10\  /A12\ /A15\  /B16\
              \___/  \___/ \___/  \___/
        ___       ___           ___       ___
       /c8 \     /A9 \         /A0 \     /C17\
       \___/     \___/         \___/     \___/
              ___     ___   ___    ___
             /B7 \   /A6 \ /A3 \  /B1 \
             \___/   \___/ \___/  \___/
                         ___
                 ___    /B4 \    ___
                /c5 \   \___/   /C2 \
                \___/           \___/
*/

simulated function InitMRLFlash(float Scale)
{
	local int i;
	for (i=0;i<18;i++)
		TubeOffsets[i] *= Scale;
}

simulated function SetBarrelIndex(int Index)
{
	Emitters[0].StartLocationOffset = TubeOffsets[Index];
	Emitters[1].StartLocationOffset = TubeOffsets[Index]+vect(25,0,0);
}

defaultproperties
{
     TubeOffsets(0)=(X=-5.000000,Y=-7.500000)
     TubeOffsets(1)=(X=-23.000000,Y=-11.250000,Z=-6.500000)
     TubeOffsets(2)=(X=-35.000000,Y=-8.000000,Z=-13.850000)
     TubeOffsets(3)=(X=-5.000000,Y=-3.750000,Z=-6.490000)
     TubeOffsets(4)=(X=-23.000000,Z=-13.000000)
     TubeOffsets(5)=(X=-35.000000,Y=8.000000,Z=-13.500000)
     TubeOffsets(6)=(X=-5.000000,Y=3.750000,Z=-6.490000)
     TubeOffsets(7)=(X=-23.000000,Y=11.250000,Z=-6.500000)
     TubeOffsets(8)=(X=-35.000000,Y=16.000000)
     TubeOffsets(9)=(X=-5.000000,Y=7.500000)
     TubeOffsets(10)=(X=-23.000000,Y=11.250000,Z=6.500000)
     TubeOffsets(11)=(X=-35.000000,Y=8.000000,Z=13.500000)
     TubeOffsets(12)=(X=-5.000000,Y=3.750000,Z=6.490000)
     TubeOffsets(13)=(X=-23.000000,Z=13.000000)
     TubeOffsets(14)=(X=-35.000000,Y=-8.000000,Z=13.850000)
     TubeOffsets(15)=(X=-5.000000,Y=-3.750000,Z=6.490000)
     TubeOffsets(16)=(X=-23.000000,Y=-11.250000,Z=6.500000)
     TubeOffsets(17)=(X=-35.000000,Y=-16.000000)
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.R78.RifleMuzzleFlash'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.070000
         FadeInEndTime=0.056000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=-5.000000,Y=-7.500000)
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.340000,RelativeSize=0.600000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.250000)
         StartSizeRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.MRLFlashEmitter.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=128,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.157500
         FadeInEndTime=0.098000
         CoordinateSystem=PTCS_Relative
         MaxParticles=20
         StartLocationOffset=(X=20.000000,Y=-7.500000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.350000,Max=0.350000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=50000.000000
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.MRLFlashEmitter.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         TriggerDisabled=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000),Z=(Min=0.750000,Max=0.750000))
         Opacity=0.850000
         FadeOutStartTime=1.710000
         FadeInEndTime=0.300000
         MaxParticles=20
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.SmokeWisp-Alpha'
         TextureUSubdivisions=4
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         SpawnOnTriggerRange=(Min=1.000000,Max=1.000000)
         SpawnOnTriggerPPS=6.000000
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=50.000000,Max=50.000000))
         VelocityLossRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.MRLFlashEmitter.SpriteEmitter1'

}

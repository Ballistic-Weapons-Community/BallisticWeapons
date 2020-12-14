//=============================================================================
// RX22AFireHit.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AFireHit extends DGVEmitter
	placeable;

simulated event Tick(float DT)
{
	super.Tick(DT);

	Emitters[0].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[0].StartSpinRange.X.Min = Emitters[0].StartSpinRange.X.Max;
	Emitters[0].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536;
	Emitters[0].StartSpinRange.Y.Min = Emitters[0].StartSpinRange.Y.Max;

	if (Rotation != OldRotation)
	{
		OldRotation = Rotation;
		AlignVelocity();
	}
}

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
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.FBlast'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.161000
         FadeInEndTime=0.119000
         MaxParticles=4
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Max=3.000000),Y=(Min=4.000000,Max=5.000000),Z=(Min=4.000000,Max=5.000000))
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.700000)
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RX22AFireHit.MeshEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         ProjectionNormal=(X=1.000000,Z=0.000000)
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.215000
         FadeInEndTime=0.105000
         MaxParticles=40
         StartLocationOffset=(X=40.000000)
         StartSizeRange=(X=(Min=50.000000,Max=80.000000),Y=(Min=50.000000,Max=80.000000),Z=(Min=50.000000,Max=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.450000,Max=0.550000)
         StartVelocityRange=(Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22AFireHit.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
         FadeOutStartTime=0.300000
         FadeInEndTime=0.204000
         MaxParticles=2
         StartLocationOffset=(X=40.000000)
         StartLocationRange=(Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
         StartSizeRange=(X=(Min=180.000000,Max=220.000000),Y=(Min=180.000000,Max=220.000000),Z=(Min=180.000000,Max=220.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.600000,Max=0.600000)
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22AFireHit.SpriteEmitter4'

     AutoDestroy=True
}

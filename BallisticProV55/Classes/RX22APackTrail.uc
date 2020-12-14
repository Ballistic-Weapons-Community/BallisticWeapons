//=============================================================================
// RX22APackTrail.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22APackTrail extends DGVEmitter;

simulated event Tick(float DT)
{
	super.Tick(DT);

	Emitters[0].StartSpinRange.X.Max = float(Rotation.Yaw)/65536;
	Emitters[0].StartSpinRange.X.Min = Emitters[0].StartSpinRange.X.Max;
	Emitters[0].StartSpinRange.Y.Max = float(Rotation.Pitch)/65536 + 0.5;
	Emitters[0].StartSpinRange.Y.Min = Emitters[0].StartSpinRange.Y.Max;

	if (Rotation != OldRotation)
	{
		OldRotation = Rotation;
		AlignVelocity();
	}
}

simulated function InitDGV()
{
	OldRotation = Rotation;
	super.InitDGV();
}

defaultproperties
{
     bVerticalZ=False
     bYIsSpread=False
     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.M806.PistolMuzzleFlash'
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
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.088000
         FadeInEndTime=0.072000
         MaxParticles=30
         SpinsPerSecondRange=(Z=(Max=2.000000))
         StartSpinRange=(Z=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.700000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.500000)
         StartSizeRange=(X=(Min=0.400000,Max=0.500000),Y=(Min=0.250000,Max=0.500000),Z=(Min=0.250000,Max=0.500000))
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=2800.000000,Max=3000.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(0)=MeshEmitter'BallisticProV55.RX22APackTrail.MeshEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.204000
         FadeInEndTime=0.176000
         MaxParticles=20
         SpinsPerSecondRange=(X=(Max=0.500000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=120.000000,Max=120.000000),Y=(Min=120.000000,Max=120.000000),Z=(Min=120.000000,Max=120.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlameParts'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.400000,Max=0.400000)
         StartVelocityRange=(X=(Min=2800.000000,Max=3000.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         FadeIn=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.297000
         FadeInEndTime=0.184500
         MaxParticles=5
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=150.000000,Max=150.000000),Y=(Min=150.000000,Max=150.000000),Z=(Min=150.000000,Max=150.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         LifetimeRange=(Min=0.450000,Max=0.450000)
         StartVelocityRange=(X=(Min=2800.000000,Max=2800.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UniformSize=True
         Acceleration=(X=600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.600000,Max=0.600000))
         FadeOutStartTime=0.170000
         FadeInEndTime=0.060000
         CoordinateSystem=PTCS_Relative
         MaxParticles=3
         StartLocationRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=10.000000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=120.000000,Max=150.000000),Y=(Min=120.000000,Max=150.000000),Z=(Min=120.000000,Max=150.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.FlareB2'
         LifetimeRange=(Min=0.300000,Max=0.500000)
         StartVelocityRange=(X=(Min=-50.000000,Max=100.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter2'

     Begin Object Class=TrailEmitter Name=TrailEmitter0
         TrailShadeType=PTTST_PointLife
         MaxPointsPerTrail=100
         DistanceThreshold=75.000000
         PointLifeTime=3.000000
         FadeOut=True
         Disabled=True
         Backup_Disabled=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorMultiplierRange=(Y=(Min=0.700000,Max=0.800000),Z=(Min=0.400000,Max=0.600000))
         FadeOutStartTime=0.100000
         DetailMode=DM_SuperHigh
         SizeScale(0)=(RelativeSize=0.500000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke3'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
     End Object
     Emitters(4)=TrailEmitter'BallisticProV55.RX22APackTrail.TrailEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.467857,Color=(B=128,G=192,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=32,G=96,R=255,A=255))
         FadeOutStartTime=0.147000
         FadeInEndTime=0.021000
         MaxParticles=2
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Max=200.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.400000)
         StartSizeRange=(X=(Min=180.000000,Max=250.000000),Y=(Min=180.000000,Max=250.000000),Z=(Min=180.000000,Max=250.000000))
         Texture=Texture'BW_Core_WeaponTex.Particles.Explode2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.250000,Max=0.400000)
         StartVelocityRange=(X=(Max=400.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=-200.000000,Max=200.000000))
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         SpinParticles=True
         UniformSize=True
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=128,G=212,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=128,R=255,A=255))
         FadeOutStartTime=0.280000
         MaxParticles=100
         DetailMode=DM_SuperHigh
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.700000,Max=0.700000)
         StartVelocityRange=(X=(Min=100.000000,Max=4000.000000),Y=(Min=-700.000000,Max=700.000000),Z=(Min=-700.000000,Max=700.000000))
     End Object
     Emitters(6)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter12
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         Acceleration=(Z=50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255))
         ColorScale(1)=(RelativeTime=0.260714,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.630000
         FadeOutStartTime=0.885000
         FadeInEndTime=0.360000
         MaxParticles=80
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.400000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=50.000000),Y=(Min=50.000000),Z=(Min=50.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke4'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
     End Object
     Emitters(7)=SpriteEmitter'BallisticProV55.RX22APackTrail.SpriteEmitter12'

     AutoDestroy=True
}

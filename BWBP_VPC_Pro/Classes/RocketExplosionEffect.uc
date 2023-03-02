//=============================================================================
// The emitter for the explosion of the Leopard and KHMKII's rockets.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class RocketExplosionEffect extends Emitter
	placeable;

var(Dust)		byte		GrassVariance, DirtVariance;
var				byte		DustType;

simulated function PreBeginPlay()
{
    SetDustColor(Level.DustColor);
}

simulated function SetDustColor(color DustColor)
{
	local color DarkDustColor;

	if(DustColor.R == 0 && DustColor.G == 0 && DustColor.B == 0)
	{
		DustColor.R=255;
		DustColor.G=150;// If the 'Dust Color' is pure black it will be changed to this.
		DustColor.B=64;
	}

	DustColor.A = 255;

	DarkDustColor.R = 32;
	DarkDustColor.G = 32;
	DarkDustColor.B = 32;
	DarkDustColor.A = 255;

// Depending on the color of a map's "Dust Color" certain emmitters are turned off, and other's on.

// Grass, this statement is used to create a Grass emitter when the map's "Dust Color" is Green looking.
    if((Level.DustColor.R & Level.DustColor.B) < (Level.DustColor.G -GrassVariance))
		 DustType = 1;
// Dirt, this statement is used to create a Dirt emitter when the map's "Dust Color" is Brown looking.
    else if(Level.DustColor.B <= (Level.DustColor.R & Level.DustColor.G -DirtVariance))
		 DustType = 2;
// Rock, this statement is used to create a Rock emitter when the map's "Dust Color" is dark Grey to Black.
    else if((Level.DustColor.R & Level.DustColor.G & Level.DustColor.B) <= 48)
		 DustType = 0;
// Snow, this statement is used to create a Snow emitter when the map's "Dust Color" is not equal to any of the above.
    else
		 DustType = 3;

	Emitters[0].ColorScale[0].Color = DarkDustColor;
	Emitters[0].ColorScale[1].Color = DustColor;
	Emitters[0].ColorScale[2].Color = DustColor;

	if(DustType == 0)
	{
		Emitters[4].Disabled = false;
		Emitters[5].Disabled = true;
		Emitters[6].Disabled = true;
		Emitters[7].Disabled = true;
	}

	else if(DustType == 1)
	{
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = false;
		Emitters[6].Disabled = true;
		Emitters[7].Disabled = true;
	}

	else if(DustType == 2)
	{
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
		Emitters[6].Disabled = false;
		Emitters[7].Disabled = true;
	}

	else if(DustType == 3)
	{
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
		Emitters[6].Disabled = true;
		Emitters[7].Disabled = false;
	}
}

defaultproperties
{
     GrassVariance=48
     DirtVariance=24
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-80.000000)
         ColorScale(0)=(Color=(B=192,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=0.600000,Color=(B=64,G=150,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=64,G=150,R=255,A=255))
         Opacity=0.750000
         FadeOutStartTime=2.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=100
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=6.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=10.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-60.000000,Max=60.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=200.000000,Max=400.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.250000,Max=0.250000),Y=(Min=0.250000,Max=0.250000),Z=(Min=0.250000,Max=0.250000))
         FadeOutStartTime=2.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=25
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=0.100000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=0.250000,RelativeSize=6.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=20.000000,Max=50.000000),Y=(Min=20.000000,Max=50.000000),Z=(Min=20.000000,Max=50.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Max=300.000000))
         VelocityLossRange=(X=(Min=0.100000,Max=0.200000),Y=(Min=0.100000,Max=0.200000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=128,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=192,A=255))
         Opacity=0.750000
         FadeOutStartTime=1.500000
         FadeInEndTime=0.500000
         CoordinateSystem=PTCS_Relative
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
         StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-200.000000,Max=200.000000),Y=(Min=-200.000000,Max=200.000000),Z=(Min=50.000000,Max=400.000000))
         VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseDirectionAs=PTDU_Up
         FadeOut=True
         RespawnDeadParticles=False
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.500000,Color=(B=255,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         Opacity=0.900000
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=15
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Min=0.200000,Max=0.500000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=10.000000,Max=20.000000))
         InitialParticlesPerSecond=100.000000
         DrawStyle=PTDS_Darken
         Texture=Texture'EpicParticles.Fire.SprayFire1'
         LifetimeRange=(Min=1.500000,Max=1.500000)
         StartVelocityRange=(X=(Min=-800.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=50.000000,Max=800.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         FadeOutStartTime=3.520000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-40.000000,Max=-16.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRadialRange=(Min=400.000000,Max=600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(4)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         FadeOutStartTime=3.520000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-40.000000,Max=-16.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTropical01.Texture.PalmLeafFX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRadialRange=(Min=400.000000,Max=600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(5)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter5'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter6
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         FadeOutStartTime=3.520000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-40.000000,Max=-16.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Dirt.DirtClumps'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         StartVelocityRadialRange=(Min=400.000000,Max=600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(6)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter6'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-300.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         FadeOutStartTime=3.520000
         MaxParticles=20
         DetailMode=DM_SuperHigh
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000),Z=(Min=-40.000000,Max=-16.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         RotationDampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'BenTex01.textures.SnowPuff'
         StartVelocityRadialRange=(Min=400.000000,Max=600.000000)
         GetVelocityDirectionFrom=PTVD_AddRadial
     End Object
     Emitters(7)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         UseDirectionAs=PTDU_Up
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AlphaTest=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-100.000000)
         DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
         ColorScale(0)=(Color=(B=64,G=192,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=64,R=64,A=255))
         ColorMultiplierRange=(X=(Min=0.800000),Y=(Min=0.650000),Z=(Min=0.650000))
         FadeOutStartTime=0.500000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         DetailMode=DM_High
         StartLocationRange=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
         SpinsPerSecondRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=35.000000),Y=(Min=10.000000,Max=35.000000),Z=(Min=10.000000,Max=35.000000))
         InitialParticlesPerSecond=200.000000
         Texture=Texture'EmitterTextures.Flares.EFlarelong2'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         LifetimeRange=(Min=1.000000,Max=1.000000)
         StartVelocityRange=(X=(Min=-1400.000000,Max=1400.000000),Y=(Min=-1400.000000,Max=1400.000000),Z=(Min=200.000000,Max=1400.000000))
     End Object
     Emitters(8)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         RespawnDeadParticles=False
         UniformSize=True
         BlendBetweenSubdivisions=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         MaxParticles=4
         StartLocationRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=10.000000,Max=40.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=75.000000,Max=200.000000),Y=(Min=75.000000,Max=200.000000),Z=(Min=75.000000,Max=200.000000))
         InitialParticlesPerSecond=1.000000
         Texture=Texture'AW-2004Explosions.Fire.Part_explode2'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=0.250000,Max=0.250000)
     End Object
     Emitters(9)=SpriteEmitter'BWBP_VPC_Pro.RocketExplosionEffect.SpriteEmitter9'

     AutoDestroy=True
     bNoDelete=False
}

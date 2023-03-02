//=============================================================================
// The emitter for the bullet impacts that come from the Leopard and KHMKII's MG's.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================
class BulletHitEffect extends Emitter
	placeable;

var(Dust)		byte		GrassVariance, DirtVariance;
var				byte		DustType;

// This Activates and sets the next function's color variable to be the same color as the Level Info's dust color.
simulated function PreBeginPlay()
{
    SetDustColor(Level.DustColor);
}

simulated function SetDustColor(color DustColor)
{
	if(DustColor.R == 0 && DustColor.G == 0 && DustColor.B == 0)
	{
		DustColor.R=255;
		DustColor.G=150; // If the 'Dust Color' is black it will be changed to this.
		DustColor.B=64;
	}

	DustColor.A = 255;

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

	Emitters[0].ColorScale[0].Color = DustColor;
	Emitters[0].ColorScale[1].Color = DustColor;

	Emitters[2].ColorScale[0].Color = DustColor;
	Emitters[2].ColorScale[1].Color = DustColor;

	if(DustType == 0)
	{
		Emitters[1].Disabled = false;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}

	else if(DustType == 1)
	{
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = false;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}

	else if(DustType == 2)
	{
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = false;
		Emitters[4].Disabled = true;
	}

	else if(DustType == 3)
	{
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = false;
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
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         Opacity=0.500000
         FadeOutStartTime=1.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=4
         DetailMode=DM_High
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         SizeScale(1)=(RelativeSize=2.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=6.000000)
         StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.SmokePanels1'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=30.000000,Max=50.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.BulletHitEffect.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=40.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.BulletHitEffect.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTropical01.Texture.PalmLeafFX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=40.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.BulletHitEffect.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Dirt.DirtClumps'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=40.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_VPC_Pro.BulletHitEffect.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-50.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.000000
         MaxParticles=4
         DetailMode=DM_SuperHigh
         SpinsPerSecondRange=(X=(Min=0.250000,Max=0.500000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         InitialParticlesPerSecond=400.000000
         Texture=Texture'BenTex01.textures.SnowPuff'
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=20.000000,Max=40.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_VPC_Pro.BulletHitEffect.SpriteEmitter4'

     Begin Object Class=MeshEmitter Name=MeshEmitter0
         StaticMesh=StaticMesh'BWBP_Vehicles_Static.Effects.Volumetric1'
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         AutoDestroy=True
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=32,G=128,R=128,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=32,G=128,R=128,A=255))
         FadeOutStartTime=0.150000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         RotationOffset=(Pitch=63350)
         StartSpinRange=(Y=(Min=0.250000,Max=0.250000),Z=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
         InitialParticlesPerSecond=800.000000
         DrawStyle=PTDS_AlphaBlend
         LifetimeRange=(Min=0.300000,Max=0.300000)
         StartVelocityRange=(X=(Min=-6.000000,Max=6.000000))
     End Object
     Emitters(5)=MeshEmitter'BWBP_VPC_Pro.BulletHitEffect.MeshEmitter0'

     AutoDestroy=True
     CullDistance=3000.000000
     bNoDelete=False
}

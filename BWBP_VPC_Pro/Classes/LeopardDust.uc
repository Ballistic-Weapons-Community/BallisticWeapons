//=============================================================================
// The emitter for the Leopard tank's tracks. It's number of particles varies on
// the speed of the vehicle, but is only activated by some functions under the vehicle's class.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================

class LeopardDust extends Emitter
	placeable;

var(Dust)		byte		GrassVariance, DirtVariance;
var				byte		DustType;

simulated function SetDustColor(color DustColor)
{
	if(DustColor.R == 0 && DustColor.G == 0 && DustColor.B == 0)
	{
		DustColor.R=192;
		DustColor.G=160;// If the 'Dust Color' is black it will be changed to this.
		DustColor.B=96;
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

	Emitters[5].ColorScale[0].Color = DustColor;
	Emitters[5].ColorScale[1].Color = DustColor;
}

simulated function UpdateTrackDust(bool bActive)
{
	local int i;

	if(!bActive)
	{
		for(i=0;i<6;i++)
		{
			Emitters[i].InitialParticlesPerSecond = 0.0;
    		Emitters[i].ParticlesPerSecond = 0.0;
		}
	}
	else if(bActive)
		for(i=0;i<6;i++)
			Emitters[i].AllParticlesDead = false;

	if(Level.DetailMode == DM_Low)
	{
		Emitters[0].Disabled = false;
		Emitters[0].SpinParticles = false;
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
	}
	else if(Level.DetailMode == DM_High)
	{
		Emitters[0].Disabled = false;
		Emitters[0].SpinParticles = true;
		Emitters[1].Disabled = true;
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
		Emitters[5].Disabled = true;
	}
	else if(Level.DetailMode == DM_SuperHigh)
	{
		if(DustType == 0)
		{
			Emitters[1].UseCollision = true;
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

		Emitters[0].Disabled = false;
		Emitters[0].SpinParticles = true;
		Emitters[5].Disabled = false;
	}
}

simulated function DustScale(float DustSize, float DustVelocity, float DustLife, float FadeTime, float DustAmmount)
{
	local int i;

	Emitters[0].StartSizeRange.X.Min = DustSize;
	Emitters[0].StartSizeRange.X.Max = DustSize;
	Emitters[0].StartSizeRange.Y.Min = DustSize;
	Emitters[0].StartSizeRange.Y.Max = DustSize;
	Emitters[0].StartSizeRange.Z.Min = DustSize;
	Emitters[0].StartSizeRange.Z.Max = DustSize;
	Emitters[5].StartSizeRange.X.Min = DustSize / 2.0;
	Emitters[5].StartSizeRange.X.Max = DustSize / 2.0;
	Emitters[5].StartSizeRange.Y.Min = DustSize / 2.0;
	Emitters[5].StartSizeRange.Y.Max = DustSize / 2.0;
	Emitters[5].StartSizeRange.Z.Min = DustSize / 2.0;
	Emitters[5].StartSizeRange.Z.Max = DustSize / 2.0;

	Emitters[0].StartVelocityRange.Z.Max = DustVelocity;
	Emitters[5].StartVelocityRange.Z.Max = DustVelocity / 3.0;

	Emitters[0].LifetimeRange.Min = DustLife;
	Emitters[0].LifetimeRange.Max = DustLife;
	Emitters[5].LifetimeRange.Min = DustLife / 1.75;
	Emitters[5].LifetimeRange.Max = DustLife / 1.75;

	Emitters[0].FadeOutStartTime = FadeTime;
	Emitters[5].FadeOutStartTime = FadeTime / 1.75;

	Emitters[0].InitialParticlesPerSecond = DustAmmount * 2.0;
    Emitters[0].ParticlesPerSecond = DustAmmount * 2.0;
	for(i=1;i<6;i++)
	{
		Emitters[i].InitialParticlesPerSecond = DustAmmount;
    	Emitters[i].ParticlesPerSecond = DustAmmount;
	}
}

defaultproperties
{
     GrassVariance=48
     DirtVariance=24
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=64,G=150,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=64,G=150,R=255,A=255))
         FadeOutStartTime=5.500000
         FadeInEndTime=0.500000
         MaxParticles=140
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Particles.Weapons.DustSmoke'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         LifetimeRange=(Min=6.000000,Max=6.000000)
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Max=10.000000))
     End Object
     Emitters(0)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter1
         UseCollision=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         FadeInEndTime=0.520000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EmitterTextures.MultiFrame.rockchunks02'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(1)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter1'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter2
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         FadeInEndTime=0.520000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BenTropical01.Texture.PalmLeafFX'
         TextureUSubdivisions=4
         TextureVSubdivisions=4
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(2)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter2'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         Disabled=True
         Backup_Disabled=True
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         FadeInEndTime=0.500000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'AW-2004Explosions.Dirt.DirtClumps'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(3)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter4
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-30.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.500000
         FadeInEndTime=0.520000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
         Texture=Texture'BenTex01.textures.SnowPuff'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Min=20.000000,Max=50.000000))
     End Object
     Emitters(4)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter4'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter5
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=10.000000)
         ColorScale(0)=(Color=(B=128,G=192,R=192,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=128,G=192,R=192,A=255))
         Opacity=0.500000
         FadeOutStartTime=3.500000
         FadeInEndTime=0.500000
         MaxParticles=25
         SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
         SizeScale(0)=(RelativeSize=1.000000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
         StartSizeRange=(X=(Min=10.000000,Max=10.000000),Y=(Min=10.000000,Max=10.000000),Z=(Min=10.000000,Max=10.000000))
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'EpicParticles.Smoke.SparkCloud_01aw'
         TextureUSubdivisions=1
         TextureVSubdivisions=1
         StartVelocityRange=(X=(Min=-40.000000,Max=40.000000),Y=(Min=-40.000000,Max=-20.000000),Z=(Max=10.000000))
     End Object
     Emitters(5)=SpriteEmitter'BWBP_VPC_Pro.LeopardDust.SpriteEmitter5'

     CullDistance=16000.000000
     bNoDelete=False
     bHardAttach=True
}

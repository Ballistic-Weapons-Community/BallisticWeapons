//=============================================================================
// BG_TorsoExplodeBot.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_TorsoExplodeBot extends BW_HitGoreEmitter
	placeable;
/*
var() array<StaticMesh> GibMeshes;

struct GibInfo
{
	var() StaticMesh	Mesh;
	var() vector		Offset;
	var() RangeVector	Velocity;
};
var() array<GibInfo>	Gibs;

simulated function InitHitForce(vector HitRay)
{
	local BallisticGib Gib;
	local vector X,Y,Z, VMax, VMin;
	local int i;

	GetAxes(Rotation,X,Y,Z);
	for (i=0;i<Gibs.length;i++)
	{
		if (Gibs[i].mesh != None)
		{
			Gib = Spawn(class'BallisticGib',Owner,,Location + X*Gibs[i].Offset.X + Y*Gibs[i].Offset.Y + Z*Gibs[i].Offset.Z, Rotation);
			Gib.Velocity =	HitRay * 	Lerp(FRand(), Gibs[i].Velocity.X.Min, Gibs[i].Velocity.X.Max) +
							Y * 		Lerp(FRand(), Gibs[i].Velocity.Y.Min, Gibs[i].Velocity.Y.Max) +
							vect(0,0,1)*Lerp(FRand(), Gibs[i].Velocity.Z.Min, Gibs[i].Velocity.Z.Max);
//			Gib.Velocity = HitRay * (50+Rand(50)) + Y * (-50+Rand(100)) + vect(0,0,1) * Rand(200) + Owner.Velocity * 0.5;
//		        StartVelocityRange=(X=(Min=-100.000000,Max=-50.000000),Y=(Min=-50.000000),Z=(Max=200.000000))
			Gib.SetStaticMesh(Gibs[i].Mesh);
		}
	}
*/
/*
	Gib = Spawn(class'BallisticGib',Owner,,Location + X*2 + Y*-4 + Z*3, Rotation);
	Gib.Velocity = HitRay * (50+Rand(50)) + Y * (-50+Rand(100)) + vect(0,0,1) * Rand(200) + Owner.Velocity * 0.5;
//        StartVelocityRange=(X=(Min=-100.000000,Max=-50.000000),Y=(Min=-50.000000),Z=(Max=200.000000))
	Gib.SetStaticMesh(GibMeshes[0]);

	Gib = Spawn(class'BallisticGib',Owner,,Location + X*2 + Y*-4 + Z*3, Rotation);
	Gib.Velocity = HitRay * (-50+Rand(150)) + Y * (25+Rand(25)) + vect(0,0,1) * (25+Rand(175)) + Owner.Velocity * 0.5;
//        StartVelocityRange=(X=(Min=-100.000000,Max=50.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=200.000000))
	Gib.SetStaticMesh(GibMeshes[1]);

	Gib = Spawn(class'BallisticGib',Owner,,Location + X*2 + Y*-4 + Z*3, Rotation);
	Gib.Velocity = HitRay * (20+Rand(130)) + Y * (25+Rand(25)) + vect(0,0,1) * Rand(150) + Owner.Velocity * 0.5;
//        StartVelocityRange=(X=(Min=-150.000000,Max=-20.000000),Y=(Min=25.000000,Max=50.000000),Z=(Max=150.000000))
	Gib.SetStaticMesh(GibMeshes[2]);

	Gib = Spawn(class'BallisticGib',Owner,,Location + X*2 + Y*-4 + Z*3, Rotation);
	Gib.Velocity = HitRay * (-10-Rand(15)) + Y * (-40+Rand(50)) + vect(0,0,1) * 50 + Owner.Velocity * 0.5;
//        StartVelocityRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=-40.000000,Max=10.000000),Z=(Min=50.000000,Max=50.000000))
	Gib.SetStaticMesh(GibMeshes[3]);
*/
/*
	GetAxes(rotator(HitRay),X,Y,Z);

	for (i=0;i<4;i++)
	{
		//Adjust StartVelocityRange
		if (bVerticalZ)
		{
			VMax = X * SVX[i].Max + Y * SVY[i].Max + Vect(0,0,1) * SVZ[i].Max;
			VMin = X * SVX[i].Min + Y * SVY[i].Min + Vect(0,0,1) * SVZ[i].Min;
			if (bYIsSpread)
			{
				VMax = VMax + Z * SVY[i].Max * Abs(X.Z);
				VMin = VMin + Z * SVY[i].Min * Abs(X.Z);
			}
		}
		else
		{
			VMax = X * SVX[i].Max + Y * SVY[i].Max + Z * SVZ[i].Max;
			VMin = X * SVX[i].Min + Y * SVY[i].Min + Z * SVZ[i].Min;
		}
		Emitters[i].StartVelocityRange = VtoRV(VMax, VMin);

		Emitters[i].StartVelocityRange.X.Max += Owner.Velocity.X*0.5;
		Emitters[i].StartVelocityRange.X.Min += Owner.Velocity.X*0.5;
		Emitters[i].StartVelocityRange.Y.Max += Owner.Velocity.Y*0.5;
		Emitters[i].StartVelocityRange.Y.Min += Owner.Velocity.Y*0.5;
		Emitters[i].StartVelocityRange.Z.Max += Owner.Velocity.Z*0.5;
		Emitters[i].StartVelocityRange.Z.Min += Owner.Velocity.Z*0.5;
	}
*/
/*		if (bVerticalZ)
		{
			VMax = X * SVX[0].Max + Y * SVY[0].Max + Vect(0,0,1) * SVZ[0].Max;
			VMin = X * SVX[0].Min + Y * SVY[0].Min + Vect(0,0,1) * SVZ[0].Min;
			if (bYIsSpread)
			{
				VMax = VMax + Z * SVY[0].Max * Abs(X.Z);
				VMin = VMin + Z * SVY[0].Min * Abs(X.Z);
			}
		}
		else
		{
			VMax = X * SVX[0].Max + Y * SVY[0].Max + Z * SVZ[0].Max;
			VMin = X * SVX[0].Min + Y * SVY[0].Min + Z * SVZ[0].Min;
		}
		Emitters[0].StartVelocityRange = VtoRV(VMax, VMin);

		Emitters[0].StartVelocityRange.X.Max += Owner.Velocity.X*0.5;
		Emitters[0].StartVelocityRange.X.Min += Owner.Velocity.X*0.5;
		Emitters[0].StartVelocityRange.Y.Max += Owner.Velocity.Y*0.5;
		Emitters[0].StartVelocityRange.Y.Min += Owner.Velocity.Y*0.5;
		Emitters[0].StartVelocityRange.Z.Max += Owner.Velocity.Z*0.5;
		Emitters[0].StartVelocityRange.Z.Min += Owner.Velocity.Z*0.5;
*/
/*
}
*/
/*
    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'BWGoreHardwarePro.Pieces.RibCage-FrontRight'
        RenderTwoSided=True
        UseCollision=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.500000,Max=0.800000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="Ribs1"
        StartLocationOffset=(X=-1.000000,Y=6.000000,Z=16.000000)
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.930000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.700000,Max=1.700000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
        InitialParticlesPerSecond=400.000000
        MinSquaredVelocity=2000.000000
        StartVelocityRange=(X=(Min=-200.000000,Max=20.000000),Y=(Max=100.000000),Z=(Max=180.000000))
    End Object
    Emitters(2)=MeshEmitter'BG_TorsoExplode.MeshEmitter0'

    Begin Object Class=MeshEmitter Name=MeshEmitter1
        StaticMesh=StaticMesh'BWGoreHardwarePro.Pieces.RibCage-BackLeft'
        RenderTwoSided=True
        UseCollision=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.500000,Max=0.800000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="Ribs2"
        StartLocationOffset=(X=-1.000000,Y=-6.000000,Z=12.000000)
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.930000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.700000,Max=1.700000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
        InitialParticlesPerSecond=400.000000
        MinSquaredVelocity=2000.000000
        StartVelocityRange=(X=(Min=-200.000000,Max=20.000000),Y=(Min=-100.000000),Z=(Max=140.000000))
    End Object
    Emitters(3)=MeshEmitter'BG_TorsoExplode.MeshEmitter1'

    Begin Object Class=MeshEmitter Name=MeshEmitter2
        StaticMesh=StaticMesh'BWGoreHardwarePro.Pieces.spine'
        RenderTwoSided=True
        UseCollision=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.500000,Max=0.800000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="Spine1"
        StartLocationOffset=(X=-1.000000,Z=4.000000)
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.930000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.700000,Max=1.700000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
        InitialParticlesPerSecond=400.000000
        MinSquaredVelocity=2000.000000
        StartVelocityRange=(X=(Min=-150.000000,Max=-10.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=150.000000))
    End Object
    Emitters(4)=MeshEmitter'BG_TorsoExplode.MeshEmitter2'

    Begin Object Class=MeshEmitter Name=MeshEmitter3
        StaticMesh=StaticMesh'BWGoreHardwarePro.Pieces.Spine2'
        RenderTwoSided=True
        UseCollision=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.800000),Y=(Min=0.500000,Max=0.800000),Z=(Min=0.500000,Max=0.800000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="Spine2"
        StartLocationOffset=(X=-1.000000,Z=18.000000)
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.930000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.700000,Max=1.700000),Y=(Min=1.700000,Max=1.700000),Z=(Min=1.700000,Max=1.700000))
        InitialParticlesPerSecond=400.000000
        MinSquaredVelocity=2000.000000
        StartVelocityRange=(X=(Min=-150.000000,Max=-10.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=100.000000,Max=300.000000))
    End Object
    Emitters(5)=MeshEmitter'BG_TorsoExplode.MeshEmitter3'

        StartLocationOffset=(X=-1.000000,Y=6.000000,Z=16.000000)
        StartVelocityRange=(X=(Min=-200.000000,Max=20.000000),Y=(Max=100.000000),Z=(Max=180.000000))
        StartLocationOffset=(X=-1.000000,Y=-6.000000,Z=12.000000)
        StartVelocityRange=(X=(Min=-200.000000,Max=20.000000),Y=(Min=-100.000000),Z=(Max=140.000000))
        StartLocationOffset=(X=-1.000000,Z=4.000000)
        StartVelocityRange=(X=(Min=-150.000000,Max=-10.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Max=150.000000))
        StartLocationOffset=(X=-1.000000,Z=18.000000)
        StartVelocityRange=(X=(Min=-150.000000,Max=-10.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=100.000000,Max=300.000000))
*/
/*    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'XEffects.GibBotTorso'
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=1
        Name="GibTorso"
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSpinRange=(X=(Min=0.750000,Max=0.750000))
        StartSizeRange=(X=(Min=0.425000,Max=0.425000),Y=(Min=0.425000,Max=0.425000),Z=(Min=0.425000,Max=0.425000))
        InitialParticlesPerSecond=50.000000
        SecondsBeforeInactive=0.000000
        MinSquaredVelocity=100.000000
        StartVelocityRange=(X=(Min=-500.000000,Max=-250.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=50.000000,Max=150.000000))
    End Object
    Emitters(5)=MeshEmitter'myLevel.BG_TorsoExplode0.MeshEmitter0'
*/

defaultproperties
{
     DisableDGV(4)=1
     Begin Object Class=SpriteEmitter Name=SpriteEmitter3
         UseCollision=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         DampRotation=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-600.000000)
         ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
         DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=0.135000
         MaxParticles=25
         AlphaRef=32
         SpinsPerSecondRange=(X=(Max=2.000000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
         StartSizeRange=(X=(Min=25.000000,Max=50.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=50.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BallisticBloodPro.Bot.Bot-Saw2'
         SecondsBeforeInactive=0.000000
         MinSquaredVelocity=1000.000000
         LifetimeRange=(Min=0.750000,Max=0.750000)
         StartVelocityRange=(X=(Min=-100.000000,Max=400.000000),Y=(Min=-150.000000,Max=150.000000),Z=(Max=250.000000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeBot.SpriteEmitter3'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter7
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-20.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.300000,Max=0.700000),Z=(Min=0.500000,Max=0.800000))
         Opacity=0.720000
         FadeOutStartTime=1.160000
         FadeInEndTime=0.280000
         MaxParticles=12
         SpinsPerSecondRange=(X=(Max=0.050000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.200000)
         SizeScale(1)=(RelativeTime=0.170000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=30.000000,Max=40.000000),Y=(Min=30.000000,Max=40.000000),Z=(Min=30.000000,Max=40.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke6'
         SecondsBeforeInactive=0.000000
         StartVelocityRange=(X=(Min=-10.000000,Max=60.000000),Y=(Min=-75.000000,Max=75.000000),Z=(Max=200.000000))
         VelocityLossRange=(X=(Min=1.300000,Max=1.300000),Y=(Min=1.300000,Max=1.300000),Z=(Min=3.000000,Max=3.000000))
     End Object
     Emitters(1)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeBot.SpriteEmitter7'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-400.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.400000,Max=0.700000),Z=(Min=0.500000,Max=0.800000))
         FadeOutStartTime=0.680000
         MaxParticles=6
         AlphaRef=128
         SpinsPerSecondRange=(X=(Max=0.200000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.680000,RelativeSize=0.700000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=80.000000),Y=(Min=80.000000),Z=(Min=80.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_AlphaBlend
         Texture=Texture'BW_Core_WeaponTex.Particles.Smoke2'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=2.000000,Max=2.000000)
         StartVelocityRange=(X=(Min=-20.000000,Max=80.000000),Y=(Min=-60.000000,Max=60.000000),Z=(Min=140.000000,Max=220.000000))
         VelocityLossRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000))
     End Object
     Emitters(2)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeBot.SpriteEmitter8'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter9
         UseDirectionAs=PTDU_Up
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         UseRandomSubdivision=True
         Acceleration=(Z=-500.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.400000,Max=0.800000),Y=(Min=0.400000,Max=0.800000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.285000
         FadeInEndTime=0.040000
         MaxParticles=35
         StartLocationRange=(Z=(Max=32.000000))
         StartSpinRange=(X=(Min=0.250000,Max=0.250000))
         StartSizeRange=(X=(Min=10.000000,Max=15.000000),Y=(Min=10.000000,Max=15.000000),Z=(Min=10.000000,Max=15.000000))
         InitialParticlesPerSecond=150.000000
         Texture=Texture'BW_Core_WeaponTex.Effects.SparkA1'
         TextureUSubdivisions=2
         TextureVSubdivisions=2
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Max=400.000000))
     End Object
     Emitters(3)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeBot.SpriteEmitter9'

     Begin Object Class=BeamEmitter Name=BeamEmitter0
         BeamDistanceRange=(Min=75.000000,Max=110.000000)
         DetermineEndPointBy=PTEP_Distance
         LowFrequencyNoiseRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000),Z=(Min=-20.000000,Max=20.000000))
         HighFrequencyNoiseRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
         HighFrequencyPoints=5
         NoiseDeterminesEndPoint=True
         UseColorScale=True
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.150000,Color=(B=255,G=128,A=255))
         ColorScale(2)=(RelativeTime=0.332143,Color=(B=255,G=255,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,A=255))
         Opacity=0.650000
         FadeOutStartTime=0.060000
         FadeInEndTime=0.036000
         MaxParticles=25
         SizeScale(0)=(RelativeSize=1.500000)
         SizeScale(1)=(RelativeTime=0.280000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=25.000000,Max=40.000000),Y=(Min=25.000000,Max=40.000000),Z=(Min=25.000000,Max=40.000000))
         InitialParticlesPerSecond=15.000000
         Texture=Texture'BallisticEpicEffects.Beams.BeamFalloff'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-10.000000,Max=15.000000))
     End Object
     Emitters(4)=BeamEmitter'BallisticProV55.BG_TorsoExplodeBot.BeamEmitter0'

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         FadeOut=True
         FadeIn=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.600000,Max=0.900000),Z=(Min=0.700000,Max=0.900000))
         FadeOutStartTime=0.090000
         FadeInEndTime=0.025000
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.310000,RelativeSize=1.250000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=2.250000)
         InitialParticlesPerSecond=50.000000
         DrawStyle=PTDS_Brighten
         Texture=Texture'BW_Core_WeaponTex.Particles.WaterRing1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
     End Object
     Emitters(5)=SpriteEmitter'BallisticProV55.BG_TorsoExplodeBot.SpriteEmitter0'

     Begin Object Class=MeshEmitter Name=MeshEmitter1
         StaticMesh=StaticMesh'BW_Core_WeaponStatic.Impact.ConcreteChip2'
         UseMeshBlendMode=False
         RenderTwoSided=True
         UseParticleColor=True
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-600.000000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=0.157143,Color=(B=128,G=255,R=255,A=255))
         ColorScale(2)=(RelativeTime=0.482143,Color=(G=128,R=255,A=255))
         ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=128,A=255))
         FadeOutStartTime=0.584000
         MaxParticles=50
         SpinsPerSecondRange=(X=(Max=4.000000),Y=(Max=4.000000),Z=(Max=4.000000))
         StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
         StartSizeRange=(X=(Min=0.050000,Max=0.300000),Y=(Min=0.050000,Max=0.300000),Z=(Min=0.050000,Max=0.300000))
         InitialParticlesPerSecond=400.000000
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.800000,Max=0.800000)
         StartVelocityRange=(X=(Max=350.000000),Y=(Min=-125.000000,Max=125.000000),Z=(Min=50.000000,Max=300.000000))
     End Object
     Emitters(6)=MeshEmitter'BallisticProV55.BG_TorsoExplodeBot.MeshEmitter1'

     AutoDestroy=True
}

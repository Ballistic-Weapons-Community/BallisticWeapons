//=============================================================================
// M75Spiral.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75Spiral extends Actor;

var ColorModifier 	SpiralColorMod;
var TexScaler 		SpiralScaler;
var FinalBlend 		SpiralFinal;
var byte			RailPower;

simulated function InitSpiral(float Dist, byte RP)
{
	local Vector Size3D;

	Size3D = DrawScale3D;
	Size3D.X = Dist/128;
	SetDrawScale3D(Size3D);

	RailPower = RP;
	SpiralColorMod = ColorModifier(Level.ObjectPool.AllocateObject(class'ColorModifier'));
	if ( SpiralColorMod != None )
	{
		SpiralColorMod.Material = Skins[0];
		SpiralColorMod.Color.R = RP;
		SpiralColorMod.Color.G = RP;
		SpiralColorMod.Color.B = RP;
	 	SpiralScaler = TexScaler(Level.ObjectPool.AllocateObject(class'TexScaler'));
	}
	if ( SpiralScaler != None )
	{
		SpiralScaler.Material = SpiralColorMod;
		SpiralScaler.UScale = 128/Dist;
	 	SpiralFinal = FinalBlend(Level.ObjectPool.AllocateObject(class'FinalBlend'));
	}
	if ( SpiralFinal != None )
	{
		SpiralFinal.Material = SpiralScaler;
		SpiralFinal.FrameBufferBlending = FB_Translucent;
		SpiralFinal.TwoSided = true;
		SpiralFinal.ZWrite = False;
		Skins[0] = SpiralFinal;
	}
}

simulated function DestroySpiralTex()
{
	if ( SpiralColorMod != None )
	{
		Level.ObjectPool.FreeObject(SpiralColorMod);
		SpiralColorMod = None;
	}
	if ( SpiralScaler != None )
	{
		Level.ObjectPool.FreeObject(SpiralScaler);
		SpiralScaler = None;
	}
	if ( SpiralFinal != None )
	{
		Level.ObjectPool.FreeObject(SpiralFinal);
		SpiralFinal = None;
	}
}

event Destroyed()
{
	DestroySpiralTex();
	super.Destroyed();
}

event Tick(float DT)
{
	local float f;
	local Vector Size3D;

	Super.Tick(DT);

	if (SpiralColorMod == None)
		return;
//	f = 128*(LifeSpan/2.0);
	f = (LifeSpan/default.LifeSpan)*RailPower;
	SpiralColorMod.Color.R = f;
	SpiralColorMod.Color.G = f;
	SpiralColorMod.Color.B = f;

	Size3D = DrawScale3D;
	f = 3.0 - 2.0 * (LifeSpan/default.LifeSpan);
	Size3D.Y = f;
	Size3D.Z = f;
	SetDrawScale3D(Size3D);
}

defaultproperties
{
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Effects.RailCylinder2'
     Physics=PHYS_Rotating
     RemoteRole=ROLE_None
     LifeSpan=0.900000
     Skins(0)=Texture'BW_Core_WeaponTex.GunFire.RailSpiralSmoke'
     bUnlit=True
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}

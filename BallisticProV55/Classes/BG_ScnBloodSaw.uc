//=============================================================================
// BG_ScnBloodSaw.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BG_ScnBloodSaw extends BallisticEmitter
	placeable;

var Actor InitialTarget;

event Tick (float DT)
{
	local actor A;
	local vector L;
	local Rotator R;

	super.Tick(DT);
	if (Owner != None && PlayerController(Owner) != None)
	{
		if (InitialTarget != PlayerController(Owner).ViewTarget)
		{
			Destroy();
			return;
		}

		PlayerController(Owner).PlayerCalcView(A, L, R);
		SetLocation(L + Vector(R)*16);
		SetRotation(R);
	}
	else
		Destroy();
}

event PostBeginPlay()
{
	local float F;

	super.PostBeginPlay();

	if (PlayerController(Owner) != None)
		InitialTarget = PlayerController(Owner).ViewTarget;

	F = FRand();
	if (F <= 0.333)
		Emitters[0].Texture=Texture'BallisticBloodPro.Decals.Cut1';
	else if (F <= 0.666)
		Emitters[0].Texture=Texture'BallisticBloodPro.Decals.Cut1';
	else
		Emitters[0].Texture=Texture'BallisticBloodPro.Decals.Cut3';
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         UseDirectionAs=PTDU_Normal
         ProjectionNormal=(X=-1.000000,Z=0.000000)
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UniformSize=True
         AutomaticInitialSpawning=False
         Acceleration=(Z=-0.200000)
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=1.770000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         StartLocationRange=(Y=(Min=-14.000000,Max=14.000000),Z=(Min=-14.000000,Max=14.000000))
         SpinsPerSecondRange=(X=(Max=0.002000))
         StartSpinRange=(X=(Max=1.000000))
         StartSizeRange=(X=(Min=10.000000,Max=25.000000),Y=(Min=10.000000,Max=25.000000),Z=(Min=10.000000,Max=25.000000))
         InitialParticlesPerSecond=400.000000
         DrawStyle=PTDS_Modulated
         Texture=Texture'BallisticBloodPro.Decals.Cut1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=3.000000,Max=3.000000)
         StartVelocityRange=(Z=(Min=-0.500000,Max=-0.300000))
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.BG_ScnBloodSaw.SpriteEmitter0'

     AutoDestroy=True
}

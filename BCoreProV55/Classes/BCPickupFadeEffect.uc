//=============================================================================
// BCPickupFadeEffect.
//
// An effect to look like a weapon sinking into teh ground...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class BCPickupFadeEffect extends Emitter;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	if ( Owner == None || Owner.StaticMesh == None)
		Destroy();
	else
	{
		SetLocation(Owner.Location-class'bUtil'.static.AlignedOffset(Rotation,Owner.PrePivot)*Owner.DrawScale);
		Emitters[0].Acceleration = (vect(0,0,1)<<Rotation) * -8;

		MeshEmitter(Emitters[0]).StaticMesh = Owner.StaticMesh;
		MeshEmitter(Emitters[0]).SizeScale[0].RelativeSize = Owner.DrawScale;
		MeshEmitter(Emitters[0]).SizeScale[1].RelativeSize = Owner.DrawScale;
	}
}

defaultproperties
{
     Begin Object Class=MeshEmitter Name=MeshEmitter1
         FadeOut=True
         RespawnDeadParticles=False
         UseSizeScale=True
         UseRegularSizeScale=False
         AutomaticInitialSpawning=False
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
         FadeOutStartTime=3.000000
         CoordinateSystem=PTCS_Relative
         MaxParticles=1
         SizeScale(0)=(RelativeSize=0.550000)
         SizeScale(1)=(RelativeTime=1.000000)
         InitialParticlesPerSecond=50000.000000
         DrawStyle=PTDS_Regular
     End Object
     Emitters(0)=MeshEmitter'BCoreProV55.BCPickupFadeEffect.MeshEmitter1'

     AutoDestroy=True
     bNoDelete=False
}

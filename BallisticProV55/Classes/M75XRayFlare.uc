//=============================================================================
// M75XRayFlare.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75XRayFlare extends BallisticEmitter;

function Initialize(Actor A)
{
	if (A == None)
	{
		Destroy();
		return;
	}

	Emitters[0].SkeletalMeshActor = A;
	SetLocation(A.Location - vect(0, 0, 1)*A.CollisionHeight);
	SetRotation(A.Rotation + rot(0, -16384, 0));
	SetBase(A);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         FadeOut=True
         FadeIn=True
         ZTest=False
         UniformSize=True
         ColorScale(0)=(Color=(G=160,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=192,G=128,A=255))
         ColorMultiplierRange=(X=(Min=0.400000),Y=(Min=0.400000,Max=0.600000),Z=(Min=0.000000,Max=0.000000))
         FadeOutStartTime=0.340000
         FadeInEndTime=0.155000
         CoordinateSystem=PTCS_Relative
         MaxParticles=30
         StartSizeRange=(X=(Min=2.000000,Max=20.000000),Y=(Min=2.000000,Max=20.000000),Z=(Min=2.000000,Max=20.000000))
         UseSkeletalLocationAs=PTSU_Location
         SkeletalScale=(X=0.390000,Y=0.390000,Z=0.390000)
         DrawStyle=PTDS_Brighten
         Texture=Texture'BallisticEffects.Particles.HotFlareA1'
         SecondsBeforeInactive=0.000000
         LifetimeRange=(Min=0.500000,Max=0.500000)
         StartVelocityRange=(Z=(Min=-10.000000,Max=-1.000000))
         GetVelocityDirectionFrom=PTVD_OwnerAndStartPosition
     End Object
     Emitters(0)=SpriteEmitter'BallisticProV55.M75XRayFlare.SpriteEmitter0'

     bHardAttach=True
}

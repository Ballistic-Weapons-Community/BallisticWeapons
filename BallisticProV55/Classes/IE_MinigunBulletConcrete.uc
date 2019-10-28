//=============================================================================
// IE_MinigunBulletConcrete.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_MinigunBulletConcrete extends DGVEmitter
	placeable;

simulated event PostBeginPlay()
{
	if ( PhysicsVolume.bWaterVolume )
	{
		Emitters[0].Disabled=true;
	}
	super.PostBeginPlay();
}

defaultproperties
{
     DisableDGV(1)=1
     bModifyLossRange=False
     Emitters(0)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter27'

     Emitters(1)=MeshEmitter'BallisticProV55.IE_BulletConcrete.MeshEmitter14'

     Emitters(2)=SpriteEmitter'BallisticProV55.IE_BulletConcrete.SpriteEmitter3'

     AutoDestroy=True
}

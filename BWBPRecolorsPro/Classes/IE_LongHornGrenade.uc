//=============================================================================
// IE_GrenadeExplosion.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class IE_LongHornGrenade extends BallisticEmitter
	placeable;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	bDynamicLight = true;
	SetTimer(0.2, false);
}

simulated event PreBeginPlay()
{
	if (Level.DetailMode < DM_SuperHigh)
		Emitters[3].Disabled=true;
	if (Level.DetailMode < DM_High)
	{
		Emitters[1].Disabled=true;
		Emitters[2].Disabled=true;
	}
	Super.PreBeginPlay();
}

simulated event Timer()
{
	Super.Timer();
	bDynamicLight = false;
}

defaultproperties
{
     Emitters(0)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter6'

     Emitters(1)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter7'

     Emitters(2)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter8'

     Emitters(3)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter34'

     Emitters(4)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter0'

     Emitters(5)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter19'

     Emitters(6)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter20'

     Emitters(7)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter21'

     Emitters(8)=SpriteEmitter'BWBPRecolorsPro.IE_FRAGExplosion.SpriteEmitter22'

     AutoDestroy=True
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=32.000000
     LightPeriod=3
     bUnlit=False
}

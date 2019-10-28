//===========================================================================
// MRS138's Torch glow.
//
// Modified SquirrelZero light
//===========================================================================
class MRS138TorchGlow extends Light
	notplaceable;

function PostBeginPlay()
{
	SetTimer(1.0,true);
}

function Timer()
{
	MakeNoise(0.3);
}

defaultproperties
{
     LightBrightness=96.000000
     LightRadius=1.000000
     LightPeriod=0
     bStatic=False
     bHidden=False
     bNoDelete=False
     bDynamicLight=True
     RemoteRole=ROLE_None
     Texture=None
     bGameRelevant=True
     bMovable=True
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bDirectional=True
}

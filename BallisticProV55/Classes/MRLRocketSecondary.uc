//=============================================================================
// MRLRocketSecondary.
//
// More crazy than primary, and slower.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MRLRocketSecondary extends MRLRocket;

//Modified LinkGun
simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	
    Acceleration = Normal(Velocity) * AccelSpeed;
	
	SetTimer(0.7, false);

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if ( Level.bDropDetail || Level.DetailMode == DM_Low )
	{
		bDynamicLight = false;
		LightType = LT_None;
	}
	else
	{
		PC = Level.GetLocalPlayerController();
		if ( (PC == None) || (Instigator == None) || (PC != Instigator.Controller) )
		{
			bDynamicLight = false;
			LightType = LT_None;
		}
	}
}

simulated function Timer()
{
	SetCollision(true,true);

	InitProjectile();
	
	Velocity = vector(Rotation) * MaxSpeed;
}

defaultproperties
{
     AccelSpeed=0.000000
     Speed=250.000000
     MaxSpeed=12000.000000
     bCollideActors=False
}

/******************************************************************************
UT3TranslocatorEffect

Creation date: 2008-07-14 14:45
Last change: $Id$
Copyright (c) 2008, Wormbo
******************************************************************************/

class UT3TranslocatorEffect extends Emitter abstract;


//=============================================================================
// Imports
//=============================================================================

#exec obj load file=EpicParticles.utx
#exec obj load file=ParticleMeshes.usx


//=============================================================================
// Properties
//=============================================================================

var vector FlashColor;
var float FlashScale;


function PostBeginPlay()
{
	if (Role == ROLE_Authority)
		Instigator = Pawn(Owner);
	if (Level.NetMode == NM_DedicatedServer)
		LifeSpan = 0.15;
	Super.PostBeginPlay();
}

simulated function PostNetBeginPlay()
{
	local PlayerController PC;
	local float Dist;
	
	if (Instigator != None) {
		SetLocation(Instigator.Location);
		SetBase(Instigator);
		if (PlayerController(Instigator.Controller) != None && !PlayerController(Instigator.Controller).bBehindView ) {
			/*Emitters[0].InitialParticlesPerSecond *= 0.5;
			Emitters[0].SphereRadiusRange.Min *= 2.4;
			Emitters[0].SphereRadiusRange.Max *= 2.4;
			Emitters[1].Disabled = true;*/
			if (Viewport(PlayerController(Instigator.Controller).Player) != None) {
				PlayerController(Instigator.Controller).ClientFlash(FlashScale, FlashColor);
			}
		}
		else if (Level.NetMode == NM_Standalone || Level.NetMode == NM_Client) {
			PC = Level.GetLocalPlayerController();
			if (PC != None && PC.ViewTarget != None) {
				Dist = VSize(PC.ViewTarget.Location - Location);
				if (Dist > PC.Region.Zone.DistanceFogEnd)
					LifeSpan = 0.01;
				else if (Dist > 8000)
					Emitters[1].Disabled = true;
			}
		}
	}
	PlaySound(Sound'TranslocatorTeleport', SLOT_None);
	Super.PostNetBeginPlay();
}


//=============================================================================
// Default values
//=============================================================================

defaultproperties
{
     FlashScale=0.700000
     AutoDestroy=True
     bNoDelete=False
     bNetTemporary=True
     bReplicateInstigator=True
     RemoteRole=ROLE_SimulatedProxy
     TransientSoundVolume=1.000000
     TransientSoundRadius=900.000000
}

//=============================================================================
// Mut_RewindCollision
//
// Binds collision to pawns in network games.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_RewindCollision extends Mutator;

var RewindCollisionManager          RwColMgr;

function PostBeginPlay()
{
    Super.PostBeginPlay();

    if (Level.NetMode != NM_DedicatedServer)
    {
        Log("Mut_RewindCollision is not required outside of dedicated servers.");
        Destroy();
    }

    RwColMgr = new class'RewindCollisionManager';
    RwColMgr.Level = Level;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    local BallisticWeapon BW;
    local BallisticPawn P;

    BW = BallisticWeapon(Other);

    if (BW != None)
    {
        BW.RwColMgr = RwColMgr;
        return true;
    }

    P = BallisticPawn(Other);

	if (P != None)
	{
        P.RwColMgr = RwColMgr;
        RwColMgr.RegisterPawn(P);
        return true;
	}

	return true;
}

function Destroyed()
{
    // Hope this actually works...
    RwColMgr.Level = None;
    RwColMgr = None;

    Super.Destroyed();
}

defaultproperties
{
     FriendlyName="BallisticPro: Rewind Collision"
     Description="This mutator implements rewind-based collision detection for network games. Do not use offline."
}
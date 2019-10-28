//=============================================================================
// Game_BWConficltCTFMaps.
//
// BW Conflict using CTF maps.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Game_BWConflictCTFMaps extends Game_BWConflict;

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	FixFlags();

	if (level.NetMode == NM_Client)
		Destroy();
}

simulated function FixFlags()
{
	local CTFFlag F;
	local xCTFBase B;

	ForEach AllActors(Class'CTFFlag', F)
	{
		f.HomeBase.bActive = false;
		F.Destroy();
	}

	if (level.NetMode != NM_DedicatedServer)
		ForEach AllActors(Class'xCTFBase', B)
			B.bHidden=true;
}

defaultproperties
{
     MapPrefix="CTF"
     GameName="BallisticPro Conflict (CTF Maps)"
     Description="Standard Ballistic Conflict, but played in the CTF maps.||www.runestorm.com"
     DecoTextName="BallisticProV55.Game_BWConflictCTFMaps"
     Acronym="BWCCM"
     bNetTemporary=True
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}

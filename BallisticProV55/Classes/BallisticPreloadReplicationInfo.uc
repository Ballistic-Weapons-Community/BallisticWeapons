class BallisticPreloadReplicationInfo extends ReplicationInfo;

var() string CurrentName[255];
var bool bAddedInteraction;

// Set on the server, sent to the clients in Info
var() int PreloadNum;
var() int RewardNum;	// How many of them are killstreak rewards (they come last)
var bool bEnableCamoLoading;
var bool bEnableTextureLoading;
var bool bPreloadPlayerModels;	// The server has BW's player models: the clients load them too (Mut_BallisticPreLoad)

// The count and the switches as the clients get them. A struct goes over the net as one piece: as separate properties
// the count could arrive while a switch was still on its way (the names fill the first bunches), and a client that
// started on the count went on without the player models.
struct PreloadInfo
{
	var int Num;			// Weapons in the list. 0: not sent yet, -1: nothing to load
	var int RewardNum;
	var bool bCamos;
	var bool bTextures;
	var bool bModels;
};
var PreloadInfo Info;

replication
{
    reliable if(Role == ROLE_Authority)
        CurrentName, Info;
}

// The server has the list: the clients can start
function SendInfo()
{
	Info.Num = PreloadNum;
	Info.RewardNum = RewardNum;
	Info.bCamos = bEnableCamoLoading;
	Info.bTextures = bEnableTextureLoading;
	Info.bModels = bPreloadPlayerModels;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Level.NetMode != NM_DedicatedServer)
		SetTimer(0.5, true);
}

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();

	if (Level.NetMode != NM_DedicatedServer)
		TryAddInteraction();
}

simulated function Timer()
{
	TryAddInteraction();
}

simulated function TryAddInteraction()
{
	local PlayerController PC;

	if (bAddedInteraction)
	{
		SetTimer(0.0, false);
		return;
	}

	PC = Level.GetLocalPlayerController();
	if (PC != None && PC.Player != None)
	{
		PC.Player.InteractionMaster.AddInteraction("BallisticProV55.BallisticPreloadInteraction", PC.Player);
		bAddedInteraction = true;
		SetTimer(0.0, false);
		// The PRI may not have arrived on the client yet
		if (PC.PlayerReplicationInfo != None)
			Log("BallisticPreloadRI: Added preload interaction for"@PC.PlayerReplicationInfo.PlayerName);
		else
			Log("BallisticPreloadRI: Added preload interaction for"@PC);
	}
}

defaultproperties
{
}

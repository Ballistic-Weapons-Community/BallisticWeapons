class BallisticPreloadReplicationInfo extends ReplicationInfo;

var() string CurrentName[255];
var() int PreloadNum;
var bool bAddedInteraction;
var bool bEnableCamoLoading;
var bool bEnableTextureLoading;

replication
{
    reliable if(Role == ROLE_Authority)
        CurrentName, PreloadNum, bEnableCamoLoading, bEnableTextureLoading;
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
		Log("BallisticPreloadRI: Added preload interaction for"@PC.PlayerReplicationInfo.PlayerName);
	}
}

defaultproperties
{
}

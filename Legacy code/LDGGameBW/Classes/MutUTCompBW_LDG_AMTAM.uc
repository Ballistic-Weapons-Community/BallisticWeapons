class MutUTCompBW_LDG_AMTAM extends Mutator
	CacheExempt;

var bool bHasInteraction;
var config bool bEnableScoreboard;
var globalconfig bool   bEnableMusicDownload;
var globalconfig string MusicDownloadURL;

function PreBeginPlay ()
{
	Level.Game.PlayerControllerClassName = string(class'Misc_Player_UTComp_LDG');
	Level.Game.DeathMessageClass = class'Misc_DeathMessage_UTComp';

	if (bEnableScoreBoard)
		Level.Game.ScoreBoardType = string(class'UTComp_Scoreboard_NEW_AMTAM');
	else
		Level.Game.ScoreBoardType = string(class'UTComp_Scoreboard_AM');
		
	Level.Game.HudType = string(class'AM_HUD_UTComp');
	Super.PreBeginPlay();
}

function PostBeginPlay()
{
	local UTComp_GameRules_BW_LDG_AMTAM G;
	
	G = spawn(class'UTComp_GameRules_BW_LDG_AMTAM');
	G.MyMutator = Self;
	
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);
}

simulated function Tick(float DeltaTime)
{
  local Misc_Player_UTComp_LDG PC;

	if(Level.NetMode != NM_DedicatedServer)
	{
		/* just in case */
	  if (bHasInteraction)
			return;
	      
	  PC = Misc_Player_UTComp_LDG(Level.GetLocalPlayerController());

	  if(PC != None)
	  {
	    PC.Player.InteractionMaster.AddInteraction(string(class'UTComp_Overlay_BW_AMTAM'), PC.Player);
	    PC.ClientLoadMusicDownloader();
	    bHasInteraction = true;
	    class'DamTypeLinkShaft'.default.bSkeletize = false;
	  	Disable('Tick');
    }
  }
  else
  	Disable('Tick');
}

function ShowDamagePopup(vector ShowLocation, int PopupDamage, optional color PopupColor)
{
	local Controller C;
	
	for (C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (Misc_Player_UTComp_LDG(C) != None && Misc_Player_UTComp_LDG(C).UTCompPRI != None)
			Misc_Player_UTComp_LDG(C).UTCompPRI.ShowDamagePopup(ShowLocation, PopupDamage, PopupColor);
	}
}


function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local LinkedReplicationInfo lPRI;
	local UTComp_PRI_BW_LDG uPRI;
		
	if (PlayerReplicationInfo(Other) != None)
	{
		uPRI = Spawn(class'UTComp_PRI_BW_LDG', Other.Owner);
				
		if(PlayerReplicationInfo(Other).CustomReplicationInfo != None)
		{
			lPRI = PlayerReplicationInfo(Other).CustomReplicationInfo;
		
			PlayerReplicationInfo(Other).CustomReplicationInfo = uPRI;
			
			if (uPRI.NextReplicationInfo != None)
				uPRI.NextReplicationInfo.NextReplicationInfo = lPRI;
			else
				uPRI.NextReplicationInfo = lPRI;
		}
		else
			PlayerReplicationInfo(Other).CustomReplicationInfo = uPRI;
	}
	
	return true;
}

static function FillPlayInfo (PlayInfo PlayInfo)
{
	PlayInfo.AddClass(Default.Class);
	
	PlayInfo.AddSetting("UTComp Settings", "bEnableScoreboard", "Enable Enhanced Scoreboard", 1, 1,"Check");
	PlayInfo.AddSetting("UTComp Settings", "bEnableMusicDownload", "Enable Music Download", 255, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "MusicDownloadURL", "Music Download URL", 255, 1, "Text", "100");
	
	PlayInfo.PopClass();
	Super.FillPlayInfo(PlayInfo);
}

static event string GetDescriptionText(string PropName)
{
	switch (PropName)
	{
		case "bEnableScoreboard":
			return "Check this to enable UTComp enhanced scoreboard.";

		case "bEnableMusicDownload":
			return "Whether to enable music download to clients.";

		case "MusicDownloadURL":
			return "Base URL for music downloads.";
	}
  
	return Super.GetDescriptionText(PropName);
}

defaultproperties
{
     bEnableScoreboard=True
     bAddToServerPackages=True
     FriendlyName="UTComp Version R04 For Ballistic Weapons on LDG - AM/TAM"
     Description="A mutator for warmup, brightskins, hitsounds, and various other features - compatibility with Ballistic Weapons."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}

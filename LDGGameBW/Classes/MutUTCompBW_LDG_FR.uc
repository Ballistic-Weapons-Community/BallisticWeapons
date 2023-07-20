class MutUTCompBW_LDG_FR extends Mutator
	CacheExempt;

var bool bHasInteraction;
var config bool bEnableScoreboard;
var config bool bNoVehicleFarming;
var config bool bNoBotFarming;
var globalconfig bool   bEnableMusicDownload;
var globalconfig string MusicDownloadURL;

var UTComp_SRI_BW_FR_LDG UTCompSRI;

function PreBeginPlay ()
{
	Level.Game.PlayerControllerClassName = string(class'Freon_Player_UTComp_LDG');
	Level.Game.DeathMessageClass = class'Misc_DeathMessage_UTComp';
	
	UTCompSRI = Spawn(class'UTComp_SRI_BW_FR_LDG', self);

	if (bEnableScoreBoard)
	{
		if (Game_Freon_Tracked(Level.Game) != None && Game_Freon_Tracked(Level.Game).bAllowViewingOfSkill)
		{
			Level.Game.ScoreBoardType = string(class'UTComp_Scoreboard_NEW_SKILL_FREON');
			UTCompSRI.ThawPointsConversionRatio = class'LDGBWFreonDataTracking'.default.ThawPointsKillConversion;
			
			if (Game_Freon_Tracked(Level.Game) != None)
				UTCompSRI.MatchStart = Game_Freon_Tracked(Level.Game).MatchStart;
			
		}
		else
			Level.Game.ScoreBoardType = string(class'UTComp_Scoreboard_NEW_FREON');
	}
	else
		Level.Game.ScoreBoardType = string(class'UTComp_Scoreboard_FREON');
		
	Level.Game.HudType = string(class'Freon_HUD_UTComp');
	Super.PreBeginPlay();
}

function PostBeginPlay()
{
	local UTComp_GameRules_BW_LDG_FR G;
	
	G = spawn(class'UTComp_GameRules_BW_LDG_FR');
	G.MyMutator = Self;
	
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);
}

simulated function Tick(float DeltaTime)
{
  local Freon_Player_UTComp_LDG PC;

	if(Level.NetMode != NM_DedicatedServer)
	{
		/* just in case */
	  if (bHasInteraction)
			return;
	      
	  PC = Freon_Player_UTComp_LDG(Level.GetLocalPlayerController());

	  if(PC != None)
	  {
	    PC.Player.InteractionMaster.AddInteraction(string(class'UTComp_Overlay_BW_FR'), PC.Player);
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
		if (Freon_Player_UTComp_LDG(C) != None && Freon_Player_UTComp_LDG(C).UTCompPRI != None)
			Freon_Player_UTComp_LDG(C).UTCompPRI.ShowDamagePopup(ShowLocation, PopupDamage, PopupColor);
	}
}

function InitSkillProps(UTComp_PRI_BW_FR_LDG uPRI)
{
	/* Set skill to average if this is a bot */
	if (Bot(uPRI.Owner) != None)
		uPRI.Skill = class'LDGBWFreonDataTracking'.default.AverageEfficiency * 10;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local LinkedReplicationInfo lPRI;
	local UTComp_PRI_BW_FR_LDG uPRI;
		
	if (PlayerReplicationInfo(Other) != None)
	{
		uPRI = Spawn(class'UTComp_PRI_BW_FR_LDG', Other.Owner);
				
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
			
		if (Level.Game.IsA('Game_Freon_Tracked'))
		{
			if (PlayerController(Other.Owner) != None)
				Game_Freon_Tracked(Level.Game).CheckPendingPlayerController(PlayerController(Other.Owner));
				
			InitSkillProps(uPRI);
		}
	}
	else if (ThawProtectionTrigger(Other) != None)
		ThawProtectionTrigger(Other).UTCompMutator = self;
	else if (Freon_Pawn_Tracked(Other) != None)
		Freon_Pawn_Tracked(Other).UTCompMutator = self;
	
	
	return true;
}

static function FillPlayInfo (PlayInfo PlayInfo)
{
	PlayInfo.AddClass(Default.Class);
	
	PlayInfo.AddSetting("UTComp Settings", "bEnableScoreboard", "Enable Enhanced Scoreboard", 1, 1,"Check");
	PlayInfo.AddSetting("UTComp Settings", "bNoVehicleFarming", "No Vehicle Farming", 1, 1, "Check");
	PlayInfo.AddSetting("UTComp Settings", "bNoBotFarming", "No Bot Farming", 1, 1, "Check");
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
			
		case "bNoVehicleFarming":
			return "Check this to disallow vehicles to gain kills and net points.";
			
		case "bNoBotFarming":
			return "Check this to exclude bots from kills / net.";
			
		case "bEnableMusicDownload":
			return "Whether to enable music download to clients.";

		case "MusicDownloadURL":
			return "Base URL for music downloads.";
	}
  
	return Super.GetDescriptionText(PropName);
}

function DriverEnteredVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	if (V != None && V.Controller != None && V.Controller.PlayerReplicationInfo != None)
	{
		if (BallisticTurret(V) == None)
		{
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(V.Controller.PlayerReplicationInfo);
			if (uPRI != None)
				uPRI.InAVehicle = true;
		}
	}
	
	if( NextMutator != None )
		NextMutator.DriverEnteredVehicle(V, P);
}

function DriverLeftVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	if (P != None && P.Controller != None && P.Controller.PlayerReplicationInfo != None)
	{
		if (BallisticTurret(V) == None)
		{	
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(P.Controller.PlayerReplicationInfo);
			if (uPRI != None)
			{
				uPRI.InAVehicle = false;
				uPRI.VehicleExitTime = Level.TimeSeconds;
			}
		}
	}
	
	if( NextMutator != None )
		NextMutator.DriverLeftVehicle(V, P);
}

defaultproperties
{
     bEnableScoreboard=True
     bAddToServerPackages=True
     FriendlyName="UTComp Version R04 For Ballistic Weapons on LDG - Freon"
     Description="A mutator for warmup, brightskins, hitsounds, and various other features - compatibility with Ballistic Weapons."
     bAlwaysRelevant=True
     RemoteRole=ROLE_SimulatedProxy
}

class Misc_Player_UTComp_LDG extends Misc_Player;

var color RedMessageColor;
var color GreenMessageColor;
var color BlueMessageColor;
var color YellowMessageColor;
var UTComp_PRI_BW_LDG UTCompPRI;
var bool bInitialized;
var bool bClientChangedScoreboard;
var UTComp_JukeboxList JKList;

var string LevelOriginalSong;
var string LevelCurrentSong;
var float LastSpectateTime;

var string ClientMusicDownloadURL;
var bool bClientEnableMusicDownload;
var bool bClientMusicDownloadInstalled;

var LDGMusicDownloaderLoader Loader;

replication
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		UTCompPRI, ClientMusicDownloadURL, bClientEnableMusicDownload;
		
	unreliable if(Role < ROLE_Authority)
		ServerGoToPlayer;
}

delegate PlayerBecamingSpectator(Misc_Player_UTComp_LDG PC) { }
delegate PlayerBecameActive(Misc_Player_UTComp_LDG PC) { }

simulated function PreBeginPlay()
{
	local Mutator M;
	
	if (Role == ROLE_Authority)
	{
		for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
		{
			if (MutUTCompBW_LDG_AMTAM(M) != None)
			{
				ClientMusicDownloadURL = MutUTCompBW_LDG_AMTAM(M).MusicDownloadURL;
				if (MutUTCompBW_LDG_AMTAM(M).MusicDownloadURL ~= "" || InStr(MutUTCompBW_LDG_AMTAM(M).MusicDownloadURL, "://") == -1)
					bClientEnableMusicDownload = false;
				else
					bClientEnableMusicDownload = MutUTCompBW_LDG_AMTAM(M).bEnableMusicDownload;
				break;
			}
		}
	}
		
	Super.PreBeginPlay();
}

simulated function PostBeginPlay()
{	
  Super.PostBeginPlay();
  
  if (Level.NetMode != NM_DedicatedServer)
  {
		JKList = new(none, "JukeBox") class'UTComp_JukeboxList';
		if (JKList.JukeBoxList.Length == 0)
		{
			JKList.JukeBoxList.Length = 1;
			JKList.JukeBoxList[0].Level = "####";
			JKList.JukeBoxList[0].Song = "####";
		}
	}
}

simulated function ClientSetHUD(class<HUD> newHUDClass, class<Scoreboard> newScoringClass )
{
	local string MySong;
	
	if ( myHUD != None )
	  myHUD.Destroy();
	
	if (newHUDClass == None)
	  myHUD = None;
	else
	{
	  myHUD = spawn (newHUDClass, self);
	
	  if (myHUD == None)
			log ("Misc_Player_UTComp_LDG::ClientSetHUD(): Could not spawn a HUD of class "$newHUDClass, 'Error');
	  else
			myHUD.SetScoreBoardClass( newScoringClass );
	}
	
	LevelOriginalSong = Level.Song;
	MySong = JKList.GetEntry(Left(string(Level), InStr(string(Level), ".")));
	
	if (MySong == "")
		MySong = Level.Song;
	
	if(MySong != "" && MySong != "None" )
	{
		Level.Song = MySong;
		LevelCurrentSong = MySong;
		Level.MusicVolumeOverride = -1;
		ClientSetInitialMusic(MySong, MTRAN_Fade);
	}
}

simulated function ClientLoadMusicDownloader()
{	
	if (bClientEnableMusicDownload && class'UTComp_xPlayer'.default.bDoDownloadMusic)
	{
		Loader = Spawn(class'LDGMusicDownloaderLoader', self);
		
		// Bind delegates
		Loader.MusicDownloadInitialized = MusicDownloadInitialized;
		Loader.DownloadError = MusicDownloadError;
		Loader.DownloadCancelled = MusicDownloadCancelled;
		Loader.DownloadComplete = MusicDownloadComplete;
		
		if (Loader.LoadDownloader(self))
		{
			Log("Misc_Player_UTComp_LDG::ClientLoadMusicDownloader(): Loaded music downloader!");
			bClientMusicDownloadInstalled = true;
		}
		else if (!Loader.IsDownloaderSupported())
		{
			Log("Misc_Player_UTComp_LDG::ClientLoadMusicDownloader(): Music downloader is not supported!");
			Loader.Destroy(); // Destroy only if not supported
		}
		else
			Log("Misc_Player_UTComp_LDG::ClientLoadMusicDownloader(): Music downloader is not installed!");
	}
	else
		Log("Misc_Player_UTComp_LDG::ClientLoadMusicDownloader(): Music downloader is not enabled!");	
}

function BecomeSpectator()
{
	if (Role < ROLE_Authority)
		return;

	if ( !Level.Game.BecomeSpectator(self) )
		return;
	
	if ( Pawn != None )
		Pawn.Died(self, class'DamageType', Pawn.Location);

	PlayerBecamingSpectator(self);

	if ( PlayerReplicationInfo.Team != None )
		PlayerReplicationInfo.Team.RemoveFromTeam(self);
		
	PlayerReplicationInfo.Team = None;
	PlayerReplicationInfo.Score = 0;
	PlayerReplicationInfo.Deaths = 0;
	PlayerReplicationInfo.GoalsScored = 0;
	PlayerReplicationInfo.Kills = 0;
	LastSpectateTime = Level.TimeSeconds;
	ServerSpectate();
	BroadcastLocalizedMessage(Level.Game.GameMessageClass, 14, PlayerReplicationInfo);

	ClientBecameSpectator();
	
	if(UTCompPRI != None)
		UTCompPRI.ResetProps();
}

function BecomeActivePlayer()
{
	local bool bRespawning;
	
	if (Role < ROLE_Authority)
		return;
	
	if (Level.TimeSeconds - LastSpectateTime < 5.0)
		return;

	if ( !Level.Game.AllowBecomeActivePlayer(self) )
		return;

	bBehindView = false;
	FixFOV();
	ServerViewSelf();
	PlayerReplicationInfo.bOnlySpectator = false;
	Level.Game.NumSpectators--;
	Level.Game.NumPlayers++;
	
	if (Level.Game.GameStats != None)
		Level.Game.GameStats.ConnectEvent(PlayerReplicationInfo);
		
	PlayerReplicationInfo.Reset();
	Adrenaline = 0;
	BroadcastLocalizedMessage(Level.Game.GameMessageClass, 1, PlayerReplicationInfo);
	if (Level.Game.bTeamGame)
		Level.Game.ChangeTeam(self, Level.Game.PickTeam(int(GetURLOption("Team")), None), false);
		
	if (!Level.Game.bDelayedStart)
	{
		// start match, or let player enter, immediately
		Level.Game.bRestartLevel = false;  // let player spawn once in levels that must be restarted after every death
		if (Level.Game.bWaitingToStartMatch)
			Level.Game.StartMatch();
		else
			Level.Game.RestartPlayer(PlayerController(Owner));
		Level.Game.bRestartLevel = Level.Game.Default.bRestartLevel;
	}
	else
	  GotoState('PlayerWaiting');

	ClientBecameActivePlayer();
	
	if(Team_GameBase(Level.Game) != None)
		bRespawning = Team_GameBase(Level.Game).bRespawning;
	else if(ArenaMaster(Level.Game) != None)
		bRespawning = ArenaMaster(Level.Game).bRespawning;
	else
		goto ending;

	PlayerReplicationInfo.bOutOfLives = !bRespawning;
	PlayerReplicationInfo.NumLives = int(bRespawning);
	
	if(!bRespawning)
		GotoState('Spectating');
	else
		GotoState('PlayerWaiting');

ending:
		
	if (UTCompPRI != None)
		UTCompPRI.Reset();
	
	PlayerBecameActive(self);
}

function string RandomColor ()
{
  local Color thecolor;

  thecolor.R = Rand(250);
  thecolor.G = Rand(250);
  thecolor.B = Rand(250);
  return class'UTComp_Util'.static.MakeColorCode(thecolor);
}

function string ColorReplace (int k)
{
  local Color thecolor;

  thecolor.R = GetBit(k,0) * 250;
  thecolor.G = GetBit(k,1) * 250;
  thecolor.B = GetBit(k,2) * 250;
  return class'UTComp_Util'.static.MakeColorCode(thecolor);
}

simulated function int GetBit (int theInt, int bitNum)
{
  return theInt & 1 << bitNum;
}

simulated function bool GetBitBool (int theInt, int bitNum)
{
  return (theInt & 1 << bitNum) != 0;
}

exec function GoToPlayer(coerce string S)
{		
	ServerGoToPlayer(S);
}

function ServerGoToPlayer(string S)
{
	local Controller C;
	
	if (Role != ROLE_Authority)
		return;
	
	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if (C.PlayerReplicationInfo != None && InStr(Caps(C.PlayerReplicationInfo.PlayerName),Caps(S)) != -1)
		{
			ServerSetViewTarget(C);
			return;
		}
	}
}


function ServerSetViewTarget(actor A)
{
	if(!PlayerReplicationInfo.bOnlySpectator)
		return;
		
	SetViewTarget(A);
	ClientSetViewTarget(A);
}

event TeamMessage(PlayerReplicationInfo PRI, coerce string S, name Type)
{
	local string c, txt;
	local int k;

	// Wait for player to be up to date with replication when joining a server, before stacking up messages
	if ( Level.NetMode == NM_DedicatedServer || GameReplicationInfo == None )
		return;

	if( AllowTextToSpeech(PRI, Type) )
	{
		txt = S;

		for(k=7; k>=0; k--)
			txt=Repl(txt, "^"$k, "");
		
		//txt=Repl(txt, "^r", "");
		
		txt=StripColor(txt);
		
		//calum
		txt=Repl(txt, "._.", "");
		
		TextToSpeech( txt, TextToSpeechVoiceVolume );
	}
		
	if ( Type == 'TeamSayQuiet' )
		Type = 'TeamSay';
	
	//replace the color codes
	if(class'UTComp_Settings'.default.bAllowColoredMessages)
	{
		if (Type=='Say' || Type=='TeamSay')
		{
			for(k=7; k>=0; k--)
				S=Repl(S, "^"$k, ColorReplace(k));
			
			//S=Repl(S, "^r", RandomColor());
		}
	}
	else
	{
		for(k=7; k>=0; k--)
			S=Repl(S, "^"$k, "");

		//S=Repl(S, "^r", "");
	}
	
	if ( myHUD != None )
	{   
		if (class'UTComp_Settings_FREON'.default.bColoredNamesInChat)
			Message( PRI, S, Type );
		else
			myHud.Message( PRI, S, Type );
	}
	
	if ( (Player != None) && (Player.Console != None) )
	{
		if ( PRI!=None )
		{
			if ( PRI.Team!=None && GameReplicationInfo.bTeamGame)
			{
				if (PRI.Team.TeamIndex==0)
					c = chr(27)$chr(200)$chr(1)$chr(1);
				else if (PRI.Team.TeamIndex==1)
					c = chr(27)$chr(125)$chr(200)$chr(253);
				else
					c = chr(27)$chr(255)$chr(255)$chr(1);
			}
			
	  	S = PRI.PlayerName$": "$S;
		}
		
		Player.Console.Chat(c$S, 6.0, PRI );
	}
}

simulated function Message(PlayerReplicationInfo PRI, coerce string Msg, name MsgType)
{
  local Class<LocalMessage> LocalMessageClass2;
  local UTComp_PRI uPRI;

  switch (MsgType)
  {
    case 'Say':
			if ( PRI == None )
				return;
			
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(PRI);
			
			if ( (uPRI == None) || (uPRI.ColoredName == "") )
				Msg = PRI.PlayerName $ ": " $ Msg;
			else if ( (PRI.Team != None) && (PRI.Team.TeamIndex == 0) )
				Msg = uPRI.ColoredName $ class'UTComp_Util'.static.MakeColorCode(RedMessageColor) $ ": " $ Msg;
			else if ( (PRI.Team != None) && (PRI.Team.TeamIndex == 1) )
				Msg = uPRI.ColoredName $ class'UTComp_Util'.static.MakeColorCode(BlueMessageColor) $ ": " $ Msg;
			else 
				Msg = uPRI.ColoredName $ class'UTComp_Util'.static.MakeColorCode(YellowMessageColor) $ ": " $ Msg;
			  
			LocalMessageClass2 = Class'SayMessagePlus';
			break;
    	
    case 'TeamSay':
			if ( PRI == None )
				return;
			
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(PRI);
				
			if ( (uPRI == None) || (uPRI.ColoredName == "") )
			  Msg = PRI.PlayerName $ "(" $ PRI.GetLocationName() $ "): " $ Msg;
			else
			  Msg = uPRI.ColoredName $ class'UTComp_Util'.static.MakeColorCode(GreenMessageColor) $ "(" $ PRI.GetLocationName() $ "): " $ Msg;
			
			LocalMessageClass2 = Class'TeamSayMessagePlus';
			break;
   			    
    case 'CriticalEvent':
	    LocalMessageClass2 = Class'CriticalEventPlus';
	    myHUD.LocalizedMessage(LocalMessageClass2,0,None,None,None,Msg);
	    return;
	    
    case 'DeathMessage':
	    LocalMessageClass2 = Class'Misc_DeathMessage_UTComp';
	    break;
	    
    default:
	    LocalMessageClass2 = Class'StringMessagePlus';
	    break;
  }
  
  if ( myHUD != None )
    myHUD.AddTextMessage(Msg,LocalMessageClass2,PRI);
}

exec function SetName(coerce string S)
{
  S = StripColorCodes(S);
  Super.SetName(S);
  
  ReplaceText(S," ","_");
  ReplaceText(S,"\"","");
  SetColoredNameOldStyle(Left(S,20));
  
  class'UTComp_Settings'.default.CurrentSelectedColoredName = 255;
  class'UTComp_Settings'.StaticSaveConfig();
}

exec function SetNameNoReset(coerce string S)
{
  S = StripColorCodes(S);
  SetName(S);
  
  ReplaceText(S," ","_");
  ReplaceText(S,"\"","");
  
  SetColoredNameOldStyle(S);
}

function InitPlayerReplicationInfo()
{
	Super.InitPlayerReplicationInfo();
	UTCompPRI = UTComp_PRI_BW_LDG(class'UTComp_Util'.static.GetUTCompPRIFor(self));
}

event PlayerTick (float DeltaTime)
{  
  //this should be client side only function, but just in case
  if ( Level.NetMode != NM_DedicatedServer) 
	{
		//showall check
		if (!Level.bHidden)
			Crash();
			
		if (!bInitialized && PlayerReplicationInfo != None && UTCompPRI != None )
		{
			class'UTComp_Settings_FREON'.StaticSaveConfig();
			SetInitialColoredName();
			InitializeScoreboard();
			bInitialized = true;
		}
		
		if (Level.Song == "" && (LevelCurrentSong != "" && LevelCurrentSong != "None"))
			Level.Song = LevelCurrentSong;
	}
	Super.PlayerTick(DeltaTime);
}

simulated function InitializeScoreboard()
{
	local class<ScoreBoard> NewScoreboardClass;
	
	if ( myHud != None && myHUD.ScoreBoard.IsA('UTComp_Scoreboard_NEW_FREON') && !class'UTComp_Settings_FREON'.Default.bUseEnhancedScoreboard )
	{
		NewScoreboardClass = class'UTComp_Scoreboard_FREON';
		bClientChangedScoreboard = true;
	}
	else if ( myHud != None && bClientChangedScoreboard && class'UTComp_Settings_FREON'.Default.bUseEnhancedScoreboard )
		NewScoreboardClass = class'UTComp_Scoreboard_NEW_FREON';
	
	if (myHUD != None && NewScoreboardClass != None)
    myHUD.SetScoreBoardClass(NewScoreboardClass);
}

simulated function SetInitialColoredName ()
{
  SetColoredNameOldStyle();
}

simulated function SetColoredNameOldStyle (optional string s2, optional bool bShouldSave)
{
  local string S;
  local color c;
  local byte k;
  local bool allwhite;
  local byte numdoatonce;
  local byte M;

  if ( (Level.NetMode == NM_DedicatedServer) || (PlayerReplicationInfo == None) )
    return;
    
  if ( s2 == "" )
    s2 = PlayerReplicationInfo.PlayerName;

	allwhite = true;

  for ( k = 1; k <= Len(s2); k++ )
  {
    numdoatonce = 1;
    
    for ( M = k; (M < Len(s2)) && class'UTComp_Settings'.default.colorname[(k - 1)]==class'UTComp_Settings'.default.colorname[M]; M++ )
    {
    	k++;
      numdoatonce++;
		}

    S = S $ class'UTComp_Util'.static.MakeColorCode(class'UTComp_Settings'.default.colorname[k - 1]) $ Right(Left(s2,k),numdoatonce);
    
    c = class'UTComp_Settings'.default.colorname[k - 1];
    if (c.R != 255 || c.G != 255 || c.B != 255)
    	allwhite = false;
  }
  
  if ( UTCompPRI != None)
  {
  	if (!allwhite)
    	UTCompPRI.SetColoredName(S);
    else
    	UTCompPRI.SetColoredName("");
  }
}

simulated function string FindColoredName (int CustomColors)
{
  local string S;
  local string s2;
  local int i;

  if ( (Level.NetMode == NM_DedicatedServer) || (PlayerReplicationInfo == None) )
    return "";
    
  if ( s2 == "" )
    s2 = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedName;

  for ( i = 0; i < Len(s2); i++ )
    S $= class'UTComp_Util'.static.MakeColorCode(class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[i]) $ Mid(class'UTComp_Settings'.default.ColoredName[CustomColors].SavedName,i,1);

  return S;
}

simulated function string AddNewColoredName (int CustomColors)
{
  local string S;
  local byte k;
  local byte numdoatonce;
  local byte M;
  local string s2;

  if ( (Level.NetMode == NM_DedicatedServer) || (PlayerReplicationInfo == None) )
    return "";

  if ( s2 == "" )
    s2 = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedName;

  SetNameNoReset(s2);

  for ( k = 0; k < 20; k++ )
    class'UTComp_Settings'.default.colorname[k] = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[k];
  
  
  for ( k = 1; k <= Len(s2); k++ )
  {
    numdoatonce = 1;
   
    for (  M = k; (M < Len(s2)) && class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[(k - 1)]==class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[M]; M++ )
    {
    	k++;
    	numdoatonce++;
		}
	
    S = S $ class'UTComp_Util'.static.MakeColorCode(class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[k - 1]) $ Right(Left(s2,k),numdoatonce);
  }
  
  return S;
}

simulated function SaveNewColoredName ()
{
  local int N;
  local int L;

  N = class'UTComp_Settings'.default.ColoredName.Length + 1;
  class'UTComp_Settings'.default.ColoredName.Length = N;
  class'UTComp_Settings'.default.ColoredName[N - 1].SavedName = PlayerReplicationInfo.PlayerName;
 
  for (  L = 0; L < 20; L++ )
    class'UTComp_Settings'.default.ColoredName[N - 1].SavedColor[L] = class'UTComp_Settings'.default.colorname[L];
}

exec function ShowColoredNames ()
{
  local int i;
  local int j;
  local string S;

  for ( i = 0; i < class'UTComp_Settings'.default.ColoredName.Length; i++ )
  {
    Log(class'UTComp_Settings'.default.ColoredName[i].SavedName);

    for ( j = 0; j < 20; j++ )
      S = S $ string(class'UTComp_Settings'.default.ColoredName[i].SavedColor[j].R) @ string(class'UTComp_Settings'.default.ColoredName[i].SavedColor[j].G) @ string(class'UTComp_Settings'.default.ColoredName[i].SavedColor[j].B);

    Log(S);
  }
}

simulated function SetColoredNameOldStyleCustom (optional string s2, optional int CustomColors)
{
  local string S;
  local color c;
  local bool allwhite;
  local byte k;
  local byte numdoatonce;
  local byte M;

  if ( (Level.NetMode == NM_DedicatedServer) || (PlayerReplicationInfo == None) )
    return;

  if ( s2 == "" )
    s2 = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedName;

  SetNameNoReset(s2);
  
  for ( k = 0; k < 20; k++ )
    class'UTComp_Settings'.default.colorname[k] = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[k];

  class'UTComp_Settings'.StaticSaveConfig();
  
  allwhite = true;
  
  for ( k = 1; k <= Len(s2); k++ )
  {
    numdoatonce = 1;
    
    for ( M = k; (M < Len(s2)) && class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[(k - 1)]==class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[M]; M++ )
    {
    	 numdoatonce++;
    	 k++;
    }
     
      
    S = S $ class'UTComp_Util'.static.MakeColorCode(class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[k - 1]) $ Right(Left(s2,k),numdoatonce);
    
    c = class'UTComp_Settings'.default.ColoredName[CustomColors].SavedColor[k - 1];
    if (c.R != 255 || c.G != 255 || c.B != 255)
    	allwhite = false;
    
  }
  
  if ( UTCompPRI != None)
  {
  	if (!allwhite)
    	UTCompPRI.SetColoredName(S);
    else
    	UTCompPRI.SetColoredName("");
  }
}

exec function ListColoredNames ()
{
  local int i;

  for ( i = 0; i < class'UTComp_Settings'.default.ColoredName.Length; i++ )
    Echo(class'UTComp_Settings'.default.ColoredName[i].SavedName);
}

exec function Echo (string S)
{
  ClientMessage("" $ S);
}

simulated function string StripColorCodes (string S)
{
  local array<string> StringParts;
  local int i;
  local string s2;

  Split(S,Chr(0x1B),StringParts);
  
  if ( StringParts.Length >= 1 )
    s2 = StringParts[0];

  
  for ( i = 1; i < StringParts.Length; i++ )
  {
    StringParts[i] = Right(StringParts[i],Len(StringParts[i]) - 3);
    s2 = s2 $ StringParts[i];
  }
  
  if ( Right(s2,1) == Chr(0x1B) )
    s2 = Left(s2,Len(s2) - 1);

  return s2;
}

exec function MyMenu()
{
	Menu3SPN();
}

exec function Menu3SPN()
{
	ClientOpenMenu(string(class'Menu_Menu3SPN_LDG'));
}

// =============================================================================
// Music download
// =============================================================================

simulated function MusicDownloadInitialized()
{
	if ((LevelOriginalSong == Level.Song || Level.Song == "") && LevelOriginalSong != "" && LevelOriginalSong != "None" && Loader != None && Loader.bDownloaderInstalled && !Loader.IsMusicDownloaded(LevelOriginalSong))
	{
		// Try download it
		if (!Loader.DownloadMusic(Repl(ClientMusicDownloadURL $ "/" $ LevelOriginalSong $ ".ogg", " ", "%20"), LevelOriginalSong))
			Log("Tried downloading " $ LevelOriginalSong $ ".ogg but failed!");
	}
}

simulated function MusicDownloadError(string URL, string MusicName)
{
	// Do nothing
}

simulated function MusicDownloadCancelled(string URL, string MusicName)
{
	// Do nothing
}

simulated function MusicDownloadComplete(string URL, string MusicName)
{
	// Download has finished, so if the song isn't overriden, play it
	if ((Level.Song ~= "" || LevelOriginalSong == Level.Song) && (MusicName == LevelOriginalSong))
	{
		Level.Song = LevelOriginalSong;
		Level.MusicVolumeOverride = -1;
		ClientSetMusic(Level.Song, MTRAN_Fade);
	}
}

defaultproperties
{
     RedMessageColor=(B=64,G=64,R=255,A=255)
     GreenMessageColor=(B=128,G=255,R=128,A=255)
     BlueMessageColor=(B=255,G=192,R=64,A=255)
     YellowMessageColor=(G=255,R=255,A=255)
}

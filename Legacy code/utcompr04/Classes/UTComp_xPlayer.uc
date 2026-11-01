class UTComp_xPlayer extends xPlayer
	config;

var float LastHitSoundTime;
var bool bInitialized;
var byte ScreenshotsTaken;
var bool bAutoDemoStarted;

var sound LoadedEnemySound;
var sound LoadedFriendlySound;

var UTComp_SRI UTCompSRI;
var UTComp_PRI UTCompPRI;
var class<MutUTComp> MutUTCompType;

var Controller LastViewedController;
var string UTCompMenuClass;

//For Colored Names
var color RedMessageColor;
var color GreenMessageColor;
var color BlueMessageColor;
var color YellowMessageColor;
var color GrayMessageColor;

var float OvertimeEndTime;
var bool bInTimedOvertime;
var float LastBroadcastReadyTime;

const HIT_SOUND_TWEEN_TIME = 0.05;

var bool bWaitingOnGrouping;
var bool bWaitingEnemy;
var int DelayedDamageTotal;
var float WaitingOnGroupingTime;

var bool bDisableSpeed, bDisableBooster, bDisableInvis, bDisableBerserk;

var string LevelOriginalSong;
var string LevelCurrentSong;
var float LastSpectateTime;
var UTComp_JukeboxList JKList;

var 	globalconfig 	bool			bOldBehindView;
var Rotator							BehindViewAimRotator;

var String LastMsg;
var int Violations;
var globalconfig bool bFilterChat;
var bool bRequestedBans;

var globalconfig bool bDoDownloadMusic;
var string ClientMusicDownloadURL;
var bool bClientEnableMusicDownload;
var bool bClientMusicDownloadInstalled;

var LDGMusicDownloaderLoader Loader;

replication
{
	unreliable if(Role == ROLE_Authority)
	  ReceiveHitSound, RClientDamageShake;

	unreliable if(Role < ROLE_Authority)
		ServerGoToPlayer;
	
	reliable if (Role < ROLE_Authority)
		ServerSetChatFiltering;
	
	reliable if (Role == ROLE_Authority && bNetInitial)
		UTCompPRI, UTCompSRI, MutUTCompType, ClientMusicDownloadURL, bClientEnableMusicDownload;
}

delegate PlayerBecamingSpectator(UTComp_xPlayer PC) { }
delegate PlayerBecameActive(UTComp_xPlayer PC) { }

simulated function PreBeginPlay()
{
	local Mutator M;
	
	if (Role == ROLE_Authority)
	{
		for (M = Level.Game.BaseMutator; M != None; M = M.NextMutator)
		{
			if (MutUTComp(M) != None)
			{
				MutUTCompType = class<MutUTComp>(M.class);
				UTCompSRI = MutUTComp(M).UTCompSRI;
				ClientMusicDownloadURL = MutUTComp(M).MusicDownloadURL;
				if (MutUTComp(M).MusicDownloadURL ~= "" || InStr(MutUTComp(M).MusicDownloadURL, "://") == -1)
					bClientEnableMusicDownload = false;
				else
					bClientEnableMusicDownload = MutUTComp(M).bEnableMusicDownload;
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
		
		SetSpectateSpeed(class'UTComp_Settings'.default.SavedSpectateSpeed);
	}
  
  ChangeDeathMessageOrder();
}

simulated function ChangeDeathMessageOrder()
{
  if(class'Crushed'.default.DeathString ~="%o was crushed by %k.")
  {
    class'DamTypeHoverBikeHeadshot'.default.DeathString = "%o's head was clipped off by %k";
    class'DamRanOver'.default.DeathString = "%o was run over by %k";
    class'DamTypeHoverBikePlasma'.default.DeathString ="%o was scorched by %k's Manta plasma.";
    class'DamTypeONSAvriLRocket'.default.DeathString = "%o was blown away by %k's AVRiL.";
    class'DamTypeONSVehicleExplosion'.default.DeathString = "%o was taken out by %k with a vehicle explosion.";
    class'DamTypePRVLaser'.default.DeathString = "%o was shocked by %k's laser.";
    class'DamTypeRoadkill'.default.DeathString = "%o was run over by %k";
    class'DamTypeTankShell'.default.DeathString = "%o was blown into flaming bits by %k's tank shell.";
    class'DamTypeTurretBeam'.default.DeathString = "%o was electrified by %k's turret.";
    class'DamTypeMASPlasma'.default.DeathString = "%o was filled with plasma by %k's Leviathan turret.";
    class'DamTypeClassicHeadshot'.default.DeathString = "%o's skull was blown apart by %k's sniper rifle.";
    class'DamTypeClassicSniper'.default.DeathString = "%o was picked off by %k's sniper rifle.";
  }
}

simulated event PlayerTick(float deltatime)
{
	if(bWaitingOnGrouping)
	{
		if(Level.TimeSeconds > WaitingOnGroupingTime)
		{
			DelayedHitSound(DelayedDamageTotal, bWaitingEnemy);
			bWaitingOnGrouping=false;
		}
	}
	 
	//this should be client side only function, but just in case
  if (Level.NetMode != NM_DedicatedServer)
	{
		if (!bInitialized && PlayerReplicationInfo != None && UTCompPRI != None && UTCompSRI != None)
		{
			InitializeStuff();
			bInitialized = true;
		}
		
		//showall check
		if (!Level.bHidden)
			Crash();
			
		if (Level.Song == "" && (LevelCurrentSong != "" && LevelCurrentSong != "None"))
			Level.Song = LevelCurrentSong;
	}
	
	Super.PlayerTick(deltatime);
}


simulated function InitializeStuff()
{      
  if(class'UTComp_Settings'.default.bFirstRun)
  {
    class'UTComp_Settings'.default.bFirstRun = false;
    ConsoleCommand("set input F5 MyMenu");
    
    if(!class'DeathMatch'.default.bForceDefaultCharacter)
    {
			class'UTComp_Settings'.default.bRedTeammateModelsForced = false;
			class'UTComp_Settings'.default.bBlueEnemyModelsForced =false;
    }
    else
    {
			class'UTComp_Settings'.default.BlueEnemyModelName = class'xGame.xPawn'.default.PlacedCharacterName;
			class'UTComp_Settings'.default.RedTeammateModelName = class'xGame.xPawn'.default.PlacedCharacterName;
    }
    
    class'UTComp_Settings'.Static.StaticSaveConfig();
  }
  
  InitializeScoreboard();
  SetInitialColoredName();
  
  MatchHudColor();
  
  if(UTCompPRI != None)
		UTCompPRI.SetShowSelf(class'UTComp_Settings'.default.bShowSelfInTeamOverlay);
  
  if (class'UTComp_Settings'.default.bEnableUTCompAutoDemorec)
  	StartDemo();
}

simulated function StartDemo()
{
	local string S;
    
	if (Level.NetMode != NM_DedicatedServer)
	{
		S = StripIllegalWindowsCharacters(class'UTComp_Settings'.default.DemoRecordingMask);
		Player.Console.DelayedConsoleCommand("Demorec "$S);
		bAutoDemoStarted = true;
	}
}

simulated function NotifyRestartMap()
{
	if (bAutoDemoStarted)
	{
		ConsoleCommand("StopDemo");
		bAutoDemoStarted = false;
	}
}

simulated function InitializeScoreboard()
{
	local class<Scoreboard> NewScoreBoardClass;
	
	if (UTCompSRI == None)
		return;
	
	if(class'UTComp_Settings'.default.bUseDefaultScoreboard || !UTCompSRI.bEnableScoreboard)
		NewScoreBoardClass = class<Scoreboard>(DynamicLoadObject(UTCompSRI.NormalScoreBoardType, class'class'));
	else
		NewScoreBoardClass = class<Scoreboard>(DynamicLoadObject(UTCompSRI.EnhancedScoreBoardType, class'class'));
		
	if(myHUD != None && NewScoreBoardClass != None)
		myHUD.SetScoreBoardClass(NewScoreBoardClass);	
}


simulated function string StripIllegalWindowsCharacters(string S)
{
	S = MakeDemoName(S);
	
	S = repl(S, ".", "-");
	S = repl(S, "*", "-");
	S = repl(S, ":", "-");
	S = repl(S, "|", "-");
	S = repl(S, "/", "-");
	S = repl(S, ";", "-");
	S = repl(S, "\\","-");
	S = repl(S, ">", "-");
	S = repl(S, "<", "-");
	S = repl(S, "+", "-");
	S = repl(S, " ", "-");
	S = repl(S, "?", "-");
   
	return S;
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
			log ("UTComp_xPlayer::ClientSetHUD(): Could not spawn a HUD of class "$newHUDClass, 'Error');
	  else
			myHUD.SetScoreBoardClass( newScoringClass );
	}
	
	LevelOriginalSong = Level.Song;
	MySong = JKList.GetEntry(Left(string(Level), InStr(string(Level), ".")));
	
	if (MySong == "")
		MySong = Level.Song;
	
	// If it's not downloaded, then nothing will happen
	if (MySong != "" && MySong != "None")
	{
		Level.Song = MySong;
		LevelCurrentSong = MySong;
		Level.MusicVolumeOverride = -1;
		ClientSetInitialMusic(MySong, MTRAN_Fade);
	}
}

simulated function ClientLoadMusicDownloader()
{	
	if (bClientEnableMusicDownload && default.bDoDownloadMusic)
	{
		Loader = Spawn(class'LDGMusicDownloaderLoader', self);
		
		// Bind delegates
		Loader.MusicDownloadInitialized = MusicDownloadInitialized;
		Loader.DownloadError = MusicDownloadError;
		Loader.DownloadCancelled = MusicDownloadCancelled;
		Loader.DownloadComplete = MusicDownloadComplete;
		
		if (Loader.LoadDownloader(self))
		{
			Log("UTComp_xPlayer::ClientLoadMusicDownloader(): Loaded music downloader!");
			bClientMusicDownloadInstalled = true;
		}
		else if (!Loader.IsDownloaderSupported())
		{
			Log("UTComp_xPlayer::ClientLoadMusicDownloader(): Music downloader is not supported!");
			Loader.Destroy(); // Destroy only if not supported
		}
		else
			Log("UTComp_xPlayer::ClientLoadMusicDownloader(): Music downloader is not installed!");
	}
	else
		Log("UTComp_xPlayer::ClientLoadMusicDownloader(): Music downloader is not enabled!");	
}

simulated function string MakeDemoname(string S)
{
	local string hourdigits, minutedigits;
	local string playerNames;
	local int i;
	
	if(Len(Level.Hour)==1)
		hourDigits = "0" $ Level.Hour;
	else
		hourDigits = Left(Level.Hour, 2);
		
	if(Len(Level.Minute)==1)
		minutedigits = "0" $ Level.Minute;
	else
		minutedigits=Left(Level.Minute, 2);
	
	for(i = 0; i < GameReplicationInfo.PRIArray.Length; i++)
	{
		if(GamereplicationInfo.PRIArray[i].bOnlySpectator==False && !GameReplicationInfo.PRIArray[i].bOnlySpectator && GamereplicationInfo.PRIArray[i].Team == None || GamereplicationInfo.PRIArray[i].Team != PlayerReplicationInfo.Team)
	  	PlayerNames=PlayerNames $ GamereplicationInfo.PRIArray[i].PlayerName $ "-";
	}
	
	S = Repl(S, "%t", HourDigits $ "-" $ MinuteDigits);
	S = Repl(S, "%p", PlayerReplicationInfo.PlayerName);
	S = Repl(S, "%o", PlayerNames);
	S = Left(S, 100);
	
	return S;
}

state GameEnded
{
  function BeginState()
  {
    Super.BeginState();
    
    if(Level.NetMode == NM_DedicatedServer)
			return;
			
    SetTimer(0.5, False);
    
    if(myHUD != None)
			myHUD.bShowScoreBoard = true;
  }
  
  function Timer()
  {
    if (class'UTComp_Settings'.default.bEnableAutoScreenShot && ScreenshotsTaken == 0)
    {
			ConsoleCommand("shot "$StripIllegalWindowsCharacters(class'UTComp_Settings'.default.ScreenShotMask));
			ScreenshotsTaken++;
    }
    
    Super.Timer();
  }
}


//====================================
// Stats / Hitsounds
//====================================

// both stat/hitsound
/*simulated function ReceiveHit(class<DamageType> DamageType, int Damage, pawn Injured)
{
	if(Level.NetMode == NM_DedicatedServer)
		return;

	if(Injured!=None && Injured.Controller!=None && Injured.Controller==Self)
		RegisterSelfHit(DamageType, Damage);
  else if(Injured.GetTeamNum()==255 || (Injured.GetTeamNum() != GetTeamNum()))
	{
		RegisterEnemyHit(DamageType, Damage);
		if(class'UTComp_Settings'.default.bCPMAStyleHitsounds && (DamageType == class'DamTypeFlakChunk')|| DamageType == class'DamTypeFlakShell') && (RepInfo == None || RepInfo.EnableHitSoundsMode==2 || LineOfSightTo(Injured)))
	    	GroupDamageSound(DamageType, Damage, true);
		else if(RepInfo==None || RepInfo.EnableHitSoundsMode==2 || LineOfSightTo(Injured) || IsHitScan(DamageType))
			PlayEnemyHitSound(Damage);
	}
	else
	{
		RegisterTeammateHit(DamageType, Damage);
		if(class'UTComp_Settings'.default.bCPMAStyleHitsounds && (DamageType == class'DamTypeFlakChunk' || DamageType == class'DamTypeFlakShell') && (RepInfo == None || RepInfo.EnableHitSoundsMode==2 || LineOfSightTo(Injured)))
			GroupDamageSound(DamageType, Damage, false);
		else if(RepInfo==None || RepInfo.EnableHitSoundsMode==2 || LineOfSightTo(Injured) || IsHitScan(DamageType))
			PlayTeammateHitSound(Damage);
	}
}*/

simulated function bool IsHitScan(class<DamageType> DamageType)
{
	if(  DamageType == Class'XWeapons.DamTypeSuperShockBeam'
		|| DamageType == Class'XWeapons.DamTypeLinkShaft'
		|| DamageType == Class'XWeapons.DamTypeSuperShockBeam'
		|| DamageType == Class'XWeapons.DamTypeSniperShot'
		|| DamageType == Class'XWeapons.DamTypeMinigunBullet'
		|| DamageType == Class'XWeapons.DamTypeShockBeam'
		|| DamageType == Class'XWeapons.DamTypeAssaultBullet'
		|| DamageType == Class'XWeapons.DamTypeShieldImpact'
		|| DamageType == Class'XWeapons.DamTypeMinigunAlt'
		|| DamageType == Class'DamTypeSniperHeadShot'
		|| DamageType == Class'DamTypeClassicHeadshot'
		|| DamageType == Class'DamTypeClassicSniper')
		return true;
    
	return false;
}

// only stats
/*simulated function ReceiveStats(class<DamageType> DamageType, int Damage, pawn Injured)
{
	if(Level.NetMode==NM_DedicatedServer)
		return;
		
	if(Injured.Controller!=None && Injured.Controller==Self)
		RegisterSelfHit(DamageType, Damage);
	else if(Injured.GetTeamNum()==255 || (Injured.GetTeamNum() != GetTeamNum()))
	  RegisterEnemyHit(DamageType, Damage);
	else
	  RegisterTeammateHit(DamageType, Damage);
}*/

simulated function GroupDamageSound(int Damage, bool bEnemy)
{
	bWaitingOnGrouping=True;
	bWaitingEnemy = bEnemy;
	DelayedDamageTotal +=Damage;
	WaitingOnGroupingTime = Level.TimeSeconds+0.030;
}

simulated function DelayedHitSound(int Damage, bool bEnemy)
{
	if(bEnemy)
	  PlayEnemyHitSound(Damage);
	else
	  PlayTeammateHitSound(Damage);
	  
	DelayedDamageTotal = 0;
}

// only hitsound, LOS check done in gamerules
simulated function ReceiveHitSound(int Damage, Pawn injured, byte type, byte team)
{
	if(Level.NetMode==NM_DedicatedServer)
		return;
	
	if(type == 2 || (Pawn(ViewTarget) != None && Pawn(ViewTarget).LineOfSightTo(injured)))
	{			
		if(team == 1)
			PlayEnemyHitSound(Damage);
		else if(team == 2)
			PlayTeammateHitSound(Damage);
		else if(team == 3)
			GroupDamageSound(Damage, True);
		else if(team == 4)
			GroupDamageSound(Damage, False);
	}
}

simulated function bool InStrNonCaseSensitive(String S, string S2)
{
	local int i;
	
	for(i = 0; i <= (Len(S) - Len(S2)); i++)
	{
		if(Mid(S, i, Len(s2)) ~= S2)
			return true;
	}
	
	return false;
}

simulated function PlayEnemyHitSound(int Damage)
{
	local float HitSoundPitch;
	
	if(!class'UTComp_Settings'.default.bEnableHitSounds || LastHitSoundTime>Level.TimeSeconds)
		return;
	
	LastHitSoundTime = Level.TimeSeconds+HIT_SOUND_TWEEN_TIME;
	HitSoundPitch=1.0;
	
	if(class'UTComp_Settings'.default.bCPMAStyleHitSounds)
		HitSoundPitch=class'UTComp_Settings'.default.CPMAPitchModifier*30.0/Damage;
	
	if(LoadedEnemySound == none)
		LoadedEnemySound = Sound(DynamicLoadObject(class'UTComp_Settings'.default.EnemySound, class'Sound', True));
	
	if(ViewTarget!=None)
		ViewTarget.PlaySound(LoadedEnemySound,,class'UTComp_Settings'.default.HitSoundVolume,,,HitSoundPitch);
}

simulated function PlayTeammateHitSound(int Damage)
{
	local float HitSoundPitch;

	if(!class'UTComp_Settings'.default.bEnableHitSounds || LastHitSoundTime>Level.TimeSeconds)
		return;
		
	LastHitSoundTime=Level.TimeSeconds+HIT_SOUND_TWEEN_TIME;
	HitSoundPitch=1.0;
	
	if(class'UTComp_Settings'.default.bCPMAStyleHitSounds)
		HitSoundPitch=class'UTComp_Settings'.default.CPMAPitchModifier*30.0/Damage;
	
	if(LoadedFriendlySound == none)
		LoadedFriendlySound = Sound(DynamicLoadObject(class'UTComp_Settings'.default.FriendlySound, class'Sound', True));
	
	if(ViewTarget!=None)
		ViewTarget.PlaySound(LoadedFriendlySound,,class'UTComp_Settings'.default.HitSoundVolume,,,HitSoundPitch);
}

exec function MyMenu()
{
	ClientOpenMenu(UTCompMenuClass);
}

exec function Echo(string S)
{
	ClientMessage(S);
}

exec function GoToPlayer(coerce string S)
{		
	ServerGoToPlayer(S);
}

function ServerGoToPlayer(string S)
{
	local Controller C;
	
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

exec function SetSavedSpectateSpeed(float F)
{
	class'UTComp_Settings'.default.SavedSpectateSpeed = F;
	SetSpectateSpeed(F);
	class'UTComp_Settings'.static.staticSaveConfig();
}

exec function ShowCrosshair()
{
	myHUD.bCrosshairShow = !myHUD.bCrosshairShow;
}

state Spectating
{
	function BeginState()
	{
		Super.BeginState();
	}
	
	exec function Fire( optional float F )
	{
		if ( bFrozen )
		{
			if ( (TimerRate <= 0.0) || (TimerRate > 1.0) )
			bFrozen = false;
			return;
		}
		
		ServerViewNextPlayer();
	}
}

simulated function string GetPlayerName()
{
	if(PlayerReplicationInfo != None)
		return PlayerReplicationInfo.PlayerName;
		
	return "";
}

exec function SetName (coerce string S)
{
  S = StripColorCodes(S);
  Super.SetName(S);
  
  ReplaceText(S," ","_");
  ReplaceText(S,"\"","");
  SetColoredNameOldStyle(Left(S,20));
  
  Class'UTComp_Settings'.default.CurrentSelectedColoredName = 255;
  Class'UTComp_Settings'.StaticSaveConfig();;
}

simulated function SetShowSelf(bool B)
{
  class'UTComp_Settings'.default.bShowSelfInTeamOverlay = B;
  class'UTComp_Settings'.static.StaticSaveConfig();
  
  if(UTCompPRI != None)
		UTCompPRI.SetShowSelf(B);
}

exec function SetNameNoReset (coerce string S)
{
	S = StripColorCodes(S);
	SetName(S);
	
	ReplaceText(S," ","_");
	ReplaceText(S,"\"","");
	
	SetColoredNameOldStyle(S);
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
    
    for ( M = k; (M < Len(s2)) && Class'UTComp_Settings'.Default.colorname[(k - 1)]==Class'UTComp_Settings'.Default.colorname[M]; M++ )
    {
    	k++;
      numdoatonce++;
		}

    S = S $ class'UTComp_Util'.static.MakeColorCode(Class'UTComp_Settings'.Default.colorname[k - 1]) $ Right(Left(s2,k),numdoatonce);
    
    c = Class'UTComp_Settings'.Default.colorname[k - 1];
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
    s2 = Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedName;

  for ( i = 0; i < Len(s2); i++ )
    S $= class'UTComp_Util'.static.MakeColorCode(Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[i]) $ Mid(Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedName,i,1);

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
    s2 = Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedName;

  SetNameNoReset(s2);

  for ( k = 0; k < 20; k++ )
    class'UTComp_Settings'.Default.colorname[k] = Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[k];
  
  
  for ( k = 1; k <= Len(s2); k++ )
  {
    numdoatonce = 1;
   
    for (  M = k; (M < Len(s2)) && Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[(k - 1)]==Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[M]; M++ )
    {
    	k++;
    	numdoatonce++;
		}
	
    S = S $ class'UTComp_Util'.static.MakeColorCode(Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[k - 1]) $ Right(Left(s2,k),numdoatonce);
  }
  
  return S;
}

simulated function SaveNewColoredName ()
{
  local int N;
  local int L;

  N = class'UTComp_Settings'.Default.ColoredName.Length + 1;
  class'UTComp_Settings'.Default.ColoredName.Length = N;
  class'UTComp_Settings'.Default.ColoredName[N - 1].SavedName = PlayerReplicationInfo.PlayerName;
 
  for (  L = 0; L < 20; L++ )
    class'UTComp_Settings'.Default.ColoredName[N - 1].SavedColor[L] = Class'UTComp_Settings'.Default.colorname[L];
}

exec function ShowColoredNames ()
{
  local int i;
  local int j;
  local string S;

  for ( i = 0; i < Class'UTComp_Settings'.Default.ColoredName.Length; i++ )
  {
    Log(Class'UTComp_Settings'.Default.ColoredName[i].SavedName);

    for ( j = 0; j < 20; j++ )
      S = S $ string(Class'UTComp_Settings'.Default.ColoredName[i].SavedColor[j].R) @ string(Class'UTComp_Settings'.Default.ColoredName[i].SavedColor[j].G) @ string(Class'UTComp_Settings'.Default.ColoredName[i].SavedColor[j].B);

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
    s2 = class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedName;

  SetNameNoReset(s2);
  
  for ( k = 0; k < 20; k++ )
    class'UTComp_Settings'.Default.colorname[k] = class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[k];

  class'UTComp_Settings'.StaticSaveConfig();
  
  allwhite = true;
  
  for ( k = 1; k <= Len(s2); k++ )
  {
    numdoatonce = 1;
    
    for ( M = k; (M < Len(s2)) && Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[(k - 1)]==Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[M]; M++ )
    {
    	 numdoatonce++;
    	 k++;
    }
     
      
    S = S $ class'UTComp_Util'.static.MakeColorCode(Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[k - 1]) $ Right(Left(s2,k),numdoatonce);
    
    c = Class'UTComp_Settings'.Default.ColoredName[CustomColors].SavedColor[k - 1];
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

  for ( i = 0; i < Class'UTComp_Settings'.Default.ColoredName.Length; i++ )
    Echo(Class'UTComp_Settings'.Default.ColoredName[i].SavedName);
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

simulated function ReskinAll()
{
	local UTComp_xPawn P;
	
	if(Level.NetMode == NM_DedicatedServer)
		return;
		
	foreach DynamicActors(class'UTComp_xPawn', P)
	   P.ColorSkins();
}

function bool AllowTextMessage(string Msg)
{
	local int k;

	if ( (Level.NetMode == NM_Standalone) || PlayerReplicationInfo.bAdmin )
		return true;

	if ( (Level.Pauser == none) && (Level.TimeSeconds - LastBroadcastTime < 0.66) )
		return false;

	// lower frequency if same text
	if ( Level.TimeSeconds - LastBroadcastTime < 5 )
	{
		Msg = Left(Msg,Clamp(len(Msg) - 4, 8, 64));
		
		for ( k=0; k<4; k++ )
			if ( LastBroadcastString[k] ~= Msg )
				return false;
	}
	
	for ( k=3; k>0; k-- )
		LastBroadcastString[k] = LastBroadcastString[k-1];

	LastBroadcastTime = Level.TimeSeconds;
	return true;
}

function string StripColor(string s)
{
	local string EscapeCode;
	local int p;

  EscapeCode = Chr(0x1B);
  p = InStr(s,EscapeCode);
  
	while ( p>=0 )
	{
		s = left(s,p)$mid(S,p+4);
		p = InStr(s,EscapeCode);
	}

	return s;
}

function ServerSay( string Msg )
{
	local controller C;	
	
	Msg = Level.Game.StripColor(Msg);
	
	//Guard for spamming.
	if (Len(Msg) > 5)
	{
		if (LastMsg != "" && Left(Msg, Len(LastMsg)) == LastMsg)
		{
			Violations++;
			if (Violations >= 2)
			{
				ClientMessage("Repeat message detected.");
				return;
			}
		}
		else 
		{
			Violations = 0;
			LastMsg = Msg;
		}
	}

	
	// center print admin messages which start with #
	if (PlayerReplicationInfo.bAdmin && left(Msg,1) == "#" )
	{
		Msg = right(Msg,len(Msg)-1);
		for( C=Level.ControllerList; C!=None; C=C.nextController )
			if( C.IsA('PlayerController') )
			{
				PlayerController(C).ClearProgressMessages();
				PlayerController(C).SetProgressTime(6);
				PlayerController(C).SetProgressMessage(0, Msg, class'Canvas'.Static.MakeColor(255,255,255));
			}
		return;
	}

	Level.Game.Broadcast(self, Msg, 'Say');
}


function ServerTeamSay( string Msg )
{
	LastActiveTime = Level.TimeSeconds;

	Msg = Level.Game.StripColor(Msg);
	
	//Guard for spamming.
	if (Len(Msg) > 5)
	{
		if (LastMsg != "" && Left(Msg, Len(LastMsg)) == LastMsg)
		{
			Violations++;
			if (Violations >= 2)
			{
				ClientMessage("Repeat message detected.");
				return;
			}
		}
		else 
		{
			Violations = 0;
			LastMsg = Msg;
		}
	}
	
	if( !GameReplicationInfo.bTeamGame )
	{
		Say( Msg );
		return;
	}

	//Drop any message with a weapon name string - they're weapon drop binds.
	if (class'MutUTComp'.default.bNoWeaponDropTeamsay && InStr(Msg, "%w") != -1)
		return;
    Level.Game.BroadcastTeam( self, Level.Game.ParseMessageString( Level.Game.BaseMutator , self, Msg ) , 'TeamSay');
}

//===========================================================================
// Behind View support
//
// Over the shoulder
//===========================================================================
function CalcBehindView(out vector CameraLocation, out rotator CameraRotation, float Dist)
{
    local vector View,HitLocation,HitNormal;
    local float ViewDist,RealDist;
    local vector globalX,globalY,globalZ;
    local vector localX,localY,localZ;
	
	if (bOldBehindView || ViewTarget != Pawn || !Pawn.bProjTarget)
	{
		Super.CalcBehindView(CameraLocation, CameraRotation, Dist);
		return;
	}

    CameraRotation = Rotation;
    CameraRotation.Roll = 0;
	
	GetAxes(CameraRotation, localX, localY, localZ);
	
	CameraLocation.Z += 22;
	CameraLocation += localY * 2.4 * CameraDist;
	CameraLocation += localZ * 4.5 * CameraDist;

    // add view rotation offset to cameraview (amb)
    CameraRotation += CameraDeltaRotation;

    View = vect(1,0,0) >> CameraRotation;

    // add view radius offset to camera location and move viewpoint up from origin (amb)
    RealDist = Dist;
    Dist += CameraDeltaRad;

    if( Trace( HitLocation, HitNormal, CameraLocation - Dist * vector(CameraRotation), CameraLocation,false,vect(10,10,10) ) != None )
        ViewDist = FMin( (CameraLocation - HitLocation) Dot View, Dist );
    else
        ViewDist = Dist;

    if ( !bBlockCloseCamera || !bValidBehindCamera || (ViewDist > 10 + FMax(ViewTarget.CollisionRadius, ViewTarget.CollisionHeight)) )
	{
		bValidBehindCamera = true;
		OldCameraLoc = CameraLocation - ViewDist * View;
		OldCameraRot = CameraRotation;
	}
	else
		SetRotation(OldCameraRot);

    CameraLocation = OldCameraLoc;
    CameraRotation = OldCameraRot;

    // add view swivel rotation to cameraview (amb)
    GetAxes(CameraSwivel,globalX,globalY,globalZ);
    localX = globalX >> CameraRotation;
    localY = globalY >> CameraRotation;
    localZ = globalZ >> CameraRotation;
    CameraRotation = OrthoRotation(localX,localY,localZ);
}

//Free aim in behind view.
simulated function rotator GetViewRotation()
{
	if (Pawn != None)
	{	
		if ( bBehindView )
		{
			if (bOldBehindView || Vehicle(Pawn) != None) 
				return Pawn.Rotation;
			return TraceView();	
		}
	}
    return Rotation;
}

simulated function rotator TraceView()
{
	local Vector HitLocation, HitNormal;
	
	if ( LastPlayerCalcView == Level.TimeSeconds && CalcViewActor != None && CalcViewActor.Location == CalcViewActorLocation )
		return BehindViewAimRotator;
	if (Trace( HitLocation, HitNormal, 25000 * vector(OldCameraRot) + OldCameraLoc, OldCameraLoc,false) != None)
		BehindViewAimRotator = Rotator(HitLocation - (Pawn.Location + Pawn.EyePosition()));
	else BehindViewAimRotator = Rotator(25000 * vector(OldCameraRot) + OldCameraLoc - (Pawn.Location + Pawn.EyePosition()));
	return BehindViewAimRotator;
}

function rotator AdjustAim(FireProperties FiredAmmunition, vector projStart, int aimerror)
{
    local vector FireDir, AimSpot, HitNormal, HitLocation, OldAim, AimOffset;
    local actor BestTarget;
    local float bestAim, bestDist, projspeed;
    local actor HitActor;
    local bool bNoZAdjust, bLeading;
    local rotator AimRot;

    FireDir = vector(GetViewRotation());
    if ( FiredAmmunition.bInstantHit )
        HitActor = Trace(HitLocation, HitNormal, projStart + 10000 * FireDir, projStart, true);
    else
        HitActor = Trace(HitLocation, HitNormal, projStart + 4000 * FireDir, projStart, true);
    if ( (HitActor != None) && HitActor.bProjTarget )
    {
        BestTarget = HitActor;
        bNoZAdjust = true;
        OldAim = HitLocation;
        BestDist = VSize(BestTarget.Location - Pawn.Location);
    }
    else
    {
        // adjust aim based on FOV
        bestAim = 0.90;
        if ( (Level.NetMode == NM_Standalone) && bAimingHelp )
        {
            bestAim = 0.93;
            if ( FiredAmmunition.bInstantHit )
                bestAim = 0.97;
            if ( FOVAngle < DefaultFOV - 8 )
                bestAim = 0.99;
        }
        else if ( FiredAmmunition.bInstantHit )
                bestAim = 1.0;
        BestTarget = PickTarget(bestAim, bestDist, FireDir, projStart, FiredAmmunition.MaxRange);
        if ( BestTarget == None )
        {
            return GetViewRotation();
        }
        OldAim = projStart + FireDir * bestDist;
    }
	InstantWarnTarget(BestTarget,FiredAmmunition,FireDir);
	ShotTarget = Pawn(BestTarget);
    if ( !bAimingHelp || (Level.NetMode != NM_Standalone) )
    {
        return GetViewRotation();
    }

    // aim at target - help with leading also
    if ( !FiredAmmunition.bInstantHit )
    {
        projspeed = FiredAmmunition.ProjectileClass.default.speed;
        BestDist = vsize(BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart);
        bLeading = true;
        FireDir = BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
        // if splash damage weapon, try aiming at feet - trace down to find floor
        if ( FiredAmmunition.bTrySplash
            && ((BestTarget.Velocity != vect(0,0,0)) || (BestDist > 1500)) )
        {
            HitActor = Trace(HitLocation, HitNormal, AimSpot - BestTarget.CollisionHeight * vect(0,0,2), AimSpot, false);
            if ( (HitActor != None)
                && FastTrace(HitLocation + vect(0,0,4),projstart) )
                return rotator(HitLocation + vect(0,0,6) - projStart);
        }
    }
    else
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }
    AimOffset = AimSpot - OldAim;

    // adjust Z of shooter if necessary
    if ( bNoZAdjust || (bLeading && (Abs(AimOffset.Z) < BestTarget.CollisionHeight)) )
        AimSpot.Z = OldAim.Z;
    else if ( AimOffset.Z < 0 )
        AimSpot.Z = BestTarget.Location.Z + 0.4 * BestTarget.CollisionHeight;
    else
        AimSpot.Z = BestTarget.Location.Z - 0.7 * BestTarget.CollisionHeight;

    if ( !bLeading )
    {
        // if not leading, add slight random error ( significant at long distances )
        if ( !bNoZAdjust )
        {
            AimRot = rotator(AimSpot - projStart);
            if ( FOVAngle < DefaultFOV - 8 )
                AimRot.Yaw = AimRot.Yaw + 200 - Rand(400);
            else
                AimRot.Yaw = AimRot.Yaw + 375 - Rand(750);
            return AimRot;
        }
    }
    else if ( !FastTrace(projStart + 0.9 * bestDist * Normal(FireDir), projStart) )
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }

    return rotator(AimSpot - projStart);
}

//===========================================================================
// Zoom fix
//===========================================================================
function AdjustView(float DeltaTime )
{
    // teleporters affect your FOV, so adjust it back down
    if ( FOVAngle != DesiredFOV )
    {
        if ( FOVAngle > DesiredFOV )
            FOVAngle = FOVAngle - FMax(7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV));
        else
            FOVAngle = FOVAngle - FMin(-7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV));
        if ( Abs(FOVAngle - DesiredFOV) <= 10 )
            FOVAngle = DesiredFOV;
    }

    // adjust FOV for weapon zooming
    if ( bZooming )
    {
		if (DesiredZoomLevel < ZoomLevel)
			ZoomLevel = FMax(ZoomLevel - DeltaTime, DesiredZoomLevel);
        else ZoomLevel = FMin(ZoomLevel + DeltaTime, DesiredZoomLevel);
        DesiredFOV = FClamp(90.0 - (ZoomLevel * 88.0), 1, 170);
    }
}

event TeamMessage( PlayerReplicationInfo PRI, coerce string S, name Type  )
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
		}
	}
	else
	{
		for(k=7; k>=0; k--)
			S=Repl(S, "^"$k, "");
	}
	
	S=Repl(S, "^r", "");
	
	if ( myHUD != None )
	{   
		if (class'UTComp_Settings'.default.bEnableColoredNamesInTalk)
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
					c = chr(27)$chr(255)$chr(255)$chr(0);
			}
			
	  	S = PRI.PlayerName$": "$S;
		}
		
		Player.Console.Chat(c$S, 6.0, PRI );
	}
}

simulated function Message( PlayerReplicationInfo PRI, coerce string Msg, name MsgType )
{
	local Class<LocalMessage> LocalMessageClass2;
	
	switch( MsgType )
	{
		case 'Say':
			if ( PRI == None )
				return;
		
			if(class'UTComp_Util'.Static.GetUTCompPRI(PRI)==None || class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName=="")
				Msg = PRI.PlayerName$": "$Msg;			
			else if(pri.team!= none && PRI.Team.TeamIndex == 0)
				Msg = class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName$class'UTComp_Util'.Static.MakeColorCode(RedMessageColor)$": "$Msg;
			else if(pri.team!= none && PRI.Team.TeamIndex == 1)
				Msg = class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName$class'UTComp_Util'.Static.MakeColorCode(BlueMessageColor)$": "$Msg;
			else
				Msg = class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName$class'UTComp_Util'.Static.MakeColorCode(YellowMessageColor)$": "$Msg;
				
			LocalMessageClass2 = class'SayMessagePlus';
			break;

		case 'TeamSay':
			if ( PRI == None )
				return;
			
			if(class'UTComp_Util'.Static.GetUTCompPRI(PRI)==None || class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName=="")
				Msg = PRI.PlayerName$"("$PRI.GetLocationName()$"): "$Msg;
			else
				Msg = class'UTComp_Util'.Static.GetUTCompPRI(PRI).ColoredName$class'UTComp_Util'.Static.MakeColorCode(GreenMessageColor)$"("$PRI.GetLocationName()$"): "$Msg;
			
			LocalMessageClass2 = class'TeamSayMessagePlus';
			break;
			
		case 'CriticalEvent':
			LocalMessageClass2 = class'CriticalEventPlus';
			myHud.LocalizedMessage( LocalMessageClass2, 0, None, None, None, Msg );
			return;
		
		case 'DeathMessage':
			LocalMessageClass2 = class'xDeathMessage';
			break;
		
		default:
			LocalMessageClass2 = class'StringMessagePlus';
			break;
	}

	if(myHud != None)
		myHud.AddTextMessage(Msg,LocalMessageClass2,PRI);
}


function string RandomColor ()
{
  local Color c;

  c.R = Rand(250);
  c.G = Rand(250);
  c.B = Rand(250);
  return class'UTComp_Util'.static.MakeColorCode(c);
}

function string ColorReplace (int k)
{
  local Color c;

  c.R = GetBit(k,0) * 250;
  c.G = GetBit(k,1) * 250;
  c.B = GetBit(k,2) * 250;
  return class'UTComp_Util'.static.MakeColorCode(c);
}

simulated function int GetBit (int i, int bitNum)
{
  return i & 1 << bitNum;
}

simulated function bool GetBitBool (int i, int bitNum)
{
  return (i & 1 << bitNum) != 0;
}

simulated function MatchHudColor()
{
	local HudCDeathMatch DMHud;
	
	if(myHud==None || HudCDeathMatch(myHud)==None)
		return;
		
  DMHud=HudCDeathMatch(myHud);
  if(!class'UTComp_HudSettings'.default.bMatchHudColor)
  {
		DMHud.HudColorRed=class'HudCDeathMatch'.default.HudColorRed;
		DMHud.HudColorBlue=class'HudCDeathMatch'.default.HudColorBlue;
		return;
  }

	if(!class'UTComp_Settings'.default.bEnemyBasedSkins)
	{
		if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 3)
			DMHud.HudColorRed = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
		else if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 2
	    || class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 1)
			DMHud.HudColorRed = class'UTComp_xPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
	
		if(class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 3)
			DMHud.HudColorBlue = class'UTComp_Settings'.default.BlueEnemyUTCompSkinColor;
		else if(class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 2
	    || class'UTComp_Settings'.default.ClientSkinModeBlueEnemy == 1)
	    DMHud.HudColorBlue = class'UTComp_xPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorBlueEnemy];
	}
	else
	{
		if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 3)
		{
	    DMHud.HudColorBlue = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
	    DMHud.HudColorRed = class'UTComp_Settings'.default.RedTeammateUTCompSkinColor;
		}
		else if(class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 2
		    || class'UTComp_Settings'.default.ClientSkinModeRedTeammate == 1)
		{
	    DMHud.HudColorBlue = class'UTComp_xPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
	    DMHud.HudColorRed = class'UTComp_xPawn'.default.BrightSkinColors[class'UTComp_Settings'.default.PreferredSkinColorRedTeammate];
		}
	}
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
	if (Role < ROLE_Authority)
		return;
	
	//Instant spec - join is scripted and OK
	if (Level.TimeSeconds != LastSpectateTime && Level.TimeSeconds - LastSpectateTime < 5.0)
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
	
	if (UTCompPRI != None)
		UTCompPRI.Reset();
	
	PlayerBecameActive(self);
}

function InitPlayerReplicationInfo()
{
	Super.InitPlayerReplicationInfo();
	UTCompPRI = Class'UTComp_Util'.static.GetUTCompPRIFor(self);
}

state PlayerWalking
{
	ignores SeePlayer, HearNoise, Bump, ServerSpectate;
	function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
    {
        local vector OldAccel;
        local bool OldCrouch;
		
		if ( Pawn == None )
			return;
		if ( (DoubleClickMove == DCLICK_Active) && (Pawn.Physics == PHYS_Falling) )
			DoubleClickDir = DCLICK_Active;
		else if ( (DoubleClickMove != DCLICK_None) && (DoubleClickMove < DCLICK_Active) )
		{
			if ( UnrealPawn(Pawn).Dodge(DoubleClickMove) )
				DoubleClickDir = DCLICK_Active;
		}
        OldAccel = Pawn.Acceleration;
        if ( Pawn.Acceleration != NewAccel )
			Pawn.Acceleration = NewAccel;
		if ( bDoubleJump && (bUpdating || Pawn.CanDoubleJump()) )
			Pawn.DoDoubleJump(bUpdating);
        else if ( bPressedJump )
			Pawn.DoJump(bUpdating);

		if (!bBehindView)
			Pawn.SetViewPitch(Rotation.Pitch);
		else
			Pawn.SetViewPitch(BehindViewAimRotator.Pitch);

        if ( Pawn.Physics != PHYS_Falling )
        {
            OldCrouch = Pawn.bWantsToCrouch;
            if (bDuck == 0)
                Pawn.ShouldCrouch(false);
            else if ( Pawn.bCanCrouch )
                Pawn.ShouldCrouch(true);
        }
    }
	function bool NotifyLanded(vector HitNormal)
	{
		if (DoubleClickDir == DCLICK_Active)
		{
			DoubleClickDir = DCLICK_Done;
			ClearDoubleClick();
			Pawn.Velocity *= Vect(0.8,0.8,1.0);
		}
		else
			DoubleClickDir = DCLICK_None;

		if ( Global.NotifyLanded(HitNormal) )
			return true;

		return false;
	}
}

exec function JoinGame()
{
	if (PlayerReplicationInfo.bOnlySpectator)
		BecomeActivePlayer();
}

exec function SpectateGame()
{
	if (!PlayerReplicationInfo.bOnlySpectator)
		BecomeSpectator();
}

exec function GetSensitivity()
{
	Player.Console.Message("Sensitivity"@class'PlayerInput'.default.MouseSensitivity, 6.0);
}

exec function Sens(float F)
{
    SetSensitivity(F);
}

function DamageShake(int damage) //send type of damage too!
{
    RClientDamageShake(Min(damage, 30));
}

protected function RClientDamageShake(int damage)
{
    // todo: add properties!
    ShakeView( Damage * vect(30,0,0),
               120000 * vect(1,0,0),
               0.15 + 0.005 * damage,
               damage * vect(0,0,0.03),
               vect(1,1,1),
               0.2);
}

function DoCombo( class<Combo> ComboClass )
{
  if (Adrenaline >= ComboClass.default.AdrenalineCost && !Pawn.InCurrentCombo() && !ComboDisabled(ComboClass))
		ServerDoCombo( ComboClass );
}

function bool ComboDisabled(class<Combo> ComboClass)
{
  if(class'UTComp_Settings'.default.bDisableSpeed && ComboClass == class'xGame.ComboSpeed')
		return true;
      
  if(class'UTComp_Settings'.default.bDisableBooster && ComboClass == class'xGame.ComboDefensive')
		return true;
      
  if(class'UTComp_Settings'.default.bDisableInvis && ComboClass == class'xGame.ComboInvis')
		return true;
      
  if(class'UTComp_Settings'.default.bDisableBerserk && ComboClass == class'xGame.ComboBerserk')
		return true;

	return false;
}

//Disallow auto-taunt except in offline games
function bool AutoTaunt()
{
	if (Level.NetMode == NM_Standalone)
		return Super.AutoTaunt();
	return false;
}

/*
//Disallow all taunts except in offline games
function ServerSpeech( name Type, int Index, string Callsign )
{
	if (Type == 'Taunt')
		return;
	if(PlayerReplicationInfo.VoiceType != None)
		PlayerReplicationInfo.VoiceType.static.PlayerSpeech( Type, Index, Callsign, Self );
}
*/

simulated function PostNetReceive()
{
	if (!bRequestedBans && ChatManager != None && Level.GRI != None)
	{
		bRequestedBans = True;
		ServerRequestBanInfo(-1);
		ServerSetChatFiltering(bFilterChat);
	}

	Super.PostNetReceive();
}

exec function ToggleFilter()
{
	bFilterChat = !bFilterChat;
	ServerSetChatFiltering(bFilterChat);
	ClientMessage("Chat filtering is now "$eval(bFilterChat, "enabled", "disabled")$".");
}

function ServerSetChatFiltering(bool bFilter)
{
	if (UTComp_PlayerChatManager(ChatManager) != None)
		UTComp_PlayerChatManager(ChatManager).bFilterChat = bFilter;
}

// =============================================================================
// Music download
// =============================================================================

simulated function MusicDownloadInitialized()
{
	if (Loader.IsMusicDownloaded(LevelOriginalSong))
		Log(LevelOriginalSong $ " is downloaded!");
	else
		Log(LevelOriginalSong $ " is not downloaded!");
	
	if ((LevelOriginalSong == Level.Song || Level.Song == "") && LevelOriginalSong != "" && LevelOriginalSong != "None" && Loader != None && Loader.bDownloaderInstalled && !Loader.IsMusicDownloaded(LevelOriginalSong))
	{
		// Try download it
		if (!Loader.DownloadMusic(Repl(ClientMusicDownloadURL $ "/" $ LevelOriginalSong $ ".ogg", " ", "%20"), LevelOriginalSong))
			Log("Tried downloading " $ LevelOriginalSong $ ".ogg but failed!");
		else
			Log("Downloading " $ LevelOriginalSong $ ".ogg!");
	}
	else
		Log("NOT Downloading " $ LevelOriginalSong $ ".ogg (bDownloaderInstalled = " $ Loader.bDownloaderInstalled $ "!");
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
     UTCompMenuClass="utcompr04.UTComp_Menu_OpenedMenu"
     RedMessageColor=(B=64,G=64,R=255,A=255)
     GreenMessageColor=(B=128,G=255,R=128,A=255)
     BlueMessageColor=(B=255,G=192,R=64,A=255)
     YellowMessageColor=(G=255,R=255,A=255)
     GrayMessageColor=(B=155,G=155,R=255)
     bDoDownloadMusic=True
     PlayerChatType="utcompr04.UTComp_PlayerChatManager"
}

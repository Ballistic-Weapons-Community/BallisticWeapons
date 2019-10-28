class Misc_Player extends BallisticPlayer;

#exec AUDIO IMPORT FILE=Sounds\alone.wav     	    GROUP=Sounds
#exec AUDIO IMPORT FILE=Sounds\hitsound.wav         GROUP=Sounds

var float NextCampCheckTime;

var array<String> BannedWords;

/* Combo related */
var config bool bShowCombos;            // show combos on the HUD

var config bool bDisableSpeed;
var config bool bDisableInvis;
var config bool bDisableBooster;
var config bool bDisableBerserk;
var config bool bDisableRadar;
var config bool bDisableAmmoRegen;
/* Combo related */

/* HUD related */
var config bool bShowTeamInfo;          // show teams info on the HUD
var config bool bExtendedInfo;          // show extra teammate info

var config bool bMatchHUDToSkins;       // sets HUD color to brightskins color

var config bool bTeamColoredDeathMessages;
/* HUD related */

/* chat filtering */
var config	int   			CapsCheckThreshold; 		// Messages longer than this will be checked for CAPS LOCK abuse.
var config	int				MaxCharRunLength;			// For stretching of chat. This many of the same character in a row will be trimmed to 2 of said character.
var config float			ColorUsageThreshold;		// Length of message over number of attempts to use color.
var config InterpCurve	MaxCapsCurve;				// Curve determining max caps in a message of a given length.
var String LastMsg;
var int Violations;

var array<int>	PendingChatIDs;
/* chat filtering */

/* brightskins related */
var config bool bUseBrightskins;        // self-explanatory
var config bool bUseTeamColors;         // use red and blue for brightkins
var config Color RedOrEnemy;            // brightskin color for the red or enemy team
var config Color BlueOrAlly;            // brightskin color for the blue or own team
/* brightskins related */

/* model related */
var config bool bForceRedEnemyModel;    // force a model for the red/enemy team
var config bool bForceBlueAllyModel;    // force a model for the blue/ally team
var config bool bUseTeamModels;         // force models by team color (opposed to enemy/ally)
var config string RedEnemyModel;        // character name for the red team's model
var config string BlueAllyModel;        // character name for the blue team's model
/* model related */

/* misc related */
var int  Spree;                         // kill count at new round
var bool bFirstOpen;                    // used by the stat screen

var float NewFriendlyDamage;            // friendly damage done
var float NewEnemyDamage;               // enemy damage done

var int HitDamage;
var int LastDamage;

var config bool bDisableAnnouncement;
var config bool bAutoScreenShot;
var bool bShotTaken;

var bool bSeeInvis;
/* misc related */

/* sounds */
var config bool  bAnnounceOverkill;
var config bool  bUseHitsounds;

var config Sound SoundHit;
var config Sound SoundHitFriendly;
var config float SoundHitVolume;

var config Sound SoundAlone; 
var config float SoundAloneVolume;

var config Sound SoundTMDeath;

var config Sound SoundUnlock;

var globalconfig bool bFilterChat;

var globalconfig bool bSlotMode;

var bool bClientAcknowledgedUnlock, bRequestedBans;
/* sounds */

replication
{
    reliable if(Role == ROLE_Authority)
        ClientResetClock, ClientPlayAlone, ClientListBest,
        ClientLockWeapons, ClientKillBases, ClientSendBWStats, ClientSendMiscStats;

    reliable if(bNetDirty && Role == ROLE_Authority)
        HitDamage, bSeeInvis;

    reliable if(Role < ROLE_Authority)
        ServerSetMapString, ServerCallTimeout, bClientAcknowledgedUnlock, ServerSetChatFiltering, ServerAcknowledgeBanReceived;
}

function PlayerTick(float DeltaTime)
{
    Super.PlayerTick(DeltaTime);

    if(Pawn == None || !bUseHitSounds || HitDamage == LastDamage)
    {
        LastDamage = HitDamage;
        return;
    }

    if(HitDamage < LastDamage)
        Pawn.PlaySound(soundHitFriendly,, soundHitVolume,,,(48 / (LastDamage - HitDamage)), false);
    else
        Pawn.PlaySound(soundHit,, soundHitVolume,,,(48 / (HitDamage - LastDamage)), false);

    LastDamage = HitDamage;
}

function ClientListBest(string acc, string dam, string aim, string spam)
{
    if(bDisableAnnouncement)
        return;

    if(acc != "")
        ClientMessage(acc);
    if(dam != "")
        ClientMessage(dam);
    if(aim != "")
        ClientMessage(aim);
	if (spam != "")
		ClientMessage(spam);
}

function ServerSetMapString(string s)
{
    if(TeamArenaMaster(Level.Game) != None)
        TeamArenaMaster(Level.Game).SetMapString(self, s);
    else if(ArenaMaster(Level.Game) != None)
        ArenaMaster(Level.Game).SetMapString(self, s);
}

exec function ThrowWeapon()
{
}

//just in case
function ServerThrowWeapon()
{
    local int ammo[2];
    local Inventory inv;
    local class<Weapon> WeaponClass;

    if(Misc_Pawn(Pawn) == None || Pawn.Weapon == None)
        return;

    ammo[0] = Pawn.Weapon.AmmoCharge[0];
    ammo[1] = Pawn.Weapon.AmmoCharge[1];
    WeaponClass = Pawn.Weapon.Class;

    Super.ServerThrowWeapon();

    Misc_Pawn(Pawn).GiveWeaponClass(WeaponClass);

    for(inv = Pawn.Inventory; inv != None; inv = inv.Inventory)
    {
        if(inv.Class == WeaponClass)
        {
            Weapon(inv).AmmoCharge[0] = ammo[0];
            Weapon(inv).AmmoCharge[1] = ammo[1];
            break;
        }
    }
}

function ServerSay( string Msg )
{
	local controller C;
	local int i;
	
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
	
	// Eusko
	if ( Locs( GetPlayerIDHash() ) == "d9f64e232f1a540bb73d9eca6810d10c" || Locs( GetPlayerIDHash() ) == "f84f13386b3b01576ce146ca8a16f0fa" )
	{
		for (i=0; i<BannedWords.Length; i++)
		{
			if (InStr(Msg, BannedWords[i]) != -1)
			{
				Level.Game.BroadcastHandler.BroadcastText(PlayerReplicationInfo, self, Msg, 'Say');
				return;
			}
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

    Level.Game.BroadcastTeam( self, Level.Game.ParseMessageString( Level.Game.BaseMutator , self, Msg ) , 'TeamSay');
}

function AwardAdrenaline(float amount)
{
    if(bAdrenalineEnabled)
    {
        if((TAM_GRI(GameReplicationInfo) == None || TAM_GRI(GameReplicationInfo).bDisableTeamCombos) && (Pawn != None && Pawn.InCurrentCombo()))
            return;

        if((Adrenaline < AdrenalineMax) && (Adrenaline + amount >= AdrenalineMax))
			ClientDelayedAnnouncementNamed('Adrenalin', 15);
        Adrenaline = FClamp(Adrenaline + amount, 0.1, AdrenalineMax);
    }
}

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

function PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

    if(Level.GRI != None)
        Level.GRI.MaxLives = 0;		
}
	
function ServerRequestBanInfo(int PlayerID)
{
	local byte i;
	local Controller C;
	local PlayerController PC;
	
	//log(Name@"ServerRequestBanInfo:"$PlayerID,'ChatManager');

	if ( Level != None && Level.Game != None )
	{
		for (C = Level.ControllerList; C != None; C = C.NextController)
		{
			// Don't send our own info
			if ( PlayerController(C) == None || C == Self )
				continue;
				
			PC = PlayerController(C);

			if (PlayerID == -1)
				PendingChatIDs.Remove(0, PendingChatIDs.Length);
			//log(Name@"ServerRequestBanInfo CArr["$i$"]:"$C@"ID:"$C.PlayerReplicationInfo.PlayerID,'ChatManager');
			if ( PlayerID == -1 || PC.PlayerReplicationInfo.PlayerID == PlayerID )
			{
				log(Name@"Sending BanInfo To Client PlayerID:"$PC.PlayerReplicationInfo.PlayerID@"Hash:"$PC.GetPlayerIDHash()@"Address:"$PC.GetPlayerNetworkAddress(),'ChatManager');
				ChatManager.TrackNewPlayer(PC.PlayerReplicationInfo.PlayerID, PC.GetPlayerIDHash(), PC.GetPlayerNetworkAddress());
				ClientReceiveBan(PC.PlayerReplicationInfo.PlayerID$Chr(27)$PC.GetPlayerIDHash()$chr(27)$PC.GetPlayerNetworkAddress());
				for (i=0; i<PendingChatIDs.Length && PendingChatIDs[i] != PC.PlayerReplicationInfo.PlayerID; i++);
				if (i == PendingChatIDs.Length)
					PendingChatIDs[i] = PC.PlayerReplicationInfo.PlayerID;				
			}
			
			if (PendingChatIDs.Length > 0)
				ChatManager.SetTimer(10, true);				
		}
	}
}

function ResendFailedBans()
{
	local byte i;
	local Controller C;
	local PlayerController PC;

	if ( Level != None && Level.Game != None )
	{
		for (C = Level.ControllerList; C != None; C = C.NextController)
		{
			// Don't send our own info
			if ( PlayerController(C) == None || C == Self )
				continue;
				
			PC = PlayerController(C);

			for (i=0; i<PendingChatIDs.Length && PendingChatIDs[i] != PC.PlayerReplicationInfo.PlayerID; i++);
			if (i < PendingChatIDs.Length)
				ClientReceiveBan(PC.PlayerReplicationInfo.PlayerID$Chr(27)$PC.GetPlayerIDHash()$chr(27)$PC.GetPlayerNetworkAddress());				
		}
	}
}

function ClientReceiveBan(string BanInfo)
{
	local String ID, Garbage;
	
	if ( UnrealPlayerChatManager(ChatManager) != None )
		UnrealPlayerChatManager(ChatManager).ReceiveBanInfo(BanInfo);
	Divide(BanInfo, Chr(27), ID, Garbage);
	ServerAcknowledgeBanReceived(int(ID));
}

function ServerAcknowledgeBanReceived(int PlayerID)
{
	local int i;
	
	for (i=0; i<PendingChatIDs.Length && PendingChatIDs[i] != PlayerID; i++);
	if (i < PendingChatIDs.Length)
	{
		PendingChatIDs.Remove(i, 1);
		if(PendingChatIDs.Length == 0)
			ChatManager.SetTimer(0.0, false);
	}
}

function ClientKillBases()
{
    local xPickupBase p;

    ForEach AllActors(class'xPickupBase', p)
    {
        if(P.IsA('Misc_PickupBase'))
            continue;

        p.bHidden = true;
        if(p.myEmitter != None)
            p.myEmitter.Destroy();
    }
}

function Reset()
{
    local NavigationPoint P;
    local float Adren;

    Adren = Adrenaline;

    P = StartSpot;
    Super.Reset();
    StartSpot = P;

    if(Pawn == None || !Pawn.InCurrentCombo())
        Adrenaline = Adren;
    else
        Adrenaline = 0.1;

    WaitDelay = 0;
}

function ClientLockWeapons(bool bLock)
{
    if(xPawn(Pawn) != None)
        xPawn(Pawn).bNoWeaponFiring = bLock;
    bClientAcknowledgedUnlock = !bLock;
}

function ClientPlayAlone()
{
    ClientPlaySound(SoundAlone, true, SoundAloneVolume);
}

simulated function PlayCustomRewardAnnouncement(sound ASound, byte AnnouncementLevel, optional bool bForce)
{
	local float Atten;

	// Wait for player to be up to date with replication when joining a server, before stacking up messages
	if(Level.NetMode == NM_DedicatedServer || GameReplicationInfo == None)
		return;

	if((AnnouncementLevel > AnnouncerLevel) || (RewardAnnouncer == None))
		return;
	if(!bForce && (Level.TimeSeconds - LastPlaySound < 1))
		return;
    LastPlaySound = Level.TimeSeconds;  // so voice messages won't overlap
	LastPlaySpeech = Level.TimeSeconds;	// don't want chatter to overlap announcements

	Atten = 2.0 * FClamp(0.1 + float(AnnouncerVolume) * 0.225, 0.2, 1.0);
	if(ASound != None)
		ClientPlaySound(ASound, true, Atten, SLOT_Talk);
}

function ClientResetClock(int seconds)
{
    Misc_BaseGRI(GameReplicationInfo).RoundTime = seconds;
}

function AcknowledgePossession(Pawn P)
{
    Super.AcknowledgePossession(P);

    SetupCombos();

    if(xPawn(P) != None && TAM_GRI(GameReplicationInfo) != None)
        xPawn(P).bNoWeaponFiring = TAM_GRI(GameReplicationInfo).bWeaponsLocked;
}

function ClientReceiveCombo(string ComboName)
{
    Super.ClientReceiveCombo(ComboName);

    SetupCombos();
}

function SetupCombos()
{
    local int i;
    local Misc_BaseGRI GRI;
    local bool bDisable;
    local string ComboName;

    GRI = Misc_BaseGRI(Level.GRI);
    if(GRI == None)
        return;

    for(i = 0; i < ArrayCount(ComboList); i++)
    {
        ComboName = ComboNameList[i];
        if(ComboName ~= "")
            continue;

        if(ComboName ~= "xGame.ComboDefensive")
            bDisable = (bDisableBooster || GRI.bDisableBooster);
        else if(ComboName ~= "xGame.ComboSpeed")
            bDisable = (bDisableSpeed || GRI.bDisableSpeed);
        else if(ComboName ~= "xGame.ComboBerserk")
            bDisable = (bDisableBerserk || GRI.bDisableBerserk);
        else if(ComboName ~= "BallisticProV55.Ballistic_ComboMiniMe")
            bDisable = (bDisableInvis || GRI.bDisableInvis);

        if(bDisable)
            ComboName = "xGame.Combo";

        ComboList[i] = class<Combo>(DynamicLoadObject(ComboName, class'Class'));
        if(ComboList[i] == None)
            log("Could not find combo:"@ComboName, '3SPN');
    }
}

function ServerViewNextPlayer()
{
    local Controller C, Pick;
    local bool bFound, bRealSpec, bWasSpec;
	local TeamInfo RealTeam;

    bRealSpec = PlayerReplicationInfo.bOnlySpectator;
    bWasSpec = (ViewTarget != Pawn) && (ViewTarget != self);
    PlayerReplicationInfo.bOnlySpectator = true;
    RealTeam = PlayerReplicationInfo.Team;

    // view next player
    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
		if ( bRealSpec && (C.PlayerReplicationInfo != None) ) // hack fix for invasion spectating
			PlayerReplicationInfo.Team = C.PlayerReplicationInfo.Team;
        if ( Level.Game.CanSpectate(self,bRealSpec,C) )
        {
            if ( Pick == None )
                Pick = C;
            if ( bFound )
            {
                Pick = C;
                break;
            }
            else
                bFound = ( (RealViewTarget == C) || (ViewTarget == C) );
        }
    }
    PlayerReplicationInfo.Team = RealTeam;
    SetViewTarget(Pick);
    ClientSetViewTarget(Pick);

    if(!bWasSpec)
        bBehindView = false;

    ClientSetBehindView(bBehindView);
    PlayerReplicationInfo.bOnlySpectator = bRealSpec;
}

// The player wants to switch to weapon group number F.
exec function SwitchWeapon(byte F)
{
	if (bSlotMode && F > 0 && F < 8)
		GetLoadoutWeapon(F-1);
	else if ( Pawn != None )
		Pawn.SwitchWeapon(F);
}

state Spectating
{
    ignores SwitchWeapon, RestartLevel, ClientRestart, Suicide,
     ThrowWeapon, NotifyPhysicsVolumeChange, NotifyHeadVolumeChange;

    exec function Fire( optional float F )
    {
    	if(bFrozen)
	    {
		    if((TimerRate <= 0.0) || (TimerRate > 1.0))
			    bFrozen = false;
		    return;
	    }

        ServerViewNextPlayer();
    }

    // Return to spectator's own camera.
    exec function AltFire( optional float F )
    {
	    if(!PlayerReplicationInfo.bOnlySpectator && !PlayerReplicationInfo.bAdmin && Level.NetMode != NM_Standalone && GameReplicationInfo.bTeamGame)
        {
            if(ViewTarget == None)
                Fire();
            else
		        ToggleBehindView();
        }
	    else
	    {
        	bBehindView = false;
        	ServerViewSelf();
	    }
    }

    function Timer()
    {
    	bFrozen = false;
    }

    function BeginState()
    {
        if ( Pawn != None )
        {
            SetLocation(Pawn.Location);
            UnPossess();
        }

	    bCollideWorld = true;
	    CameraDist = Default.CameraDist;
    }

    function EndState()
    {
        PlayerReplicationInfo.bIsSpectator = false;
        bCollideWorld = false;
    }
}

function ServerChangeTeam(int Team)
{
    Super.ServerChangeTeam(Team);

    if(Team_GameBase(Level.Game) != None && Team_GameBase(Level.Game).bRespawning)
    {
        PlayerReplicationInfo.bOutOfLives = false;
        PlayerReplicationInfo.NumLives = 1;
    }
}

function BecomeActivePlayer()
{
    local bool bRespawning;

    Super.BecomeActivePlayer();

    if(Role == Role_Authority)
    {
        if(Team_GameBase(Level.Game) != None)
            bRespawning = Team_GameBase(Level.Game).bRespawning;
        else if(ArenaMaster(Level.Game) != None)
            bRespawning = ArenaMaster(Level.Game).bRespawning;
        else
            return;

        PlayerReplicationInfo.bOutOfLives = !bRespawning;
        PlayerReplicationInfo.NumLives = int(bRespawning);
        if(!bRespawning)
            GotoState('Spectating');
        else
            GotoState('PlayerWaiting');
    }
}

function DoCombo(class<Combo> ComboClass)
{
    if(TAM_GRI(GameReplicationInfo) == None || TAM_GRI(Level.GRI).bDisableTeamCombos)
    {
        Super.DoCombo(ComboClass);
        return;
    }

    ServerDoCombo(ComboClass);
}

function bool CanDoCombo(class<Combo> ComboClass)
{
    if(TAM_GRI(GameReplicationInfo) == None)
        return true;

    if(class<ComboSpeed>(ComboClass) != None)
        return (!TAM_GRI(GameReplicationInfo).bDisableSpeed);
    if(class<ComboDefensive>(ComboClass) != None)
        return (!TAM_GRI(GameReplicationInfo).bDisableBooster);
    if(class<Ballistic_ComboMiniMe>(ComboClass) != None)
        return (!TAM_GRI(GameReplicationInfo).bDisableInvis);
    if(class<ComboBerserk>(ComboClass) != None)
        return (!TAM_GRI(GameReplicationInfo).bDisableBerserk);

    return true;
}

function ServerDoCombo(class<Combo> ComboClass)
{
    if(class<ComboBerserk>(ComboClass) != None)
        ComboClass = class<Combo>(DynamicLoadObject("3SPNv3141BW.Misc_ComboBerserk", class'Class'));
    else if(class<ComboSpeed>(ComboClass) != None && class<Misc_ComboSpeed>(ComboClass) == None)
        ComboClass = class<Combo>(DynamicLoadObject("3SPNv3141BW.Misc_ComboSpeed", class'Class'));

    if(Adrenaline < ComboClass.default.AdrenalineCost)
        return;

    if(!CanDoCombo(ComboClass))
        return;

    if(TAM_GRI(GameReplicationInfo) == None || TAM_GRI(Level.GRI).bDisableTeamCombos)
    {
        Super.ServerDoCombo(ComboClass);
        return;
    }

    if(xPawn(Pawn) != None)
    {
        if(TAM_TeamInfo(PlayerReplicationInfo.Team) != None)
            TAM_TeamInfo(PlayerReplicationInfo.Team).PlayerUsedCombo(self, ComboClass);
        else if(TAM_TeamInfoRed(PlayerReplicationInfo.Team) != None)
            TAM_TeamInfoRed(PlayerReplicationInfo.Team).PlayerUsedCombo(self, ComboClass);
        else if(TAM_TeamInfoBlue(PlayerReplicationInfo.Team) != None)
            TAM_TeamInfoBlue(PlayerReplicationInfo.Team).PlayerUsedCombo(self, ComboClass);
        else
            log("Could not get TeamInfo for player:"@PlayerReplicationInfo.PlayerName, '3SPN');
    }
}

function ServerUpdateStatArrays(TeamPlayerReplicationInfo PRI)
{
  local Misc_PRI P;
  local BallisticPlayerReplicationInfo BWPRI;
  local int i;

  Super.ServerUpdateStatArrays(PRI);

  P = Misc_PRI(PRI);
  if(P == None)
		return;
		
	BWPRI = class'Mut_Ballistic'.static.GetBPRI(P);
		
	if (BWPRI == None)
		return;

	for (i = 0; i < 10; i++)
  	ClientSendBWStats(BWPRI, BWPRI.HitStats[i], i);

  ClientSendMiscStats(P, BWPRI, BWPRI.HeadShots, P.EnemyDamage, P.ReverseFF, BWPRI.AveragePercent, 
      P.FlawlessCount, P.OverkillCount, P.DarkHorseCount, BWPRI.SGDamage);
}

function ClientSendMiscStats(Misc_PRI P, BallisticPlayerReplicationInfo BWPRI, int HS, int ED, float RFF, float AP, int FC, int OC, int DHC, int SGD)
{
    BWPRI.HeadShots = HS; P.EnemyDamage = ED; P.ReverseFF = RFF; BWPRI.AveragePercent = AP;
    P.FlawlessCount = FC; P.OverkillCount = OC; P.DarkHorseCount = DHC; BWPRI.SGDamage = SGD;
}

function ClientSendBWStats(BallisticPlayerReplicationInfo BWPRI, BallisticPlayerReplicationInfo.HitStat Stat, int index)
{
  if (BWPRI != None && index >= 0 && index < 10)
  	BWPRI.HitStats[index] = Stat;
}

state GameEnded
{
    function BeginState()
    {
        Super.BeginState();

        if(Level.NetMode == NM_DedicatedServer)
            return;

        if(MyHUD != None)
        {
            MyHUD.bShowScoreBoard = true;
            MyHUD.bShowLocalStats = false;
        }

        SetTimer(1.0, false);
    }

    function Timer()
    {
        if(bAutoScreenShot && !bShotTaken)
            TakeShot();

        Super.Timer();
    }
}

/* exec functions */
exec function Suicide()
{
	ClientMessage("You can't commit suicide in 3SPN gametypes.");
}

function TakeShot()
{
    if(GameReplicationInfo.bTeamGame)
        ConsoleCommand("shot TAM-"$Left(string(Level), InStr(string(Level), "."))$"-"$Level.Month$"-"$Level.Day$"-"$Level.Hour$"-"$Level.Minute);
    else
        ConsoleCommand("shot AM-"$Left(string(Level), InStr(string(Level), "."))$"-"$Level.Month$"-"$Level.Day$"-"$Level.Hour$"-"$Level.Minute);
    bShotTaken = true;
}


static function string StripColor(string s)
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

event TeamMessage( PlayerReplicationInfo PRI, coerce string S, name Type  )
{
	local string c, txt;

	// Wait for player to be up to date with replication when joining a server, before stacking up messages
	if ( Level.NetMode == NM_DedicatedServer || GameReplicationInfo == None )
		return;

	if( AllowTextToSpeech(PRI, Type) )
	{
		txt = S;
		txt = StripColor(txt);
		
		//calum
		txt = Repl(txt, "._.", "");
				
		TextToSpeech( txt, TextToSpeechVoiceVolume );
	}
		
	if ( Type == 'TeamSayQuiet' )
		Type = 'TeamSay';
	
	if ( myHUD != None )
		myHud.Message( PRI, S, Type );
	
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

exec function SetSkins(byte r1, byte g1, byte b1, byte r2, byte g2, byte b2)
{
    RedOrEnemy.R = Clamp(r1, 0, 100);
    RedOrEnemy.G = Clamp(g1, 0, 100);
    RedOrEnemy.B = Clamp(b1, 0, 100);

    BlueOrAlly.R = Clamp(r2, 0, 100);
    BlueOrAlly.G = Clamp(g2, 0, 100);
    BlueOrAlly.B = Clamp(b2, 0, 100);

    saveconfig();
}

exec function Menu3SPN()
{
	local Rotator r;

	r = GetViewRotation();
	r.Pitch = 0;
	SetRotation(r);

	ClientOpenMenu("3SPNv3141BW.Menu_Menu3SPN");
}

exec function ToggleTeamInfo()
{
    bShowTeamInfo = !bShowTeamInfo;
    saveconfig();
}


exec function BehindView(bool b)
{
	if(PlayerReplicationInfo.bOnlySpectator || (Pawn == None && !Misc_BaseGRI(GameReplicationInfo).bEndOfRound) 
        || PlayerReplicationInfo.bAdmin || Level.NetMode == NM_Standalone)
		Super.BehindView(b);
	else
		Super.BehindView(false);
}

exec function ToggleBehindView()
{
	if(PlayerReplicationInfo.bOnlySpectator || (Pawn == None && !Misc_BaseGRI(GameReplicationInfo).bEndOfRound) 
        || PlayerReplicationInfo.bAdmin || Level.NetMode == NM_Standalone)
		Super.ToggleBehindView();
	else
		Super.BehindView(false);
}


function Possess(Pawn aPawn)
{
	Super.Possess(aPawn);
	if (Vehicle(aPawn) != None && Vehicle(aPawn).Driver != None)
		Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(Vehicle(aPawn).Driver);
	else Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(aPawn);
}

function Unpossess()
{
	Super.Unpossess();
	Misc_PRI(PlayerReplicationInfo).PawnReplicationInfo.SetMyPawn(None);
}

exec function DisableCombos(bool s, bool b, bool be, bool i, optional bool r, optional bool a)
{
    bDisableSpeed = s;
    bDisableBooster = b;
    bDisableBerserk = be;
    bDisableInvis = i;
    bDisableRadar = r;
    bDisableAmmoRegen = a;

    SetupCombos();
}

exec function UseSpeed()
{
    if(Adrenaline < class'ComboSpeed'.default.AdrenalineCost)
        return;

    DoCombo(class'ComboSpeed');
}

exec function UseBooster()
{
    if(Adrenaline < class'ComboDefensive'.default.AdrenalineCost)
        return;

    DoCombo(class'ComboDefensive');
}

exec function UsePint()
{
    if(Adrenaline < class'Ballistic_ComboMiniMe'.default.AdrenalineCost)
        return;

    DoCombo(class'Ballistic_ComboMiniMe');
}

exec function UseBerserk()
{
    if(Adrenaline < class'ComboBerserk'.default.AdrenalineCost)
        return;

    DoCombo(class'ComboBerserk');
}

exec function CallTimeout()
{
    ServerCallTimeout();
}

function ServerCallTimeout()
{
    if(Team_GameBase(Level.Game) != None)
        Team_GameBase(Level.Game).CallTimeout(self);
}

exec simulated function ToggleFilter()
{
	local UnrealChatHandler UCH;
	
	bFilterChat = !bFilterChat;
	default.bFilterChat = bFilterChat;
	StaticSaveConfig();
	ServerSetChatFiltering(bFilterChat);
	ClientMessage("Chat filtering is now"@eval(bFilterChat, "enabled", "disabled")$".");
	foreach AllActors(class'UnrealChatHandler', UCH)
	{
		ClientMessage("Found ChatHandler");
		break;
	}
}
/* exec functions */

function ServerSetChatFiltering(bool bFilter)
{
	if (Misc_PlayerChatManager(ChatManager) != None)
		Misc_PlayerChatManager(ChatManager).bFilterChat = bFilter;
}

defaultproperties
{
     BannedWords(0)="joke"
     BannedWords(1)="shutup"
     BannedWords(2)="fucking"
     BannedWords(3)="ridiculous"
     BannedWords(4)="nerf"
     BannedWords(5)="so op"
     BannedWords(6)="shut up"
     BannedWords(7)=" aza"
     BannedWords(8)="italian"
     BannedWords(9)="fook"
     BannedWords(10)="useless"
     BannedWords(11)="shield"
     bShowCombos=True
     bShowTeamInfo=True
     bExtendedInfo=True
     bMatchHUDToSkins=True
     bTeamColoredDeathMessages=True
     CapsCheckThreshold=5
     MaxCharRunLength=4
     ColorUsageThreshold=6.000000
     MaxCapsCurve=(Points=((OutVal=1.000000),(InVal=5.000000,OutVal=1.000000),(InVal=6.000000,OutVal=0.800000),(InVal=25.000000,OutVal=0.350000),(InVal=100.000000,OutVal=0.200000),(InVal=100000.000000,OutVal=0.200000)))
     bUseBrightskins=True
     bUseTeamColors=True
     RedOrEnemy=(R=100,A=128)
     BlueOrAlly=(B=100,G=25,A=128)
     RedEnemyModel="Gorge"
     BlueAllyModel="Jakob"
     bAnnounceOverkill=True
     bUseHitsounds=True
     SoundHit=Sound'3SPNv3141BW.Sounds.HitSound'
     SoundHitFriendly=Sound'MenuSounds.denied1'
     SoundHitVolume=0.600000
     SoundAlone=Sound'3SPNv3141BW.Sounds.alone'
     SoundAloneVolume=1.000000
     SoundUnlock=Sound'NewWeaponSounds.Newclickgrenade'
     PlayerChatType="3SPNv3141BW.Misc_PlayerChatManager"
     PlayerReplicationInfoClass=Class'3SPNv3141BW.Misc_PRI'
     PawnClass=Class'3SPNv3141BW.Misc_Pawn'
     Adrenaline=0.100000
}

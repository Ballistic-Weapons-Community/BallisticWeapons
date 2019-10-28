class UTComp_ScoreBoard_NEW_AS extends UTComp_ScoreBoard_NEW;

var string RemainingRoundTime, CurrentRound, RoundSeparator;
var string Defender, Attacker;
var string WaitForReinforcements, WaitingToSpawnReinforcements, AutoRespawn;
var string YouWonRound, YouLostRound, PracticeRoundOver;

function PostBeginPlay()
{
	//fetch the localized items
	RemainingRoundTime = class'ScoreBoard_Assault'.default.RemainingRoundTime;
	CurrentRound = class'ScoreBoard_Assault'.default.CurrentRound;
	RoundSeparator = class'ScoreBoard_Assault'.default.RoundSeparator;
	Defender = class'ScoreBoard_Assault'.default.Defender;
	Attacker = class'ScoreBoard_Assault'.default.Attacker;
	
	WaitForReinforcements = class'ScoreBoard_Assault'.default.WaitForReinforcements;
	WaitingToSpawnReinforcements = class'ScoreBoard_Assault'.default.WaitingToSpawnReinforcements;
	AutoRespawn = class'ScoreBoard_Assault'.default.AutoRespawn;
	YouWonRound = class'ScoreBoard_Assault'.default.YouWonRound;
	YouLostRound = class'ScoreBoard_Assault'.default.YouLostRound;
	PracticeRoundOver = class'ScoreBoard_Assault'.default.PracticeRoundOver;
	
	Super.PostBeginPlay();	
}

function String GetTitleString()
{
	local string	InfoString;
	local byte		OwnerTeam;
	local ASGameReplicationInfo	ASGRI;

	ASGRI		= ASGameReplicationInfo(GRI);
	InfoString	= super.GetTitleString();
	
	if ( ASGRI != None && Controller(Owner) != None && Controller(Owner).PlayerReplicationInfo != None 
		&& Controller(Owner).PlayerReplicationInfo.Team != None )
	{
		OwnerTeam = Controller(Owner).PlayerReplicationInfo.Team.TeamIndex;
		if ( OwnerTeam == byte(ASGRI.bTeamZeroIsAttacking) )
			InfoString = InfoString@Defender;
		else
			InfoString = InfoString@Attacker;
	}

	return InfoString;
}

function String GetRestartString()
{
	local string				RestartString;
	local ASGameReplicationInfo	ASGRI;

	ASGRI = ASGameReplicationInfo(GRI);

	if ( ASGRI.RoundWinner != ERW_None )
	{
		return ASGRI.GetRoundWinnerString();
		/*
		if ( ASGRI.IsPracticeRound() )
			return PracticeRoundOver;

		if (  Controller(Owner).GetTeamNum() == ASGRI.RoundWinner )
			return YouWonRound;
		return YouLostRound;
		*/
	}

	if ( Controller(Owner).PlayerReplicationInfo != None 
		&& ASPlayerReplicationInfo(Controller(Owner).PlayerReplicationInfo).bAutoRespawn 
		&& !Controller(Owner).IsInState('PlayerWaiting') )
	{
		RestartString = AutoRespawn @ ASGRI.ReinforcementCountDown;
		return RestartString;
	}

	if ( ASGRI.ReinforcementCountDown > 0 && !Controller(Owner).IsInState('PlayerWaiting') )
	{
		RestartString = WaitForReinforcements @ ASGRI.ReinforcementCountDown;
	}
	else
		RestartString = super.GetRestartString();

	return RestartString;
}

function String GetDefaultScoreInfoString()
{
	local string				AssaultInfoString;
	local int					RemainingRoundTimeVal;
	local ASGameReplicationInfo	ASGRI;

	ASGRI = ASGameReplicationInfo(GRI);
	if ( ASGRI == None )
		return super.GetDefaultScoreInfoString();

	// remaining round time
	if ( ASGRI.RoundTimeLimit > 0 && ASGRI.RoundWinner == ERW_None )
	{
		RemainingRoundTimeVal = Max(0, ASGRI.RoundTimeLimit-ASGRI.RoundStartTime+ASGRI.RemainingTime);

		if ( ASGRI.RoundWinner != ERW_None )
			RemainingRoundTimeVal = ASGRI.RoundOverTime;

		AssaultInfoString = RemainingRoundTime@FormatTime( RemainingRoundTimeVal );
	}

	// current round

	if ( AssaultInfoString != "" )
		AssaultInfoString = AssaultInfoString@spacer;	// add spacer

	AssaultInfoString = AssaultInfoString@CurrentRound@ASGRI.CurrentRound$RoundSeparator$ASGRI.MaxRounds;

	//if ( AssaultInfoString == "" )
	//	return super.GetDefaultScoreInfoString();

	return AssaultInfoString;
}

simulated function DrawPlayerInformation(Canvas C, PlayerReplicationInfo PRI, float XOffset, float YOffset, float Scale)
{
	local int otherteam;
	local PlayerReplicationInfo OwnerPRI;
	local UTComp_PRI uPRI;
	local float oldClipX;
	local float TrophiesXOffset;
	local string temp;
	local float XL, YL,ClipYHeight;
	local float IconOffset;
	  
	if(Owner != None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
	
	uPRI=class'UTComp_Util'.static.GetUTCompPRI(PRI);
	ClipYHeight = C.ClipY*0.055*PlayerBoxScale;	
	  
	// Draw Player name
	C.Font = PlrBigFont;
	C.SetPos(C.ClipX*0.02+PingOffset+ScoreOffset+DeathsOffset+XOffset, (ClipYHeight-PlrSmallFontHeight-PlrBigFontHeight)/2+YOffset);
	
	IconOffset = 3*32*scale*1.02;
	
	oldClipX=C.ClipX;
	C.ClipX=C.ClipX*0.470-IconOffset+XOffset;
	if(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard && uPRI!=None && uPRI.ColoredName !="")
	  C.DrawTextClipped(uPRI.ColoredName);
	else
	{
		C.SetDrawColor(255,255,255,255);
		C.DrawTextClipped(PRI.PlayerName);
	}
	C.ClipX=OldClipX;
	
	if( PRI == OwnerPRI )
		C.SetDrawColor(255,255,0,255);
	else
		C.SetDrawColor(255,255,255,255);

  // DrawScore
	C.Font = PlrScoreFont;
	C.SetPos(C.ClipX*0.0192+XOffset, ClipYHeight*0.5+YOffset-PlrScoreFontHeight/2);

	if ( PRI.bOutOfLives )
		C.DrawText("OUT");
	else
		C.DrawText(int(PRI.Score));
    
	if(PRI.Team!=None && PRI.Team.TeamIndex==0)
		OtherTeam=1;
	else
		OtherTeam=0;

	C.Font = PlrMidFont;
	  
	//deaths & net  
	C.SetDrawColor(255,0,0,255);
	if (uPRI != None)
	{
		C.StrLen(uPRI.RealDeaths, XL, YL);
		C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset, ClipYHeight * 0.25 + YOffset - PlrMidFontHeight / 2);
		C.DrawText(uPRI.RealDeaths);
	}
	else
	{
		C.StrLen("-", XL, YL);
		C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset, ClipYHeight * 0.25 + YOffset - PlrMidFontHeight / 2);
		C.DrawText("-");
	}
  
	C.SetDrawColor(0,200,255,255);  
	if (uPRI != None)
  {
		C.StrLen(uPRI.RealKills - uPRI.RealDeaths, XL, YL);
		C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset, ClipYHeight * 0.75 + YOffset - PlrMidFontHeight / 2);		
		C.DrawText(uPRI.RealKills - uPRI.RealDeaths);
	}
	else
	{
		C.StrLen("-", XL, YL);
		C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset, ClipYHeight * 0.75 + YOffset - PlrMidFontHeight / 2);		
		C.DrawText("-");
	}
	      	
	if(PRI == OwnerPRI)
		C.SetDrawColor(255,255,0,255);
	else
		C.SetDrawColor(255,255,255,255);
  
	C.Font = PlrPingFont;
         
	if ( Level.NetMode != NM_Standalone )
	{
		// Net Info
		C.SetPos(C.ClipX*0.02+ScoreOffset+DeathsOffset+XOffset, ClipYHeight*0.20 + YOffset - PlrPingFontHeight/2);
		C.DrawText("Ping:"$Min(999,4*PRI.Ping));
		
		C.SetPos(C.ClipX*0.02+ScoreOffset+DeathsOffset+XOffset, ClipYHeight*0.515 + YOffset - PlrPingFontHeight/2);
		C.DrawText("P/L :"$PRI.PacketLoss);  
	}

	C.SetPos(C.ClipX*0.02+ScoreOffset+DeathsOffset+XOffset, ClipYHeight*0.83 + YOffset - PlrPingFontHeight/2);

	C.DrawText(FormatTime(Max(0,FPHTime - PRI.StartTime)) );

	C.Font = PlrSmallFont;

	// Location Name
	// Hide if Player is using HUDTeamoverlay
	if (OwnerPRI.bOnlySpectator || (PRI.Team!=None && OwnerPRI.Team!=None && PRI.Team.TeamIndex==OwnerPRI.Team.TeamIndex))
	{
		C.SetDrawColor(255,150,0,255);
		C.SetPos(C.ClipX*0.02+PingOffset*1.2+ScoreOffset+DeathsOffset+XOffset, ClipYHeight+YOffset-PlrSmallFontHeight);
		OldClipX=C.ClipX;
		
		if (!PRI.bAdmin)
			C.ClipX=C.ClipX*0.470+XOffset;
		else
			C.ClipX=C.ClipX*0.467-IconOffset+XOffset;
		
		C.DrawTextClipped(PRI.GetLocationName());
		C.ClipX=OldClipX;
	}
  
		if (PRI.bAdmin)
	{
		C.SetPos(C.ClipX*0.47-IconOffset+XOffset, ClipYHeight+YOffset-PlrSmallFontHeight);
		C.SetDrawColor(255,0,0,255);
		C.DrawText("ADMIN");
	}
    
	C.SetDrawColor(255,255,255,255);
	C.Font = PlrMidFont;  
  
  // Vehicle Kills Trophy

	if ( ASPlayerReplicationInfo(PRI) != None )
	{
		ASPlayerReplicationInfo(PRI).TrophiesXOffset = 0;	// reinitialize

		if ( ASPlayerReplicationInfo(PRI).DestroyedVehicles > 0 )
		{
			TrophiesXOffset = ASPlayerReplicationInfo(PRI).TrophiesXOffset;
			ASPlayerReplicationInfo(PRI).TrophiesXOffset += 32;
			C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale, (C.ClipY*0.002)+YOffset);
			C.DrawTile( Texture'HudContent.Generic.HUD', 32*scale, 32*scale, 227, 406, 53, 42);

			// If more than one, display number...
			if ( ASPlayerReplicationInfo(PRI).DestroyedVehicles > 1 )
			{
				temp = String(ASPlayerReplicationInfo(PRI).DestroyedVehicles);
				C.StrLen( temp, XL, YL );
				C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale + 17.5*scale - XL*0.5, (C.ClipY*0.002)+YOffset + 16*scale - YL*0.5);
				C.DrawText(temp, true);
			}
		}

	}

	// Objective Disabled Trophy

	if ( ASPlayerReplicationInfo(PRI) != None )
	{
		if ( ASPlayerReplicationInfo(PRI).DisabledObjectivesCount > 0 )
		{
			TrophiesXOffset = ASPlayerReplicationInfo(PRI).TrophiesXOffset;
			ASPlayerReplicationInfo(PRI).TrophiesXOffset += 32;
			C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale, (C.ClipY*0.002)+YOffset);
			C.DrawTile( Texture'AS_FX_TX.Icons.ScoreBoard_Objective_Final', 32*scale, 32*scale, 0, 0, 128, 128);

			// If more than one, display number...
			if ( ASPlayerReplicationInfo(PRI).DisabledObjectivesCount > 1 )
			{
				temp = String(ASPlayerReplicationInfo(PRI).DisabledObjectivesCount);
				C.StrLen( temp, XL, YL );
				C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale + 17.5*scale - XL*0.5, (C.ClipY*0.002)+YOffset + 16*scale - YL*0.5);
				C.DrawText(temp, true);
			}
		}

	}

	// Round Won Trophies

	if ( ASPlayerReplicationInfo(PRI) != None )
	{
		if ( ASPlayerReplicationInfo(PRI).DisabledFinalObjective > 0 )
		{
			TrophiesXOffset = ASPlayerReplicationInfo(PRI).TrophiesXOffset;
			ASPlayerReplicationInfo(PRI).TrophiesXOffset += 32;
			C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale, (C.ClipY*0.002)+YOffset);		
			C.DrawTile( Texture'AS_FX_TX.Icons.ScoreBoard_Objective_Single', 32*scale, 32*scale, 0, 0, 128, 128);

			// If more than one, display number...
			if ( ASPlayerReplicationInfo(PRI).DisabledFinalObjective > 1 )
			{
				temp = String(ASPlayerReplicationInfo(PRI).DisabledFinalObjective);
				C.StrLen( temp, XL, YL );
				C.SetPos(C.ClipX*0.47-IconOffset+XOffset+TrophiesXOffset*scale + 17.5*scale - XL*0.5, (C.ClipY*0.002)+YOffset + 16*scale - YL*0.5);
				C.DrawText(temp, true);
			}
		}

	}
}

defaultproperties
{
     RemainingRoundTime="Remaining round time:"
     CurrentRound="Round:"
     RoundSeparator="/"
     Defender="( Defender )"
     Attacker="( Attacker )"
     WaitForReinforcements="   You were killed. Reinforcements in"
     WaitingToSpawnReinforcements="Waiting for reinforcements..."
     AutoRespawn="Automatically respawning in..."
     YouWonRound="You've won the round!"
     YouLostRound="You've lost the round."
     PracticeRoundOver="Practice round over."
}

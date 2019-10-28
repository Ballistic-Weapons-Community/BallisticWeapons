class UTComp_ScoreBoard_NEW extends UTComp_ScoreBoard_DM;

#exec TEXTURE IMPORT File=textures\UTCompLogo.TGA Name=UTCompLogo MIPS=OFF LODSET=5 ALPHA=1
#exec TEXTURE IMPORT FILE=textures\ScoreboardText_NEW.bmp Name=ScoreboardText_NEW MIPS=OFF LODSET=5

var localized string FragLimitTeam;

var float PlayerBoxScale;
var Font PlrScoreFont, PlrBigFont, PlrMidFont, PlrSmallFont, PlrPingFont;
var float PlrScoreFontHeight, PlrBigFontHeight, PlrMidFontHeight, PlrSmallFontHeight, PlrPingFontHeight;
var int PlrScoreFontType, PlrBigFontType, PlrMidFontType, PlrSmallFontType, PlrPingFontType;

var Font MainFont, NotReducedFont;

var float ScoreOffset;
var float DeathsAlign;
var float DeathsOffset;
var float PingOffset;

simulated function DrawTitle2(Canvas Canvas, float Scale)
{
  local string titlestring;
  local string scoreinfostring;
  local string RestartString;
  local float YL, TitleXL, ScoreInfoXL;
	local Font TitleFont;
	local float TitleFontHeight;
	local int TitleFontType;
	
	GetSuitableFontForHeight(Canvas, (128.0 * 0.59 * Scale) * 0.60, TitleFont, TitleFontHeight, TitleFontType);

	Canvas.Font = TitleFont;
  titlestring = GetTitleString();
  scoreinfostring = GetDefaultScoreInfoString();
 
  if ( UnrealPlayer(Owner).bDisplayLoser )
    scoreinfostring = Class'HudBase'.default.YouveLostTheMatch; 
  else if ( UnrealPlayer(Owner).bDisplayWinner )
    scoreinfostring = Class'HudBase'.default.YouveWonTheMatch;
  else if ( PlayerController(Owner).IsDead() )
  {
    RestartString = GetRestartString();
    scoreinfostring = RestartString;
  }

  Canvas.SetDrawColor(255,150,0,255);
  
  Canvas.StrLen(titlestring,TitleXL,YL);
  Canvas.SetPos(Canvas.ClipX / 2 - TitleXL / 2,(128.0 * 0.59 * Scale) - YL);
  Canvas.DrawText(titlestring);
  
  Canvas.StrLen(scoreinfostring,ScoreInfoXL,YL);
  Canvas.SetPos(Canvas.ClipX / 2 - ScoreInfoXL / 2, Canvas.ClipY - (YL * 1.02));
  Canvas.DrawText(scoreinfostring);
}

simulated function String GetRestartString()
{
	local string RestartString;

	RestartString = Restart;
	if ( PlayerController(Owner).PlayerReplicationInfo.bOutOfLives )
		RestartString = OutFireText;
	else if ( Level.TimeSeconds - UnrealPlayer(Owner).LastKickWarningTime < 2 )
		RestartString = class'GameMessage'.Default.KickWarning;
	return RestartString;
}


simulated function String GetTitleString()
{
	local string titlestring;

	if ( Level.NetMode == NM_Standalone )
	{
		if ( Level.Game.CurrentGameProfile != None )
			titlestring = SkillLevel[Clamp(Level.Game.CurrentGameProfile.BaseDifficulty,0,7)];
		else
			titlestring = SkillLevel[Clamp(Level.Game.GameDifficulty,0,7)];
	}
	else if ( (GRI != None) && (GRI.BotDifficulty >= 0) )
		titlestring = SkillLevel[Clamp( GRI.BotDifficulty,0,7)];

	return titlestring@GRI.GameName$MapName$Level.Title;
}

simulated function String GetDefaultScoreInfoString()
{
	local String ScoreInfoString;

	if ( GRI.MaxLives != 0 )
		ScoreInfoString = MaxLives@GRI.MaxLives;
	else if ( GRI.GoalScore != 0 )
	{
       if(!GRI.bTeamGame)
		   ScoreInfoString = FragLimit@GRI.GoalScore;
	   else
	       ScoreInfoString = FraglimitTeam@GRI.GoalScore;
    }
    if ( GRI.TimeLimit != 0 )
		ScoreInfoString = ScoreInfoString@spacer@TimeLimit$FormatTime(GRI.RemainingTime);
	else
		ScoreInfoString = ScoreInfoString@spacer@FooterText@FormatTime(GRI.ElapsedTime);

	return ScoreInfoString;
}

simulated function string GetAverageTeamPing(byte team)
{
	local int i;
	local float avg;
	local int NumSamples;
	
	for(i=0; i<GRI.PRIArray.Length; i++)
	{
		if(!GRI.PRIArray[i].bOnlySpectator && GRI.PRIArray[i].Team!=None && GRI.PRIArray[i].Team.TeamIndex == team)
		{
			Avg+=GRI.PRIArray[i].Ping;
			NumSamples++;
		}
	}
	
	if(NumSamples == 0)
		return "";
        
	return string(int(4.0*Avg/float(NumSamples)));
}

simulated function DrawTCMBar (Canvas C, float Scale)
{
  C.SetPos(0.0,0.0);
  C.Style = 5;
  C.SetDrawColor(255,255,255,180);
  C.DrawTileStretched(Texture'BlackTexture',C.ClipX,128.0 * 0.59 * Scale * 1.02); //add %2 percent below logo
  C.SetPos(0.0,0.0);
  C.DrawTile(Texture'UTCompLogo',512.0 * 0.75 * Scale,128.0 * 0.75 * Scale,0.0,0.0,256.0,64.0);
}

simulated function DrawPlayerInformation(Canvas C, PlayerReplicationInfo PRI, float XOffset, float YOffset, float Scale)
{
  local int otherteam;
  local PlayerReplicationInfo OwnerPRI;
  local UTComp_PRI uPRI;
  local float oldClipX;
  local float XL, YL, ClipYHeight, AdminOffset;
    
 	if(Owner != None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;

  uPRI = class'UTComp_Util'.static.GetUTCompPRI(PRI);
	ClipYHeight = C.ClipY*0.055*PlayerBoxScale;
    
  // Draw Player name
  C.Font = PlrBigFont;
  
  if (PRI.bAdmin)
  {
  	C.StrLen("ADMIN", AdminOffset, YL);
  	AdminOffset += C.ClipX*0.002;
  	C.SetPos(C.ClipX*0.470+XOffset-AdminOffset, (ClipYHeight-PlrSmallFontHeight-PlrBigFontHeight)/2+YOffset);
  	AdminOffset += C.ClipX*0.006;
  	C.SetDrawColor(255,0,0,255);
  	C.DrawText("ADMIN");
  }
  else
  	AdminOffset = 0.0;
  
  C.SetDrawColor(255,255,255,255);
  C.SetPos(C.ClipX*0.02+PingOffset+ScoreOffset+DeathsOffset+XOffset, (ClipYHeight-PlrSmallFontHeight-PlrBigFontHeight)/2+YOffset);
  oldClipX=C.ClipX;
  C.ClipX=C.ClipX*0.470+XOffset-AdminOffset;

  if(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
    C.DrawTextClipped(uPRI.ColoredName);
  else
		C.DrawTextClipped(PRI.PlayerName);
  
  C.ClipX = OldClipX;

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
    
	if(PRI.Team != None && PRI.Team.TeamIndex == 0)
		OtherTeam = 1;
	else
		OtherTeam = 0;

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
    oldClipX=C.ClipX;
    C.ClipX=C.ClipX*0.470+XOffset;
  	C.DrawTextClipped(PRI.GetLocationName());
  	C.ClipX=OldClipX;
  }
}

simulated function DrawTeamInfoBox(Canvas C,float StartX, float StartY,int TeamNum, float scale, int mPlayerCount)
{
	local int i;
	local float NewBoxYscale,NewPosY,YL, realScale;
	local bool bDraw;
	local Font oldFont;
	
	bDraw=false;
	NewBoxYscale = (( C.ClipY*0.055)*mPlayerCount*PlayerBoxScale)+C.ClipY*0.035;
	
	C.Style=5;
	
	if(TeamNum==0)
	   C.SetDrawColor(0,0,255,35);
	else if(TeamNum == 1)
	  C.SetDrawColor(255,0,0,35);
	else
	  C.SetDrawColor(150,150,150,35);
	
	// Main Colored background
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.WhiteTexture',C.ClipX*0.472,NewBoxYscale);
		
	NewPosY = (C.ClipY*(StartY+0.035));
	for(i=0;i<mPlayerCount;i++)
	{
		if(bDraw)
		{// Seperators
			bDraw=false;
			C.SetDrawColor(255,255,255,30);
			C.SetPos(C.ClipX *StartX,NewPosY);
			C.DrawTileStretched(material'Engine.WhiteTexture',C.ClipX*0.472,C.ClipY*0.055*PlayerBoxScale);
		}
		else
			bDraw=true;
		
		NewPosY += (C.ClipY*0.055*PlayerBoxScale);
	}
	
	// Trim for box
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX*0.472,1);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',1,NewBoxYscale);
	C.SetPos((C.ClipX *StartX + C.ClipX*0.472),C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',1, NewBoxYscale);
	C.SetPos(C.ClipX *StartX,(C.ClipY*StartY + NewBoxYscale));
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX*0.472,1);
	
	oldFont = C.Font;
	C.Font = PlrBigFont;
	C.StrLen("OUT ", ScoreOffset, YL);
	
	C.Font = PlrMidFont;
	C.StrLen("999 ", DeathsOffset, YL);
	C.StrLen("999", DeathsAlign, YL);
	
	C.Font = PlrPingFont;
	C.StrLen("Not Ready ", PingOffset, YL);	
	C.Font = oldFont;
	
	C.SetPos((C.ClipX *StartX + ScoreOffset + DeathsOffset),C.ClipY*StartY);	
	C.DrawTileStretched(material'Engine.BlackTexture',1,NewBoxYscale);
	
	// TitleBar
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY-C.ClipY*0.020);
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX*0.472 + 1,C.ClipY*0.055); //+1 for trim
	
	C.SetPos( C.ClipX *StartX, C.ClipY*StartY - C.ClipY*0.020);
	realScale = C.ClipY*0.055 / 64;
	C.DrawTile(Texture'ScoreboardText_NEW',(256*1.0)*realScale,(64*1.0)*realScale,0,0,256,64);
}

simulated event UpdateScoreBoard(Canvas C)
{
	local PlayerReplicationInfo PRI, OwnerPRI;
	local PlayerReplicationInfo RedPRI[MAXPLAYERS], BluePRI[MAXPLAYERS], SPecPRI[MAXPLAYERS];
	local int i, BluePlayerCount, RedPlayerCount, RedOwnerOffset, BlueOwnerOffset,maxTiles, numspecs,PlayerScaleCount;
	local float MyScale;
	local font TeamScoreFont, AvgPingFont;
	local int TeamScoreFontType, AvgPingFontType;
	local float TeamScoreFontHeight, AvgPingFontHeight;
	local float XL, YL;
	local string AvgPingText;
	local bool bOwnerDrawn;
	local float xoff, yoff;
	
	// Fonts
	MainFont     			= HUDClass.static.GetMediumFontFor(C);
	NotReducedFont  	= GetSmallerFontFor (C,1);

	maxTiles = 20;
	
	if(Owner!=None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
		
	RedOwnerOffset = -1;
	BlueOwnerOffset = -1;

  for (i=0; i<GRI.PRIArray.Length; i++)
	{
		PRI = GRI.PRIArray[i];

    if(PRI.bOnlySpectator)
    {
			if (Caps(Left(PRI.PlayerName,8)) != "WEBADMIN")
			{
				specPRI[numSpecs]=PRI;
				numSpecs++;
			}
    }
    else
		{
			if (PRI.Team == None)
			{
				if (!GRI.bTeamGame)
				{
					RedPRI[RedPlayerCount] = PRI;
					if ( PRI == OwnerPRI )
						RedOwnerOffset = RedPlayerCount;
						
					RedPlayerCount++;
				}
			}
			else if ( PRI.Team.TeamIndex == 0 )
			{
				if ( RedPlayerCount < MAXPLAYERS )
				{
					RedPRI[RedPlayerCount] = PRI;
					if ( PRI == OwnerPRI )
						RedOwnerOffset = RedPlayerCount;
					RedPlayerCount++;
				}
			}
			else 
			{
				if ( BluePlayerCount < MAXPLAYERS )
				{
					BluePRI[BluePlayerCount] = PRI;
					if ( PRI == OwnerPRI )
						BlueOwnerOffset = BluePlayerCount;
					BluePlayerCount++;
				}
			}
		}
	}

	PlayerScaleCount = Min(Max(RedPlayerCount, BluePlayerCount), maxTiles);
	PlayerBoxScale = FMin(1.0, float(28 - PlayerScaleCount) * (0.0625));

	GetSuitableFontForHeight(C, C.ClipY*0.055*PlayerBoxScale*0.80, PlrScoreFont, PlrScoreFontHeight, PlrScoreFontType);
	GetSuitableFontForHeight(C, C.ClipY*0.055*PlayerBoxScale*0.70, PlrBigFont, PlrBigFontHeight, PlrBigFontType);
	GetSuitableFontForHeight(C, C.ClipY*0.055*PlayerBoxScale*0.56, PlrMidFont, PlrMidFontHeight, PlrMidFontType);
	GetSuitableFontForHeight(C, C.ClipY*0.055*PlayerBoxScale*0.46, PlrPingFont, PlrPingFontHeight, PlrPingFontType);
	GetSuitableFontForHeight(C, C.ClipY*0.055*PlayerBoxScale*0.43, PlrSmallFont, PlrSmallFontHeight, PlrSmallFontType);
	GetSuitableFontForHeight(C, C.ClipY*0.055*0.42, StatsFont, StatsFontHeight, StatsFontType);

  MyScale = C.ClipY / 900;
  DrawTCMBar(C,MyScale);
  DrawTitle2(C,MyScale);
  
  if(GRI.bTeamGame)
  {
		DrawTeamInfoBox(C, 0.020, 0.12, 1, MyScale, Min(RedPlayerCount, maxTiles));  // RedTeam
		DrawTeamInfoBox(C, 0.514, 0.12, 0, MyScale, Min(BluePlayerCount, maxTiles)); // BlueTeam
  }
  else
		DrawTeamInfoBox(C, 0.252, 0.12, 2, MyScale, Min(RedPlayerCount, maxTiles)); // Deathmatch Team
  
  C.SetDrawColor(255,255,255,255);
	C.Font = MainFont;
	
	if ( ((FPHTime == 0) || (!UnrealPlayer(Owner).bDisplayLoser && !UnrealPlayer(Owner).bDisplayWinner))
		&& (GRI.ElapsedTime > 0) )
		FPHTime = GRI.ElapsedTime;
	
	if(GRI.bTeamGame)
	{
		GetSuitableFontForHeight(C, C.ClipY*0.055, TeamScoreFont, TeamScoreFontHeight, TeamScoreFontType);
		C.Font = TeamScoreFont;
		C.SetPos( C.ClipX*0.25 , C.ClipY*0.15 - TeamScoreFontHeight);// Red
		C.DrawText(int(GRI.Teams[0].Score));
		C.SetPos( C.ClipX*0.744 , C.ClipY*0.15 - TeamScoreFontHeight);// Blue
		C.DrawText(int(GRI.Teams[1].Score));
		
		if ( Level.NetMode != NM_Standalone )
		{
			GetSuitableFontForHeight(C, C.ClipY*0.055 * 0.60, AvgPingFont, AvgPingFontHeight, AvgPingFontType);
			C.Font = AvgPingFont;
			
			AvgPingText = "Avg ping:"@GetAverageTeamPing(0);
			C.StrLen(AvgPingText, XL, YL);
			C.SetPos(C.ClipX*0.470 - XL, C.ClipY*0.15 - AvgPingFontHeight); // Red
			C.DrawText(AvgPingText);
			
			AvgPingText = "Avg ping:"@GetAverageTeamPing(1);
			C.StrLen(AvgPingText, XL, YL);
			C.SetPos(C.ClipX*0.964 - XL, C.ClipY*0.15 - AvgPingFontHeight); // Blue
			C.DrawText(AvgPingText);
			
		}

		//reset font
		C.Font = MainFont;

		for (i = 0; i<RedPlayerCount && i < maxTiles; i++)
		{
			if(!RedPRI[i].bOnlySpectator)
			{
				if(i == (maxTiles - 1) && !bOwnerDrawn && OwnerPRI.Team != None && OwnerPRI.Team.TeamIndex==0 && !OwnerPRI.bOnlySpectator)
					DrawPlayerInformation(C, OwnerPRI, C.ClipX * 0.003, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
				else
					DrawPlayerInformation(C, RedPRI[i], C.ClipX * 0.003, C.ClipY * 0.155 + (C.ClipY * 0.055) * i *PlayerBoxScale, MyScale * PlayerBoxScale);
				
				if (RedPRI[i] == OwnerPRI)
					bOwnerDrawn = true;
			}
		}
		
		for (i = 0; i<BluePlayerCount && i < maxTiles; i++)
		{
			if(!BluePRI[i].bOnlySpectator)
			{
				if(i==(maxTiles-1) && !bOwnerDrawn && OwnerPRI.Team != None && OwnerPRI.Team.TeamIndex==1 && !OwnerPRI.bOnlySpectator)
					DrawPlayerInformation(C, OwnerPRI, C.ClipX * 0.496, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
				else
					DrawPlayerInformation(C, BluePRI[i], C.ClipX * 0.496, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
					
				if (BluePRI[i] == OwnerPRI)
					bOwnerDrawn = true;
			}
		}
	}
	else
	{
		for (i = 0; i < RedPlayerCount && i < maxTiles; i++)
		{
			if(!RedPRI[i].bOnlySpectator)
			{
				if(i == (maxTiles - 1) && !bOwnerDrawn && !OwnerPRI.bOnlySpectator)
					//	DrawTeamInfoBox(C, 0.252, 0.12, 2, MyScale, Min(RedPlayerCount, maxTiles)); // Deathmatch Team
					DrawPlayerInformation(C, OwnerPRI, C.Clipx * 0.236, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
				else
					DrawPlayerInformation(C, RedPRI[i], C.Clipx * 0.236, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
				if (RedPRI[i ]== OwnerPRI)
					bOwnerDrawn = true;
			}
		}
	}
	
	if(numSpecs>0)
  {
  	xoff = 0;
  	yoff = 0;
  	DrawSpecs(C, None, xoff, yoff);
  	
     for (i = 0; i < numspecs && specPRI[i] != None; i++)
        DrawSpecs(C, SpecPRI[i], xoff, yoff);
        
    DrawSpecs(C, None, xoff, yoff);
  }
}

defaultproperties
{
     FragLimitTeam="SCORE LIMIT:"
     PlayerBoxScale=1.000000
}

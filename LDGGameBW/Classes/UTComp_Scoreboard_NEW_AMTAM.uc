class UTComp_Scoreboard_NEW_AMTAM extends UTComp_ScoreBoard_NEW;

var Color DeadNameColor;
var Color DeadColor;

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
	
	C.Font = PlrPingFont;
	C.StrLen("0000.0 ", DeathsOffset, YL);
	C.StrLen("0000.0", DeathsAlign, YL);
	
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
	C.DrawTile(Texture'ScoreboardText_FREON',(256*1.0)*realScale,(64*1.0)*realScale,0,0,256,64);
}

simulated function DrawPlayerInformation(Canvas C, PlayerReplicationInfo PRI, float XOffset, float YOffset, float Scale)
{
  local int otherteam;
  local PlayerReplicationInfo OwnerPRI;
  local UTComp_PRI uPRI;
  local float oldClipX;
  local float XL, YL, ClipYHeight, AdminOffset;
  local int pprbig, pprsmall;
  local string pprstr;
  local float PPR;
  local bool bLiving;
    
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

  if (PRI.bOutOfLives)
	{
		C.DrawColor = DeadNameColor;
		C.DrawTextClipped(PRI.PlayerName);
  }
  else if(class'UTComp_Settings_FREON'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
    C.DrawTextClipped(uPRI.ColoredName);
  else
		C.DrawTextClipped(PRI.PlayerName);
  
  C.ClipX = OldClipX;

	if (PRI.bOutOfLives)
		C.DrawColor = DeadNameColor;
	else if (PRI == OwnerPRI)
		C.SetDrawColor(255,255,0,255);
	else
		C.SetDrawColor(255,255,255,255);

  // DrawScore
	C.Font = PlrScoreFont;
	C.SetPos(C.ClipX*0.0192+XOffset, ClipYHeight*0.5+YOffset-PlrScoreFontHeight/2);

	C.DrawText(int(PRI.Score));
    
	if(PRI.Team != None && PRI.Team.TeamIndex == 0)
		OtherTeam = 1;
	else
		OtherTeam = 0;

  C.Font = PlrPingFont;
	  
	//deaths & net & ppr  
  C.SetDrawColor(255,0,0,255);
  if (uPRI != None)
  {
	  C.StrLen(uPRI.RealDeaths, XL, YL);
	  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.2 + YOffset - PlrPingFontHeight / 2);
	  C.DrawText(uPRI.RealDeaths);
	}
	else
	{
		C.StrLen("-", XL, YL);
	  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.2 + YOffset - PlrPingFontHeight / 2);
	  C.DrawText("-");
	}
  
  C.SetDrawColor(0,200,255,255);
  if (uPRI != None)
  {
	  C.StrLen(uPRI.RealKills - uPRI.RealDeaths,XL,YL);
	  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.515 + YOffset - PlrPingFontHeight / 2);
	  C.DrawText(uPRI.RealKills - uPRI.RealDeaths);
	}
	else
	{
		C.StrLen("-",XL,YL);
	  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.515 + YOffset - PlrPingFontHeight / 2);
	  C.DrawText("-");
	}
  
	if(Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound > 0)
		PPR = PRI.Score / (Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound);
	else
		PPR = PRI.Score;
  
  pprbig = int(PPR);
  pprsmall = int(int(Abs(PPR * 10)) - 10 * Abs(pprbig));
  pprstr = string(pprbig) $ "." $ string(pprsmall);
  
  if (pprbig == 0 && PPR < 0)
  	pprstr = "-" $ pprstr;
  
  if ( PRI == OwnerPRI )
    C.SetDrawColor(225,225,0,255);
  else
    C.SetDrawColor(225,225,225,255);
  
  C.StrLen(pprstr,XL,YL);
  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.83 + YOffset - PlrPingFontHeight / 2);
  C.DrawText(pprstr);
  
         
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
  
  
  
	if(!PRI.bOutOfLives)
	{
		bLiving = true;
  	C.SetDrawColor(255,150,0,255);
  }
 	else
 	{
 		bLiving = false;
 		C.DrawColor = DeadColor;
  }
  
  if (!bLiving || OwnerPRI.bOnlySpectator || (PRI.Team!=None && OwnerPRI.Team!=None && PRI.Team.TeamIndex==OwnerPRI.Team.TeamIndex))
  {
    C.SetPos(C.ClipX*0.02+PingOffset*1.2+ScoreOffset+DeathsOffset+XOffset, ClipYHeight+YOffset-PlrSmallFontHeight);
    oldClipX=C.ClipX;
    C.ClipX=C.ClipX*0.470+XOffset;
  	C.DrawTextClipped(PRI.GetLocationName());
  	C.ClipX=OldClipX;
  }
}

defaultproperties
{
     DeadNameColor=(B=128,G=128,R=128,A=255)
     DeadColor=(R=200,A=255)
}

class UTComp_Scoreboard_NEW_SKILL_FREON extends UTComp_Scoreboard_NEW_FREON;

var bool bShowingNewSkill;
var bool bViewingSkill;

var bool bShownNewSkill, bDeranked;
var float NewSkillDataReceivedTime;

//var globalconfig bool bForceDrawSkill;

var localized string ShowSkillString, ShowNormalString, ShowNewSkillString;

simulated function DrawTitle2(Canvas Canvas, float Scale)
{
  local string titlestring, subtitlestring;
  local string scoreinfostring;
  local string RestartString;
  local float YL, TitleXL, ScoreInfoXL, SubtitleXL, SubtitleYL;
	local Font TitleFont, SubTitleFont;
	local float TitleFontHeight, SubTitleFontHeight;
	local int TitleFontType, SubTitleFontType;
	
	GetSuitableFontForHeight(Canvas, (128.0 * 0.59 * Scale) * 0.45, TitleFont, TitleFontHeight, TitleFontType);
	GetSuitableFontForHeight(Canvas, (128.0 * 0.59 * Scale) * 0.30, SubTitleFont, SubTitleFontHeight, SubTitleFontType);

	Canvas.Font = TitleFont;
  titlestring = GetTitleString();
  scoreinfostring = GetDefaultScoreInfoString();;
 
  if ( UnrealPlayer(Owner).bDisplayLoser )
    scoreinfostring = Class'HudBase'.default.YouveLostTheMatch; 
  else if ( UnrealPlayer(Owner).bDisplayWinner )
    scoreinfostring = Class'HudBase'.default.YouveWonTheMatch;
  else if ( PlayerController(Owner).IsDead() )
  {
    RestartString = GetRestartString();
    scoreinfostring = RestartString;
  }
  
  if (bShowingNewSkill)
  	subtitlestring = ShowNewSkillString;
  else if (bViewingSkill)
  	subtitlestring = ShowSkillString;
  else
  	subtitlestring = ShowNormalString;

  Canvas.SetDrawColor(255,150,0,255);
  
  Canvas.StrLen(titlestring,TitleXL,YL);
  
  Canvas.Font = SubTitleFont;
  Canvas.StrLen(subtitlestring,SubtitleXL,SubtitleYL);
  
  Canvas.Font = TitleFont;
  Canvas.SetPos(Canvas.ClipX / 2 - TitleXL / 2,(128.0 * 0.59 * Scale * 0.98) - YL - SubtitleYL);
  Canvas.DrawText(titlestring);
  
  Canvas.Font = SubTitleFont;
  Canvas.SetPos(Canvas.ClipX / 2 - SubtitleXL / 2,(128.0 * 0.59 * Scale) - SubtitleYL);
  Canvas.DrawText(subtitlestring);
  
  Canvas.Font = TitleFont;
  Canvas.StrLen(scoreinfostring,ScoreInfoXL,YL);
  Canvas.SetPos(Canvas.ClipX / 2 - ScoreInfoXL / 2, Canvas.ClipY - (YL * 1.02));
  Canvas.DrawText(scoreinfostring);
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
	
	if (bViewingSkill)
		C.DrawTile(Texture'ScoreboardText_SKILL',(256*1.0)*realScale,(64*1.0)*realScale,0,0,256,64);
	else
		C.DrawTile(Texture'ScoreboardText_FREON',(256*1.0)*realScale,(64*1.0)*realScale,0,0,256,64);
}

simulated function DrawPlayerInformation(Canvas C, PlayerReplicationInfo PRI, float XOffset, float YOffset, float Scale)
{
  local int otherteam;
  local PlayerReplicationInfo OwnerPRI;
  local UTComp_PRI_BW_FR_LDG uPRI;
  local UTComp_SRI_BW_FR_LDG uSRI;
  local float oldClipX, MyNet,PPR;
  local float XL, YL, ClipYHeight, AdminOffset;
  local int skillb, skills, netb, nets, pprbig, pprsmall;
  local string skillstr, netstr, pprstr;
  local bool bLiving;
      
 	if(Owner != None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;

  uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(PRI));
  
  if (Freon_Player_UTComp_LDG(Owner) != None)
  	uSRI = Freon_Player_UTComp_LDG(Owner).UTCompSRI;
  
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
		C.DrawColor = FrozenColor;
		C.DrawTextClipped(PRI.PlayerName);
  }
  else if(class'UTComp_Settings_FREON'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
    C.DrawTextClipped(uPRI.ColoredName);
  else
		C.DrawTextClipped(PRI.PlayerName);
  
  C.ClipX = OldClipX;

	if (PRI.bOutOfLives)
		C.DrawColor = FrozenColor;
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
  	if (bViewingSkill && uSRI != None && uSRI.ThawPointsConversionRatio > 0)
  	{
  		MyNet = (uPRI.RealKills - uPRI.RealDeaths) + (uPRI.ThawPoints / uSRI.ThawPointsConversionRatio);
  		
  		netb = int(MyNet);
		  nets = int(int(Abs(MyNet * 10)) - 10 * Abs(netb));
		  
		  netstr = string(netb) $ "." $ string(nets);
		  	
		  if (netb == 0 && MyNet < 0)
		  	netstr = "-" $ netstr;
		  		  
		  C.StrLen(netstr,XL,YL);
		  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.515 + YOffset - PlrPingFontHeight / 2);
		  C.DrawText(netstr);
  	}
  	else
  	{
		  C.StrLen(uPRI.RealKills - uPRI.RealDeaths,XL,YL);
		  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.515 + YOffset - PlrPingFontHeight / 2);
		  C.DrawText(uPRI.RealKills - uPRI.RealDeaths);
		}
	}
	else
	{
		C.StrLen("-",XL,YL);
	  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.515 + YOffset - PlrPingFontHeight / 2);
	  C.DrawText("-");
	}
  
  if ( PRI == OwnerPRI )
    C.SetDrawColor(225,225,0,255);
  else
    C.SetDrawColor(225,225,225,255);
  
  if (bViewingSkill)
  {
		if (uPRI != None)
	  {
	  	if (uPRI.bDeranked || uPRI.bHideSkill)
				skillstr = "X.XX";
	  	else
	  	{
		  	skillb = int(uPRI.Skill);
			  skills = int(int(Abs(uPRI.Skill * 100)) - 100 * Abs(skillb));
			  
			  if (skills < 10)
			  	skillstr = string(skillb) $ ".0" $ string(skills);
			  else
			  	skillstr = string(skillb) $ "." $ string(skills);
			  	
			  if (skillb == 0 && uPRI.Skill < 0)
			  	skillstr = "-" $ skillstr;
		}
		  
		  if ( PRI == OwnerPRI )
		    C.SetDrawColor(225,225,0,255);
		  else
		    C.SetDrawColor(225,225,225,255);
		  
		  C.StrLen(skillstr,XL,YL);
		  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.83 + YOffset - PlrPingFontHeight / 2);
		  C.DrawText(skillstr);
		}
		else
		{
			C.StrLen("-",XL,YL);
		  C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.83 + YOffset - PlrPingFontHeight / 2);
		  C.DrawText("-");
		}
	}
	else
	{
		if(Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound > 0)
			PPR = PRI.Score / (Misc_BaseGRI(GRI).CurrentRound - Misc_PRI(PRI).JoinRound);
		else
			PPR = PRI.Score;
  
	  pprbig = int(PPR);
	  pprsmall = int(int(Abs(PPR * 10)) - 10 * Abs(pprbig));
	  pprstr = string(pprbig) $ "." $ string(pprsmall);
	  
	  if (pprbig == 0 && PPR < 0)
	  	pprstr = "-" $ pprstr;
	  	
		C.StrLen(pprstr,XL,YL);
		C.SetPos(C.ClipX * 0.0192 + ScoreOffset + DeathsAlign - XL + XOffset,ClipYHeight * 0.83 + YOffset - PlrPingFontHeight / 2);
		C.DrawText(pprstr);
	}
       
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
  
  bLiving = true;
  
	if(!PRI.bOutOfLives)
  	C.SetDrawColor(255,150,0,255);
  else if(Freon_PRI(PRI) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo).bFrozen)
 		C.DrawColor = FrozenColor;
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

simulated function DrawSkillInfoBoxes(Canvas C,float StartX, float StartY, float scale)
{
	local byte i;
	local float NewBoxYscale,NewPosY,YL;
	//local float realScale;
	local Font oldFont;
	
	NewBoxYscale = (( C.ClipY*0.055)*4*PlayerBoxScale)+C.ClipY*0.035;
	
	C.Style=5;
	C.SetDrawColor(150,150,150,35);
	
	// Main Colored background
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.WhiteTexture',C.ClipX*0.302,NewBoxYscale);
		
	NewPosY = (C.ClipY*(StartY+0.035));
	for(i=0;i<4;i++)
	{
		if(bool(i & 1))
		{// Separators
			C.SetDrawColor(255,255,255,30);
			C.SetPos(C.ClipX *StartX,NewPosY);
			C.DrawTileStretched(material'Engine.WhiteTexture',C.ClipX* 0.302,C.ClipY*0.055*PlayerBoxScale);
		}
		NewPosY += (C.ClipY*0.055*PlayerBoxScale);
	}
	
	// Trim for box
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX* 0.302,1);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',1,NewBoxYscale);
	C.SetPos((C.ClipX *StartX + C.ClipX* 0.302),C.ClipY*StartY);
	C.DrawTileStretched(material'Engine.BlackTexture',1, NewBoxYscale);
	C.SetPos(C.ClipX *StartX,(C.ClipY*StartY + NewBoxYscale));
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX* 0.302,1);
	
	oldFont = C.Font;
	C.Font = PlrBigFont;
	C.StrLen("10. ", ScoreOffset, YL);
		
	DeathsOffset = 0;
		
	C.Font = PlrPingFont;
	C.StrLen(" ", PingOffset, YL);	
	C.Font = oldFont;
	
	// TitleBar
	C.SetDrawColor(255,255,255,255);
	C.SetPos(C.ClipX *StartX,C.ClipY*StartY-C.ClipY*0.020);
	C.DrawTileStretched(material'Engine.BlackTexture',C.ClipX* 0.302 + 1,C.ClipY*0.055); //+1 for trim
	
	/*C.SetPos( C.ClipX *StartX, C.ClipY*StartY - C.ClipY*0.020);
	realScale = C.ClipY*0.055 / 64;
	C.DrawTile(Texture'BestPlayersText',(256*1.0)*realScale,(64*1.0)*realScale,0,0,256,64);*/
}


simulated function DrawSkillInformation(Canvas C, float XOffset, float YOffset, float BoxScale, float Scale)
{
	local PlayerReplicationInfo OwnerPRI;
	local UTComp_PRI_BW_FR_LDG uPRI;
	local string CurRightString, skillstr;
	local float oldClipX;
	local float XL, YL, ClipYHeight;
	local int skillb,skills,skilldiff;
	local UTComp_SRI_BW_FR_LDG uSRI;
	
 	if(Owner != None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;

	uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(OwnerPRI));
	
	if (Freon_Player_UTComp_LDG(Owner) != None)
		uSRI = Freon_Player_UTComp_LDG(Owner).UTCompSRI;
	ClipYHeight = C.ClipY*0.055*PlayerBoxScale;
    
	// Draw Player name
	C.Font = PlrBigFont;

	C.SetDrawColor(255,255,255,255);
	
	C.SetPos(C.ClipX/2, (ClipYHeight-PlrSmallFontHeight-PlrBigFontHeight)/2+YOffset);
	if(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
	{
		C.StrLen(OwnerPRI.PlayerName, XL, YL);
		C.CurX = (C.ClipX-XL)/2;
		C.DrawText(uPRI.ColoredName);
	}
	else
	{
		C.StrLen(OwnerPRI.PlayerName, XL, YL);
		C.CurX -= XL/2;
		C.DrawText(OwnerPRI.PlayerName);
	}
	
	C.SetPos(C.ClipX*0.02+XOffset, ((ClipYHeight-PlrSmallFontHeight-PlrBigFontHeight)/2+YOffset) + (C.ClipY * 0.055 * BoxScale));
	oldClipX=C.ClipX;
	C.ClipX=C.ClipX * 0.3 +XOffset;

	C.DrawTextClipped("Skill:");
	
	if (!uPRI.bDeranked)
	{
		skillb = int(uPRI.NewSkill);
		skills = int(int(Abs(uPRI.NewSkill * 100)) - 100 * Abs(skillb));
	
		if (skills < 10)
			skillstr = string(skillb) $ ".0" $ string(skills);
		else
			skillstr = string(skillb) $ "." $ string(skills);
	
		if (skillb == 0 && uPRI.Skill < 0)
			skillstr = "-" $ skillstr;
			
		skilldiff = int(uPRI.NewSkill * 100) - int(uPRI.Skill * 100);
	
		if (skilldiff > 0)
			CurRightString = skillstr@Chr(0x1B)$Chr(32)$Chr(255)$Chr(32)$Chr(255)$"(+"$skilldiff / 100.0f$")";
		else if (skilldiff < 0)
			CurRightString = skillstr@Chr(0x1B)$Chr(255)$Chr(32)$Chr(32)$Chr(255)$"("$skilldiff / 100.0f$")";
		else 
			CurRightString = skillstr;
	}
	else
		CurRightString = "X.XX";
	
	C.StrLen(StripColor(CurRightString), XL, YL);
	C.CurX = C.ClipX -XL - (oldClipX * 0.02);
	C.DrawTextClipped(CurRightString);
	
	C.CurX = oldClipX*0.02+XOffset;
	C.CurY += C.ClipY * 0.055 * BoxScale;
	C.DrawTextClipped("Kills:");
	CurRightString = String(uPRI.KillPoints);
	C.StrLen(CurRightString, XL, YL);
	C.CurX = C.ClipX -XL - (oldClipX * 0.02);
	C.DrawTextClipped(CurRightString);
	
	C.CurX = oldClipX*0.02+XOffset;
	C.CurY += C.ClipY * 0.055 * BoxScale;
	C.DrawTextClipped("Deaths:");
	CurRightString = String(uPRI.DeathPoints);
	C.StrLen(CurRightString, XL, YL);
	C.CurX = C.ClipX -XL - (oldClipX * 0.02);
	C.DrawTextClipped(CurRightString);
	
	C.CurX = oldClipX*0.02+XOffset;
	C.CurY += C.ClipY * 0.055 * BoxScale;
	C.DrawTextClipped("Thaw Points:");
	CurRightString = String(uPRI.NewThawPoints / uSRI.ThawPointsConversionRatio);
	C.StrLen(CurRightString, XL, YL);
	C.CurX = C.ClipX -XL - (oldClipX * 0.02);
	C.DrawTextClipped(CurRightString);
  
	C.ClipX = OldClipX;	  
}

simulated function CheckNewSkill()
{
	local PlayerReplicationInfo OwnerPRI;
	local UTComp_PRI_BW_FR_LDG OwnerUPRI;
	
	if (!bShownNewSkill)
	{	
		if(Owner != None)
			OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
		
		if (OwnerPRI != None)
			OwnerUPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(OwnerPRI));
			
		if (OwnerUPRI.bDeranked || OwnerUPRI.bHideSkill)
		{
			if (OwnerUPRI.bDeranked)
				bDeranked = true;
			return;
		}
		
		if (NewSkillDataReceivedTime == 0 && OwnerUPRI != None)
		{	
			if (OwnerUPRI.NewSkillReceiver)
				NewSkillDataReceivedTime = Level.TimeSeconds;
		}

		if ((NewSkillDataReceivedTime != 0) && (Level.TimeSeconds - NewSkillDataReceivedTime) > 10)
		{
			if (PlayerController(Owner).myHUD != None)
				PlayerController(Owner).myHUD.bShowScoreboard = true;
			
			bShowingNewSkill = true;
			bShownNewSkill = true;
		}
	}
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
	local string AvgPingText, AvgSkillText;
	local bool bOwnerDrawn;
	local float xoff, yoff;
	local UTComp_PRI_BW_FR_LDG OwnerUPRI;
	
	// Fonts
	MainFont     			= HUDClass.static.GetMediumFontFor(C);
	NotReducedFont  	= GetSmallerFontFor (C,1);

	maxTiles = 20;
	
	if(Owner != None)
		OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
	
	if (OwnerPRI != None)
		OwnerUPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(OwnerPRI));
			
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
  
	if (bShowingNewSkill && OwnerUPRI != None) // || bForceDrawSkill)
		DrawSkillInfoBoxes(C, 0.349, 0.37, MyScale);
	else if(GRI.bTeamGame)
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
	
	if (!bShowingNewSkill || OwnerUPRI == None)// && !bForceDrawSkill)
	{
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
				if (bViewingSkill) //show both Avg.Skill and Avg.Ping
				{
					GetSuitableFontForHeight(C, C.ClipY*0.055 * 0.45, AvgPingFont, AvgPingFontHeight, AvgPingFontType);
					C.Font = AvgPingFont;
					
					AvgSkillText = "Avg skill:"@GetAverageTeamSkill(0);
					C.StrLen(AvgSkillText, XL, YL);
					C.SetPos(C.ClipX*0.470 - XL, C.ClipY*0.13 - AvgPingFontHeight); // Red
					C.DrawText(AvgSkillText);
					
					AvgSkillText = "Avg skill:"@GetAverageTeamSkill(1);
					C.StrLen(AvgSkillText, XL, YL);
					C.SetPos(C.ClipX*0.964 - XL, C.ClipY*0.13 - AvgPingFontHeight); // Blue
					C.DrawText(AvgSkillText);
					
					AvgPingText = "Avg ping:"@GetAverageTeamPing(0);
					C.StrLen(AvgPingText, XL, YL);
					C.SetPos(C.ClipX*0.470 - XL, C.ClipY*0.15 - AvgPingFontHeight); // Red
					C.DrawText(AvgPingText);
					
					AvgPingText = "Avg ping:"@GetAverageTeamPing(1);
					C.StrLen(AvgPingText, XL, YL);
					C.SetPos(C.ClipX*0.964 - XL, C.ClipY*0.15 - AvgPingFontHeight); // Blue
					C.DrawText(AvgPingText);
				}
				
				else
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
						DrawPlayerInformation(C, OwnerPRI, C.Clipx * 0.236, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
					else
						DrawPlayerInformation(C, RedPRI[i], C.Clipx * 0.236, C.ClipY * 0.155 + (C.ClipY * 0.055) * i * PlayerBoxScale, MyScale * PlayerBoxScale);
					if (RedPRI[i ]== OwnerPRI)
						bOwnerDrawn = true;
				}
			}
		}
	}
	
	else
		DrawSkillInformation(C, C.ClipX * 0.35, C.ClipY * 0.362, PlayerBoxScale, MyScale * PlayerBoxScale);
	
	if(numSpecs > 0)
  {
  	xoff = 0;
  	yoff = 0;
  	DrawSpecs(C, None, xoff, yoff);
  	
     for (i = 0; i < numspecs && specPRI[i] != None; i++)
        DrawSpecs(C, SpecPRI[i], xoff, yoff);
        
    DrawSpecs(C, None, xoff, yoff);
  }
}

simulated function string GetAverageTeamSkill(byte team)
{
	local int i;
	local float avg;
	local int NumSamples;
	local int skillb, skills;
	local String skillstr;
	local UTComp_PRI_BW_FR_LDG uPRI;
	
	for(i = 0; i < GRI.PRIArray.Length; i++)
	{
		if(!GRI.PRIArray[i].bOnlySpectator && GRI.PRIArray[i].Team!=None && GRI.PRIArray[i].Team.TeamIndex == team)
		{
			uPRI = UTComp_PRI_BW_FR_LDG(class'UTComp_Util'.static.GetUTCompPRI(GRI.PRIArray[i]));
			if (uPRI != None && uPRI.Skill != 0.0f)
			{
				Avg += (uPRI.Skill / (10 - uPRI.Skill)); //Convert to K/D + TP form (yeah, I know) reductio ad absurdum: 8.xx + 2.xx > 2* 5.xx
				NumSamples++;
			}
		}
	}
	
	if(NumSamples == 0)
		return "";

	Avg /= NumSamples;
	Avg = Avg / (Avg + 1);
	Avg *= 10;
	
	skillb = int(Avg);
	skills = int(int(Abs(Avg * 100)) - 100 * Abs(skillb));
			  
	if (skills < 10)
		skillstr = string(skillb) $ ".0" $ string(skills);
	else
		skillstr = string(skillb) $ "." $ string(skills);

	if (skillb == 0 && uPRI.Skill < 0)
		skillstr = "-" $ skillstr;
        
	return skillstr;
}

defaultproperties
{
     ShowSkillString="Viewing in skill mode (NET includes thaw points)"
     ShowNormalString="Viewing in normal mode (NET doesn't include thaw points)"
     ShowNewSkillString="Viewing your skill data"
}

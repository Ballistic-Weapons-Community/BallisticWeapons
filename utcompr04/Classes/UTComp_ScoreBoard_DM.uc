class UTComp_ScoreBoard_DM extends ScoreBoardDeathMatch;

var Font SmallerFont;
var Font StatsFont;
var float StatsFontHeight;
var int StatsFontType;

simulated function GetSuitableFontForHeight(Canvas C, float maxHeight, out Font F, out float fontHeight, out int Type)
{
	local int i;
	local Font F2, Orig;
	local float XL,YL;
	
	Orig = C.Font;
	
	for (i = 10; i >= 0; i--)
	{
		F2 = GetSmallerFontFor(C,i);
		C.Font = F2;
		C.StrLen("X", XL, YL);

		if (YL >= maxHeight)
			break;
			
		F = F2;
		fontHeight = YL;
		Type = i;
	}
	
	C.Font = Orig;
}

simulated function string StripColor(string s)
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

simulated function DrawColoredNameCorrectly(Canvas C, string PlayerName)
{
	local Color Col, OldCol;
	local float OrigY;
	local string Str, CutStr, EscapeCode;
	local int t;
	
	EscapeCode = Chr(0x1B);
	CutStr = PlayerName;
	OrigY = C.CurY;
	OldCol = C.DrawColor;
	C.SetDrawColor(255,255,255,255);
	
	while (true)
	{	
		t = InStr(CutStr, EscapeCode);
		
		if (t == -1)
		{
		 	if (CutStr != "")
		 		C.DrawText(CutStr, false);
		 			 	
		 	break;
		}
				
		Str = Mid(CutStr,0,t);
		
		if (Str != "")
		{
			C.DrawText(Str, false);
			
			//check if we are on the beginning of a new line
			if (C.CurX > 0)
				C.CurY = OrigY;
			else
				OrigY = C.CurY;
		}
		
		Col.R=Asc(Mid(CutStr,t+1,1));
		Col.G=Asc(Mid(CutStr,t+2,1));
		Col.B=Asc(Mid(CutStr,t+3,1));
		Col.A=255;
		
		C.DrawColor = Col;
		CutStr = Mid(CutStr, t+4);
	}
	
	C.DrawColor = OldCol;	
}

simulated event UpdateScoreBoard(Canvas Canvas)
{
	local PlayerReplicationInfo PRI, OwnerPRI;
	local int i, FontReduction, OwnerPos, NetXPos, PlayerCount,HeaderOffsetY,HeadFoot, MessageFoot, PlayerBoxSizeY, BoxSpaceY, NameXPos, BoxTextOffsetY, OwnerOffset, ScoreXPos, DeathsXPos, BoxXPos, TitleYPos, BoxWidth;
	local float XL,YL, MaxScaling;
	local float deathsXL, scoreXL, netXL, MaxNamePos, LongestNameLength;
	local string playername[MAXPLAYERS], LongestName;
	local bool bNameFontReduction;
	local font ReducedFont;
	local int numSpecs;
	local array<playerreplicationinfo> specpri;
	local UTComp_PRI uPRI;
	local float xoff, yoff;

	OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
  for (i=0; i<GRI.PRIArray.Length; i++)
	{
		PRI = GRI.PRIArray[i];
		if ( !PRI.bOnlySpectator && (!PRI.bIsSpectator || PRI.bWaitingPlayer) )
		{
			if ( PRI == OwnerPRI )
				OwnerOffset = i;
			PlayerCount++;
		}
	}
	
	PlayerCount = Min(PlayerCount,MAXPLAYERS);
   SmallerFont  = GetSmallerFontFor (Canvas,4);
  GetSuitableFontForHeight(Canvas, Canvas.ClipY*0.055*0.42, StatsFont, StatsFontHeight, StatsFontType);
	// Select best font size and box size to fit as many players as possible on screen
	Canvas.Font = HUDClass.static.GetMediumFontFor(Canvas);
	Canvas.StrLen("Test", XL, YL);
	BoxSpaceY = 0.25 * YL;
	PlayerBoxSizeY = 1.4 * YL;
	HeadFoot = 5*YL;
	MessageFoot = 1.4 * HeadFoot;
	if ( PlayerCount > (Canvas.clipy*0.80 - 1.4 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
	{
		BoxSpaceY = 0.125 * YL;
		PlayerBoxSizeY = 1.25 * YL;
		if ( PlayerCount > (Canvas.clipy*0.80 - 1.4 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
		{
			if ( PlayerCount > (Canvas.clipy*0.80 - 1.4 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
				PlayerBoxSizeY = 1.125 * YL;
			if ( PlayerCount > (Canvas.clipy*0.80 - 1.4 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
			{
				FontReduction++;
				Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
				Canvas.StrLen("Test", XL, YL);
				BoxSpaceY = 0.125 * YL;
				PlayerBoxSizeY = 1.125 * YL;
				HeadFoot = 5*YL;
				if ( PlayerCount > (Canvas.clipy*0.80 - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
				{
					FontReduction++;
					Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
					Canvas.StrLen("Test", XL, YL);
					BoxSpaceY = 0.125 * YL;
					PlayerBoxSizeY = 1.125 * YL;
					HeadFoot = 5*YL;
					if ( (Canvas.ClipY >= 768) && (PlayerCount > (Canvas.clipy*0.80 - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY)) )
					{
						FontReduction++;
						Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
						Canvas.StrLen("Test", XL, YL);
						BoxSpaceY = 0.125 * YL;
						PlayerBoxSizeY = 1.125 * YL;
						HeadFoot = 5*YL;
					}
				}
			}
		}
	}
	if ( Canvas.ClipX < 512 )
		PlayerCount = Min(PlayerCount, 1+(Canvas.ClipY - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) );
	else
		PlayerCount = Min(PlayerCount, (Canvas.ClipY - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) );
	if ( OwnerOffset >= PlayerCount )
		PlayerCount -= 1;

	if ( FontReduction > 2 )
		MaxScaling = 3;
	else
		MaxScaling = 2.125;
	PlayerBoxSizeY = FClamp((1+(Canvas.clipy*0.80 - 0.67 * MessageFoot))/PlayerCount - BoxSpaceY, PlayerBoxSizeY, MaxScaling * YL);

  HeaderOffsetY = 3 * YL;
	BoxWidth = 0.9375 * Canvas.ClipX;
	BoxXPos = 0.5 * (Canvas.ClipX - BoxWidth);
	BoxWidth = Canvas.ClipX - 2*BoxXPos;
	NameXPos = BoxXPos + 0.0625 * BoxWidth;
	ScoreXPos = BoxXPos + 0.5 * BoxWidth;
	DeathsXPos = BoxXPos + 0.6875 * BoxWidth;
	NetXPos = BoxXPos + 0.8125 * BoxWidth;

	// draw background boxes
	Canvas.Style = ERenderStyle.STY_Alpha;
	Canvas.DrawColor = HUDClass.default.WhiteColor * 0.5;
	for ( i=0; i<PlayerCount; i++ )
	{
		Canvas.SetPos(BoxXPos, HeaderOffsetY + (PlayerBoxSizeY + BoxSpaceY)*i);
		Canvas.DrawTileStretched( BoxMaterial, BoxWidth, PlayerBoxSizeY);
	}
	Canvas.Style = ERenderStyle.STY_Translucent;

	// draw title
	Canvas.Style = ERenderStyle.STY_Normal;
	DrawTitle(Canvas, HeaderOffsetY, (PlayerCount+1)*(PlayerBoxSizeY + BoxSpaceY), PlayerBoxSizeY);

	// Draw headers
	TitleYPos = HeaderOffsetY - 1.25*YL;
	Canvas.StrLen(PointsText, ScoreXL, YL);
	Canvas.StrLen(DeathsText, DeathsXL, YL);

	Canvas.DrawColor = HUDClass.default.WhiteColor;
	Canvas.SetPos(NameXPos, TitleYPos);
	Canvas.DrawText(PlayerText,true);
	Canvas.SetPos(ScoreXPos - 0.5*ScoreXL, TitleYPos);
	Canvas.DrawText(PointsText,true);
	Canvas.SetPos(DeathsXPos - 0.5*DeathsXL, TitleYPos);
	Canvas.DrawText(DeathsText,true);

	if ( PlayerCount <= 0 )
		return;

	// draw player names
	MaxNamePos = 0.9 * (ScoreXPos - NameXPos);
	for ( i=0; i<PlayerCount; i++ )
	{
		uPRI=class'UTComp_Util'.Static.GetUTCompPRI(GRI.PRIArray[i]);
        if(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard==True)
        {
           playername[i] = uPRI.ColoredName;
           if(PlayerName[i]=="")
              PlayerName[i]=GRI.PRIArray[i].PlayerName;
        }
        else
            playername[i] = GRI.PRIArray[i].PlayerName;
		Canvas.StrLen(StripColor(playername[i]), XL, YL);
		if ( XL > FMax(LongestNameLength,MaxNamePos) )
		{
			LongestName = StripColor(PlayerName[i]);
			LongestNameLength = XL;
		}
	}
	if ( OwnerOffset >= PlayerCount )
	{
		uPRI=class'UTComp_Util'.Static.GetUTCompPRI(GRI.PRIArray[OwnerOffset]);
        if(class'UTComp_SCoreBoard'.default.bEnableColoredNamesOnScoreboard==True)
        {
           playername[OwnerOffset] = uPRI.ColoredName;
           if(PlayerName[OwnerOffset]=="")
              PlayerName[OwnerOffset]=GRI.PRIArray[OwnerOffset].PlayerName;
        }
        else
            playername[OwnerOffset] = GRI.PRIArray[OwnerOffset].PlayerName;
		Canvas.StrLen(StripColor(playername[OwnerOffset]), XL, YL);
		if ( XL > FMax(LongestNameLength,MaxNamePos) )
		{
			LongestName = StripColor(PlayerName[i]);
			LongestNameLength = XL;
		}
	}

	if ( LongestNameLength > 0 )
	{
		bNameFontReduction = true;
		Canvas.Font = GetSmallerFontFor(Canvas,FontReduction+1);
		Canvas.StrLen(LongestName, XL, YL);
		if ( XL > MaxNamePos )
		{
			Canvas.Font = GetSmallerFontFor(Canvas,FontReduction+2);
			Canvas.StrLen(LongestName, XL, YL);
			if ( XL > MaxNamePos )
				Canvas.Font = GetSmallerFontFor(Canvas,FontReduction+3);
		}
		ReducedFont = Canvas.Font;
	}

	for ( i=0; i<PlayerCount; i++ )
	{
		uPRI=class'UTComp_Util'.Static.GetUTCompPRI(GRI.PRIArray[i]);
        if(class'UTComp_SCoreBoard'.default.bEnableColoredNamesOnScoreboard==True)
        {
           playername[i] = uPRI.ColoredName;
           if(PlayerName[i]=="")
              PlayerName[i]=GRI.PRIArray[i].PlayerName;
        }
        else
            playername[i] = GRI.PRIArray[i].PlayerName;

	}
	if ( OwnerOffset >= PlayerCount )
	{
		uPRI=class'UTComp_Util'.Static.GetUTCompPRI(GRI.PRIArray[OwnerOffset]);
        if(class'UTComp_SCoreBoard'.default.bEnableColoredNamesOnScoreboard==True)
        {
           playername[OwnerOffset] = uPRI.ColoredName;
           if(PlayerName[OwnerOffset]=="")
              PlayerName[OwnerOffset]=GRI.PRIArray[OwnerOffset].PlayerName;
        }
        else
            playername[OwnerOffset] = GRI.PRIArray[OwnerOffset].PlayerName;
		}

	Canvas.Style = ERenderStyle.STY_Normal;
	Canvas.DrawColor = HUDClass.default.WhiteColor;
	Canvas.SetPos(0.5 * Canvas.ClipX, HeaderOffsetY + 4);
	BoxTextOffsetY = HeaderOffsetY + 0.5 * (PlayerBoxSizeY - YL);

	Canvas.DrawColor = HUDClass.default.WhiteColor;
	for ( i=0; i<PlayerCount; i++ )
		if ( i != OwnerOffset )
		{
			Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
			DrawColoredNameCorrectly(Canvas, playername[i]);
		}
	if ( bNameFontReduction )
		Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);

	// draw scores
	Canvas.DrawColor = HUDClass.default.WhiteColor;
	for ( i=0; i<PlayerCount; i++ )
		if ( i != OwnerOffset )
		{
			Canvas.SetPos(ScoreXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
			if ( GRI.PRIArray[i].bOutOfLives )
				Canvas.DrawText(OutText,true);
			else
				Canvas.DrawText(int(GRI.PRIArray[i].Score),true);
		}

	// draw deaths
	Canvas.DrawColor = HUDClass.default.WhiteColor;
	for ( i=0; i<PlayerCount; i++ )
		if ( i != OwnerOffset )
		{
			Canvas.SetPos(DeathsXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
			Canvas.DrawText(int(GRI.PRIArray[i].Deaths),true);
		}

	// draw owner line
	if ( OwnerOffset >= PlayerCount )
	{
		OwnerPos = (PlayerBoxSizeY + BoxSpaceY)*PlayerCount + BoxTextOffsetY;
		// draw extra box
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.DrawColor = HUDClass.default.TurqColor * 0.5;
		Canvas.SetPos(BoxXPos, HeaderOffsetY + (PlayerBoxSizeY + BoxSpaceY)*PlayerCount);
		Canvas.DrawTileStretched( BoxMaterial, BoxWidth, PlayerBoxSizeY);
		Canvas.Style = ERenderStyle.STY_Normal;
	}
	else
		OwnerPos = (PlayerBoxSizeY + BoxSpaceY)*OwnerOffset + BoxTextOffsetY;

	Canvas.DrawColor = HUDClass.default.GoldColor;
	Canvas.SetPos(NameXPos, OwnerPos);
	if ( bNameFontReduction )
		Canvas.Font = ReducedFont;
		
	DrawColoredNameCorrectly(Canvas, playername[OwnerOffset]);
	if ( bNameFontReduction )
		Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
    Canvas.DrawColor = HUDClass.default.GoldColor;
    Canvas.SetPos(ScoreXPos, OwnerPos);
	if ( GRI.PRIArray[OwnerOffset].bOutOfLives )
		Canvas.DrawText(OutText,true);
	else
		Canvas.DrawText(int(GRI.PRIArray[OwnerOffset].Score),true);
	Canvas.SetPos(DeathsXPos, OwnerPos);
	Canvas.DrawText(int(GRI.PRIArray[OwnerOffset].Deaths),true);

	for ( i=0; i<GRI.PRIArray.Length; i++ )
  {
  	PRIArray[i] = GRI.PRIArray[i];
    if(PRIArray[i].bOnlySpectator && Caps(Left(PRIArray[i].PlayerName,8)) != "WEBADMIN")
    {
			SpecPRI[SpecPRI.Length]=PRIArray[i];
			numSpecs++;
    }
  }
  
  if(numSpecs>0)
  {
  	xoff = 0;
  	yoff = 0;
  	
  	DrawSpecs(Canvas, None, xoff, yoff);
  	
		for (i = 0; i < numspecs && specPRI[i] != None; i++)
			DrawSpecs(Canvas, SpecPRI[i], xoff, yoff);
        
		DrawSpecs(Canvas, None, xoff, yoff);    
  }

  ExtraMarking(Canvas, PlayerCount, OwnerOffset, NameXPos, PlayerBoxSizeY + BoxSpaceY, BoxTextOffsetY);

	if ( Level.NetMode == NM_Standalone )
		return;

	Canvas.StrLen(NetText, NetXL, YL);
	Canvas.DrawColor = HUDClass.default.WhiteColor;
	Canvas.SetPos(NetXPos + 0.5*NetXL, TitleYPos);
	Canvas.DrawText(NetText,true);

    for ( i=0; i<GRI.PRIArray.Length; i++ )
    {
    	PRIArray[i] = GRI.PRIArray[i];
    }
	DrawNetInfo(Canvas,FontReduction,HeaderOffsetY,PlayerBoxSizeY,BoxSpaceY,BoxTextOffsetY,OwnerOffset,PlayerCount,NetXPos);
	DrawMatchID(Canvas,FontReduction);
}

simulated function PlayerReplicationInfo GetPRI(UTComp_PRI uPRI)
{
  local int i;

  for ( i = 0; i < GRI.PRIArray.Length; i++ )
  {
    if ( Class'UTComp_Util'.static.GetUTCompPRI(GRI.PRIArray[i]) == uPRI )
      return GRI.PRIArray[i];
  }
  
  return None;
}

simulated function DrawSpecs(Canvas C, PlayerReplicationInfo PRI, out float xoff, out float yoff)
{
  local string DrawText, MesText;
  local float BoxSizeX, BoxSizeY, StartPosX, StartPosY;
  local float MesTextLengthX, MesTextLengthY;
  local float bordersize;
  local UTComp_PRI uPRI;

  if ( C.SizeX < 630 )
    return;
  
  C.Font = StatsFont; 
  	
  C.StrLen(" 100% / 100%",BoxSizeX,BoxSizeY);
  StartPosX = C.ClipX * 0.005;
  StartPosY = C.ClipY * 0.9152 - 3.5*BoxSizeY;
  bordersize =  C.ClipY * 0.001;
  if (PRI == None)
  {
  	if (xoff == 0 && yoff == 0)
  	{
	  	C.SetDrawColor(255,255,255,255); 
	    DrawText = "Spectators";
	    C.TextSize(DrawText, MesTextLengthX, MesTextLengthY);    
	    C.SetPos(StartPosX, StartPosY + BoxSizeY);
	    C.DrawTileStretched(Texture'WhiteTexture', MesTextLengthX, bordersize);
	    
	    C.SetDrawColor(10,10,10,155); 
		  C.SetPos(StartPosX - C.ClipX * 0.0025,StartPosY);
		  C.DrawTileStretched(Texture'WhiteTexture', MesTextLengthX + 2 * C.ClipX * 0.0025, BoxSizeY + bordersize);
		  C.SetDrawColor(255,255,255,255);
		  C.SetPos(StartPosX,StartPosY);
		  C.DrawText(DrawText);
		  
		  xoff = 0;
		  yoff = BoxSizeY + bordersize;
		}
		else
		{
			C.SetDrawColor(10,10,10,155); 
			C.SetPos(StartPosX + xoff, StartPosY + yoff);
    	C.DrawTileStretched(Texture'WhiteTexture',C.ClipX * 0.0025,BoxSizeY);
		}
  } 
  else 
  {
    MesText = PRI.PlayerName;
    uPRI = Class'UTComp_Util'.static.GetUTCompPRI(PRI);
    
    if (class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard && uPRI != None && uPRI.ColoredName != "")
    	DrawText = uPRI.ColoredName;
    else
    	DrawText = PRI.PlayerName;
    	
    if (xoff == 0)    	
    	C.TextSize(MesText, MesTextLengthX, MesTextLengthY);
    else
    	C.TextSize(", " $ MesText, MesTextLengthX, MesTextLengthY);
    
    C.SetDrawColor(10,10,10,155);
    if (StartPosX + xoff + MesTextLengthX >= C.ClipX * 0.9975)
    {
    	C.SetPos(StartPosX + xoff, StartPosY + yoff);
    	C.DrawTileStretched(Texture'WhiteTexture',MesTextLengthX + C.ClipX * 0.0025,MesTextLengthY);
    	
    	yoff += BoxSizeY + bordersize;
    	xoff = 0;
    	
    	C.TextSize(MesText, MesTextLengthX, MesTextLengthY);
    }
     
    if (xoff == 0)
    {
    	C.SetPos(StartPosX + xoff - C.ClipX * 0.0025, StartPosY + yoff);
    	C.DrawTileStretched(Texture'WhiteTexture',MesTextLengthX + C.ClipX * 0.0025,MesTextLengthY);
    }
    else
    {
    	C.SetPos(StartPosX + xoff, StartPosY + yoff);
    	C.DrawTileStretched(Texture'WhiteTexture',MesTextLengthX,MesTextLengthY);
    }
    
    C.SetDrawColor(255,255,255,255);
    C.SetPos(StartPosX + xoff, StartPosY + yoff);
    
    if (xoff == 0)
    	DrawColoredNameCorrectly(C, DrawText);
    else
    	DrawColoredNameCorrectly(C, ", "$DrawText);
    	
    xoff += MesTextLengthX;
  }
}

defaultproperties
{
}

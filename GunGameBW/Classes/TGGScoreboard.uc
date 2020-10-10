class TGGScoreboard extends ScoreBoardTeamDeathMatch;

var byte VictoryCondition;
var bool bInit;

function String GetDefaultScoreInfoString()
{
     local String ScoreInfoString;

     if ( GRI == None )
          return "";
     else if ( VictoryCondition == 1 )
          ScoreInfoString = FragLimit@GRI.GoalScore;
     else if ( VictoryCondition == 0 )
          ScoreInfoString = "HIGHEST LEVEL:"@GunGameGRI(GRI).HighestLevel;
     else if ( VictoryCondition == 2 )
          ScoreInfoString = MaxLives@GRI.MaxLives;

     if ( GRI.TimeLimit != 0 )
          ScoreInfoString = ScoreInfoString@spacer@TimeLimit$FormatTime(GRI.RemainingTime);
     else
          ScoreInfoString = ScoreInfoString@spacer@FooterText@FormatTime(GRI.ElapsedTime);

     return ScoreInfoString;
}

function DrawTeam(int TeamNum, int PlayerCount, int OwnerOffset, Canvas Canvas, int FontReduction, int BoxSpaceY, int PlayerBoxSizeY, int HeaderOffsetY)
{
     local int i, OwnerPos, NetXPos, NameXPos, BoxTextOffsetY, ScoreXPos, ScoreYPos, BoxXPos, BoxWidth, LineCount,NameY;
     local float XL,YL,IconScale,ScoreBackScale,ScoreYL,MaxNamePos,LongestNameLength, oXL, oYL;
     local string PlayerName[MAXPLAYERS], OrdersText, LongestName;
     local font MainFont, ReducedFont;
     local bool bHaveHalfFont, bNameFontReduction;
     local int SymbolUSize, SymbolVSize, OtherTeam, LastLine;

     if ( !bInit )
     {
          if ( GunGameGRI(GRI) != None )
          {
               VictoryCondition = GunGameGRI(GRI).VictoryCondition;

               switch (VictoryCondition)
               {
                    case 0:  PointsText = "GUNLEVEL";
                             break;
                    case 1:  PointsText = "SCORE";
                             break;
                    case 2:  PointsText = "LIVES";
               }

               bInit = true;
          }
     }
	
     BoxWidth = 0.47 * Canvas.ClipX;
     BoxXPos = 0.5 * (0.5 * Canvas.ClipX - BoxWidth);
     BoxWidth = 0.5 * Canvas.ClipX - 2*BoxXPos;
     BoxXPos = BoxXPos + TeamNum * 0.5 * Canvas.ClipX;
     NameXPos = BoxXPos + 0.05 * BoxWidth;
     ScoreXPos = BoxXPos + 0.55 * BoxWidth;
     NetXPos = BoxXPos + 0.76 * BoxWidth;
     bHaveHalfFont = HaveHalfFont(Canvas, FontReduction);

     // draw background box
     Canvas.Style = ERenderStyle.STY_Alpha;
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     Canvas.SetPos(BoxXPos, HeaderOffsetY);
     Canvas.DrawTileStretched( TeamBoxMaterial[TeamNum], BoxWidth, PlayerCount * (PlayerBoxSizeY + BoxSpaceY));

     // draw team header
     IconScale = Canvas.ClipX/4096;
     ScoreBackScale = Canvas.ClipX/1024;
     if ( GRI.TeamSymbols[TeamNum] != None )
     {
          SymbolUSize = GRI.TeamSymbols[TeamNum].USize;
          SymbolVSize = GRI.TeamSymbols[TeamNum].VSize;
     }
     else
     {
          SymbolUSize = 256;
          SymbolVSize = 256;
     }
     ScoreYPos = HeaderOffsetY - SymbolVSize * IconScale - BoxSpaceY;

     Canvas.DrawColor = 0.75 * HUDClass.default.WhiteColor;
     Canvas.SetPos(BoxXPos, ScoreYPos - BoxSpaceY);
     Canvas.DrawTileStretched( Material'InterfaceContent.ScoreBoxA', BoxWidth, HeaderOffsetY + BoxSpaceY - ScoreYPos);

     Canvas.Style = ERenderStyle.STY_Normal;
     Canvas.DrawColor = TeamColors[TeamNum];
     Canvas.SetPos((0.25 + 0.5*TeamNum) * Canvas.ClipX - (SymbolUSize + 32) * IconScale, ScoreYPos);
     if ( GRI.TeamSymbols[TeamNum] != None )
          Canvas.DrawIcon(GRI.TeamSymbols[TeamNum],IconScale);
     MainFont = Canvas.Font;
     Canvas.Font = HUDClass.static.LargerFontThan(MainFont);
     Canvas.StrLen("TEST",XL,ScoreYL);
     if ( ScoreYPos == 0 )
          ScoreYPos = HeaderOffsetY - ScoreYL;
     else
          ScoreYPos = ScoreYPos + 0.5 * SymbolVSize * IconScale - 0.5 * ScoreYL;
     Canvas.SetPos((0.25 + 0.5*TeamNum) * Canvas.ClipX + 32*IconScale,ScoreYPos);
     if ( VictoryCondition == 1 )
          Canvas.DrawText(int(GRI.Teams[TeamNum].Score));
     else
     {
          if ( TeamNum == 0 )
               Canvas.DrawText("Red");
          else
               Canvas.DrawText("Blue");
     }
     Canvas.Font = MainFont;
     Canvas.DrawColor = HUDClass.default.WhiteColor;

     IconScale = Canvas.ClipX/1024;

     if ( PlayerCount <= 0 )
          return;

     // draw lines between sections
     if ( TeamNum == 0 )
          Canvas.DrawColor = HUDClass.default.RedColor;
     else
          Canvas.DrawColor = HUDClass.default.BlueColor;
     if ( OwnerOffset >= PlayerCount )
          LastLine = PlayerCount+1;
     else
          LastLine = PlayerCount;
     for ( i=1; i<LastLine; i++ )
     {
          Canvas.SetPos( NameXPos, HeaderOffsetY + (PlayerBoxSizeY + BoxSpaceY)*i - 0.5*BoxSpaceY);
          Canvas.DrawTileStretched( Material'InterfaceContent.ButtonBob', 0.9*BoxWidth, ScorebackScale*3); 
     }
     Canvas.DrawColor = HUDClass.default.WhiteColor;
		
     // draw player names
     MaxNamePos = 0.95 * (ScoreXPos - NameXPos);
     for ( i=0; i<PlayerCount; i++ )
     {
          playername[i] = GRI.PRIArray[i].PlayerName;
          Canvas.StrLen(playername[i], XL, YL);
          if ( XL > FMax(LongestNameLength,MaxNamePos) )
          {
               LongestName = PlayerName[i];
               LongestNameLength = XL;
          }
     }
     if ( OwnerOffset >= PlayerCount )
     {
          playername[OwnerOffset] = GRI.PRIArray[OwnerOffset].PlayerName;
          Canvas.StrLen(playername[OwnerOffset], XL, YL);
          if ( XL > FMax(LongestNameLength,MaxNamePos) )
          {
               LongestName = PlayerName[i];
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
          playername[i] = PRIArray[i].PlayerName;
          Canvas.StrLen(playername[i], XL, YL);
          if ( XL > MaxNamePos )
               playername[i] = left(playername[i], MaxNamePos/XL * len(PlayerName[i]));
     }
     if ( OwnerOffset >= PlayerCount )
     {
          playername[OwnerOffset] = PRIArray[OwnerOffset].PlayerName;
          Canvas.StrLen(playername[OwnerOffset], XL, YL);
          if ( XL > MaxNamePos )
               playername[OwnerOffset] = left(playername[OwnerOffset], MaxNamePos/XL * len(PlayerName[OwnerOffset]));
     }

     if ( Canvas.ClipX < 512 )
          NameY = 0.5 * YL;
     else if ( !bHaveHalfFont )
          NameY = 0.125 * YL;
     Canvas.Style = ERenderStyle.STY_Normal;
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     Canvas.SetPos(0.5 * Canvas.ClipX, HeaderOffsetY + 4);
     BoxTextOffsetY = HeaderOffsetY + 0.5 * PlayerBoxSizeY - 0.5 * YL;
     Canvas.DrawColor = HUDClass.default.WhiteColor;

     if ( OwnerOffset == -1 )
     {
          for ( i=0; i<PlayerCount; i++ )
          {
               if ( i != OwnerOffset )
               {
                    Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
                    Canvas.DrawText(playername[i],true);
               }
          }
     }
     else
     {
          for ( i=0; i<PlayerCount; i++ )
          {
               if ( i != OwnerOffset )
               {
                    Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY - 0.5 * YL + NameY);
                    Canvas.DrawText(playername[i],true);
               }
          }
     }

     if ( bNameFontReduction )
          Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);

     // draw scores
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     for ( i=0; i<PlayerCount; i++ )
     {
          if ( i != OwnerOffset )
          {
               Canvas.SetPos(ScoreXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
               if ( PRIArray[i].bOutOfLives )
                    Canvas.DrawText(OutText,true);
               else
               {
                    switch (VictoryCondition)
                    {
                         case 0:  Canvas.DrawText(GunGamePRI(PRIArray[i]).GunLevel,true);
                                  break;
                         case 1:  Canvas.DrawText(int(PRIArray[i].Score),true);
                                  break;
                         case 2:  Canvas.DrawText(GRI.MaxLives-PRIArray[i].NumLives,true);
                    }
               }
          }
     }

     // draw owner line
     if ( OwnerOffset >= 0 )
     {
          if ( OwnerOffset >= PlayerCount )
          {
               OwnerPos = (PlayerBoxSizeY + BoxSpaceY)*PlayerCount + BoxTextOffsetY;
               // draw extra box
               Canvas.Style = ERenderStyle.STY_Alpha;
               Canvas.SetPos(BoxXPos, HeaderOffsetY + (PlayerBoxSizeY + BoxSpaceY)*PlayerCount);
               Canvas.DrawTileStretched( TeamBoxMaterial[TeamNum], BoxWidth, PlayerBoxSizeY);
               Canvas.Style = ERenderStyle.STY_Normal;
               if ( PRIArray[OwnerOffset].HasFlag != None )
               {
                    Canvas.DrawColor = HUDClass.default.WhiteColor;
                    Canvas.SetPos(NameXPos - 48*IconScale, OwnerPos - 16*IconScale);
                    Canvas.DrawTile( FlagIcon, 64*IconScale, 32*IconScale, 0, 0, 256, 128);
               }
          }
          else
               OwnerPos = (PlayerBoxSizeY + BoxSpaceY)*OwnerOffset + BoxTextOffsetY;

          Canvas.DrawColor = HUDClass.default.GoldColor;
          Canvas.SetPos(NameXPos, OwnerPos-0.5*YL+NameY);
          if ( bNameFontReduction )
               Canvas.Font = ReducedFont;
          Canvas.DrawText(playername[OwnerOffset],true);
          if ( bNameFontReduction )
               Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
          Canvas.SetPos(ScoreXPos, OwnerPos);
          if ( PRIArray[OwnerOffset].bOutOfLives )
               Canvas.DrawText(OutText,true);
          else
          {
               switch (VictoryCondition)
               {
                    case 0:  Canvas.DrawText(GunGamePRI(PRIArray[OwnerOffset]).GunLevel,true);
                             break;
                    case 1:  Canvas.DrawText(int(PRIArray[OwnerOffset].Score),true);
                             break;
                    case 2:  Canvas.DrawText(GRI.MaxLives-PRIArray[OwnerOffset].NumLives,true);
               }
          }
     }

     // draw flag icons
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     if ( TeamNum == 0 )
          OtherTeam = 1;
     if ( (GRI.FlagState[OtherTeam] != EFlagState.FLAG_Home) && (GRI.FlagState[OtherTeam] != EFlagState.FLAG_Down) )
     {
          for ( i=0; i<PlayerCount; i++ )
          {
               if ( (PRIArray[i].HasFlag != None) || (PRIArray[i] == GRI.FlagHolder[TeamNum]) )
               {
                    Canvas.SetPos(NameXPos - 48*IconScale, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY - 16*IconScale);
                    Canvas.DrawTile( FlagIcon, 64*IconScale, 32*IconScale, 0, 0, 256, 128);
               }
          }
     }

     // draw location and/or orders
     if ( (OwnerOffset >= 0) && (Canvas.ClipX >= 512) )
     {
          BoxTextOffsetY = HeaderOffsetY + 0.5*PlayerBoxSizeY + NameY;
          Canvas.DrawColor = HUDClass.default.CyanColor;
          if ( FontReduction > 3 )
               bHaveHalfFont = false;
          if ( Canvas.ClipX >= 1280 )
               Canvas.Font = GetSmallFontFor(Canvas.ClipX, FontReduction+2);
          else
               Canvas.Font = GetSmallFontFor(Canvas.ClipX, FontReduction+1);
          Canvas.StrLen("Test", XL, YL);
          for ( i=0; i<PlayerCount; i++ )
          {
               LineCount = 0;
               if( PRIArray[i].bBot && (TeamPlayerReplicationInfo(PRIArray[i]) != None) && (TeamPlayerReplicationInfo(PRIArray[i]).Squad != None) )
               {
                    LineCount = 1;
                    Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
                    if ( Canvas.ClipX < 800 )
                         OrdersText = "("$PRIArray[i].GetCallSign()$") "$TeamPlayerReplicationInfo(PRIArray[i]).Squad.GetShortOrderStringFor(TeamPlayerReplicationInfo(PRIArray[i]));
                    else
                    {
                         OrdersText = TeamPlayerReplicationInfo(PRIArray[i]).Squad.GetOrderStringFor(TeamPlayerReplicationInfo(PRIArray[i]));
                         OrdersText = "("$PRIArray[i].GetCallSign()$") "$OrdersText;  
                         Canvas.StrLen(OrdersText, oXL, oYL);
                         if ( oXL >= ScoreXPos - NameXPos )
                              OrdersText = "("$PRIArray[i].GetCallSign()$") "$TeamPlayerReplicationInfo(PRIArray[i]).Squad.GetShortOrderStringFor(TeamPlayerReplicationInfo(PRIArray[i]));
                    }
                    Canvas.DrawText(OrdersText,true);
               }
               if ( bHaveHalfFont || !PRIArray[i].bBot )
               {
                    Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY + LineCount*YL);
                    Canvas.DrawText(PRIArray[i].GetLocationName(),true);
               }
          }
          if ( OwnerOffset >= PlayerCount )
          {
               Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
               Canvas.DrawText(PRIArray[OwnerOffset].GetLocationName(),true);
          }
     }

     if ( Level.NetMode == NM_Standalone )
          return;

     Canvas.Font = MainFont;
     Canvas.StrLen("Test",XL,YL);
     BoxTextOffsetY = HeaderOffsetY + 0.5 * PlayerBoxSizeY - 0.5 * YL;
     DrawNetInfo(Canvas,FontReduction,HeaderOffsetY,PlayerBoxSizeY,BoxSpaceY,BoxTextOffsetY,OwnerOffset,PlayerCount,NetXPos);
}

simulated function bool InOrder( PlayerReplicationInfo P1, PlayerReplicationInfo P2 )
{
     if( P1.bOnlySpectator )
     {
          if( P2.bOnlySpectator )
               return true;
          else
               return false;
     }
     else if ( P2.bOnlySpectator )
          return true;

     switch( VictoryCondition )
     {
          case 0:  if( GunGamePRI(P1).GunLevel < GunGamePRI(P2).GunLevel )  //GunLevel
                        return false;
                   if( GunGamePRI(P1).GunLevel == GunGamePRI(P2).GunLevel )
                   {
                        if ( P1.Deaths > P2.Deaths )
                             return false;
                        if ( (P1.Deaths == P2.Deaths) && (PlayerController(P2.Owner) != None) && (Viewport(PlayerController(P2.Owner).Player) != None) )
                             return false;
                   }
                   break;

          case 1:  if( P1.Score < P2.Score )  //GoalScore
                        return false;
                   if( P1.Score == P2.Score )
                   {
                        if ( P1.Deaths > P2.Deaths )
                             return false;
                        if ( (P1.Deaths == P2.Deaths) && (PlayerController(P2.Owner) != None) && (Viewport(PlayerController(P2.Owner).Player) != None) )
                             return false;
                   }
                   break;

          case 2:  if (P1.NumLives > P2.NumLives)  //Lives
    	                return false;
                   if (P1.NumLives == P2.NumLives)
                   {
    	                if (P1.Score < P2.Score)
        	             return false;

		        if ( (P1.Score == P2.Score) && (PlayerController(P2.Owner) != None) && (Viewport(PlayerController(P2.Owner).Player) != None) )
			     return false;
                   }
     }

     return true;
}

simulated function SortPRIArray()
{
     local int i,j, len;
     local PlayerReplicationInfo tmp;

     //Determine length only once
     len = GRI.PRIArray.Length;

     for ( i=0; i<len-1; i++ )
     {
          for ( j=i+1; j<len; j++ )
          {
               if( !InOrder( GRI.PRIArray[i], GRI.PRIArray[j] ) )
               {
                    tmp = GRI.PRIArray[i];
                    GRI.PRIArray[i] = GRI.PRIArray[j];
                    GRI.PRIArray[j] = tmp;
               }
          }
     }
}

defaultproperties
{
}

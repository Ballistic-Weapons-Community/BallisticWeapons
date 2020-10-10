class GGScoreboard extends ScoreBoardDeathMatch;

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

simulated event UpdateScoreBoard(Canvas Canvas) //Ripped out of ScoreBoardDeathMatch and adjusted the code
{
     local PlayerReplicationInfo PRI, OwnerPRI;
     local int i, FontReduction, OwnerPos, NetXPos, PlayerCount,HeaderOffsetY,HeadFoot, MessageFoot, PlayerBoxSizeY, BoxSpaceY, NameXPos, BoxTextOffsetY, OwnerOffset, ScoreXPos, DeathsXPos, BoxXPos, TitleYPos, BoxWidth;
     local float XL,YL, MaxScaling;
     local float deathsXL, scoreXL, netXL, MaxNamePos, LongestNameLength;
     local string playername[MAXPLAYERS], LongestName;
     local bool bNameFontReduction;
     local font ReducedFont;

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

     OwnerPRI = PlayerController(Owner).PlayerReplicationInfo;
     for (i=0; i<GRI.PRIArray.Length; i++)
     {
          PRI = GRI.PRIArray[i];
          if( !PRI.bOnlySpectator && (!PRI.bIsSpectator || PRI.bWaitingPlayer) )
          {
               if ( PRI == OwnerPRI )
                    OwnerOffset = i;
               PlayerCount++;
          }
     }
     PlayerCount = Min(PlayerCount,MAXPLAYERS);

     // Select best font size and box size to fit as many players as possible on screen
     Canvas.Font = HUDClass.static.GetMediumFontFor(Canvas);
     Canvas.StrLen("Test", XL, YL);
     BoxSpaceY = 0.25 * YL;
     PlayerBoxSizeY = 1.5 * YL;
     HeadFoot = 5*YL;
     MessageFoot = 1.5 * HeadFoot;
     if ( PlayerCount > (Canvas.ClipY - 1.5 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
     {
          BoxSpaceY = 0.125 * YL;
          PlayerBoxSizeY = 1.25 * YL;
          if ( PlayerCount > (Canvas.ClipY - 1.5 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
          {
               if ( PlayerCount > (Canvas.ClipY - 1.5 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
                    PlayerBoxSizeY = 1.125 * YL;
               if ( PlayerCount > (Canvas.ClipY - 1.5 * HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
               {
                    FontReduction++;
                    Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
                    Canvas.StrLen("Test", XL, YL);
                    BoxSpaceY = 0.125 * YL;
                    PlayerBoxSizeY = 1.125 * YL;
                    HeadFoot = 5*YL;
                    if ( PlayerCount > (Canvas.ClipY - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY) )
                    {
                         FontReduction++;
                         Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
                         Canvas.StrLen("Test", XL, YL);
                         BoxSpaceY = 0.125 * YL;
                         PlayerBoxSizeY = 1.125 * YL;
                         HeadFoot = 5*YL;
                         if ( (Canvas.ClipY >= 768) && (PlayerCount > (Canvas.ClipY - HeadFoot)/(PlayerBoxSizeY + BoxSpaceY)) )
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
     PlayerBoxSizeY = FClamp((1+(Canvas.ClipY - 0.67 * MessageFoot))/PlayerCount - BoxSpaceY, PlayerBoxSizeY, MaxScaling * YL);

     bDisplayMessages = (PlayerCount <= (Canvas.ClipY - MessageFoot)/(PlayerBoxSizeY + BoxSpaceY));
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
          playername[i] = GRI.PRIArray[i].PlayerName;
          Canvas.StrLen(playername[i], XL, YL);
          if ( XL > MaxNamePos )
               playername[i] = left(playername[i], MaxNamePos/XL * len(PlayerName[i]));
     }
     if ( OwnerOffset >= PlayerCount )
     {
          playername[OwnerOffset] = GRI.PRIArray[OwnerOffset].PlayerName;
          Canvas.StrLen(playername[OwnerOffset], XL, YL);
          if ( XL > MaxNamePos )
               playername[OwnerOffset] = left(playername[OwnerOffset], MaxNamePos/XL * len(PlayerName[OwnerOffset]));
     }

     Canvas.Style = ERenderStyle.STY_Normal;
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     Canvas.SetPos(0.5 * Canvas.ClipX, HeaderOffsetY + 4);
     BoxTextOffsetY = HeaderOffsetY + 0.5 * (PlayerBoxSizeY - YL);

     Canvas.DrawColor = HUDClass.default.WhiteColor;
     for ( i=0; i<PlayerCount; i++ )
     {
          if ( i != OwnerOffset )
          {
               Canvas.SetPos(NameXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
               Canvas.DrawText(playername[i],true);
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
               if ( GRI.PRIArray[i].bOutOfLives )
                    Canvas.DrawText(OutText,true);
               else
               {
                    switch (VictoryCondition)
                    {
                         case 0:  Canvas.DrawText(GunGamePRI(GRI.PRIArray[i]).GunLevel,true);
                                  break;
                         case 1:  Canvas.DrawText(int(GRI.PRIArray[i].Score),true);
                                  break;
                         case 2:  Canvas.DrawText(GRI.MaxLives-GRI.PRIArray[i].NumLives,true);
                    }
               }
          }
     }

     // draw deaths
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     for ( i=0; i<PlayerCount; i++ )
     {
          if ( i != OwnerOffset )
          {
               Canvas.SetPos(DeathsXPos, (PlayerBoxSizeY + BoxSpaceY)*i + BoxTextOffsetY);
               Canvas.DrawText(int(GRI.PRIArray[i].Deaths),true);
          }
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
     Canvas.DrawText(playername[OwnerOffset],true);
     if ( bNameFontReduction )
          Canvas.Font = GetSmallerFontFor(Canvas,FontReduction);
     Canvas.SetPos(ScoreXPos, OwnerPos);

     if ( GRI.PRIArray[OwnerOffset].bOutOfLives )
          Canvas.DrawText(OutText,true);
     else
     {
          switch (VictoryCondition)
          {
               case 0:  Canvas.DrawText(GunGamePRI(GRI.PRIArray[OwnerOffset]).GunLevel,true);
                        break;
               case 1:  Canvas.DrawText(int(GRI.PRIArray[OwnerOffset].Score),true);
                        break;
               case 2:  Canvas.DrawText(GRI.MaxLives-GRI.PRIArray[OwnerOffset].NumLives,true);
          }
     }

     Canvas.SetPos(DeathsXPos, OwnerPos);
     Canvas.DrawText(int(GRI.PRIArray[OwnerOffset].Deaths),true);

     ExtraMarking(Canvas, PlayerCount, OwnerOffset, NameXPos, PlayerBoxSizeY + BoxSpaceY, BoxTextOffsetY);

     if ( Level.NetMode == NM_Standalone )
          return;

     Canvas.StrLen(NetText, NetXL, YL);
     Canvas.DrawColor = HUDClass.default.WhiteColor;
     Canvas.SetPos(NetXPos + 0.5*NetXL, TitleYPos);
     Canvas.DrawText(NetText,true);

     for ( i=0; i<GRI.PRIArray.Length; i++ )
          PRIArray[i] = GRI.PRIArray[i];

     DrawNetInfo(Canvas,FontReduction,HeaderOffsetY,PlayerBoxSizeY,BoxSpaceY,BoxTextOffsetY,OwnerOffset,PlayerCount,NetXPos);
     DrawMatchID(Canvas,FontReduction);
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
     HudClass=Class'GunGameBW.GGHUD'
}

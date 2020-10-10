class UT2K4Tab_PlayerLoginControlsGunGame extends UT2K4Tab_PlayerLoginControls;

var byte VictoryCondition;
var byte MaxLives;

function InitGRI()
{
     local PlayerController PC;
     local GunGameGRI GRI;

     GRI = GunGameGRI(GetGRI());
     if ( GRI == None )
          return;

     PC = PlayerOwner();
     if ( PC.PlayerReplicationInfo == None || GRI==None )
          return;

     bInit = false;
     VictoryCondition = GRI.VictoryCondition;
     MaxLives = GRI.MaxLives;
     if ( !bTeamGame && !bFFAGame )
     {
          if ( GRI.bTeamGame )
               bTeamGame = True;
          else if ( !(GRI.GameClass ~= "Engine.GameInfo") )
               bFFAGame = True;
     }

     bNetGame = PC.Level.NetMode != NM_StandAlone;
     if ( bNetGame )
          b_Leave.Caption = LeaveMPButtonText;
     else
          b_Leave.Caption = LeaveSPButtonText;

     if (PC.PlayerReplicationInfo.bOnlySpectator)
          b_Spec.Caption = JoinGameButtonText;
     else
          b_Spec.Caption = SpectateButtonText;

     if ( !bTeamGame )
     {
          switch(VictoryCondition)
          {
               case 0:  sb_FFA.Caption="Players' GunLevels";
                        break;

               case 1:  sb_FFA.Caption="Players' Scores";
                        break;

               case 2:  sb_FFA.Caption="Players' Lives";
          }
     }

     InitLists();
}

function bool InternalOnPreDraw(Canvas C)
{
     local GunGameGRI GRI;

     GRI = GunGameGRI(GetGRI());
     if (GRI != None)
     {
          if (bInit)
               InitGRI();

          if ( bTeamGame ) //0=GunLevel; 1=GoalScore; 2=Lives
          {
               switch ( VictoryCondition )
               {
                    case 0:  sb_Red.Caption = RedTeam@"GunLevels";
                             sb_Blue.Caption = BlueTeam@"GunLevels";
                             break;

                    case 1:  if ( GRI.Teams[0] != None )
                                  sb_Red.Caption = RedTeam@string(int(GRI.Teams[0].Score));
                             if ( GRI.Teams[1] != None )
                                  sb_Blue.Caption = BlueTeam@string(int(GRI.Teams[1].Score));

                             break;

                    case 2:  sb_Red.Caption = RedTeam@"Lives";
                             sb_Blue.Caption = BlueTeam@"Lives";
               }

               if (PlayerOwner().PlayerReplicationInfo.Team != None)
               {
                    if (PlayerOwner().PlayerReplicationInfo.Team.TeamIndex == 0)
                    {
                         sb_Red.HeaderBase = texture'Display95';
                         sb_Blue.HeaderBase = sb_blue.default.headerbase;
                    }
                    else
                    {
                         sb_Blue.HeaderBase = texture'Display95';
                         sb_Red.HeaderBase = sb_blue.default.headerbase;
                    }
               }
          }

          SetButtonPositions(C);
          UpdatePlayerLists();

          if ( ((PlayerOwner().myHUD == None) || !PlayerOwner().myHUD.IsInCinematic()) && GRI.bMatchHasBegun && !PlayerOwner().IsInState('GameEnded') )
               EnableComponent(b_Spec);
          else
               DisableComponent(b_Spec);
     }

     return false;
}

function DrawPlayerItem(PlayerReplicationInfo PRI, Canvas Canvas, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
     local eMenuState m;
     local string s;
     local float xl,yl;
     local eFontScale F;

     if (bTeamGame)
          F = FNS_Medium;
     else
          F = FNS_Large;

     if ( GunGamePRI(PRI) != None )
     {
          Y += H*0.1;
          H -= H*0.2;

          if ( bSelected )
          {
               Canvas.SetPos(X,Y);
               Canvas.SetDrawColor(32,32,128,255);
               Canvas.DrawTile(Controller.DefaultPens[0],W,H,0,0,2,2);
               m = MSAT_Focused;
          }
          else
               m = MSAT_Blurry;

          PlayerStyle.TextSize(Canvas,m, PRI.PlayerName,XL,YL,FNS_Medium);
          PlayerStyle.DrawText( Canvas, m, X, Y, W, YL, TXTA_Left, PRI.PlayerName, FNS_Medium );

          switch(VictoryCondition)
          {
               case 0:  PlayerStyle.TextSize(Canvas,m,""$GunGamePRI(PRI).GunLevel,XL,YL,FNS_Medium);
                        PlayerStyle.DrawText( Canvas, m, X+W-XL,Y,XL,YL, TXTA_Right, ""$GunGamePRI(PRI).GunLevel,FNS_Medium);
                        break;

               case 1:  PlayerStyle.TextSize(Canvas,m,""$INT(PRI.Score),XL,YL,FNS_Medium);
                        PlayerStyle.DrawText( Canvas, m, X+W-XL,Y,XL,YL, TXTA_Right, ""$INT(PRI.Score),FNS_Medium);
                        break;

               case 2:  PlayerStyle.TextSize(Canvas,m,""$INT(PRI.Score),XL,YL,FNS_Medium);
                        PlayerStyle.DrawText( Canvas, m, X+W-XL,Y,XL,YL, TXTA_Right, ""$MaxLives-PRI.NumLives,FNS_Medium);
          }          

          if (Canvas.ClipX>640 && bNetGame)
          {
               Y+=YL;

               s = "Ping:"$(4*PRI.Ping)$" P/L:"$PRI.PacketLoss;

               PlayerStyle.TextSize(Canvas,m, s,XL,YL,FNS_Medium);
               PlayerStyle.DrawText( Canvas, m, X, Y, W,YL, TXTA_Left, S, FNS_Small);
          }
     }
}

defaultproperties
{
}

class Freon_HUD extends TAM_HUD;

var Texture FrozenBeacon;

var float ThawBarWidth;
var float ThawBarHeight;
var Texture ThawBackMat;
var Texture ThawBarMat;
var Color BeaconFullColor, NoThawColor;

var globalconfig bool bAlwaysHPTint;

exec function ToggleHPTint()
{
	bAlwaysHPTint = !bAlwaysHPTint;
	SaveConfig();
}

static function bool IsTargetInFrontOfPlayer( Canvas C, Actor Target, out Vector ScreenPos,
											 Vector CamLoc, Rotator CamRot )
{
	// Is Target located behind camera ?
	if((Target.Location - CamLoc) Dot vector(CamRot) < 0)
		return false;

	// Is Target on visible canvas area ?
	ScreenPos = C.WorldToScreen(Target.Location + vect(0,0,1) * Target.CollisionHeight);
	if(ScreenPos.X <= 0 || ScreenPos.X >= C.ClipX)
        return false;
	if(ScreenPos.Y <= 0 || ScreenPos.Y >= C.ClipY)
        return false;

	return true;
}

function DrawCustomBeacon(Canvas C, Pawn P, float ScreenLocX, float ScreenLocY)
{
    local vector ScreenLoc;
    local vector CamLoc;
    local rotator CamRot;
    local float distance;
    local float scaledist;
    local float scale;
	local float XL, YL;
    local byte pawnTeam, ownerTeam;
    local string info;
	local int health;
    local int starthealth;
	local Misc_PRI PRI;
	local texture MyBeaconTex;

	if((FrozenBeacon == None) || (P.PlayerReplicationInfo == None) || P.PlayerReplicationInfo.Team == None)
		return;

    pawnTeam = P.PlayerReplicationInfo.Team.TeamIndex;
    ownerTeam = PlayerOwner.GetTeamNum();

    if(!PlayerOwner.PlayerReplicationInfo.bOnlySpectator && pawnTeam != ownerTeam)
    	return;

    C.GetCameraLocation(CamLoc, CamRot);

    distance = VSize(CamLoc - P.Location);
    if(distance > PlayerOwner.TeamBeaconMaxDist)
		return;

    if(!IsTargetInFrontOfPlayer(C, P, ScreenLoc, CamLoc, CamRot) || !FastTrace(P.Location, CamLoc))
        return;

    scaledist = PlayerOwner.TeamBeaconMaxDist * FClamp(0.04 * P.CollisionRadius, 1.0, 2.0);
    scale = FClamp(0.28 * (scaledist - distance) / scaledist, 0.1, 0.25);

	if (Freon_Pawn(P).bFrozen)
	{
		if (Freon_Pawn(P).Health < 13)
			C.DrawColor = NoThawColor;
		else if(distance <= class'Freon_Trigger'.default.CollisionRadius)
			C.DrawColor = class'Freon_PRI'.default.FrozenColor;
		else
			C.DrawColor = class'Freon_PRI'.default.FrozenColor * 0.75;
	}
	
	else if (P == PlayerOwner.Pawn)
		return;
	
	else /* if (bAlwaysHPTint || (PlayerOwner.Pawn != None && BallisticWeapon(PlayerOwner.Pawn.Weapon) != None && BallisticWeapon(PlayerOwner.Pawn.Weapon).bWT_Heal)) */
	{
		PRI = Misc_PRI(P.PlayerReplicationInfo);
		health = PRI.PawnReplicationInfo.Health + PRI.PawnReplicationInfo.Shield;
		if(TAM_TeamInfo(PRI.Team) != None)
			starthealth = TAM_TeamInfo(PRI.Team).StartingHealth;
		else if(TAM_TeamInfoRed(PRI.Team) != None)
			starthealth = TAM_TeamInfoRed(PRI.Team).StartingHealth;
		else if(TAM_TeamInfoBlue(PRI.Team) != None)
			starthealth = TAM_TeamInfoBlue(PRI.Team).StartingHealth;
		else
			starthealth = 200;

		if(health < starthealth)
		{
			C.DrawColor.B = 0;
			C.DrawColor.R = Min(200, (400 * (float(StartHealth - Health) / float(StartHealth))));

			if(C.DrawColor.R == 200)
				C.DrawColor.G = Min(200, (400 * (float(Health) / float(StartHealth))));
			else
				C.DrawColor.G = 200;
		}
		else
			C.DrawColor = BeaconFullColor;
			
		C.DrawColor.A = 255 * ((PlayerOwner.TeamBeaconMaxDist - distance) / PlayerOwner.TeamBeaconMaxDist);
	}
	
	//else C.DrawColor = class'PlayerController'.default.TeamBeaconTeamColors[P.GetTeamNum()];
    
    C.Style = ERenderStyle.STY_Normal;
    if(distance < PlayerOwner.TeamBeaconPlayerInfoMaxDist)
    {
        C.Font = C.MedFont;
		
		info = P.PlayerReplicationInfo.PlayerName;
		if (Freon_Pawn(P).bFrozen)
			info $= " (" $ P.Health $ "%)";
	    C.TextSize(info, XL, YL);
	    C.SetPos(ScreenLoc.X - 0.125 * FrozenBeacon.USize, ScreenLoc.Y - 0.345 * FrozenBeacon.VSize - YL);
	    C.DrawTextClipped(info, false);

        // thaw bar
		if (Freon_Pawn(P).bFrozen)
		{
			C.SetPos(ScreenLoc.X + 1.25 * FrozenBeacon.USize * scale, ScreenLoc.Y - 0.85 * FrozenBeacon.VSize * scale);
			C.DrawTileStretched(ThawBackMat, ThawBarWidth, FrozenBeacon.VSize * scale * 0.5);

			C.SetPos(ScreenLoc.X + 1.25 * FrozenBeacon.USize * scale, ScreenLoc.Y - 0.85 * FrozenBeacon.VSize * scale);
			C.DrawTileStretched(ThawBarMat, ThawBarWidth * (P.Health / 100.0), FrozenBeacon.VSize * scale * 0.5);
		}
    }

	if (Freon_Pawn(P).bFrozen)
		myBeaconTex = FrozenBeacon;
	else myBeaconTex = class'xPlayer'.default.TeamBeaconTexture;
	
	C.DrawColor.A = 255;
	
	C.SetPos(ScreenLoc.X - 0.125 * myBeaconTex.USize * scale, ScreenLoc.Y + (-0.125 -1) * myBeaconTex.VSize * scale);
	C.DrawTile(myBeaconTex,
			myBeaconTex.USize * scale,
			myBeaconTex.VSize * scale,
			0.0,
			0.0,
			myBeaconTex.USize,
			myBeaconTex.VSize);
}

simulated function bool ShouldDrawPlayer(Misc_PRI PRI)
{
    if(PRI == None || PRI.Team == None)
        return false;
    if(Freon_PawnReplicationInfo(PRI.PawnReplicationInfo) == None || 
            (PRI.bOutOfLives && !Freon_PawnReplicationInfo(PRI.PawnReplicationInfo).bFrozen) || 
            PRI == PlayerOwner.PlayerReplicationInfo)
        return false;
    return true;
}



simulated function DrawPlayers(Canvas C)
{
    local int i;
    local int Team;
    local float xl;
    local float yl;
    local float MaxNamePos;
    local int posx;
    local int posy;
    local float scaley, scalex;
    local string name;
    local int listy;
    local int space;
    local int namey;
    local int namex;
    local int height;
    local int width;
    local Misc_PRI pri;
    local int health;
    local int starthealth;

    local int allies;
    local int enemies;

    if(myOwner == None)
        return;

    if(PlayerOwner.PlayerReplicationInfo.Team != None)
        Team = PlayerOwner.GetTeamNum();
    else
    {
        if(Pawn(PlayerOwner.ViewTarget) == None || Pawn(PlayerOwner.ViewTarget).GetTeamNum() == 255)
            return;
        Team = Pawn(PlayerOwner.ViewTarget).GetTeamNum();
    }

    listy = 0.08 * HUDScale * C.ClipY;
    scaley = 0.75;
	scalex = scaley / ((C.ClipX / C.ClipY) * 0.75);
    height = C.ClipY * 0.02;
    space = height + (0.0075 * C.ClipY);
    namex = C.ClipX * 0.02; 
    
    C.Font = GetFontSizeIndex(C, -3);
    C.StrLen("Test", xl, yl);
    namey = (height * 0.6) - (yl * 0.5);

    for(i = 0; i < MyOwner.GameReplicationInfo.PRIArray.Length; i++)
    {
        PRI = Misc_PRI(myOwner.GameReplicationInfo.PRIArray[i]);
        if(!ShouldDrawPlayer(PRI))
            continue;

        if(!myOwner.bShowTeamInfo)
            continue;

        if(PRI.Team.TeamIndex == Team)
        {
            space = (0.005 * C.ClipY);
            width = C.ClipX * 0.14;
            MaxNamePos = 0.99 * (width - namex);

            posy = listy + ((height + space) * allies);
            posx = C.ClipX * 0.01;
            
            // draw backgrounds
            C.SetPos(posx, posy);
            if(Freon_PawnReplicationInfo(PRI.PawnReplicationInfo) != None && Freon_PawnReplicationInfo(PRI.PawnReplicationInfo).bFrozen)
                C.DrawColor = class'Freon_PRI'.default.FrozenColor * 0.6;
            else
                C.DrawColor = default.BlackColor;
            C.DrawColor.A = 100;
            C.DrawTile(TeamTex, width + posx, height, 168, 211, 166, 44);

            // draw disc
            C.SetPos(posx, posy);
            C.DrawColor = default.WhiteColor;
            C.DrawTile(TeamTex, C.ClipX * 0.0195 * ScaleX, C.ClipY * 0.026 * ScaleY, 119, 258, 54, 55);

// draw health dot
            if(Freon_PawnReplicationInfo(PRI.PawnReplicationInfo) != None && Freon_PawnReplicationInfo(PRI.PawnReplicationInfo).bFrozen)
            {
                health = PRI.PawnReplicationInfo.Health;
                C.DrawColor = class'Freon_PRI'.default.FrozenColor * (0.5 + (health * 0.005));
            }
            else
            {
                health = PRI.PawnReplicationInfo.Health + PRI.PawnReplicationInfo.Shield;
                if(TAM_TeamInfo(PRI.Team) != None)
                    starthealth = TAM_TeamInfo(PRI.Team).StartingHealth;
                else if(TAM_TeamInfoRed(PRI.Team) != None)
                    starthealth = TAM_TeamInfoRed(PRI.Team).StartingHealth;
                else if(TAM_TeamInfoBlue(PRI.Team) != None)
                    starthealth = TAM_TeamInfoBlue(PRI.Team).StartingHealth;
                else
                    starthealth = 200;

                if(health < starthealth)
                {
                    C.DrawColor.B = 0;
                    C.DrawColor.R = Min(200, (400 * (float(StartHealth - Health) / float(StartHealth))));

                    if(C.DrawColor.R == 200)
				        C.DrawColor.G = Min(200, (400 * (float(Health) / float(StartHealth))));
                    else
                        C.DrawColor.G = 200;
                }
                else
                    C.DrawColor = FullHealthColor;
            }

            C.SetPos(posx + (0.0022 * ScaleX * C.ClipX), posy + (0.0035 * ScaleY * C.ClipY));
            C.DrawTile(TeamTex, C.ClipX * 0.0165 * ScaleX, C.ClipY * 0.0185 * ScaleY, 340, 432, 78, 78);

            // draw health
            name = string(health);
            C.SetPos(posx + namex, posy + namey);       
            C.DrawText(name);

            // draw name
            name = PRI.PlayerName;
            C.StrLen(name, xl, yl);
            if(xl > MaxNamePos)
                name = left(name, MaxNamePos / xl * len(name));
                
            C.DrawColor = NameColor;
            C.StrLen("0000", xl, yl);
            C.SetPos(posx + namex + xl, posy + namey);   
            C.DrawText(name);

 						// draw location dot
            C.DrawColor = WhiteColor;
            Draw2DLocationDot(C, PRI.PawnReplicationInfo.Position, (posx / C.ClipX) + (0.006 * ScaleX), (posy / C.ClipY) + (0.008 * ScaleY), 0.008 * ScaleX, 0.01 * ScaleY);

            
            // allies shown
            allies++;

        }
        else
        {
            space = (0.005 * C.ClipY);
            width = C.ClipX * 0.11;
            MaxNamePos = 0.99 * (width - namex);

            posy = listy + ((height + space) * enemies);
            posx = C.ClipX * 0.99;

            // draw background
            C.SetPos(posx - width, posy);
            if(Freon_PawnReplicationInfo(PRI.PawnReplicationInfo) != None && Freon_PawnReplicationInfo(PRI.PawnReplicationInfo).bFrozen)
                C.DrawColor = class'Freon_PRI'.default.FrozenColor * 0.6;
            else
                C.DrawColor = default.BlackColor;
            C.DrawColor.A = 100;
            C.DrawTile(TeamTex, width, height, 168, 211, 166, 44);

            // draw disc
            C.SetPos(posx - (C.ClipX * 0.0195 * ScaleX), posy);
            C.DrawColor = default.WhiteColor;
            C.DrawTile(TeamTex, C.ClipX * 0.0195 * ScaleX, C.ClipY * 0.026 * ScaleY, 119, 258, 54, 55);

            // draw name
            name = PRI.PlayerName;
            C.StrLen(name, xl, yl);
            if(xl > MaxNamePos)
            {
                name = left(name, MaxNamePos / xl * len(name));
                C.StrLen(name, xl, yl);
            }
            C.DrawColor = NameColor;
            C.SetPos(posx - xl - namex, posy + namey); 
            C.DrawText(name);

            // draw health dot
            if(Freon_PawnReplicationInfo(PRI.PawnReplicationInfo)!= None && Freon_PawnReplicationInfo(PRI.PawnReplicationInfo).bFrozen)
                C.DrawColor = class'Freon_PRI'.default.FrozenColor;
            else
                C.DrawColor = HudColorTeam[PRI.Team.TeamIndex];
            C.SetPos(posx - (0.016 * ScaleX * C.ClipX), posy + (0.0035 * ScaleY * C.ClipY));
            C.DrawTile(TeamTex, C.ClipX * 0.0165 * ScaleX, C.ClipY * 0.0185 * ScaleY, 340, 432, 78, 78);

            // enemies shown
            enemies++;
        }
    }
}

defaultproperties
{
     FrozenBeacon=Texture'3SPNv3141BW.textures.Flake'
     ThawBarWidth=50.000000
     ThawBarHeight=10.000000
     ThawBackMat=Texture'InterfaceContent.Menu.BorderBoxD'
     ThawBarMat=Texture'ONSInterface-TX.HealthBar'
     BeaconFullColor=(B=10,G=255,A=255)
     NoThawColor=(B=255,G=200,R=100,A=255)
}

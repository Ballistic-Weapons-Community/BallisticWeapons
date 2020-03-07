//=============================================================================
// BallisticInteraction.
//
// Interaction used by BW to draw splash screen
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class BallisticInteraction extends Interaction;

var PlayerController PC;

/* splash screen */

var float							ScaleFactor;
var bool							bShowSplash;
var float							SplashStartTime;
var Material						SplashPic;
var localized string				VersionText, FixText;

/* replicated variable display */

var BallisticPlayerReplicationInfo 	BPRI;
var KillstreakLRI					KLRI;

event Initialized()
{
	PC = ViewportOwner.Actor;
	SplashStartTime=PC.Level.TimeSeconds;
}

function DrawSplash( canvas C )
{
	local float XL, YL;

	if (PC.Level.TimeSeconds - SplashStartTime > 7.9)
	{
		bShowSplash=false;
		// Using this as a convenient delay to get the BPRI and KLRI
		BPRI = class'Mut_Ballistic'.static.GetBPRI(PC.PlayerReplicationInfo);
		if (BPRI == None)
			log("BallisticInteraction: Couldn't find the BPRI!");
			
		KLRI = class'Mut_Killstreak'.static.GetKLRI(PC.PlayerReplicationInfo);
		return;
	}
	// Draw splash pic
	C.SetPos(C.OrgX + C.SizeX/2 - 600 * ScaleFactor * 0.5, C.OrgY + 150 * ScaleFactor);
	if (PC.Level.TimeSeconds - SplashStartTime < 5)
		C.SetDrawColor(255,255,255,255);
	else
		C.SetDrawColor(255,255,255, FClamp(255 * (1-((PC.Level.TimeSeconds-SplashStartTime-5)/3.0)), 0, 255));
	C.DrawTile(SplashPic, 600*ScaleFactor, 600*ScaleFactor, 0,0,512,512);

    C.Font = class'UT2MidGameFont'.static.GetMidGameFont(C.SizeX);
	// Draw version text
	C.StrLen(VersionText, XL, YL);
	C.SetPos(C.OrgX + C.SizeX/2 - XL/2, C.OrgY + 675*ScaleFactor);
	C.DrawText(VersionText);

	C.SetDrawColor(150,150,150,150);
	C.StrLen(FixText, XL, YL);
	C.SetPos(C.OrgX + C.SizeX/2 - XL/2, C.OrgY + 700*ScaleFactor);
	C.DrawText(FixText);
}

function DrawKillstreakIndicator(Canvas C)
{
	local float XL, YL;
	local string s;
	local int i;
	
	for (i=0;i<2;i++)
	{
		if (bool(KLRI.RewardLevel & (2 ** i)))
			if (s == "")
				s = "Level"@i+1@"Killstreak";
			else s $= ", Level"@i+1@"Killstreak";
	}
	C.Font = class'BallisticWeapon'.static.GetFontSizeIndex(C, -4 + int(2 * class'HUD'.default.HudScale));
	C.SetDrawColor(100 + (KLRI.RewardLevel * 50),100,100,150);
	C.StrLen (s, XL, YL);
	C.SetPos(C.SizeX/2 - XL/2, C.SizeY * 0.9 - YL/2);
	C.DrawText(s);
}

function Tick(float DT)
{
}

function PostRender( canvas C )
{
	C.Style = 5; //STY_Alpha
	ScaleFactor = float(C.SizeX) / 1600;

	if (bShowSplash)
		DrawSplash(C);
		
	if (KLRI != None && KLRI.RewardLevel != 0)
		DrawKillstreakIndicator(C);
}

static function BallisticInteraction Launch (PlayerController ThePC)
{
	local int i;
	local BallisticInteraction NI;

	log ("Launching BallisticInteraction...");

	for(i=0;i<ThePC.Player.LocalInteractions.length;i++)
		if (ThePC.Player.LocalInteractions[i].Class == class'BallisticInteraction')
			return BallisticInteraction(ThePC.Player.LocalInteractions[i]);
	NI = BallisticInteraction(ThePC.Player.InteractionMaster.AddInteraction("BallisticProV55.BallisticInteraction", ThePC.Player));
	return NI;
}

event NotifyLevelChange()
{
	PC = None;
	Master.RemoveInteraction(self);
}

defaultproperties
{
     bShowSplash=True
     SplashPic=Texture'BallisticTextures_25.ui.SplashScreenNew'
     VersionText="BallisticPro"
     FixText="http://www.ldg-gaming.eu/"
     bVisible=True
}

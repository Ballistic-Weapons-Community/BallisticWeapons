//=============================================================================
// SRS900Rifle.
//
// An automatic rifle with elements of both a sniper rifle and assault rifle.
// More powerful than M50, but less firerate and more recoil.
// Can be silenced.
// Less powerful, but complex sniper scope with fancy features like. range
// finder, stability indicator, stealth meter, Z meter, mag ammo display and
// some miscellaneous scrolling text.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SRS900Rifle extends BallisticWeapon;

var float LastRangeFound, LastStabilityFound, StealthRating, StealthImps, ZRefHeight;

var   bool		bSilenced;
var() name		SilencerBone;
var() name		SilencerOnAnim;			
var() name		SilencerOffAnim;
var() sound		SilencerOnSound;
var() sound		SilencerOffSound;

//Classic Scope
var() Material	ScopeViewTexAlt;
var() Material ScopeViewOverlayTexClassic;
var() Material	BulletTex;
var() Material	ReadoutTex;
var() Material	ElevationRulerTex;
var() Material	ElevationGraphTex;
var() Material	RangeRulerTex;
var() Material	RangeCursorTex;
var() Material	RangeTitleTex;
var() Material	StealthBackTex;
var() Material	StealthTex;
var() Material	StabTitleTex;
var() Material	StabBackTex;
var() Material	StabCurveTex;

//Arena Scope
var() Material  GeneralUITexArena;
var() Material	ScopeViewOverlayTexArena;
var() Material	ReadoutTexArena;
var() Material	ElevationRulerTexArena;
var() Material	ElevationGraphTexArena;
var() Material	RangeRulerTexArena;
var() Material	RangeCursorTexArena;
var() Material	RangeTitleTexArena;
var() Material	StealthBackTexArena;
var() Material	StealthTexArena;
var() Material	StabTitleTexArena;
var() Material	StabBackTexArena;
var() Material	StabCurveTexArena;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated function PostNetBeginPlay()
{
	local NavigationPoint N;
	local float TotalZ;
	local int ZCount;

	super.PostNetBeginPlay();

	if (InStr(WeaponParams.LayoutTags, "irons") != -1)
	{
		SightAnimScale = 0.75;
		SightBobScale = 0.075 *class'BallisticGameStyles'.static.GetReplicatedStyle().default.SightBobScale;
	}

	for(n=level.NavigationPointList;N!=None;N=N.nextNavigationPoint)
	{
		TotalZ += N.Location.Z;
		ZCount++;
	}
	if (ZCount > 0)
		ZRefHeight = TotalZ / ZCount;
}

simulated function ClientPlayerDamaged(int Damage)
{
	super.ClientPlayerDamaged(Damage);
	if (Instigator.IsLocallyControlled())
		StealthImpulse(FMin(0.8, Damage));
}

simulated function ClientJumped()
{
	super.ClientJumped();
	if (Instigator.IsLocallyControlled())
		StealthImpulse(0.15);
}

simulated function StealthImpulse(float Amount)
{
	if (Instigator.IsLocallyControlled())
		StealthImps = FMin(1.0, StealthImps + Amount);
}

simulated event WeaponTick(float DT)
{
	local float Speed, NewSR, P;
	local vector Start, HitLoc, HitNorm;
	local actor T;

	super.WeaponTick(DT);

	if (!Instigator.IsLocallyControlled())
		return;

	if (Instigator.Base != None)
		Speed = VSize(Instigator.Velocity - Instigator.Base.Velocity);
	else
		Speed = VSize(Instigator.Velocity);
	if (Instigator.bIsCrouched)
		NewSR = 0.06;
	else
		NewSR = 0.2;
	if (Speed > Instigator.WalkingPct * Instigator.GroundSpeed)
		NewSR += Speed / 1100;
	else
		NewSR += Speed / 1900;

//	StealthRating -= StealthImps;

	NewSR = FMin(1.0, NewSR + StealthImps);

	P = NewSR-StealthRating;
	P = P / Abs(P);
	StealthRating = FClamp(StealthRating + P*DT, NewSR, StealthRating);

	StealthImps = FMax(0, StealthImps - DT / 4);
	
	if (ClientState == WS_ReadyToFire)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * 40000, Start, true);
		if (T == None)
			LastRangeFound = -1;
		else
			LastRangeFound = VSize(HitLoc-Start);
	}
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
	StealthImpulse(0.1);
}

function ServerSwitchSilencer(bool bDetachSuppressor)
{
	SwitchSilencer(bSilenced);
}

exec simulated function WeaponSpecial(optional byte i)
{
    // too strong
    if (class'BallisticReplicationInfo'.static.IsTactical())
        return;

	if (ReloadState != RS_None || SightingState != SS_None)
		return;
        
	TemporaryScopeDown(0.5);
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
	ReloadState = RS_GearSwitch;
	StealthImpulse(0.1);
}

simulated function SwitchSilencer(bool bDetachSuppressor)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bDetachSuppressor)
		PlayAnim(SilencerOffAnim);
	else
		PlayAnim(SilencerOnAnim);

	OnSuppressorSwitched();
}

simulated function OnSuppressorSwitched()
{
	if (bSilenced)
	{
		ApplySuppressorAim();
		SightingTime *= 1.25;
	}
	else
	{
		AimComponent.Recalculate();
		SightingTime = default.SightingTime;
	}
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bSilenced)
		ApplySuppressorAim();
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

simulated function Notify_SilencerOn()	{	PlaySound(SilencerOnSound,,0.5);	}
simulated function Notify_SilencerOff()	{	PlaySound(SilencerOffSound,,0.5);	}

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	bSilenced=True; SRS900PrimaryFire(BFireMode[0]).SetSilenced(true);}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	bSilenced=False; SRS900PrimaryFire(BFireMode[0]).SetSilenced(false);}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function Notify_ClipOutOfSight()	{	SetBoneScale (1, 1.0, 'Bullet');	}

simulated function PlayReload()
{
	super.PlayReload();

	StealthImpulse(0.1);

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SRS900Clip';
}

// Draw the scope view CLASSIC
/*simulated event RenderOverlays (Canvas C)
{
	local float	ScaleFactor, HF, ZM, ImageScaleRatio;
	local Vector X, Y, Z;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		return;
	}

}*/

// Draw the scope view Arena
simulated function DrawScopeOverlays(Canvas C)
{
	local PlayerController PC;
	local float	ScaleFactor, HF, ZM, XL, XY, ImageScaleRatio;
	local Vector X, Y, Z;

	if (!class'BallisticReplicationInfo'.static.IsClassic())
	{
		ScaleFactor = C.ClipY / 1200;
		if (ScopeViewTex != None)
		{
			// Draw Red overlay
			C.SetDrawColor(255,255,255,255);
			C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
			C.DrawTile(ScopeViewOverlayTexArena, C.SizeY, C.SizeY, 0, 0, 256, 256);

			// Draw Bullets

			C.SetDrawColor(255,0,0,96);
			C.SetPos(C.ClipX / 2 + 156 * ScaleFactor, C.ClipY / 2 - (12*(Default.MagAmmo / 2) ) * ScaleFactor );
			C.DrawTile(BulletTex, 51*ScaleFactor, 12*(Default.MagAmmo)*ScaleFactor, 0, 0, 256, 64*(Default.MagAmmo));


			if (MagAmmo > 0)
			{
				C.SetDrawColor(255,128,64,255);
				C.SetPos(C.ClipX / 2 + 156 * ScaleFactor, C.ClipY / 2 + (12*(Default.MagAmmo / 2) - (12*MagAmmo) ) * ScaleFactor );
				C.DrawTile(BulletTex, 51*ScaleFactor, 12*ScaleFactor, 0, 0, 256, 64);
				if (MagAmmo > 1)
				{
					C.SetDrawColor(255,0,0,255);
					C.SetPos(C.ClipX / 2 + 156 * ScaleFactor, C.ClipY / 2 + (12*(Default.MagAmmo / 2) - (12*(MagAmmo-1)) ) * ScaleFactor );
					C.DrawTile(BulletTex, 51*ScaleFactor, 12*(MagAmmo-1)*ScaleFactor, 0, 0, 256, 64*(MagAmmo-1));
				}
			}

			// Draw Brackets
			C.SetDrawColor(255,0,0,255);
			//Left
			C.SetPos((C.ClipX / 2) - (262 * ScaleFactor), (C.ClipY / 2) - (179 * ScaleFactor));
			C.DrawTile(GeneralUITexArena, 91*ScaleFactor, 358*ScaleFactor, 1, 2, 63, 252);
			//Right
			C.SetPos((C.ClipX / 2) + (171 * ScaleFactor), (C.ClipY / 2) - (179 * ScaleFactor));
			C.DrawTile(GeneralUITexArena, 91*ScaleFactor, 358*ScaleFactor, 64, 2, 63, 252);

			//Draw Stealth Meter Background
			C.SetDrawColor(255,0,0,96);
			C.SetPos((C.ClipX / 2) - (262 * ScaleFactor), (C.ClipY / 2) - (179 * ScaleFactor));
			C.DrawTile(GeneralUITexArena, 91*ScaleFactor, 358*ScaleFactor, 128, 2, 63, 252);

			//Draw Stealth Meter
			C.SetDrawColor(255,0,0,255);
			//C.SetPos((C.ClipX / 2) - (262 * ScaleFactor), (C.ClipY / 2) + (175 - 350 * int(StealthRating * 20)/20) * ScaleFactor);
			//C.DrawTile(GeneralUITexArena, 91*ScaleFactor, 350 * int(StealthRating * 20)/20 * ScaleFactor, 128, 246 - 246*int(StealthRating * 20)/20, 63, 246*int(StealthRating * 20)/20);
			C.SetPos((C.ClipX / 2) - (262 * ScaleFactor), (C.ClipY / 2) + (179 - 358 * StealthRating) * ScaleFactor);
			C.DrawTile(GeneralUITexArena, 91*ScaleFactor, 358 * StealthRating * ScaleFactor, 128, 254 - 252*StealthRating, 63, 252*StealthRating);

			// Draw Select Fire indicator
			C.SetDrawColor(255,0,0,255);
			C.SetPos((C.ClipX / 2) - (38 * ScaleFactor), (C.ClipY / 2) - (218 * ScaleFactor));
			if (CurrentWeaponMode == 1)
				C.DrawTile(GeneralUITexArena, 38*ScaleFactor, 38*ScaleFactor, 192, 0, 32, 32);
			else if (CurrentWeaponMode == 0)
				C.DrawTile(GeneralUITexArena, 38*ScaleFactor, 38*ScaleFactor, 224, 0, 32, 32);

			// Draw Zoom indicator
			PC = PlayerController(Instigator.Controller);
			if (PC != none)
			{
				C.SetDrawColor(255,0,0,255);
				C.SetPos((C.ClipX / 2) + (0 * ScaleFactor), (C.ClipY / 2) - (218 * ScaleFactor));
				if (PC.DefaultFOV / PC.DesiredFOV <= 3.2)
					C.DrawTile(GeneralUITexArena, 38*ScaleFactor, 38*ScaleFactor, 192, 64, 32, 32);
				else if (PC.DefaultFOV / PC.DesiredFOV <= 6.4)
					C.DrawTile(GeneralUITexArena, 38*ScaleFactor, 38*ScaleFactor, 192, 96, 32, 32);
				else
					C.DrawTile(GeneralUITexArena, 38*ScaleFactor, 38*ScaleFactor, 192 ,128, 32, 32);
			}

			// Draw Suppressor Indicator
			C.SetDrawColor(255,0,0,255);
			C.SetPos((C.ClipX / 2) - (38 * ScaleFactor), (C.ClipY / 2) - (256 * ScaleFactor) /* + (179 * ScaleFactor)*/);
			if (!bSilenced)
				C.DrawTile(GeneralUITexArena, 76*ScaleFactor, 38*ScaleFactor, 192, 192, 64, 32);
			else
				C.DrawTile(GeneralUITexArena, 76*ScaleFactor, 38*ScaleFactor, 192, 224, 64, 32);

			// Draw Range Ruler
			C.SetDrawColor(255,0,0,255);
			// The extra multiplication found here is to keep widescreen text from getting too large
			C.Font = GetFontSizeIndex(C, -6 + int(2 * class'HUD'.default.HudScale * (C.ClipY / C.ClipX) * (4/3)));
			if (LastRangeFound >= 0)
			{
				C.StrLen("999.99 m", XL, XY);
				C.DrawTextJustified(FMin(999.99,LastRangeFound / 52.5) $ " m",2, C.ClipX/2 - XL/2, (C.ClipY/2) + (179*ScaleFactor) - XY, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (179*ScaleFactor) + XY);
			}
			else
			{
				C.StrLen("N/A m", XL, XY);
				C.DrawTextJustified(FMin(999.99,LastRangeFound / 52.5) $ " m",2, C.ClipX/2 - XL/2, (C.ClipY/2) + (179*ScaleFactor) - XY, C.ClipX/2 + XL/2 ,(C.ClipY/2) + (179*ScaleFactor) + XY);
			}
			// Draw Scope view
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.OrgX, C.OrgY);
			C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
			C.SetPos((C.SizeX - C.SizeY)/2, C.OrgY);
			C.DrawTile(ScopeViewTex, C.SizeY, C.SizeY, 0, 0, 1024, 1024);
			C.SetPos(C.SizeX - (C.SizeX - C.SizeY)/2, C.OrgY);
			C.DrawTile(ScopeViewTex, (C.SizeX - C.SizeY)/2, C.SizeY, 0, 0, 1, 1);
		}
	}
	else
	{		
		ScaleFactor = C.ClipX / 1600;
		if (ScopeViewTexAlt != None)
		{
			C.ColorModulate.W = 1;
			// Draw Bullets
			if (MagAmmo > 0)
			{
				C.SetDrawColor(255,128,64,255);
				C.SetPos(C.OrgX + 1273 * ScaleFactor, C.OrgY + (840 - (24*MagAmmo) ) * ScaleFactor );
				C.DrawTile(BulletTex, 102*ScaleFactor, 24*ScaleFactor, 0, 0, 256, 64);
				if (MagAmmo > 1)
				{
					C.SetDrawColor(255,0,0,255);
					C.SetPos(C.OrgX + 1273 * ScaleFactor, C.OrgY + (840 - (24*(MagAmmo-1)) ) * ScaleFactor );
					C.DrawTile(BulletTex, 102*ScaleFactor, 24*(MagAmmo-1)*ScaleFactor, 0, 0, 256, 64*(MagAmmo-1));
				}
			}

		// Draw Scope view
		 if (ScopeViewTexAlt != None)
		 {
			C.SetDrawColor(255,255,255,255);
			C.SetPos(C.OrgX, C.OrgY);
			
			//SRS's scope is off from the normal.
			ImageScaleRatio = 1.24;
			
			C.DrawTile(ScopeViewTexAlt, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);

			C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
			C.DrawTile(ScopeViewTexAlt, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

			C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
			C.DrawTile(ScopeViewTexAlt, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);
		}

		}
		C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));

		// Draw Readout
		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY + 565 * ScaleFactor);
		C.DrawTile(ReadoutTex, 729 * ScaleFactor, 635 * ScaleFactor, -1, 1, 512, 512);

		// Draw Elevation Ruler
		HF = (Instigator.Location.Z-ZRefHeight)/1024 - int((Instigator.Location.Z-ZRefHeight)/1024);
		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX + 1385 * ScaleFactor, C.OrgY + 256 * ScaleFactor);
		C.DrawTile(ElevationRulerTex, 85 * ScaleFactor, 768 * ScaleFactor, 0, 1024*HF, 64, 1024);
		// Draw Elevation Graphs
		C.SetPos(C.OrgX + 1450 * ScaleFactor, C.OrgY + 128 * ScaleFactor);
		C.DrawTile(ElevationGraphTex, 150 * ScaleFactor, 1024 * ScaleFactor, 0, 0, 128, 1024);
		// Draw Elevation Title
		C.SetDrawColor(64,255,32,255);
		C.SetPos(1300*ScaleFactor, 192*ScaleFactor);
		C.DrawText("Elevation", false);
		// Draw Elevation Number
		C.SetPos(1300*ScaleFactor, 1024*ScaleFactor);
		ZM = (Instigator.Location.Z-ZRefHeight)/44.0;
		C.DrawText(ZM $ "m", false);

		// Draw Range Ruler
		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX + 498 * ScaleFactor, C.OrgY);
		C.DrawTile(RangeRulerTex, 602 * ScaleFactor, 86 * ScaleFactor, 0, 0, 512, 64);
		// Draw Range Cursor	600 998
		C.SetPos(C.OrgX + (600 + 398*(LastRangeFound/15000) - 9) * ScaleFactor, C.OrgY + 12 * ScaleFactor);
		C.DrawTile(RangeCursorTex, 19 * ScaleFactor, 36 * ScaleFactor, 0, 0, 16, 32);
		// Draw Range Title
		C.SetPos(C.OrgX + 280 * ScaleFactor, C.OrgY + 7 * ScaleFactor);
		C.DrawTile(RangeTitleTex, 219 * ScaleFactor, 62 * ScaleFactor, 0, 0, 256, 64);
		// Draw Range Number
		C.SetDrawColor(255,0,0,255);
		C.SetPos(440 * ScaleFactor, 23 * ScaleFactor);
		if (LastRangeFound < 0)
			C.DrawText("N/A", false);
		else
			C.DrawText(LastRangeFound/52.5 $ "m", false);

	//	184 705
	//	616 1101
		// Draw Stealth Meter Background
		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX + 184 * ScaleFactor, C.OrgY + 705 * ScaleFactor);
		C.DrawTile(StealthBackTex, 432 * ScaleFactor, 396 * ScaleFactor, 0, 0, 512, 512);
		// Draw Stealth Meter
		C.SetPos(C.OrgX + 184 * ScaleFactor, C.OrgY + (705 + (396 * (1-StealthRating))) * ScaleFactor);
		C.DrawTile(StealthTex, 432 * ScaleFactor, 396 * StealthRating * ScaleFactor, 0, 512 - 512*StealthRating, 64, 512*StealthRating);

		// Draw Stability Title
		C.SetPos(C.OrgX + 26 * ScaleFactor, C.OrgY + 170 * ScaleFactor);
		C.DrawTile(StabTitleTex, 240 * ScaleFactor, 30 * ScaleFactor, 0, 0, 256, 32);
		// Draw Stability Background
		C.SetPos(C.OrgX + 26 * ScaleFactor, C.OrgY + 204 * ScaleFactor);
		C.DrawTile(StabBackTex, 227 * ScaleFactor, 227 * ScaleFactor, 0, 0, 256, 256);
		// Draw Stability Curve
		C.SetDrawColor(64,255,32,255);
		C.SetPos(C.OrgX + 26 * ScaleFactor, C.OrgY + 204 * ScaleFactor);
		C.DrawTile(StabCurveTex, 227 * ScaleFactor, 227 * ScaleFactor, 192 * (1-AimComponent.GetChaos()), SMerp(1-Abs(AimComponent.GetChaos() * 2 - 1), 0, 48), 64, 64);
		// Draw Stability Number
		C.SetDrawColor(0,255,0,255);
		C.SetPos(64 * ScaleFactor, 431 * ScaleFactor);
		C.DrawText(int(LastStabilityFound*100) $ "%", false);
	}
}

simulated event Timer()
{
	local vector Start, HitLoc, HitNorm;
	local actor T;

	StealthImpulse(FRand()*0.1-0.05);

	if (ClientState == WS_ReadyToFire)
	{
		Start = Instigator.Location + Instigator.EyePosition();
		T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * 15000, Start, true);
		if (T == None)
			LastRangeFound = -1;
		else
			LastRangeFound = VSize(HitLoc-Start);
		LastStabilityFound = 1-AimComponent.GetChaos();
//		ElevationGraphTex.Trigger(self, Instigator);
		return;
	}
	if (ClientState == WS_BringUp)
		SetTimer(0.2, true);
	else
		SetTimer(0.0, false);
	super.Timer();
}

// Secondary fire doesn't count for this weapon
simulated function bool HasAmmo()
{
	//First Check the magazine
	if (!bNoMag && FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 3072, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.6;	}
// End AI Stuff =====

defaultproperties
{
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	BulletTex=Texture'BW_Core_WeaponTex.SRS900-UI.ScopeBullet'
	ReadoutTex=Shader'BW_Core_WeaponTex.SRS900-UI.Readout-SD'
	ElevationRulerTex=Texture'BW_Core_WeaponTex.SRS900-UI.ElevationLines'
	ElevationGraphTex=TexPanner'BW_Core_WeaponTex.SRS900-UI.Elevation-G-Panner'
	RangeRulerTex=Texture'BW_Core_WeaponTex.SRS900-UI.RangeLines'
	RangeCursorTex=Texture'BW_Core_WeaponTex.SRS900-UI.RangeCursor'
	RangeTitleTex=Texture'BW_Core_WeaponTex.SRS900-UI.RangeIcon'
	StealthBackTex=Texture'BW_Core_WeaponTex.SRS900-UI.DBMeterBG'
	StealthTex=Shader'BW_Core_WeaponTex.SRS900-UI.DBLevel-SD'
	StabTitleTex=Texture'BW_Core_WeaponTex.SRS900-UI.StabilityIcon'
	StabBackTex=Texture'BW_Core_WeaponTex.SRS900-UI.StabilityScreen'
	StabCurveTex=FinalBlend'BW_Core_WeaponTex.SRS900-UI.StabilityCurve-FB'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_SRS900'
	
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="High-powered battle rifle fire. Long range, good penetration and high per-shot damage. Recoil is significant."
	ManualLines(1)="Attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible."
	ManualLines(2)="Effective at medium to long range."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	PutDownTime=0.4
	MagAmmo=20
	CockSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Cock',Volume=0.650000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=2.000000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(G=255,A=108),Color2=(G=0),StartSize1=103,StartSize2=19)
	
	ScopeXScale=1.333000
	ScopeViewTex=Texture'BW_Core_WeaponTex.SRS900-SUI.SRS900ScopeView'
	ScopeViewTexAlt=Texture'BW_Core_WeaponTex.SRS900.SRS900ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoCrosshairInScope=True

	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	GunLength=72.000000
	ParamsClasses(0)=Class'SRS900WeaponParamsComp'
	ParamsClasses(1)=Class'SRS900WeaponParamsClassic'
	ParamsClasses(2)=Class'SRS900WeaponParamsRealistic'
    ParamsClasses(3)=Class'SRS900WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.SRS900PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	Description="Designed and refined in NDTR Industries' top notch R&D labs before the war, the SRS is indeed a fine weapon. Using high velocity 7.62mm ammunition, this rifle causes a lot of damage to the target, but suffers from high recoil, chaos and a low clip capacity. The SRS-600 is a civilian variant of the SRS-900, awarded a 10 out of 10 by the Gentleman's Rifle Association for amazing precision and accuracy and was quoted to be 'the best gun for big game and home defense!' The 900 variant can now incorporate a silencer to the end of the barrel, increasing its capabilities as a stealth weapon. This particular model also features a versatile, red-filter scope, complete with various tactical readouts and indicators, including a range finder, stability meter, elevation indicator, ammo display and stealth meter. After 11 years of being backlogged and the Skrith wars dampening sales, gold camos are slated to return to shelves soon."
	Priority=40
	HudColor=(B=50,G=50,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=6
	PickupClass=Class'BallisticProV55.SRS900Pickup'
	PlayerViewOffset=(X=3.00,Y=3.00,Z=-4.00)
	SightOffset=(X=9.000000,Z=3.150000)
	
	AttachmentClass=Class'BallisticProV55.SRS900Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.SRS900.SmallIcon_SRS900'
	IconCoords=(X2=127,Y2=31)
	ItemName="SRS-900 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS900'
	DrawScale=0.300000
	
	//Arena Scope Stuff
	GeneralUITexArena=Texture'BW_Core_WeaponTex.SRS900-SUI.SRS900UI'
	ScopeViewOverlayTexArena=FinalBlend'BW_Core_WeaponTex.SRS900-SUI.SRSScopeViewOverlay_FB'
	ScopeViewOverlayTexClassic=FinalBlend'BW_Core_WeaponTex.SRS900.SRSScopeViewOverlay_FB'

	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BW_Core_WeaponTex.SRS900.SRS900Main'
	Skins(2)=Shader'BW_Core_WeaponTex.SRS900.SRS900ScopeShine'
	Skins(3)=Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo'
	Skins(4)=FinalBlend'BW_Core_WeaponTex.SRS.SRS-HSight-FB'
	Skins(5)=Shader'BW_Core_WeaponTex.SRS.SRS-HSight-S'
}

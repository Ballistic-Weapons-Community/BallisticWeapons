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

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated event PostNetBeginPlay()
{
	local NavigationPoint N;
	local float TotalZ;
	local int ZCount;

	super.PostNetBeginPlay();

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

// Draw the scope view
simulated event RenderOverlays (Canvas C)
{
	local float	ScaleFactor, HF, ZM, ImageScaleRatio;
	local Vector X, Y, Z;

	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		return;
	}
	GetViewAxes(X, Y, Z);
	if (BFireMode[0].MuzzleFlash != None)
	{
		BFireMode[0].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
		BFireMode[0].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
		C.DrawActor(BFireMode[0].MuzzleFlash, false, false, DisplayFOV);
	}
	if (BFireMode[1].MuzzleFlash != None)
	{
		BFireMode[1].MuzzleFlash.SetLocation(Instigator.Location + Instigator.EyePosition() + X * SMuzzleFlashOffset.X + Z * SMuzzleFlashOffset.Z);
		BFireMode[1].MuzzleFlash.SetRotation(Instigator.GetViewRotation());
		C.DrawActor(BFireMode[1].MuzzleFlash, false, false, DisplayFOV);
	}
	SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
	SetRotation(Instigator.GetViewRotation());
	
	ScaleFactor = C.ClipX / 1600;
    if (ScopeViewTex != None)
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
   	 if (ScopeViewTex != None)
   	 {
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		
		//SRS's scope is off from the normal.
		ImageScaleRatio = 1.24;
		
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);

		C.SetPos((C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeY*ImageScaleRatio), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ImageScaleRatio))/2, C.SizeY, 0, 0, 1, 1024);
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
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=3)
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_SRS900'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
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
	CockAnimRate=1.200000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-Cock',Volume=0.650000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.SRS900.SRS-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Burst",ModeID="WM_Burst",Value=3.000000)
	WeaponModes(1)=(ModeName="Semi",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	ScopeXScale=1.333000
	ScopeViewTex=Texture'BW_Core_WeaponTex.SRS900.SRS900ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=20.000000
	bNoCrosshairInScope=True
	SightOffset=(X=20.000000,Z=11.750000)
	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	GunLength=72.000000
	ParamsClasses(0)=Class'SRS900WeaponParams'
	ParamsClasses(1)=Class'SRS900WeaponParamsClassic'
	FireModeClass(0)=Class'BallisticProV55.SRS900PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	Description="Another battlefield favourite produced by high-tech manufacturer, NDTR Industries, the SRS-900 is indeed a fine weapon. Using high velocity 7.62mm ammunition, this rifle causes a lot of damage to the target, but suffers from high recoil, chaos and a low clip capacity. The altered design, can now incorporate a silencer to the end of the barrel, increasing its capabilities as a stealth weapon. This particular model, also features a versatile, red-filter scope, complete with various tactical readouts and indicators, including a range finder, stability metre, elevation indicator, ammo display and stealth meter."
	Priority=40
	HudColor=(B=50,G=50,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=6
	PickupClass=Class'BallisticProV55.SRS900Pickup'
	PlayerViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
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
	DrawScale=0.500000
	Skins(0)=Texture'BW_Core_WeaponTex.SRS900.SRS900Main'
	Skins(1)=Texture'BW_Core_WeaponTex.SRS900.SRS900Scope'
	Skins(2)=Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo'
	Skins(3)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}

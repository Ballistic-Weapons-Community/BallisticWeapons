//=============================================================================
// R9RangerRifle.
//
// A simple, semi-auto, unscoped, accuracte, medium to high power, long range
// rifle. Secondary fire is iron sights. Has a decent Mag. Not too great at
// mobile combat. Suffers from long-gun.
// A handy when you need a quick to opertate rifle for fighting at medium to
// long range. (Works pretty well close-up too!)
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class R9RangerRifle extends BallisticWeapon;

var float LastModeChangeTime;

exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None) 
	{
		if (ModeNum == 0)
			ServerSwitchWeaponMode(255);
		else ServerSwitchWeaponMode(ModeNum-1);
	}
}

// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	local int m;
	
	if (bPreventReload || ReloadState != RS_None)
		return;

	if (NewMode == 255)
		NewMode = CurrentWeaponMode + 1;
		
	if (NewMode == CurrentWeaponMode)
		return;
	
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}

	if (!WeaponModes[NewMode].bUnavailable)
	{
		CommonSwitchWeaponMode(NewMode);
		ClientSwitchWeaponMode(CurrentWeaponMode);
		NetUpdateTime = Level.TimeSeconds - 1;
	}
	
	// mode switch for this weapon causes a reload
	R9Attachment(ThirdPersonActor).CurrentTracerMode = CurrentWeaponMode;
		
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;

	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');

	CommonStartReload(0);	//Server animation
	ClientStartReload(0);	//Client animation
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (WeaponModes[CurrentWeaponMode].ModeID ~= "WM_FullAuto" || WeaponModes[CurrentWeaponMode].ModeID ~= "WM_None")
		return true;
	if ((Mode == 0 && FireCount >= WeaponModes[CurrentWeaponMode].Value) || (Mode == 1 && FireCount >= 2))
		return false;
	return true;
}

//===========================================================================
// ManageHeatInteraction
//
// Called from primary fire when hitting a target. Objects don't like having iterators used within them
// and may crash servers otherwise.
//===========================================================================
function int ManageHeatInteraction(Pawn P, int HeatPerShot)
{
	local R9HeatManager HM;
	local int HeatBonus;
	
	foreach P.BasedActors(class'R9HeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'R9HeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
	{
		HeatBonus = HM.Heat;
		if (Vehicle(P) != None)
			HM.AddHeat(HeatPerShot/4);
		else HM.AddHeat(HeatPerShot);
	}
	
	return heatBonus;
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
function byte BestMode()
{
	local Bot B;
	local R9HeatManager HM;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;
		
	if (level.TimeSeconds - LastModeChangeTime < 1.4 - B.Skill*0.1)
		return 0;
		
		
	Dist = VSize(Instigator.Location - B.Enemy.Location);
	
	foreach B.Enemy.BasedActors(class'R9HeatManager', HM)
		break;
		
	if (HM != None || B.Enemy.Health + B.Enemy.ShieldStrength > 200)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
			R9PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		R9PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	}
	
	LastModeChangeTime = level.TimeSeconds;

	return 0;
}

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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.8;	}
// End AI Stuff =====

defaultproperties
{
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=1)
	BigIconMaterial=Texture'BW_Core_WeaponTex.ui.BigIcon_R9'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic rifle fire. High damage, long range, high penetration and moderate recoil. Sustained damage output is modest."
	ManualLines(1)="As primary, except fires subsonic rounds. Loses damage over range but has lower recoil, lesser flash and is quieter."
	ManualLines(2)="As a long-ranged weapon lacking a scope, it has a reasonably quick aiming time. Does not use tracer rounds. Cumbersome to use in close combat."
	SpecialInfo(0)=(Info="240.0;25.0;0.5;50.0;1.0;0.2;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Cock')
	ReloadAnimRate=1.250000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipHit')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Regular")
	WeaponModes(1)=(ModeName="Freeze",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(ModeName="Laser",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(3)=(ModeName="Phosphorous",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(4)=(ModeName="Poison",bUnavailable=True,ModeID="WM_SemiAuto",Value=1.000000)
	CurrentWeaponMode=0
	FullZoomFOV=60.000000
	bNoCrosshairInScope=True
	SightPivot=(Pitch=50)
	SightOffset=(X=25.000000,Y=0.030000,Z=6.200000)
	SightDisplayFOV=40.000000
	GunLength=80.000000
	ParamsClasses(0)=Class'R9WeaponParams'
	ParamsClasses(1)=Class'R9WeaponParamsClassic'
	FireModeClass(0)=Class'BallisticProV55.R9PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.R9SecondaryFire'
	SelectAnimRate=1.100000
	BringUpTime=0.400000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Outstanding reliability and durability in the field are what characterise one of Black & Wood's legendary rifles. Though not widely used by most military forces, the R9 is renowned for its near indestructable design, and superb reliability. Those who use the weapon, mostly snipers, hunters, and specialised squads, swear by it's accuracy and dependability. Often used without fancy features or burdening devices such as optical scopes and similar attachements, the R9 is a true legend with it's users."
	Priority=33
	HudColor=(G=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=3
	PickupClass=Class'BallisticProV55.R9Pickup'
	PlayerViewOffset=(Y=9.500000,Z=-11.000000)
	AttachmentClass=Class'BallisticProV55.R9Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.ui.SmallIcon_R9'
	IconCoords=(X2=127,Y2=31)
	ItemName="R9 Ranger Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_R9'
	DrawScale=0.500000
    Skins(0)=Shader'BW_Core_WeaponTex.R9.USSR-Shiny' 
	Skins(1)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'	
}

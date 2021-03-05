//=============================================================================
// M46AssaultRifle.
//
// M46 Assault Rifle, a powerful full auto assault rifle with a limited scope.
// Also has proximity grenade launcher secondary. It can be used to plant discreet devices to blow players to hell when they pass.
// Grenades also stick to players and vehicles, automatically triggering the mine.
//
// Weapon balance basis: FN SCAR-H
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class M46AssaultRifle extends BallisticWeapon;

var() name		GrenadeLoadAnim;	//Anim for grenade reload
var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var	float		LastDetonationTime;

var 	array<M46Mine> Mines;

replication
{
	unreliable if (Role == Role_Authority)
		ClientGrenadePickedUp;
}

// Notifys for greande loading sounds
simulated function Notify_OAARGrenadeOpen()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_OAARGrenadeIn()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_OAARGrenadeClose()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64); M46SecondaryFire(FireMode[1]).bLoaded = true; FireMode[1].PreFireTime = FireMode[1].default.PreFireTime; }

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else
			M46SecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			M46SecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return M46SecondaryFire(FireMode[1]).bLoaded;
}

function bool AddMine(M46Mine Proj)
{
	Mines[Mines.Length] = Proj;
	return (CurrentWeaponMode == 1);
}

// Tell our ammo that this is the M46 it must notify about grenade pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_M46Grenades(Ammo[1]) != None)
		Ammo_M46Grenades(Ammo[1]).DaM46 = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == GrenadeLoadAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
	Super.AnimEnd(Channel);
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || M46SecondaryFire(FireMode[1]).bLoaded)
	{
		if(!M46SecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}
	if (ReloadState == RS_None)
	{
		ReloadState=RS_Cocking;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}
}

simulated function Destroyed()
{
	local int i;
	for (i=0; i < Mines.Length; ++i)
	{
		if (Mines[i] != None)
			Mines[i].Explode(Mines[i].Location, Vector(Mines[i].Rotation));
	}
	
	Super.Destroyed();
}

simulated function bool HasNonMagAmmo(byte Mode)
{
	if ((Mode == 255 || Mode == 0) && Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
		return true;
	if ((Mode == 255 || Mode == 1) && Ammo[1] != None && FireMode[1] != None && Ammo[1].AmmoAmount >= FireMode[1].AmmoPerFire)
		return true;
	return false;
}

function ServerSwitchWeaponMode (byte NewMode)
{
	local int i;
	
	if (LastDetonationTime + 0.3 > Level.TimeSeconds)
		return;
	super.ServerSwitchWeaponMode (NewMode);
	for (i = 0; i < Mines.Length; i++)
	{
		if (Mines[i] == None)
			Mines.Remove(i, 1);
		else Mines[i].SetManualMode(CurrentWeaponMode == 1);
	}
	LastDetonationTime = Level.TimeSeconds;
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (Instigator.bNoWeaponFiring || CurrentWeaponMode != 1 || LastDetonationTime + 0.75 > Level.TimeSeconds )
		return;
	ServerWeaponSpecial();
	LastDetonationTime = Level.TimeSeconds;
}

function ServerWeaponSpecial(optional byte i)
{
	local int j;
	
	if (Instigator.bNoWeaponFiring || CurrentWeaponMode != 1 || LastDetonationTime + 0.75 > Level.TimeSeconds )
		return;
		
	for (j = Mines.Length - 1; j >= 0; j--)
	{
		if (Mines[j] == None)
			Mines.Remove(j, 1);
		else
		{
			if (Level.TimeSeconds < Mines[j].TriggerStartTime - 1 || Mines[j].TriggerStartTime == 0)
				break;
			Mines[j].Explode(Mines[j].Location, Vector(Mines[j].Rotation));
			Mines.Remove(j, 1);
			break;
		}
	}
	LastDetonationTime = Level.TimeSeconds;
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();
}

simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}
// End AI Stuff =====

defaultproperties
{
	GrenadeLoadAnim="GrenadeReload"
	GrenOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	GrenCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.OA-AR.BigIcon_OAAR'
	BigIconCoords=(Y1=40,Y2=235)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Splash=True
	bWT_Machinegun=True
	bWT_Projectile=True
	ManualLines(0)="Automatic battle rifle fire. Moderate damage per shot with greater range and penetration than assault rifles. Recoil is moderate."
	ManualLines(1)="Deploys a mine. These mines can be detonated with the Weapon Function key shortly after being placed for severe damage. Mines can be picked up with the Use key."
	ManualLines(2)="Effective at medium to long range."
	SpecialInfo(0)=(Info="240.0;25.0;0.9;70.0;0.9;0.2;0.7")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	CockAnimPostReload="ReloadEndCock"
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_Cock',Volume=1.100000)
	ReloadAnimRate=1.250000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipHit',Volume=1.000000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipOut',Volume=1.000000)
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.OA-AR.OA-AR_ClipIn',Volume=1.000000)
	ClipInFrame=0.700000
	WeaponModes(0)=(ModeName="Proximity Detonation",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Manual Detonation",ModeID="WM_FullAuto")
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=1
	ScopeXScale=1.250000
	ZoomInAnim="ZoomIn"
	ZoomOutAnim="ZoomOut"
	ScopeViewTex=Texture'BW_Core_WeaponTex.SRS900.SRS900ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=60.000000
	bNoCrosshairInScope=True
	SightPivot=(Pitch=600,Roll=-1024)
	SightOffset=(Y=-1.000000,Z=12.500000)
	SightDisplayFOV=40.000000
	MinZoom=2.000000
	MaxZoom=4.000000
	ZoomStages=1
	ParamsClasses(0)=Class'M46WeaponParams'
	ParamsClasses(1)=Class'M46WeaponParamsClassic' //todo: RDS variant
    AmmoClass(0)=Class'BallisticProV55.Ammo_M46Clip'	
	AmmoClass(1)=Class'BallisticProV55.Ammo_M46Clip'
	FireModeClass(0)=Class'BallisticProV55.M46PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.M46SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.700000
	CurrentRating=0.700000
	Description="The M46 was one of Black & Wood's first forays into high powered assault weaponry, specifically rifles. As with all of Black & Wood's weapons, the 'Jackal' is incredibly reliable and tough. Used by certain Terran units, the M46 is typically equipped with a short-range optical scope and often various Grenade Launcher attachments. While not quite yet a widely used weapon, its reputation has grown in recent times as heroic stories of Armoured Squadron 190's use of it has spread amongst the bulk of the UTC troops."
	DisplayFOV=55.000000
	Priority=41
	HudColor=(G=175)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	GroupOffset=1
	PickupClass=Class'BallisticProV55.M46Pickup'
	PlayerViewOffset=(X=5.000000,Y=4.750000,Z=-8.000000)
	PlayerViewPivot=(Pitch=384)
	AttachmentClass=Class'BallisticProV55.M46Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.OA-AR.SmallIcon_OAAR'
	IconCoords=(X2=127,Y2=31)
	ItemName="M46A1 Combat Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_M46A1'
	DrawScale=0.300000
}

//=============================================================================
// XMK5SubMachinegun.
//
// XMK5 SubMachinegun, a powerful SubMachinegun with an attached dart launcher for stunning 
// and poisoning your prey.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class XMK5SubMachinegun extends BallisticWeapon;

var() name		DartLoadAnim;		//Anim for Dart reload
var() Sound		DartLoadSound;		//Sounds for Dart reloading
var() Sound		DartCockSound;		//Sounds for Dart cocking

replication
{
	unreliable if (Role == Role_Authority)
		ClientDartPickedUp;
}

// Notifys for Dart loading sounds
simulated function Notify_DartIn()			{	PlaySound(DartLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_DartHit()			{	PlaySound(DartCockSound, SLOT_Misc, 0.75, ,64);	XMK5SecondaryFire(FireMode[1]).bLoaded = true;	}

// A Dart has just been picked up. Loads one in if we're empty
function DartPickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadDart();
		else
			XMK5SecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientDartPickedUp();
}

simulated function ClientDartPickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
//		if (ClientState == WS_ReadyToFire)
			LoadDart();
//		else
//			XMK5SecondaryFire(FireMode[1]).bLoaded=true;
	}
}
simulated function bool IsDartLoaded()
{
	return XMK5SecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the XMK5 it must notify about Dart pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_XMK5Darts(Ammo[1]) != None)
		Ammo_XMK5Darts(Ammo[1]).DaXMK5 = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == DartLoadAnim)
	{
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		Super.AnimEnd(Channel);
}
// Load in a Dart
simulated function LoadDart()
{
	if (Ammo[1].AmmoAmount < 1 || XMK5SecondaryFire(FireMode[1]).bLoaded)
		return;
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		if (Role == ROLE_Authority)
			bServerReloading=True;
		PlayAnim(DartLoadAnim, 1.1, , 0);
	}
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
	if (seq == DartLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingDart())
		{
			LoadDart();
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
			if (AmmoAmount(1) > 0 && !IsReloadingDart())
				LoadDart();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadDart ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsDartLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadDart() && !IsReloadingDart())
		LoadDart();
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
/*
	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
		return 0;
	else if (MagAmmo < 1)
		return 1;
*/
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

simulated function bool IsReloadingDart()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == DartLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsDartLoaded())
	{
		if (IsReloadingDart())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadDart())
		{
			LoadDart();
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

defaultproperties
{
	DartLoadAnim="Reload2"
	DartLoadSound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_LoadDart'
	DartCockSound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_CockDart'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.OA-SMG.BigIcon_OASMG'
	BigIconCoords=(Y1=16,Y2=210)
	
	bWT_Bullet=True
	bWT_Machinegun=True
	bWT_Projectile=True
	ManualLines(0)="Automatic submachinegun fire. Higher damage per bullet than other SMGs, good range and solid DPS, but higher recoil. Penetration is acceptable."
	ManualLines(1)="Launches a stun dart. Upon impact with the enemy, deals damage over time and inflicts a blinding effect multiple times upon them."
	ManualLines(2)="Effective at close range."
	SpecialInfo(0)=(Info="180.0;15.0;0.7;60.0;0.1;0.4;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	AIRating=0.8
	CurrentRating=0.8
	CockAnimPostReload="ReloadEndCock"
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_Cock',Volume=1.350000)
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_ClipOut',Volume=1.150000)
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_ClipIn',Volume=1.150000)
	ClipInFrame=0.760000
	WeaponModes(0)=(bUnavailable=True)
	bNoCrosshairInScope=True
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(G=105,R=0,A=133),Color2=(G=0),StartSize1=87,StartSize2=55)
	
	SightPivot=(Pitch=200)
	SightZoomFactor=0.85
	SightOffset=(X=1.000000,Z=17.750000)
	SightDisplayFOV=25.000000
	GunLength=40.000000
	ParamsClasses(0)=Class'XMK5WeaponParamsComp'
	ParamsClasses(1)=Class'XMK5WeaponParamsClassic'
	ParamsClasses(2)=Class'XMK5WeaponParamsRealistic'
    ParamsClasses(3)=Class'XMK5WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.XMK5PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.XMK5SecondaryFire'
	PutDownTime=0.350000
	SelectForce="SwitchToAssaultRifle"
	Description="NDTR's recent line of urban submachineguns, specfically the XMk5, has garnered attention from various UTC units operating in such environments. The XMk5 is often, and is indeed encouraged to be, fitted with all manner of attachments designed by NDTR as well. While many of the attachments are 'standard' sights, grenade launchers, flash lights and laser sights, there are other more peculiar devices. One of the most popular of these, is a unique, air-powered, dart launcher. The most commonly used dart, is one that stuns and poisons the victim, making them easy prey for the XMk5's primary bullet fire mode."
	Priority=41
	HudColor=(G=150,R=225)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=2
	PickupClass=Class'BallisticProV55.XMK5Pickup'
	PlayerViewOffset=(X=2.000000,Y=8.000000,Z=-10.000000)
	AttachmentClass=Class'BallisticProV55.XMK5Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.OA-SMG.SmallIcon_OASMG'
	IconCoords=(X2=127,Y2=31)
	ItemName="XMk5 Submachine Gun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_XMK5'
	DrawScale=0.450000
}

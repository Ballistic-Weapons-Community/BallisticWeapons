//=============================================================================
// MARS-3 (i.e. F2000.)
//=============================================================================
class F2000AssaultRifle extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//

var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var() name		GrenadeLoadAnim;	//Anim for grenade reload

var(F2000AssaultRifle) name		ScopeBone;			// Bone to use for hiding scope

replication
{
	reliable if (Role == ROLE_Authority)
		ClientGrenadePickedUp;
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

//=====================================================================
// GRENADE CODE
//=====================================================================

// Notifys for greande loading sounds
simulated function Notify_F2000GrenOpen()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenLoad()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_F2000GrenClose()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64);F2000SecondaryFire(FireMode[1]).bLoaded = true;		}

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else

			F2000SecondaryFire(FireMode[1]).bLoaded=true;
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
			F2000SecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return F2000SecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the F2000 it must notify about grenade pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_F2000Grenades(Ammo[1]) != None)
		Ammo_F2000Grenades(Ammo[1]).DaF2K = self;
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || F2000SecondaryFire(FireMode[1]).bLoaded)
	{
		if(!F2000SecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}

	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
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

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
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

//=====================================================================
// SUPPRESSOR CODE
//=====================================================================
function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	F2000PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading=True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}

simulated function Notify_MARSSilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_MARSSilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_MARSSilencerOff()
{
	PlaySound(SilencerOffSound,,0.5);
}
simulated function Notify_MARSSilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}
simulated function Notify_MARSSilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}
simulated function Notify_MARSSilencerHide()
{
	SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}
simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

//=====================================================================
// AI INTERFACE CODE
//=====================================================================
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

defaultproperties
{
     SilencerBone="tip2"
     SilencerOnAnim="SilencerOn"
     SilencerOffAnim="SilencerOff"
     SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
     SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
     SilencerOnTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     SilencerOffTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
     GrenOpenSound=Sound'BallisticSounds2.M50.M50GrenOpen'
     GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
     GrenCloseSound=Sound'BallisticSounds2.M50.M50GrenClose'
     GrenadeLoadAnim="GLReload"
     ScopeBone="EOTech"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.MARS.BigIcon_F2000Alt'
     BigIconCoords=(X1=32,Y1=40,X2=475)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     ManualLines(0)="5.56mm fire. Has a fast fire rate and high sustained DPS, but high recoil, limiting its hipfire."
     ManualLines(1)="Launches a cryogenic grenade. Upon impact, freezes nearby enemies, slowing their movement. The effect is proportional to their distance from the epicentre. This attack will also extinguish the fires of an FP7 grenade."
     ManualLines(2)="The Weapon Special key attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible.||Effective at close to medium range."
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M50.M50Putaway')
     CockAnimPostReload="ReloadEndCock"
     CockAnimRate=1.10000
     CockSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-BoltPull',Volume=1.100000,Radius=32.000000)
     ReloadAnimRate=1.10000
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagFiddle',Volume=1.200000,Radius=32.000000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagOut',Volume=1.200000,Radius=32.000000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.MARS.MARS-MagIn',Volume=1.200000,Radius=32.000000)
     ClipInFrame=0.650000
     WeaponModes(0)=(bUnavailable=True)
     WeaponModes(1)=(ModeName="Burst",Value=4.000000)
     WeaponModes(2)=(ModeName="Auto")
     bNoCrosshairInScope=True
     SightOffset=(X=6.000000,Y=-6.350000,Z=23.150000)
     SightDisplayFOV=25.000000
     SprintOffSet=(Pitch=-3000,Yaw=-4096)
	 
     AimSpread=16
     ChaosDeclineTime=0.5
     ChaosAimSpread=128
	 
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.080000),(InVal=0.25000,OutVal=0.2000),(InVal=0.3500000,OutVal=0.150000),(InVal=0.4800000,OutVal=0.20000),(InVal=0.600000,OutVal=-0.050000),(InVal=0.750000,OutVal=0.0500000),(InVal=0.900000,OutVal=0.15),(InVal=1.000000,OutVal=0.3)))
     RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.250000),(InVal=0.400000,OutVal=0.500000),(InVal=0.600000,OutVal=0.800000),(InVal=0.800000,OutVal=0.900000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.050000
     RecoilYFactor=0.050000
	 
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.140000
	 
	 ViewRecoilFactor=0.4
	 
     FireModeClass(0)=Class'BWBPRecolorsPro.F2000PrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.F2000SecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.750000
     CurrentRating=0.750000
     Description="The 3 variant of the Modular Assault Rifle System is one of many rifles built under NDTR Industries' MARS project. The project, which was aimed to produce a successor to the army's current M50 and M30 rifles, has produced a number of functional prototypes. ||The 3 variant is a short barreled model designed for CQC use with non-standard ammunition. Field tests have shown excellent results when loaded with Snowstorm or Firestorm rounds, and above-average performance with Zero-G, toxic and electro rounds. This specific MARS-3 is loaded with Snowstorm XII rounds and is set to fire at a blistering 850 RPM. Enemies hit with this ammunition will be chilled and slowed."
     Priority=65
     HudColor=(B=255,G=175,R=125)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBPRecolorsPro.F2000Pickup'
     PlayerViewOffset=(X=0.500000,Y=12.000000,Z=-18.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBPRecolorsPro.F2000Attachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.MARS.SmallIcon_F2000Alt'
     IconCoords=(X2=127,Y2=31)
     ItemName="MARS-3 'Snowstorm' XII"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.MARS3_FP'
     DrawScale=0.300000
}

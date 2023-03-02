//=============================================================================
// ProtoLMG
//=============================================================================
class ProtoSMG extends BallisticWeapon;

#exec OBJ LOAD File=BWBP_CC_Tex.utx

var() name			PhotonLoadAnim, PhotonLoadEmptyAnim;	// Anim for reloading photon ammo

var() Sound			PhotonMagOutSound;		// Sounds for Photon reloading
var() Sound			PhotonMagSlideInSound;	//
var() Sound			PhotonMagHitSound;		//
var() Sound			PhotonMagCockSound;		//

var   bool			bSilenced;				// Silencer on. Silenced
var() name			SilencerBone;			// Bone to use for hiding silencer
var() name			SilencerOnAnim;			// Think hard about this one...
var() name			SilencerOffAnim;		//
var() sound			SilencerOnSound;		// Silencer stuck on sound
var() sound			SilencerOffSound;		//
var() sound			SilencerOnTurnSound;	// Silencer screw on sound
var() sound			SilencerOffTurnSound;	//

var rotator ScopeSightPivot;
var vector ScopeSightOffset;

var rotator IronSightPivot;
var vector IronSightOffset;

var Name 			ReloadAltAnim;
var BUtil.FullSound DrumInSound, DrumHitSound, DrumOutSound;
var	bool			bAltNeedCock;			//Should SG cock after reloading

var float StealthRating, StealthImps;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
	unreliable if (ROLE == Role_Authority)
		ClientPhotonPickedUp; 
}

//=====================================================================
// SUPPRESSOR CODE
//=====================================================================
function ServerSwitchSilencer(bool bNewValue)
{
	if (bSilenced == bNewValue)
		return;

	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);

	StealthImpulse(0.1);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);

	OnSuppressorSwitched();
}

simulated function OnRecoilParamsChanged()
{
	Super.OnRecoilParamsChanged();

	if (bSilenced)
		ApplySuppressorRecoil();
}

simulated function ApplySuppressorAim()
{
	AimComponent.AimSpread.Min *= 1.25;
	AimComponent.AimSpread.Max *= 1.25;
}

function ApplySuppressorRecoil()
{
	RcComponent.XRandFactor *= 0.7f;
	RcComponent.YRandFactor *= 0.7f;
}

simulated function StealthImpulse(float Amount)
{
	if (Instigator.IsLocallyControlled())
		StealthImps = FMin(1.0, StealthImps + Amount);
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

simulated function Notify_SilencerAdd()
{
	PlaySound(SilencerOnSound,,0.5);
}

simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}

simulated function Notify_SilencerRemove()
{
	PlaySound(SilencerOffSound,,0.5);
}

simulated function Notify_SilencerOffTurn()
{
	PlaySound(SilencerOffTurnSound,,0.5);
}

simulated function Notify_SilencerShow()
{
	SetBoneScale (0, 1.0, SilencerBone);
}

simulated function Notify_SilencerHide()
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

//===========================================================================
// Extra ammo type code
//===========================================================================

// Notifys for greande loading sounds
simulated function Notify_AltClipOut()			{	PlaySound(PhotonMagOutSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_AltClipSlideIn()		{	PlaySound(PhotonMagSlideInSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_SGCock()				{	PlaySound(PhotonMagCockSound, SLOT_Misc, 0.5, ,64);		}
simulated function Notify_AltClipIn()	
{	
	PlaySound(PhotonMagHitSound, SLOT_Misc, 0.5, ,64);
	if (Ammo[1].AmmoAmount < ProtoPrimaryFire(FireMode[0]).default.PhotonCharge)
		ProtoPrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
	else
		ProtoPrimaryFire(FireMode[0]).PhotonCharge = ProtoPrimaryFire(FireMode[0]).default.PhotonCharge;
}

// Photon has just been picked up. Loads one in if we're empty
function PhotonPickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadPhoton();
		else
		{
			if (Ammo[1].AmmoAmount < ProtoPrimaryFire(FireMode[0]).default.PhotonCharge)
				ProtoPrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
			else
				ProtoPrimaryFire(FireMode[0]).PhotonCharge = ProtoPrimaryFire(FireMode[0]).default.PhotonCharge;
		}
	}
	if (!Instigator.IsLocallyControlled())
		ClientPhotonPickedUp();
}

simulated function ClientPhotonPickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadPhoton();
		else
		{
			if (Ammo[1].AmmoAmount < ProtoPrimaryFire(FireMode[0]).default.PhotonCharge)
				ProtoPrimaryFire(FireMode[0]).PhotonCharge = Ammo[1].AmmoAmount;
			else
				ProtoPrimaryFire(FireMode[0]).PhotonCharge = ProtoPrimaryFire(FireMode[0]).default.PhotonCharge;
		}
	}
}

simulated function bool IsPhotonLoaded()
{
	if (ProtoPrimaryFire(FireMode[0]).PhotonCharge > 0)
		return true;
	else 
		return false;
}

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_ProtoAlt(Ammo[1]) != None)
		Ammo_ProtoAlt(Ammo[1]).Gun = self;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	if (anim == PhotonLoadAnim || anim == PhotonLoadEmptyAnim)
	{
		ReloadState = RS_None;
		IdleTweenTime=0.0;
		PlayIdle();
	}
	else
		IdleTweenTime=default.IdleTweenTime;
		
	Super.AnimEnd(Channel);
}

// Load in rockets
//if reserve ammo is above mag size, just need to check if the number of rockets is below the default
//if reserve ammo is less or equal to mag size, check if the number of rockets is below the reserve ammo

simulated function LoadPhoton()
{
	if (Ammo[1].AmmoAmount > ProtoPrimaryFire(FireMode[0]).default.PhotonCharge && ProtoPrimaryFire(FireMode[0]).PhotonCharge >= ProtoPrimaryFire(FireMode[0]).default.PhotonCharge)
		return;
		
	if (Ammo[1].AmmoAmount <= ProtoPrimaryFire(FireMode[0]).default.PhotonCharge && ProtoPrimaryFire(FireMode[0]).PhotonCharge >= Ammo[1].AmmoAmount)
		return;
		
	if (ReloadState == RS_None)
	{
		ReloadState = RS_Cocking;
		
		if (bScopeView && Instigator.IsLocallyControlled())
			TemporaryScopeDown(Default.SightingTime);
		
		if (ProtoPrimaryFire(FireMode[0]).PhotonCharge < 1 && HasAnim(PhotonLoadEmptyAnim))
			PlayAnim(PhotonLoadEmptyAnim, 0.75, , 0);
		else
			PlayAnim(PhotonLoadAnim, 0.75, , 0);
	}		
}

simulated function bool IsReloadingPhoton()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == PhotonLoadAnim || Anim == PhotonLoadEmptyAnim)
 		return true;
	return false;
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
	
	if (seq == PhotonLoadAnim || seq == PhotonLoadEmptyAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingPhoton())
		{
			LoadPhoton();
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
			if (AmmoAmount(1) > 0 && !IsReloadingPhoton())
				LoadPhoton();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (CurrentWeaponMode == 1)
		return FireCount <= ProtoPrimaryFire(FireMode[0]).default.PhotonCharge;
		
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadPhoton()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsPhotonLoaded() && AmmoAmount(1) > 0 && BotShouldReloadPhoton() && !IsReloadingPhoton())
		LoadPhoton();
}

// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	//consume ammo from other mode
	if (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false && CurrentWeaponMode == 1)
		ConsumeAmmo(CurrentWeaponMode, Load, bAmountNeededIsMax);
	else
		super.ConsumeMagAmmo(Mode, Load, bAmountNeededIsMax);
		
	return true;
}

//===========================================================================
// Dual scoping
//===========================================================================
exec simulated function ScopeView()
{
	if (ZoomType == ZT_Fixed && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		if (ZoomType == ZT_Fixed)
		{
			SightPivot = IronSightPivot;
			SightOffset = IronSightOffset;
			ZoomType = ZT_Irons;
			ScopeViewTex = None;
			SightingTime = default.SightingTime;
		}
	}
	
	Super.ScopeView();
}

exec simulated function ScopeViewRelease()
{
	if (ZoomType != ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

simulated function ScopeViewTwo()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	if (SightingState == SS_None)
	{
		ScopeViewTex = Texture'BWBP_CC_Tex.ProtoLMG.ProtoScope1';
		if (ZoomType == ZT_Irons)
		{
			SightPivot = ScopeSightPivot;
			SightOffset = ScopeSightOffset;
			ZoomType = ZT_Fixed;
			SightingTime = 0.4;
		}
	}
	
	Super.ScopeView();
}

simulated function ScopeViewTwoRelease()
{
	if (ZoomType == ZT_Irons && SightingState != SS_None && SightingState != SS_Active)
		return;
		
	Super.ScopeViewRelease();
}

// Swap sighted offset and pivot for left handers
simulated function SetHand(float InHand)
{
	IronSightPivot = default.SightPivot;
	IronSightOffset = default.SightOffset;

	super.SetHand(InHand);
	if (Hand < 0)
	{
		if (ZoomType != ZT_Irons)
		{
			ScopeSightOffset.Y = ScopeSightOffset.Y * -1;
			ScopeSightPivot.Roll = ScopeSightPivot.Roll * -1;
			ScopeSightPivot.Yaw = ScopeSightPivot.Yaw * -1;
		}
		else
		{
			IronSightOffset.Y = IronSightOffset.Y * -1;
			IronSightPivot.Roll = IronSightPivot.Roll * -1;
			IronSightPivot.Yaw = IronSightPivot.Yaw * -1;
		}
	}
}

//=====================================================================
// Photon Fire
//=====================================================================
simulated function float ChargeBar()
{
	return float(ProtoPrimaryFire(BFireMode[0]).PhotonCharge)/float(ProtoPrimaryFire(BFireMode[0]).default.PhotonCharge);
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

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsPhotonLoaded())
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

function bool CanAttack(Actor Other)
{
	if (!IsPhotonLoaded())
	{
		if (IsReloadingPhoton())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadPhoton())
		{
			LoadPhoton();
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.6;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.6;	}
// End AI Stuff =====

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
	PhotonMagOutSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOff'
	PhotonMagSlideInSound=Sound'BW_Core_WeaponSound.BX5.BX5-SecOn'
	PhotonMagHitSound=Sound'BW_Core_WeaponSound.A73.A73-PipeIn'
	PhotonMagCockSound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock'
	PhotonLoadAnim="ReloadAlt"
	PhotonLoadEmptyAnim="ReloadEmptyAlt"
	
	ScopeSightPivot=(Roll=-4096)
	ScopeSightOffset=(X=15.000000,Y=-3.000000,Z=24.000000)
	
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	SilencerOffTurnSound=SoundGroup'BW_Core_WeaponSound.XK2.XK2-SilencerTurn'
	//AltClipOutSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	//AltClipInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	//AltClipSlideInSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_CC_Tex.ProtoLMG.BigIcon_ProtoLMG'
	BigIconCoords=(X1=16,Y1=30)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Shotgun=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic 7.62mm fire. High power, but shorter effective range and suffers from high recoil."
	ManualLines(1)="Burst Fire Enables a Photon Burst, allowing for a forced faster rate of fire for the longer range engagement"
	ManualLines(2)="Effective at close to medium to long range. With the addition of the Scope, Red Dot Sight & the attachable Silencer"
	SpecialInfo(0)=(Info="240.0;25.0;0.9;85.0;0.1;0.9;0.4")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	MagAmmo=50
	CockAnimPostReload="Cock"
	CockAnimRate=1.400000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock',Volume=2.000000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagOut',Volume=2.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagIn',Volume=2.000000)
	ClipInFrame=0.700000
	bAltTriggerReload=True
	WeaponModes(0)=(ModeName="Full Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Photon Burst",ModeID="WM_Burst",Value=3.000000)
	WeaponModes(2)=(bUnavailable=True)
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=255,R=255,A=255),Color2=(B=255,G=52,R=59,A=255),StartSize1=96,StartSize2=96)
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)

	CurrentWeaponMode=0
	bNoCrosshairInScope=False
	SightPivot=(Pitch=128)
	SightOffset=(X=-10.000000,Y=-0.950000,Z=25.000000)
	GunLength=16.000000
	ParamsClasses(0)=Class'ProtoWeaponParams' 
	ParamsClasses(1)=Class'ProtoWeaponParamsClassic' 
	ParamsClasses(2)=Class'ProtoWeaponParamsRealistic' 
	//AmmoClass[0]=Class'BWBP_APC_Pro.Ammo_Proto'
	//AmmoClass[1]=Class'BWBP_APC_Pro.Ammo_ProtoAlt'
	FireModeClass(0)=Class'BWBP_APC_Pro.ProtoPrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.ProtoScopeFire'
	SelectAnimRate=1.000000
	PutDownAnimRate=1.000000
	PutDownTime=1.000000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	Description="After the restrictions of photon based weaponry was lifted, several manufacturers began working on making new weapons with the technology in mind.  One such company was NDTR Industries, who saw the development of the EP90 and decided to make a PDW like that on their own, utilizing the old P90 as their inspiration.  Now known as the FCO1-B Proto PDW, as the name implies, it's still a prototype with only a few 100 being made for testing.  Still relatively potent thanks to an integral silencer and a unique second magazine that is actually a photon battery, powering a special burst that disorients and disables any organic or mechanized target."
	DisplayFOV=55.000000
	Priority=41
	HudColor=(B=135)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=10
	PickupClass=Class'BWBP_APC_Pro.ProtoPickup'
	PlayerViewOffset=(X=16.000000,Y=7.000000,Z=-17.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_APC_Pro.ProtoAttachment'
	IconMaterial=Texture'BWBP_CC_Tex.ProtoLMG.SmallIcon_ProtoLMG'
	IconCoords=(X2=127,Y2=31)
	ItemName="FC-01B PROTO PDW"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	bShowChargingBar=True
	Mesh=SkeletalMesh'BWBP_CC_Anim.FPm_ProtoLMG'
	DrawScale=0.400000
}

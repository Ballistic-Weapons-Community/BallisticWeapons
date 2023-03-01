class SRS600Rifle extends BallisticWeapon HideDropDown CacheExempt;

var float StealthRating, StealthImps;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
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

function ServerSwitchSilencer(bool bNewValue)
{
	if (bNewValue == bSilenced)
		return;

	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;
	BFireMode[0].bAISilent = bSilenced;
	SRS600PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
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

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	}

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.75, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.0;	}
// End AI Stuff =====

defaultproperties
{
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=3)
	BigIconMaterial=Texture'BW_Core_WeaponTex.SRS.BigIcon_SRSM2'
	BigIconCoords=(Y2=240)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="High-powered battle rifle fire. Long range, good penetration and high per-shot damage. Recoil is significant."
	ManualLines(1)="Attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible."
	ManualLines(2)="Effective at medium to long range."
	SpecialInfo(0)=(Info="240.0;20.0;0.9;75.0;1.0;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
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
	FullZoomFOV=70.000000
	bNoCrosshairInScope=True
	SightOffset=(X=16.000000,Z=10.460000)
	SightDisplayFOV=25.000000
	GunLength=72.000000
	ParamsClasses(0)=Class'SRS600WeaponParams'
	ParamsClasses(1)=Class'SRS600WeaponParamsClassic'
	ParamsClasses(2)=Class'SRS600WeaponParamsRealistic'
    ParamsClasses(3)=Class'SRS600WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.SRS600PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(G=255,A=108),Color2=(G=0),StartSize1=103,StartSize2=19)
	
	SelectAnimRate=1.350000
	BringUpTime=0.350000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.80000
	Description="Another battlefield favourite produced by high-tech manufacturer, NDTR Industries, the SRS-900 is indeed a fine weapon. Using high velocity 7.62mm ammunition, this rifle causes a lot of damage to the target, but suffers from high recoil, chaos and a low clip capacity. The altered design, can now incorporate a silencer to the end of the barrel, increasing its capabilities as a stealth weapon. This particular model, also features a versatile, red-filter scope, complete with various tactical readouts and indicators, including a range finder, stability metre, elevation indicator, ammo display and stealth meter."
	Priority=40
	HudColor=(B=50,G=50,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	PickupClass=Class'BallisticProV55.SRS600Pickup'
	PlayerViewOffset=(X=2.000000,Y=9.000000,Z=-10.000000)
	AttachmentClass=Class'BallisticProV55.SRS600Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.SRS.SmallIcon_SRSM2'
	IconCoords=(X2=127,Y2=31)
	ItemName="SRS-600 Battle Rifle"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SRS600'
	DrawScale=0.500000
	Skins(0)=Texture'BW_Core_WeaponTex.SRS.SRSNSGrey'
	Skins(1)=Texture'BW_Core_WeaponTex.SRS900.SRS900Scope'
	Skins(2)=Texture'BW_Core_WeaponTex.SRS900.SRS900Ammo'
	Skins(3)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}

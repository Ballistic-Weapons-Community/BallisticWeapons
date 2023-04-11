//=============================================================================
// R78Rifle.
//
// Powerful, accurate semi automatic rifle with good power and reasonable
// reload time, but low clip capacity. Secondary fire makes it the weapon it is
// by providing a powerful scope. Holding secondary zooms in further initially,
// but the player can still use Prev and Next weapon to adjust.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class R78Rifle extends BallisticWeapon;

var   bool		bSilenced;
var() name		SilencerBone;
var() name		SilencerOnAnim;			
var() name		SilencerOffAnim;
var() sound		SilencerOnSound;
var() sound		SilencerOffSound;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();

	if (!class'BallisticReplicationInfo'.static.IsArena())
	{
		CockAnim = 'Cock';
		CockAnimPostReload = 'Cock'; 
		ReloadEmptyAnim='ReloadEmptySlow';
		CockSound.Sound=Sound'BW_Core_WeaponSound.R78.R78-Cock';
	}
}

function ServerSwitchSilencer(bool bDetachSuppressor)
{
	SwitchSilencer(bSilenced);
}

exec simulated function WeaponSpecial(optional byte i)
{
    if (class'BallisticReplicationInfo'.static.IsArenaOrTactical())
        return;

	if (ReloadState != RS_None || SightingState != SS_None)
		return;
		
	TemporaryScopeDown(0.5);
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
	ReloadState = RS_GearSwitch;
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

simulated function Notify_SilencerShow(){	SetBoneScale (0, 1.0, SilencerBone);	bSilenced=True; R78PrimaryFire(BFireMode[0]).SetSilenced(true);}
simulated function Notify_SilencerHide(){	SetBoneScale (0, 0.0, SilencerBone);	bSilenced=False; R78PrimaryFire(BFireMode[0]).SetSilenced(false);}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None && Type != 1)
		TemporaryScopeDown(0.5);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockSlow()
{
	bNeedCock = False;
	ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 2048, 3072); 
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.9;	}
// End AI Stuff =====

defaultproperties
{
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerAdd"
	SilencerOffAnim="SilencerRemove"
	SilencerOnSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.SRS900.SRS-SilencerOff'

     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_R78'
     
     bWT_Bullet=True
     ManualLines(0)="Bolt-action sniper rifle fire. High damage, long range, slow fire rate."
     ManualLines(1)="Engages the scope."
     ManualLines(2)="Does not use tracer rounds. Effective at long range and against clustered enemies."
     SpecialInfo(0)=(Info="240.0;25.0;0.5;60.0;10.0;0.0;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	 PutDownTime=0.5
     CockAnim="CockQuick"
     //CockSound=(Sound=Sound'BW_Core_WeaponSound.TEC.RSMP-Cock')
	 CockSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78NS-Cock')
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78-ClipIn')
     ClipInFrame=0.650000
     bCockOnEmpty=True
     WeaponModes(0)=(ModeName="Bolt-Action")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0

	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.R78InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=192),StartSize1=98,StartSize2=87)

     ScopeXScale=1.333000
     ZoomInAnim="ZoomIn"
     ScopeViewTex=Texture'BW_Core_WeaponTex.R78.RifleScopeView'
     ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=20.000000
     bNoCrosshairInScope=True
     MinZoom=4.000000
     MaxZoom=16.000000
     ZoomStages=2
     GunLength=80.000000
     ParamsClasses(0)=Class'R78WeaponParamsComp'
     ParamsClasses(1)=Class'R78WeaponParamsClassic'
     ParamsClasses(2)=Class'R78WeaponParamsRealistic'
     ParamsClasses(3)=Class'R78WeaponParamsTactical'
     FireModeClass(0)=Class'BallisticProV55.R78PrimaryFire'
     FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.800000
     CurrentRating=0.800000
     bSniping=True
     Description="Originally taken from the design of a bird hunting rifle, the R78 'Raven' is a favourite among military snipers and commando corps. Used to a great extent by the expert marksmen of the New European Army, the Raven is extremely reliable and capable of incredible damage in a single shot. The added long distance sniping scope makes the R78 one of the most deadly weapons. Of course, the gun is only as good as the soldier using it; it has a low magazine capacity, long reload times and is terribly ineffective in close quarters combat."
     Priority=33
     HudColor=(B=50,G=50,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=9
     GroupOffset=2
     PickupClass=Class'BallisticProV55.R78Pickup'
     PlayerViewOffset=(X=8.5,Y=4.500000,Z=-6)
     SightOffset=(X=-1.500000,Y=-0.5,Z=5.30000)
	 SightPivot=(Roll=-1024)
     AttachmentClass=Class'BallisticProV55.R78Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_R78'
     IconCoords=(X2=127,Y2=31)
     ItemName="R78A1 Sniper Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_R78'
     DrawScale=0.3
}

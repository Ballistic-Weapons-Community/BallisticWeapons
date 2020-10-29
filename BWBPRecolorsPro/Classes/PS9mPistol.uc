//=============================================================================
// PS9mPistol.
//
// Soviet assassin pistol. Fires darts that blur screen. Alt is medical dart.
// This gun is for cool people.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mPistol extends BallisticHandGun;

var() name			GrenBone;			
var() name			GrenBoneBase;
var() name			GrenadeLoadAnim;	//Anim for grenade reload
var   bool			bLoaded;


var() Sound			GrenSlideSound;		//Sounds for grenade reloading
var() Sound			GrenLoadSound;		//	

var() sound			PartialReloadSound;	// Silencer stuck on sound
var() name			HealAnim;		// Anim for murdering Simon
var() sound			HealSound;		// The sound of a thousand dying orphans

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (!bLoaded)
	{
		SetBoneScale (0, 0.0, GrenBone);
		SetBoneScale (1, 0.0, GrenBoneBase);
	}

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		ReloadAnim = 'ReloadOpen';
		IdleAnim = 'IdleOpen';
	}
	else
	{
		ReloadAnim = 'Reload';
		IdleAnim = 'Idle';
	}

	super.BringUp(PrevWeapon);
}

function ServerWeaponSpecial(optional byte i)
{
	if (bLoaded)
	{
		PlayAnim(HealAnim, 1.1, , 0);
		ReloadState = RS_Cocking;
	}
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None)
		return;
	if (Clientstate != WS_ReadyToFire)
		return;
	TemporaryScopeDown(0.5);
	ServerWeaponSpecial();
	if (bLoaded)
	{
		PlayAnim(HealAnim, 1.1, , 0);
		ReloadState = RS_Cocking;
	}
}


simulated function Notify_DartHeal()
{
	PlaySound(HealSound, SLOT_Misc, 1.5, ,64);
	//Ammo[1].UseAmmo (1, True);
	DoDartEffect(Instigator, Instigator);
	bLoaded = false;
}

static function DoDartEffect(Actor Victim, Pawn Instigator)
{
	local PS9mDartHeal HP;

	if(Pawn(Victim) == None || Vehicle(Victim) != None || Pawn(Victim).Health <= 0)
		Return;

	HP = Victim.Level.Spawn(class'PS9mDartHeal', Pawn(Victim).Owner);

	HP.Instigator = Instigator;

    if(Victim.Role == ROLE_Authority && Instigator != None && Instigator.Controller != None)
		HP.InstigatorController = Instigator.Controller;

	HP.Initialize(Victim);
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || bLoaded)
		return;
	if (ReloadState == RS_None)
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
}

// Notifys for greande loading sounds
simulated function Notify_GrenVisible()	{	SetBoneScale (0, 1.0, GrenBone); SetBoneScale (1, 1.0, GrenBoneBase);	ReloadState = RS_PreClipOut;}
simulated function Notify_GrenLoaded()	
{
	PS9mAttachment(ThirdPersonActor).bGrenadier=true;
	PS9mAttachment(ThirdPersonActor).IAOverride(True);	
	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	
	Ammo[1].UseAmmo (1, True);
}

simulated function Notify_GrenReady()	{	ReloadState = RS_None; bLoaded = true;	}
simulated function Notify_GrenLaunch()	
{
	SetBoneScale (0, 0.0, GrenBone); 
	PS9mAttachment(ThirdPersonActor).IAOverride(False);
	PS9mAttachment(ThirdPersonActor).bGrenadier=false;	
}

simulated function Notify_GrenInvisible()	{ SetBoneScale (1, 0.0, GrenBoneBase);	}

simulated function PlayReload()
{
    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadOpen';
       ClipInSound.Sound=default.ClipInSound.Sound;
    }
    else
    {
       ReloadAnim='Reload';
       ClipInSound.Sound=PartialReloadSound;
    }
	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == HealAnim)
		ReloadState = RS_None;
	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'Fire' || Anim == 'Dart_Fire' || Anim == 'Dart_FireOpen' ||Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
}


simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;
	return super.CanAlternate(Mode);
}

simulated state Lowering// extends DualAction
{
Begin:
	SafePlayAnim(PutDownAnim, 1.75, 0.1);
	FinishAnim();
	GotoState('Lowered');
}

simulated function OnRecoilParamsChanged()
{
	Super.OnRecoilParamsChanged();

	if (IsInDualMode())
		ApplyDualModeRecoilModifiers();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (IsInDualMode())
		ApplyDualModeAimModifiers();
}

simulated function OnDualModeChanged(bool bDualMode)
{
	if (bDualMode)
	{
		ApplyDualModeAimModifiers();
		ApplyDualModeRecoilModifiers();
	}
	else 
	{
		AimComponent.Recalculate();
		RcComponent.Recalculate();
	}
}

simulated function ApplyDualModeAimModifiers()
{
	AimComponent.AimSpread.Min		 *= 1.4;
	AimComponent.AimSpread.Max		 *= 1.2;
	AimComponent.ChaosDeclineTime	 *= 1.2;
	AimComponent.ChaosSpeedThreshold *= 0.8;
}

simulated function ApplyDualModeRecoilModifiers()
{
	RcComponent.PitchFactor			*= 1.2f;
	RcComponent.YawFactor			*= 1.2f;
	RcComponent.XRandFactor			*= 1.2f;
	RcComponent.YRandFactor			*= 1.2f;
	RcComponent.DeclineTime			*= 1.2f;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 1536); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =================================


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

// =============================================

defaultproperties
{
	ManualLines(0)="Rapid automatic dart fire. Very low recoil and accurate from point shooting, but no penetration and very low magazine capacity."
	ManualLines(1)="Readies a medical dart. When a medical dart has been readied, firing again will launch the dart. Allies will receive a significant health boost."
	ManualLines(2)="Effective at close range and support."
	GrenBone="Dart"
	GrenBoneBase="MuzzleAttachment"
	GrenadeLoadAnim="DartOn"
	GrenSlideSound=Sound'BallisticSounds2.M50.M50GrenOpen'
	GrenLoadSound=Sound'BallisticSounds2.M50.M50GrenLoad'
	PartialReloadSound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagInS2'
	HealAnim="Heal"
	HealSound=Sound'PackageSounds4ProExp.Stealth.Stealth-Heal'
	bShouldDualInLoadout=False
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BallisticRecolors4TexPro.Stealth.BigIcon_PS9M'
	BigIconCoords=(X1=96,Y1=16,X2=418,Y2=255)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Heal=True
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;2.0;0.1;0.1")
	BringUpSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-Pickup')
	PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
	CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock',Radius=32.000000)
	ClipHitSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagInS1',Volume=1.800000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagOut',Volume=1.800000,Radius=32.000000)
	ClipInSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-MagIn',Volume=1.800000,Radius=32.000000)
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Automatic")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(ModeName="Repeating")
	bNoCrosshairInScope=True
	SightOffset=(X=-10.000000,Y=11.400000,Z=7.900000)
	SightDisplayFOV=60.000000
	ParamsClass=Class'PS9mWeaponParams'
	FireModeClass(0)=Class'BWBPRecolorsPro.PS9mPrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.PS9mSecondaryFire'
	PutDownTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	Description="PS-9m Stealth Pistol||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: Tranquilizer Dart Fire|Secondary: FMD Medical Dart"
	Priority=65
	HudColor=(B=130,G=100,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	PickupClass=Class'BWBPRecolorsPro.PS9mPickup'
	PlayerViewOffset=(X=3.000000,Y=-5.000000,Z=-8.500000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBPRecolorsPro.PS9mAttachment'
	IconMaterial=Texture'BallisticRecolors4TexPro.Stealth.SmallIcon_PS9M'
	IconCoords=(X2=127,Y2=31)
	ItemName="PS-9m Stealth Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.Stealth_FP'
	DrawScale=0.300000
	Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	Skins(1)=Texture'BallisticRecolors4TexPro.Stealth.Stealth-Main'
}

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

simulated state PendingSelfHeal extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) WeaponSpecial();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}

simulated state PendingLoadGrenade extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) LoadGrenade();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}

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
		if (Othergun != None)
		{
			if (Othergun.Clientstate != WS_ReadyToFire)
				return;
			if (IsinState('DualAction'))
				return;
			if (!Othergun.IsinState('Lowered'))
			{
				GotoState('PendingSelfHeal');
				return;
			}
		}
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
	if (Othergun != None)
	{
		if (Othergun.Clientstate != WS_ReadyToFire)
			return;
		if (IsinState('DualAction'))
			return;
		if (!Othergun.IsinState('Lowered'))
		{
			GotoState('PendingLoadGrenade');
			return;
		}
	}
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

/*simulated function PlayReload()
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
}*/

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);
	if (Anim == HealAnim)
		ReloadState = RS_None;
	if (Anim == 'FireOpen' || Anim == 'Pullout' || Anim == 'Fire' || Anim == 'Dart_Fire' || Anim == 'Dart_FireOpen' ||Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'IdleOpen';
			ReloadAnim = 'ReloadOpen';
			SelectAnim = 'PulloutOpen';
			PutDownAnim = 'PutawayOpen';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			SelectAnim = 'Pullout';
			PutDownAnim = 'Putaway';
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
	GrenSlideSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	PartialReloadSound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-MagInS2'
	HealAnim="Heal"
	HealSound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Heal'
	bShouldDualInLoadout=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',pic2=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=25,G=122,R=11,A=255),Color2=(B=255,G=255,R=255,A=255),StartSize1=22,StartSize2=59)
    TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.Stealth.BigIcon_PS9M'
	BigIconCoords=(X1=96,Y1=16,X2=418,Y2=255)
	
	bWT_Bullet=True
	bWT_Heal=True
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;2.0;0.1;0.1")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-Pickup')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806-Cock',Radius=32.000000)
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-MagInS1',Volume=1.100000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-MagOut',Volume=1.100000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Stealth.Stealth-MagIn',Volume=1.100000,Radius=32.000000)
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi-Automatic")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(ModeName="Repeating")
	bNoCrosshairInScope=True
	SightOffset=(X=-10.000000,Y=11.400000,Z=7.900000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'PS9mWeaponParamsComp'
	ParamsClasses(1)=Class'PS9mWeaponParamsClassic'
	ParamsClasses(2)=Class'PS9mWeaponParamsRealistic'
    ParamsClasses(3)=Class'PS9mWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.PS9mPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.PS9mSecondaryFire'
	PutDownTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	Description="PS-9m Stealth Pistol||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: Tranquilizer Dart Fire|Secondary: FMD Medical Dart||The PS-9m Stealth Pistol is a rare weapon seldom seen outside the walls of the Earth-based Russian Federation and black ops PMCs. It is mainly used as a tool for covert assassination and as such fires darts filled with highly potent neurotoxins. Every dart carries a 100% chance of death without medical aid and a 95% chance with. Subjects injected with the concoction report immediate vision impairment and excruciating pain, after 20 minutes subjects lose the ability to respond, and after 1 hour lethal convulsions set in. In order to make up for that unacceptable 95% success rate, the stealth pistol additionally comes with a fully automatic firing mode. This has been a cause for major concern, because there have been several times where the weapon's rapid fire recoil has directed darts into hapless civilians. It should be noted that the PS-9m's darts are instantly lethal on a headshot and are additionally filled with corrosive acids to neutralize mechanized threats. General Alexi 'Rasputin' Volkov is the only known man to have survived more than 9 darts and famously killed his attacker in hand-to-hand combat."
	Priority=65
	HudColor=(B=130,G=100,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	PickupClass=Class'BWBP_SKC_Pro.PS9mPickup'
	PlayerViewOffset=(X=3.000000,Y=-5.000000,Z=-8.500000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_SKC_Pro.PS9mAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Stealth.SmallIcon_PS9M'
	IconCoords=(X2=127,Y2=31)
	ItemName="PS-9m Stealth Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_PS9M'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BWBP_SKC_Tex.Stealth.Stealth-Main'
}

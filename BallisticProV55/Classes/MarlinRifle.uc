//=============================================================================
// MarlinRifle.
//
// Lever action rifle with under-barrel tubular mag. Has blunt melee attack.
// Has movement stability
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MarlinRifle extends BallisticWeapon;

//Layouts
var()   bool		bHasGauss;				// Fancy version
var	 	float 		GaussLevel, MaxGaussLevel;
var() 	Sound		GaussOnSound;

var		Actor		GaussGlow1, GaussGlow2;

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bHasGauss=False;
	if (InStr(WeaponParams.LayoutTags, "gauss") != -1)
	{
		bHasGauss=True;
		bShowChargingBar=True;
	}
	
}

// Gauss Stuff ==================================
simulated function Tick (float DT)
{
	super.Tick(DT);

	if (bHasGauss)
	{
		AddGauss(DT);
	}
}

simulated function AddGauss(optional float Amount)
{
	if (bBerserk)
		Amount *= 1.2;
		
	GaussLevel = FMin(GaussLevel + Amount, MaxGaussLevel);
	
	if (GaussLevel == MaxGaussLevel && CurrentWeaponMode == 0)
	{			
		GaussGlow1.bHidden=false;
		GaussGlow2.bHidden=false;
		PlaySound(GaussOnSound,,0.7,,32);
		ServerSwitchWeaponMode(1);
		ClientSwitchWeaponMode(1);
	}
}

//override to prevent weapon switching for arena
exec simulated function SwitchWeaponMode (optional byte ModeNum)
{
	if (bHasGauss)
		return;
		
	super.SwitchWeaponMode(ModeNum);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	super.BringUp(PrevWeapon);
	
	if (bHasGauss)
	{
		if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GaussGlow1 == None || GaussGlow1.bDeleteMe))
			class'BUtil'.static.InitMuzzleFlash(GaussGlow1, class'MarlinChargeEffect', DrawScale, self, 'Gauss2');
			
		if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GaussGlow2 == None || GaussGlow2.bDeleteMe))
			class'BUtil'.static.InitMuzzleFlash(GaussGlow2, class'MarlinChargeEffect', DrawScale, self, 'Gauss3');
			
		if (GaussGlow1 != None)
		{
			AttachToBone(GaussGlow1, 'Gauss2');
			GaussGlow1.bHidden=true;
		}
		if (GaussGlow2 != None)
		{
			AttachToBone(GaussGlow2, 'Gauss3');
			GaussGlow2.bHidden=true;
		}
	}
}

simulated event Destroyed()
{
	if (GaussGlow1 != None)
		GaussGlow1.Destroy();
		
	if (GaussGlow2 != None)
		GaussGlow2.Destroy();

	Super.Destroyed();
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (GaussGlow1 != None)	GaussGlow1.Destroy();
		if (GaussGlow2 != None)	GaussGlow2.Destroy();
		return true;
	}
	return false;
}

simulated function float ChargeBar()
{
	return FMax(0, GaussLevel/MaxGaussLevel);
}



//================================================================

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	if (anim == FireMode[0].FireAnim || (FireMode[1] != None && anim == FireMode[1].FireAnim))
		bPreventReload=false;
		
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
		
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) && MeleeState < MS_Held)
        {
			bPreventReload=false;
            PlayIdle();
        }
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (Ammo[0].AmmoAmount < 1 || MagAmmo >= default.MagAmmo)
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			AimComponent.ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
	}
	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function CommonCockGun(optional byte Type)
{
	if (!FireMode[1].IsFiring())
		super.CommonCockGun(Type);
}

simulated function WeaponTick (float DT)
{
	if (!FireMode[1].IsFiring())
	{
		if (ReloadState != RS_None && ReloadState != RS_Cocking)
			GunLength = 1;
		else if (GunLength == 1)
			GunLength = default.GunLength;
	}

	super.WeaponTick(DT);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	//if (SightingState != SS_None)
	//	TemporaryScopeDown(Default.SightingTime*Default.SightingTimeScale);
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
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
function byte BestMode()
{
/*
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	if (Dist < FireMode[1].MaxRange())
		return 1;
	if (Dist < FireMode[1].MaxRange() * 2 && FRand() > 0.5)
		return 1;
*/
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
	
	// the deermaster is effective at close range as well
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.8, Dist, 1024, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.4;	}
// End AI Stuff =====


defaultproperties
{
	GaussOnSound=Sound'BW_Core_WeaponSound.AMP.Amp-Install'
	MaxGaussLevel=3
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Marlin.BigIcon_Marlin'
	
	bWT_Bullet=True
	ManualLines(0)="Lever-action rifle fire. High damage per shot with modest recoil and good penetration. Good shoulder fire properties. This mode fires more quickly when the weapon is aimed."
	ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
	ManualLines(2)="As a long-ranged weapon lacking a scope, it has a very quick aiming time. Does not use tracer rounds. Effective at medium to long range."
	SpecialInfo(0)=(Info="240.0;25.0;0.6;50.0;1.0;0.5;-999.0")
	MeleeFireClass=Class'BallisticProV55.MarlinMeleeFire'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78Putaway')
	PutDownTime=0.4
	CockAnimRate=1.700000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.Marlin.Mar-Cock',Volume=0.750000)
	ReloadAnim="ReloadLoop"
	ReloadAnimRate=2.000000
	ClipInSound=(Sound=SoundGroup'BW_Core_WeaponSound.Marlin.Mar-ShellIn')
	ClipInFrame=0.650000
	bCockOnEmpty=True
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="StartReload"
	EndShovelAnim="EndReload"
	WeaponModes(0)=(ModeName="Lever Action",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bShowChargingBar=False
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Dot1',USize1=256,VSize1=256,Color1=(A=138),StartSize1=61,StartSize2=10)
	
	FullZoomFOV=70.000000
	bNoCrosshairInScope=True

	ParamsClasses(0)=Class'MarlinWeaponParamsComp'	 
	ParamsClasses(1)=Class'MarlinWeaponParamsClassic'	
	ParamsClasses(2)=Class'MarlinWeaponParamsRealistic'	
    ParamsClasses(3)=Class'MarlinWeaponParamsTactical' 
	FireModeClass(0)=Class'BallisticProV55.MarlinPrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.80000
	CurrentRating=0.800000
	bSniping=True
	Description="Redwood Firearms are well known for their high quality hunting and sport rifles and ammuntion. One of their most successful rifles, the '6000 Deermaster', is widely recognised as an excellent hunting weapon. It has only ever been used by civilians for hunting and sporting competitions. Although not used by miltary forces, for it's inconvenient operational design, it is still a powerful weapon, using specified .341 cal ammunition. The heavy wooden stock is useful as a blunt instrument should the user require it in a desperate situation."
	Priority=33
	HudColor=(B=57,G=98,R=140)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=9
	GroupOffset=1
	PickupClass=Class'BallisticProV55.MarlinPickup'

	PlayerViewOffset=(X=15,Y=7.00000,Z=-10.000000)
	SightOffset=(X=6.000000,Y=-0.040000,Z=2.850000)
	SightBobScale=0.2

	AttachmentClass=Class'BallisticProV55.MarlinAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Marlin.SmallIcon_Marlin'
	IconCoords=(X2=127,Y2=31)
	ItemName="Redwood 6000 'DeerMaster'"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=5.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_Marlin'
	DrawScale=0.3
}

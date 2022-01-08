//=============================================================================
// MD24Pistol.
//
// Semi Automatic pistol with decent damage.
// Secondary fixes the unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class MD24Pistol extends BallisticHandgun;

var   bool			bLaserOn;
var   bool			bStriking;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;
var name			BulletBone;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	Super.Notify_ClipIn();

	SetBoneScale(0,1.0,BulletBone);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
		SetBoneScale(0,0.0,BulletBone);
}

simulated function bool SlaveCanUseMode(int Mode)
{
	if(MD24Pistol(OtherGun) != None)
		return (Mode == 0 || (Mode == 1 && Level.TimeSeconds >= FireMode[Mode].NextFireTime));

	return Mode == 0;
}

simulated function bool MasterCanSendMode(int Mode)
{
	if(MD24Pistol(OtherGun) != None)
		return Mode < 2;

	return Mode == 0;
}

simulated function bool CanAlternate(int Mode)
{
	if(MD24Pistol(OtherGun) == None && Mode != 0)
		return false;
	else if(MD24Pistol(OtherGun) != None)
		return true;

	return super.CanAlternate(Mode);
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 1.5;
	AimComponent.AimSpread.Max *= 0.65;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		OnLaserSwitched();

		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerWeaponSpecial(optional byte i)
{
	if (bServerReloading)
		return;
	ServerSwitchLaser(!bLaserOn);
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor!=None)
		MD24Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	OnLaserSwitched();
	
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	OnLaserSwitched();
	
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,0.7,,32);
	}

	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();

	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if ( ThirdPersonActor != None )
		MD24Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'MD24LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			MD24Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
}

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1;
	Scale3D.Z = 1;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if(Anim != 'PrepMelee')
		bStriking = false;
	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == CockAnim || Anim == ReloadAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
		}
	}
	Super.AnimEnd(Channel);
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
// Change some properties when using sights...
simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function OnScopeViewChanged()
{
	Super.OnScopeViewChanged();
	
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		if (bScopeView)
			BFireMode[0].FireAnim = 'SightOpenFire';
		else	BFireMode[0].FireAnim = 'NewOpenFire';
	}
	else
	{
		if (bScopeView)
			BFireMode[0].FireAnim = 'SightFire';
		else BFireMode[0].FireAnim = 'NewFire';
	}
}

// AI Interface =====
// choose between regular or alt-fire
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	BulletBone="Bullet"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BW_Core_WeaponTex.MD24.BigIcon_MD24'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	ManualLines(0)="Low-recoil pistol fire. Has the option of burst fire. Very controllable."
	ManualLines(1)="Prepares a bludgeoning attack, which will be executed upon release. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind."
	ManualLines(2)="The Weapon Function key toggles a laser sight, which reduces the spread of the weapon's hipfire, but exposes the user's position to the enemy. This laser sight makes the MD24 a strong choice for dual wielding.||Effective at close range."
	SpecialInfo(0)=(Info="120.0;10.0;-999.0;25.0;0.0;0.0;-999.0")
	MeleeFireClass=Class'BallisticProV55.MD24MeleeFire'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_Cock',Volume=0.675000)
	ReloadAnimRate=1.350000
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_ClipHit',Volume=0.800000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_ClipOut',Volume=0.800000)
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.MD24.MD24_ClipIn',Volume=0.800000)
	ClipInFrame=0.580000
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightFXClass=Class'BallisticProV55.MD24SightLED'
    SightFXBone="Slide"
	SightOffset=(X=-15.000000,Y=-0.030000,Z=7.400000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'MD24WeaponParams'
	ParamsClasses(1)=Class'MD24WeaponParamsClassic'
	FireModeClass(0)=Class'BallisticProV55.MD24PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.600000
	CurrentRating=0.600000
	Description="The MD24 is a lightweight, medium powered pistol, recently developed by the internal UTC Defense Tech manufacturer for those troops in need of the simple maneuverability. The MD24 is primarily made up of specialised polymers and lightweight metals to make it useful to stealth and Commando units. Fitted with a stock laser pointing device, the MD24 is an easy to use sidearm, especially useful in tight spots."
	Priority=19
	HudColor=(B=25,G=150,R=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=6
	PickupClass=Class'BallisticProV55.MD24Pickup'
	PlayerViewOffset=(X=6.500000,Y=6.000000,Z=-6.500000)
	AttachmentClass=Class'BallisticProV55.MD24Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.MD24.SmallIcon_MD24'
	IconCoords=(X2=127,Y2=31)
	ItemName="MD24 Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_MD24'
	DrawScale=0.350000
}

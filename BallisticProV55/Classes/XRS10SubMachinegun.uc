//=============================================================================
// XRS10SubMachinegun.
//
// A one hand machine-pistol with laser sight and silencer.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class XRS10SubMachinegun extends BallisticWeapon;

var   bool		bSilenced;				// Silencer on. Silenced
var() name		SilencerBone;			// Bone to use for hiding silencer
var() name		SilencerOnAnim;			// Think hard about this one...
var() name		SilencerOffAnim;		//
var() sound		SilencerOnSound;		// Silencer stuck on sound
var() sound		SilencerOffSound;		//
var() sound		SilencerOnTurnSound;	// Silencer screw on sound
var() sound		SilencerOffTurnSound;	//
var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserBlast;
var   Emitter		LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
	reliable if (Role < ROLE_Authority)
		ServerSwitchSilencer;
}

simulated function PlayIdle()
{
	super.PlayIdle();

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != default.bLaserOn)
	{
		if (bLaserOn)
		{
			AimAdjustTime = default.AimAdjustTime * 1.5;
			ChaosAimSpread *= 0.65;
		}
		else
		{
			AimAdjustTime = default.AimAdjustTime;
			ChaosAimSpread = default.ChaosAimSpread;
		}
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;

	if (ThirdPersonActor != None)
		XRS10Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (bLaserOn)
	{
		AimAdjustTime = default.AimAdjustTime * 1.5;
		ChaosAimSpread *= 0.65;
	}
	else
	{
		AimAdjustTime = default.AimAdjustTime;
		ChaosAimSpread = default.ChaosAimSpread;
	}

    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
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
	if (!IsinState('DualAction') && !IsinState('PendingDualAction') && ReloadState != RS_GearSwitch)
		PlayIdle();
	bUseNetAim = default.bUseNetAim || bLaserOn;
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot()
{
	if (LaserDot == None)
		LaserDot = Spawn(class'XRS10LaserDot');
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			XRS10Attachment(ThirdPersonActor).bLaserOn = false;
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
    local name anim;
    local float frame, rate;
    local bool bAimAligned;

	if ((ClientState == WS_Hidden) || (!bLaserOn) || Laser==None)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip3').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
//	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
	{
	    GetAnimParams(0, anim, frame, rate);
 		if (anim != SilencerOnAnim && anim != SilencerOffAnim)
			bAimAligned = true;
 	}

	if (bAimAligned)
		SpawnLaserDot();
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip3');
		Laser.SetRotation(AimDir);
	}

	if (LaserBlast != None)
	{
		LaserBlast.SetLocation(Laser.Location);
		LaserBlast.SetRotation(Laser.Rotation);
		Canvas.DrawActor(LaserBlast, false, false, DisplayFOV);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (!IsInState('Lowered'))
		DrawLaserSight(Canvas);
}

// Change some properties when using sights...
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

function ServerSwitchSilencer(bool bNewValue)
{
	bSilenced = bNewValue;
	SwitchSilencer(bSilenced);
	bServerReloading=True;
	ReloadState = RS_GearSwitch;

	XRS10PrimaryFire(BFireMode[0]).SetSilenced(bNewValue);
}

/*
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
	ReloadState = RS_GearSwitch;
}
*/

simulated function SwitchSilencer(bool bNewValue)
{
	if (bNewValue)
		PlayAnim(SilencerOnAnim);
	else
		PlayAnim(SilencerOffAnim);
}
simulated function Notify_SilencerOn()
{
	PlaySound(SilencerOnSound,,0.5);
}
simulated function Notify_SilencerOnTurn()
{
	PlaySound(SilencerOnTurnSound,,0.5);
}
simulated function Notify_SilencerOff()
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
simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_RSBlue');
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
		LaserBlast = Spawn(class'XRS10LaserBlast');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		XRS10Attachment(ThirdPersonActor).bLaserOn = bLaserOn;


	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated function PlayReload()
{
	super.PlayReload();

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}
// End AI Stuff =====

defaultproperties
{
	bSilenced=True
	AIRating=0.85
	CurrentRating=0.85
	AimDisplacementDurationMult=0.5
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BallisticSounds2.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BallisticSounds2.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
	SilencerOffTurnSound=SoundGroup'BallisticSounds2.XK2.XK2-SilencerTurn'
	LaserOnSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
	LaserOffSound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-LaserClick'
	PlayerSpeedFactor=1.050000
	TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_XRS10'
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic machine pistol fire. Moderate damage per bullet and high fire rate. Deals extreme DPS at close range, but has controllability and recoil issues, especially from the hip."
	ManualLines(1)="Toggles the laser sight. While active, reduces the hipfire spread, but broadcasts the user's position to the enemy."
	ManualLines(2)="The Weapon Function key attaches a suppressor, reducing recoil, range and noise output and removing the flash.||This weapon is highly effective at very close range."
	SpecialInfo(0)=(Info="60.0;5.0;0.4;-1.0;0.0;0.2;-999.0")
	BringUpSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BallisticSounds2.XK2.XK2-Putaway')
	MagAmmo=25
	CockSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Cock')
	ClipOutSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Clipout')
	ClipInSound=(Sound=Sound'BWAddPack-RS-Sounds.TEC.RSMP-Clipin')
	ClipInFrame=0.650000
	
	WeaponModes(0)=(ModeName="Burst Fire",ModeID="WM_Burst",Value=4.000000)
	WeaponModes(1)=(bUnavailable=True)
    WeaponModes(2)=(ModeName="Full Auto",ModeID="WM_FullAuto",bUnavailable=True)
	CurrentWeaponMode=0
	
	SightOffset=(X=-15.000000,Z=9.500000)
	SightDisplayFOV=60.000000
	SightingTime=0.200000
	SightAimFactor=0.200000
	SightZoomFactor=0
	HipRecoilFactor=1.5
	SprintOffSet=(Pitch=-3000,Yaw=-4000)
	AimAdjustTime=0.450000
	
	AimSpread=16
	ChaosSpeedThreshold=7500.000000
	ChaosAimSpread=512
	
	ViewRecoilFactor=0.5
	RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=0.05),(InVal=0.400000,OutVal=0.10000),(InVal=0.5500000,OutVal=0.120000),(InVal=0.800000,OutVal=0.15000),(InVal=1.000000,OutVal=0.100000)))
	RecoilYCurve=(Points=(,(InVal=0.200000,OutVal=0.170000),(InVal=0.400000,OutVal=0.420000),(InVal=0.600000,OutVal=0.650000),(InVal=0.800000,OutVal=0.800000),(InVal=1.000000,OutVal=1.000000)))
	RecoilXFactor=0.1
	RecoilYFactor=0.1
	RecoilMax=4096.000000
	RecoilDeclineTime=0.5
	RecoilDeclineDelay=0.30000
	
	FireModeClass(0)=Class'BallisticProV55.XRS10PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.XRS10SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	Description="The XRS10 is a small, silencable Sub-Machinegun, constructed by newcomer arms company, Drake & Co. Based on a design from many years ago, the XRS10 is a short, medium-range weapon, using .40 calibre ammunition. The weapon has a medium rate-of-fire, fair damage, and a decent magazine capacity, yet can generate much recoil and chaos. The new model, features silencer and blue-light laser sight, to give it some more edge in stealthier situations."
	Priority=27
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=3
	GroupOffset=3
	PickupClass=Class'BallisticProV55.XRS10Pickup'
	PlayerViewOffset=(X=5.000000,Y=11.000000,Z=-11.000000)
	AttachmentClass=Class'BallisticProV55.XRS10Attachment'
	IconMaterial=Texture'BWAddPack-RS-Skins.XRS10.SmallIcon_XRS10'
	IconCoords=(X2=127,Y2=31)
	ItemName="XRS-10 Machine Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BallisticProAnims.XRS10'
	DrawScale=0.200000
	Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
	Skins(1)=Shader'BWAddPack-RS-Skins.XRS10.XRS10Shiney'
	Skins(2)=Shader'BWAddPack-RS-Skins.XRS10.XRS10LaserShiney'
	Skins(3)=Shader'BWAddPack-RS-Skins.XRS10.XRS10SilencerShiney'
}

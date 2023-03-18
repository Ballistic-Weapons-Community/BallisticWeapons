//=============================================================================
// RS8X3Pistol.
//
// A medium power pistol with a lasersight and silencer
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RS8X3Pistol extends BallisticWeapon HideDropDown CacheExempt;

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

/*simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated state PendingSwitchSilencer extends PendingDualAction
{
	simulated function BeginState()	{	OtherGun.LowerHandGun();	}
	simulated function HandgunLowered (BallisticHandgun Other)	{ global.HandgunLowered(Other); if (Other == Othergun) WeaponSpecial();	}
	simulated event AnimEnd(int Channel)
	{
		Othergun.RaiseHandGun();
		global.AnimEnd(Channel);
	}
}*/

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

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor != None)
		RS8X3Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
			RS8X3Attachment(ThirdPersonActor).bLaserOn = false;
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

simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function OnScopeViewChanged()
{
	super.OnScopeViewChanged();

	if (Hand < 0)
		SightOffset.Y = default.SightOffset.Y * -1;
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
	BFireMode[0].bAISilent = bSilenced;
	SwitchSilencer(bSilenced);
	if (bSilenced)
	{
		BFireMode[0].FireRecoil *= 0.85;
		BallisticInstantFire(BFireMode[0]).Damage *= 0.85;
	}
	else
	{
		BFireMode[0].FireRecoil = BFireMode[0].default.FireRecoil;
		BallisticInstantFire(BFireMode[0]).Damage = BallisticInstantFire(BFireMode[0]).default.Damage;
	}
}

exec simulated function WeaponSpecial(optional byte i)
{
	if (ReloadState != RS_None || SightingState != SS_None)
		return;
	//if (bIsPendingHandGun || PendingHandGun!=None)
		//return;
	if (Clientstate != WS_ReadyToFire)
		return;
	/*if (Othergun != None)
	{
		if (Othergun.Clientstate != WS_ReadyToFire)
			return;
		if (IsinState('DualAction'))
			return;
		if (!Othergun.IsinState('Lowered'))
		{
			GotoState('PendingSwitchSilencer');
			return;
		}
	}*/
	TemporaryScopeDown(0.5);
	bSilenced = !bSilenced;
	ServerSwitchSilencer(bSilenced);
	SwitchSilencer(bSilenced);
}

simulated function SwitchSilencer(bool bNewValue)
{
	if(Role == ROLE_Authority)
		bServerReloading=False;
	ReloadState = RS_GearSwitch;
	
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
		RS8X3Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

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

	if (AIController(Instigator.Controller) != None)
		bSilenced = (FRand() > 0.5);

	if (bSilenced)
		SetBoneScale (0, 1.0, SilencerBone);
	else
		SetBoneScale (0, 0.0, SilencerBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

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

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function PlayReload()
{
	super.PlayReload();

	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 768, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_RS8Clip';
}

defaultproperties
{
	SilencerBone="Silencer"
	SilencerOnAnim="SilencerOn"
	SilencerOffAnim="SilencerOff"
	SilencerOnSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOn'
	SilencerOffSound=Sound'BW_Core_WeaponSound.XK2.XK2-SilenceOff'
	SilencerOnTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
	SilencerOffTurnSound=Sound'BW_Core_WeaponSound.Pistol.RSP-SilencerTurn'
	LaserOnSound=Sound'BW_Core_WeaponSound.TEC.RSMP-LaserClick'
	LaserOffSound=Sound'BW_Core_WeaponSound.TEC.RSMP-LaserClick'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	MeleeFireClass=Class'BWBP_APC_Pro.RS8X3MeleeFire'
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_RS8'
	BigIconCoords=(X1=64,Y1=70,X2=418)
	bWT_Bullet=True
	ManualLines(0)="Semi-automatic 10mm fire. Moderate damage and fire rate. Has the option of burst fire."
	ManualLines(1)="Attaches a suppressor, reducing the effective range but removing the flash and reducing the noise output."
	ManualLines(2)="Weapon Function toggles a laser sight, reducing the hipfire spread."
	SpecialInfo(0)=(Info="0.0;-5.0;-999.0;-1.0;0.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-Cock')
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.Pistol.RSP-ClipIn')
	ClipInFrame=0.650000
	//WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=2
	//bShouldDualInLoadout=False
	bNoCrosshairInScope=True
	SightOffset=(X=-15.000000,Z=8.700000)
	SightDisplayFOV=60.000000
	ParamsClasses(0)=Class'RS8WeaponParamsComp'
	ParamsClasses(1)=Class'RS8WeaponParamsClassic'
	ParamsClasses(2)=Class'RS8WeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_APC_Pro.RS8X3PrimaryFire'
	FireModeClass(1)=Class'BWBP_APC_Pro.RS8X3SecondaryFire'
	SelectForce="SwitchToAssaultRifle"
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross4',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=203,R=0,A=160),StartSize1=79,StartSize2=33)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
	AIRating=0.600000
	CurrentRating=0.6
	Description="Every weapon has it's pros and cons, the X3 and the RS8 being prime examples. The former being a handy tool in close quarters combat while the latter is decent for stealth and ranged engagements, but when both are used at the same time; it shores up their weaknesses. The X3 can slice and stab through armor for the RS8 to deal better damage while the RS8 can take down targets that are out of the X3’s range.  Elite soldiers of the UTC Commando Corp have started using both weapons in tandem for covert operations that demand the situation to either keep enemies at arms reach or up close and personal."
	Priority=17
	HudColor=(B=255,G=200,R=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=10
	PickupClass=Class'BWBP_APC_Pro.RS8X3Pickup'
	PlayerViewOffset=(X=3.000000,Y=9.000000,Z=-12.000000)
	AttachmentClass=Class'BWBP_APC_Pro.RS8X3Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.RS8.SmallIcon_RS8'
	IconCoords=(X2=127,Y2=31)
	ItemName="RS8X3 Pistol/Knife Combo"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_RS8X3'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.RS8.RS8-Shiney'
}

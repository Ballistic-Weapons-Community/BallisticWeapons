//=============================================================================
// G5Bazooka.
//
// Big rocket launcher. Fires a dangerous, not too slow moving rocket, with
// high damage and a fair radius. Low clip capacity, long reloading times and
// hazardous close combat temper the beast though.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class RGPXBazooka extends BallisticWeapon;

var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;
var   bool			bNowEmpty;			    // Checks if it should play modified animation.

struct RevInfo
{
	var() name	BoneName;
};
var() RevInfo	MiniRocketBones[7]; 	//Bones for rockets in flak canister
var() name		FlakBone;	//Bone for flak canister

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
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

	if (ThirdPersonActor!=None)
		RGPXAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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

	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
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
	if ( ThirdPersonActor != None )
		RGPXAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
		LaserDot = Spawn(class'RGPXLaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			RGPXAttachment(ThirdPersonActor).bLaserOn = false;
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
	Loc = GetBoneCoords('Laser').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('Laser');
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

//Bone related code
simulated function HideMiniRockets()
{
	SetBoneScale(MagAmmo + 2, 0.0, MiniRocketBones[MagAmmo-1].BoneName);
}

simulated function HideFlak()
{
	local int i;
	SetBoneScale(1, 0.0, FlakBone);
	for (i = 0; i <= 6; i++)
		SetBoneScale(i+2, 0.0, MiniRocketBones[i].BoneName);
}

simulated function Notify_ShowMiniRockets()
{
	local int i, j;
	
	if (default.MagAmmo - MagAmmo > Ammo[0].AmmoAmount)
		j=Ammo[0].AmmoAmount + MagAmmo;
	else
		j=default.MagAmmo;
	
	for (i = 0; i <= j; i++)
		SetBoneScale(i+2, 1.0, MiniRocketBones[i].BoneName);
}

simulated function Notify_ShowFlak()
{
	SetBoneScale(1, 1.0, FlakBone);
}

// Play different reload starting anims depending on the situation
simulated function PlayReload()
{
	if (MagAmmo == 0 && bNowEmpty)		// Keg'O'Shit fired
	{
		PlayAnim('ReloadFull', ReloadAnimRate, , 0.25);
		bNowEmpty = false;
	}
	else
		PlayAnim('Reload', ReloadAnimRate, , 0.25);
}

// AI Interface =====
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 0.6;
	else if (Dist > 3000)
		Result -= 0.3;
	result += 0.2 - FRand()*0.4;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

defaultproperties
{
	MiniRocketBones(0)=(BoneName="Rocket1")
	MiniRocketBones(1)=(BoneName="Rocket2")
	MiniRocketBones(2)=(BoneName="Rocket3")
	MiniRocketBones(3)=(BoneName="Rocket4")
	MiniRocketBones(4)=(BoneName="Rocket5")
	MiniRocketBones(5)=(BoneName="Rocket6")
	MiniRocketBones(6)=(BoneName="ihateiteration")
	FlakBone="RocketMain"
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
    LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	BigIconMaterial=Texture'BWBP_JCF_Tex.RGP-X350.BigIcon_RGPX'
	BigIconCoords=(Y1=36,Y2=230)
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	ManualLines(0)="Fires a rocket. These rockets have an arming delay and will ricochet off surfaces when unarmed."
	ManualLines(1)="Flak Shot"
	ManualLines(2)="Regular Laser (Non Guidance)"
	SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
	CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
	ReloadAnimRate=1.000000
	ClipOutSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_RocketOut',Volume=2.500000)
    ClipInSound=(Sound=Sound'BWBP_JCF_Sounds.RGX.RGX_RocketIn',Volume=2.000000)
	WeaponModes(0)=(ModeName="Rocket")
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	SightPivot=(Yaw=-512)
    PlayerViewOffset=(X=5.000000,Y=20.000000,Z=-22.000000)
	SightOffset=(X=-5.000000,Y=-30.000000,Z=24.300000)
	SightingTime=0.350000
	ParamsClasses(0)=Class'RGPXWeaponParamsArena'
	ParamsClasses(1)=Class'RGPXWeaponParamsClassic'
	ParamsClasses(2)=Class'RGPXWeaponParamsTactical'
	ParamsClasses(3)=Class'RGPXWeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_JCF_Pro.RGPXPrimaryFire'
	FireModeClass(1)=Class'BWBP_JCF_Pro.RGPXSecondaryFire'
	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353OutA',USize1=128,VSize1=128,USize2=256,VSize2=256,Color1=(B=0,G=127,R=255,A=180),Color2=(B=255,G=255,R=255,A=119),StartSize1=107,StartSize2=77)
	SelectAnimRate=0.900000
	PutDownAnimRate=0.900000
	PutDownTime=1.600000
	BringUpTime=1.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Every country on Earth has their own way to deal with the looming Skrith threat, ZTV Exports has several eastern offerings to combat the foriegn invaders from beyond the stars.  While most of them have armor penetrating capabilities, not a lot of them can tackle heavy threats like the Cryons, suffering several defeats at the hands of the mechanical behemoths. Looking back at their history, ZTV managed to unearth some old RGP-7's and modified them into the new RGX-350 HV Flak Bazooka.  While it doesn't have much explosive prowess, the blast has been known to disorient Cyron troops, stunning them long enough for them to be exposed to getting flaked by it's secondary function. It's a devastating weapon, even some brave ZTV Rocket Soldats have been insane enough to get in close and unleash a storm of flak, reducing the enemy to scraps."
	Priority=44
	HudColor=(B=0,G=150,R=255)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BWBP_JCF_Pro.RGPXPickup'
	AttachmentClass=Class'BWBP_JCF_Pro.RGPXAttachment'
	IconMaterial=Texture'BWBP_JCF_Tex.RGP-X350.SmallIcon_RGPX'
	IconCoords=(X2=127,Y2=31)
	ItemName="RGK-350 H-V Flak Bazooka"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BWBP_JCF_Anims.FPm_RGP-X350'
	DrawScale=0.600000
}

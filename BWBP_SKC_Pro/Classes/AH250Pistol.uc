//=============================================================================
// AH250 "Hawk".
// With compliments of team-spec*Azarael
//=============================================================================
class AH250Pistol extends Ballistichandgun;

var(AH250Pistol) name		RDSBone;			// Bone to use for hiding Red Dot Sight
var(AH250Pistol) name		MuzzBone;			// Bone to use for hiding Compensator
var(AH250Pistol) name		LAMBone;			// Bone to use for hiding LAM
var(AH250Pistol) name		ScopeBone;			// Bone to use for hiding scope
var(AH250Pistol) name		BulletBone;			// Bone to use for hiding bullet

var(AH250Pistol)   bool			bHasLaser;
var(AH250Pistol)   LaserActor	Laser;
var(AH250Pistol)   Emitter		LaserDot;
var(AH250Pistol)   bool			bLaserOn;
var(AH250Pistol)   bool			bStriking;

var(AH250Pistol) Sound			LaserOnSound;
var(AH250Pistol) Sound			LaserOffSound;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn, bHasLaser;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bHasLaser=False;
	if (InStr(WeaponParams.LayoutTags, "laser") != -1)
	{
		bHasLaser=True;
	}
	
}
//Laser Code
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
	if (!bHasLaser || bServerReloading)
		return;
	ServerSwitchLaser(!bLaserOn);
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;
	if (ThirdPersonActor!=None)
		AH250Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

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
	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'OpenIdle';
		ReloadAnim = 'OpenReload';
		SelectAnim = 'OpenPullout';
		BringUpTime=default.BringUpTime;
		SetBoneScale(4,0.0,BulletBone);
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
		SelectAnim = 'Pullout';
		BringUpTime=default.BringUpTime;
	}
	
	Super.BringUp(PrevWeapon);
	
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (bHasLaser && Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		AH250Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
		LaserDot = Spawn(class'M806LaserDot',,,Loc);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			AH250Attachment(ThirdPersonActor).bLaserOn = false;
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

simulated function Notify_HideBullet()
{
	if (MagAmmo < 2)
		SetBoneScale(4,0.0,BulletBone);
}

simulated function Notify_ShowBullet()
{
	SetBoneScale(4,1.0,BulletBone);
}

simulated event AnimEnd (int Channel)
{
    local name Anim;
    local float Frame, Rate;

    GetAnimParams(0, Anim, Frame, Rate);

	if (Anim == 'OpenFire' || Anim == 'Fire' || Anim == 'OpenFire' || Anim == 'OpenSightFire' || Anim == CockAnim || Anim == ReloadAnim || Anim == DualReloadAnim || Anim == DualReloadEmptyAnim)
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
		{
			IdleAnim = 'OpenIdle';
			ReloadAnim = 'OpenReload';
			PutDownAnim = 'OpenPutaway';
			SelectAnim = 'OpenPullout';
		}
		else
		{
			IdleAnim = 'Idle';
			ReloadAnim = 'Reload';
			PutDownAnim = 'Putaway';
			SelectAnim = 'Pullout';
		}
	}
	Super.AnimEnd(Channel);
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
	LaserOnSound=Sound'BW_Core_WeaponSound.TEC.RSMP-LaserClick'
	LaserOffSound=Sound'BW_Core_WeaponSound.TEC.RSMP-LaserClick'
	AIRating=0.6
	CurrentRating=0.6
	ManualLines(0)="High-powered semi-automatic fire."
	ManualLines(1)="Engages the sight."
	ManualLines(2)="Effective at medium range."
	RDSBone="RedDotSight"
	MuzzBone="Compensator"
	LAMBone="LAM"
	ScopeBone="Scope"
	BulletBone="Bullet"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BWBP_SKC_Tex.Eagle.BigIcon_EagleAlt'
	BigIconCoords=(X1=48,Y1=0,X2=455,Y2=255)
	
	bWT_Bullet=True
	SpecialInfo(0)=(Info="140.0;12.0;0.7;70.0;0.55;0.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout',Pitch=0.9)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway',Pitch=0.9)
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-Cock',Volume=5.100000,Radius=48.000000)
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipHit',Volume=2.500000,Radius=48.000000)
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipOut',Volume=2.500000,Radius=48.000000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Eagle.Eagle-ClipIn',Volume=2.500000,Radius=48.000000)
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Semi")
	WeaponModes(1)=(ModeName="Mode-2",bUnavailable=True,Value=7.000000)
	WeaponModes(2)=(bUnavailable=True)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.G5OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M806InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=122),Color2=(B=122),StartSize1=64,StartSize2=76)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
	CurrentWeaponMode=0
	ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=40.000000
	bNoCrosshairInScope=True
	SightOffset=(X=70.000000,Y=-7.350000,Z=45.400002)
	SightDisplayFOV=40.000000
	GunLength=4.000000
	bShouldDualInLoadout=True
	ParamsClasses(0)=Class'AH250WeaponParamsComp'
	ParamsClasses(1)=Class'AH250WeaponParamsClassic'
	ParamsClasses(2)=Class'AH250WeaponParamsRealistic'
    ParamsClasses(3)=Class'AH250WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.AH250PrimaryFire'
	FireModeClass(1)=Class'BCoreProV55.BallisticScopeFire'
	MeleeFireClass=Class'BWBP_SKC_Pro.AH250MeleeFire'
	SelectAnimRate=2.000000
	PutDownAnimRate=1.600000
	PutDownTime=0.500000
	BringUpTime=0.600000
	CockingBringUpTime=1.400000
	SelectForce="SwitchToAssaultRifle"
	Description="AH-250 'Hawk' Assault Pistol||Manufacturer: Enravion Combat Solutions|Primary: Magnum Rounds|Secondary: Scope||Built as a more affordable alternative to the AH-104, the AH-250 is an alternate design chambered for .44 magnum rounds instead of the usual $100 .600 HEAP ones. It is less accurate than the AH-104 and D49, but its 8 round magazine and faster reload times let it put more rounds down range than both. Its significant weight and recoil means it requires both hands to shoot and is harder to control than its revolver and hand cannon siblings, a fact that comes into play where range is a concern. An updated version known as the AH-250M2 'Hawk' is also available, complete with a compensator, match-grade internals, and a 6x precision scope to make aiming easier. Military adoption remains low due to the heavy recoil and impracticality of carrying around such a large sidearm, yet big game hunters have taken a liking to it, plus it remains a popular weapon in every outer planet action flick."
	Priority=96
	HudColor=(B=200,G=200)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=2
	GroupOffset=13
	PickupClass=Class'BWBP_SKC_Pro.AH250Pickup'
	PlayerViewOffset=(X=15,Y=12,Z=-37)
	BobDamping=1.200000
	AttachmentClass=Class'BWBP_SKC_Pro.AH250Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.Eagle.SmallIcon_EagleAlt'
	IconCoords=(X2=127,Y2=31)
	ItemName="AH250 Assault Pistol"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AHDeagle'
	DrawScale=0.800000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MainBlack'
	Skins(2)=Texture'BWBP_SKC_Tex.Eagle.Eagle-MiscBlack'
	Skins(3)=Texture'BWBP_SKC_Tex.Eagle.Eagle-Scope'
	Skins(4)=Texture'BWBP_SKC_Tex.Eagle.Eagle-FrontBlack'
	Skins(5)=Shader'BWBP_SKC_Tex.Eagle.Eagle-SightDotGreen'
}

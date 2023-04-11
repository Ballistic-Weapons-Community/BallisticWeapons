//=============================================================================
// E23PlasmaRifle.
//
// An energy weapon that firing fast moving plasma bolts aor a plasma beam in
// 3 weapon modes. Also has an IR nightvision cope
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class E23PlasmaRifle extends BallisticWeapon;

var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserDot;

var   bool			bNightVision;
var   actor			NVLight;
var() float			ScopePopupHeight;
var   float			ScopeExtension;
var   float			LastSightDownTime;

var   byte			ModeBefore;

var   float			lastModeChangeTime;

replication
{
	reliable if (Role == ROLE_Authority)
		ClientSwitchLaser;
	reliable if (Role == ROLE_Authority && bNetDirty && bNetOwner)
		bNightVision;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassic())
		E23PrimaryFire(FireMode[0]).SGFireCount = 9;
	E23PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	if (Laser == None)
		Laser = spawn(class'LaserActor_VPR');
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
		LaserDot = Spawn(class'IE_VPRLaserHit',,,Loc);
}

simulated function ClientSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn || Role == ROLE_Authority)
		return;

	bLaserOn = bNewLaserOn;

	if (!bLaserOn)
		KillLaserDot();
}

simulated function SwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;

	bLaserOn = bNewLaserOn;

	ClientSwitchLaser(bLaserOn);

	if (Role == ROLE_Authority && ThirdPersonActor != None)
		E23Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (!bLaserOn)
		KillLaserDot();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			E23Attachment(ThirdPersonActor).bLaserOn = false;
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

	if (NVLight != None)
		NVLight.Destroy();

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
    local bool bAimAligned;

	if (ClientState == WS_Hidden || !bLaserOn)
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	if (bScopeView)
		Loc = Instigator.Location + vect(0,0,1)*(Instigator.EyeHeight-8);
	else
		Loc = GetBoneCoords('tip').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		LaserDot.Emitters[5].AutomaticInitialSpawning = Other.bWorldGeometry;
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip');
		Laser.SetRotation(AimDir);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 4;
	Scale3D.Z = 4;

	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}


simulated function TickSighting (float DT)
{
	local vector V;

	if (SightingState == SS_None && Instigator.IsLocallyControlled() && LastSightDownTime > 0 && level.TimeSeconds - LastSightDownTime > 10)
	{
		ScopeExtension = FMax(0.0, ScopeExtension-DT/4);
		V.Z = ScopePopupHeight * ScopeExtension;
		SetBoneLocation('Scope', V, 1.0);
		if (level.TimeSeconds - LastSightDownTime > 14)
			LastSightDownTime = 0;
		return;
	}

	if (SightingState == SS_None || SightingState == SS_Active)
		return;

	super.TickSighting (DT);

	if (!Instigator.IsLocallyControlled())
		return;
	if (SightingState == SS_Raising)
	{
		ScopeExtension = FMin(1.0, ScopeExtension+DT*2);
		V.Z = ScopePopupHeight * ScopeExtension;
		SetBoneLocation('Scope', V, 1.0);
	}
	else if (SightingState == SS_Active)
	{
		ScopeExtension = 1.0;
		V.Z = ScopePopupHeight;
		SetBoneLocation('Scope', V, 1.0);
	}
	else if (SightingState == SS_None)
		LastSightDownTime = level.TimeSeconds;
}

function ServerWeaponSpecial(optional byte i)
{
	bNightVision = !bNightVision;
}

simulated event WeaponTick(float DT)
{
	local actor T;
	local vector HitLoc, HitNorm, Start, End;

	super.WeaponTick(DT);

	if (!Instigator.IsLocallyControlled())
		return;

	if (bNightVision && bScopeView)
	{
		SetNVLight(true);

		Start = Instigator.Location+Instigator.EyePosition();
		End = Start+vector(Instigator.GetViewRotation())*1500;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(16,16,16));
		if (T==None)
			HitLoc = End;

		if (VSize(HitLoc-Start) > 400)
			NVLight.SetLocation(Start + (HitLoc-Start)*0.5);
		else
			NVLight.SetLocation(HitLoc + HitNorm*30);
	}
	else
		SetNVLight(false);
}

simulated event DrawFPWeapon(Canvas C)
{
	Super.DrawFPWeapon(C);

	DrawLaserSight(C);
}

simulated function DrawScopeOverlays(Canvas C)
{
	DrawLaserSight(C);
	
	Super.DrawScopeOverlays(C);
}

simulated function SetNVLight(bool bOn)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bOn)
	{
		if (NVLight == None)
		{
			NVLight = Spawn(class'E23NightVisionLight',,,Instigator.location);
			NVLight.SetBase(Instigator);
		}
		NVLight.bDynamicLight = true;
	}
	else if (NVLight != None)
		NVLight.bDynamicLight = false;
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
	local Bot B;
	local float Dist, Result;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;
		
	if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
		|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	     && (B.Enemy == None || !B.EnemyVisible()) )
		return 1;
	if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
		return 1;
		
	if (level.TimeSeconds - lastModeChangeTime < 1.4 - B.Skill*0.1 && (MagAmmo > 8 || CurrentWeaponMode!=1))
		return 0;
		
	Dist = VSize(Instigator.Location - B.Enemy.Location);
	
	Result = 0.35 + FRand()*0.4;
	
	if (Dist < 1000)
		Result *= FMax(0.65-B.Skill*0.11, Dist/1000);
	else if (Dist > 3000)
	{
		if (Dist < 5000 && FRand() > 0.9)
			Result -= 0.4;
		else
			Result += 0.2 + B.Skill*0.1;
	}
	else
		Result += (Dist-1000)/4000;

	if (MagAmmo > 8 && Result < 0.35)
	{
		if (CurrentWeaponMode != 1)
		{
			CurrentWeaponMode = 1;
			E23PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	else if (MagAmmo > 5 && Result > 0.6)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
			E23PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	else if (CurrentWeaponMode != 0)
	{
		CurrentWeaponMode = 0;
		E23PrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
	}
	
	lastModeChangeTime = level.TimeSeconds;

	return 0;
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;
		
	if (RecommendHeal(B))
		return 1.2;
		
	// the VPR is modestly effective at all ranges
	return Super.GetAIRating();
}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	
{	
	switch (CurrentWeaponMode)
	{
		case 0:
			return -0.2;
		case 1:
			return 0.8;
		case 2:
			return -0.7;
		default:
			return 0.0;
	}
}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	
{	
	switch (CurrentWeaponMode)
	{
		case 0:
			return 0.2;
		case 1:
			return -0.8;
		case 2:
			return 0.7;
		default:
			return 0.0;
	}
}
// End AI Stuff =====

simulated function float ChargeBar()
{
	return FMax(0.0, (E23PrimaryFire(FireMode[0]).NextSGFireTime - level.Timeseconds)/1.5);
}

defaultproperties
{
	ScopePopupHeight=17.000000
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.VPR.BigIcon_VPR'
	BigIconCoords=(Y1=36,Y2=225)
	SightFXClass=Class'BallisticProV55.E23ClipEffect'
	SightFXBone="Clip"
	
	bWT_RapidProj=True
	bWT_Energy=True
	ManualLines(0)="Series mode fires a continuous stream of high damage projectiles, which gain damage over range.|Multi mode fires five projectiles simultaneously in a spread pattern, mimicking a shotgun.|Sniper mode fires a very fast projectile which is weak up close but quickly gains damage over range."
	ManualLines(1)="Projects a hitscan beam with almost no recoil but low damage output."
	ManualLines(2)="While scoped, the weapon function toggles the infra-red night vision lamp. The E-23 ViPeR is effective at all ranges, but requires mode switching and uses the same ammo pool for all its modes. It has low recoil but poor hipfire. Its energy projectiles repair nodes and vehicles. Plasma projectiles will penetrate players, but not walls and surfaces."
	SpecialInfo(0)=(Info="300.0;25.0;0.9;80.0;0.2;0.4;0.1")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73Putaway')
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.VPR.VPR-ClipIn')
	ClipInFrame=0.700000
	bNonCocking=True
	WeaponModes(0)=(ModeName="Series Pulse",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Multi Pulse",ModeID="WM_SemiAuto",Value=1.000000)
	WeaponModes(2)=(ModeName="Sniper Pulse",ModeID="WM_SemiAuto",Value=1.000000)
	CurrentWeaponMode=0
	MinZoom=2
	MaxZoom=8
	ZoomStages=2
	ScopeViewTex=Texture'BW_Core_WeaponTex.VPR.VPR-ScopeUI'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=45.000000
	bNoCrosshairInScope=True
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.X3OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=72,G=41,R=52,A=121),Color2=(R=201),StartSize1=100,StartSize2=50)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,Y2=0.500000),MaxScale=3.000000)
    NDCrosshairChaosFactor=1.000000
	NDCrosshairScaleFactor=1.000000

	ParamsClasses(0)=Class'E23WeaponParamsComp'
	ParamsClasses(1)=Class'E23WeaponParamsClassic'
	ParamsClasses(2)=Class'E23WeaponParamsRealistic'
    ParamsClasses(3)=Class'E23WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.E23PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.E23SecondaryFire'
	SelectAnimRate=1.250000
	BringUpTime=0.400000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.650000
	CurrentRating=0.650000
	bShowChargingBar=True
	Description="This experimental prototype was developed on Earth by Frontier Tech and fires variable high-power plasma projectiles from an advanced energy cell. Designed for law enforcement and light infantry sectors, the E-23 is a light, fairly compact and powerful energy assault weapon. The 'ViPeR' is equipped with a sniper scope including optional Infra-Red night-vision lamp."
	Priority=39
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	GroupOffset=12
	PickupClass=Class'BallisticProV55.E23Pickup'

	PlayerViewOffset=(X=3,Y=6.00,Z=-8.00)
	SightOffset=(X=15,Z=4)

	AttachmentClass=Class'BallisticProV55.E23Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.VPR.SmallIcon_VPR'
	IconCoords=(X2=127,Y2=31)
	ItemName="E-23 'ViPeR' Plasma Rifle"
	ScopeXScale=1.33
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=64
	LightSaturation=96
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_VPR'
	DrawScale=0.3
	bFullVolume=True
	SoundRadius=32.000000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Shader'BW_Core_WeaponTex.VPR.VPR-Shiny'
	Skins(2)=Shader'BW_Core_WeaponTex.VPR.VPRGlass-Shiny'
}

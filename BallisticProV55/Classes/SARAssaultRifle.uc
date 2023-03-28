//=============================================================================
// SARAssaultRifle.
//
// Highly compact, but innacurate assault rifle with switchable stock,
// flash, large mag, quick reloading and red-dot sights.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class SARAssaultRifle extends BallisticWeapon;

const AUTO_MODE = 0;
const BURST_MODE = 1;

var()   bool			bLaserOn, bOldLaserOn;
var()   bool			bStriking;
var()   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

var()   name		StockOpenAnim;
var()   name		StockCloseAnim;
var()   bool		bStockOpen, bStockBoneOpen;

// This uhhh... thing is added to allow manual drawing of brass OVER the muzzle flash
struct UziBrass
{
	var() actor Actor;
	var() float KillTime;
};
var   array<UziBrass>	UziBrassList;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetStockRotation();

	if (bStockOpen)
		OnStockSwitched();
}

simulated function float ChargeBar()
{
	if (level.TimeSeconds >= FireMode[1].NextFireTime)
	{
		if (FireMode[1].bIsFiring)
			return FMin(1, FireMode[1].HoldTime / FireMode[1].MaxHoldTime);
		return FMin(1, SARFlashFire(FireMode[1]).DecayCharge / FireMode[1].MaxHoldTime);
	}
	return (FireMode[1].NextFireTime - level.TimeSeconds) / FireMode[1].FireRate;
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_SARClip';
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
	if (bStockOpen)
		ApplyStockAim();
}

//======================================================================
// Weapon mode behaviour
//
// Switches mode by animating the stock
//======================================================================
exec simulated function SwitchWeaponMode (optional byte ModeNum)	
{
	// SAR animates to change weapon mode
	if (ReloadState != RS_None)
		return;

	if (ModeNum == 0)
		ServerSwitchWeaponMode(255);
	else ServerSwitchWeaponMode(ModeNum-1);
}

// Cycle through the various weapon modes
function ServerSwitchWeaponMode (byte NewMode)
{
	Log("SAR ServerSwitchWeaponMode: Stock open: "$bStockOpen);
	
	if (ReloadState != RS_None)
		return;
		
	NewMode = byte(!bStockOpen);
		
	// can feasibly happen
	if (NewMode == CurrentWeaponMode)
		return;

	CommonSwitchWeaponMode(NewMode);
	ClientSwitchWeaponMode(NewMode);
	NetUpdateTime = Level.TimeSeconds - 1;
}

simulated function CommonSwitchWeaponMode(byte NewMode)
{
	Super.CommonSwitchWeaponMode(NewMode);
	SwitchStock(NewMode == BURST_MODE);
}

simulated function OnStockSwitched()
{
	if (bStockOpen)
		ApplyStockAim();
	else
		AimComponent.Recalculate();

	AdjustStockProperties();
}

simulated function SwitchStock(bool bNewValue)
{
	if (bNewValue == bStockOpen)
		return;

	Log("SAR SwitchStock: Stock open: "$bStockOpen);
	
	if (Role == ROLE_Authority)
		bServerReloading = True;
	ReloadState = RS_GearSwitch;
	
	TemporaryScopeDown(0.4);

	bStockOpen = !bStockOpen;

	SetStockRotation();

	//bStockOpen = bNewValue;
	
	//SetBoneRotation('Stock', rot(0,0,0));
	
	if (bStockOpen)
		PlayAnim(StockOpenAnim);
	else
		PlayAnim(StockCloseAnim);

	OnStockSwitched();
}

simulated function ApplyStockAim()
{
	if (bStockOpen)
		AimComponent.CrouchMultiplier *= 0.7f;
}

simulated function AdjustStockProperties()
{
	if (bStockOpen)
	{
		// Long Gun related
	    LongGunPivot 	= rot(4000, -12000, 0);
    	LongGunOffset	= vect(15, 20, -7);
		GunLength 		= 64;
		
		SightingTime = default.SightingTime * 1.25;
	}
	else
	{
		// Long Gun related
		GunLength	 		= default.GunLength;
    	LongGunPivot		= default.LongGunPivot;
    	LongGunOffset		= default.LongGunOffset;
		
		SightingTime = default.SightingTime;
	}
}

simulated function SetStockRotation()
{
	if (bStockOpen)
	{
		SetBoneLocation('Stock',vect(-38.472,0,0),1.0);
		bStockBoneOpen = true;
	}
	else
	{
		SetBoneLocation('Stock',vect(0,0,0),1.0);
		bStockBoneOpen = false;
	}
}

simulated function PlayIdle()
{
	if (bStockOpen && !bStockBoneOpen)
	{
		SetStockRotation();
		IdleTweenTime=0.0;
		super.PlayIdle();
		IdleTweenTime=default.IdleTweenTime;
	}
	else
	{	if (!bStockOpen && bStockBoneOpen)
			SetStockRotation();
		super.PlayIdle();
	}

	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || bScopeView || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

//=======================================================================
// Laser handling
//=======================================================================
function ServerWeaponSpecial(optional byte i)
{
	if (bServerReloading)
		return;
	ServerSwitchLaser(!bLaserOn);
}

simulated function OnLaserSwitched()
{
	if (bLaserOn)
		ApplyLaserAim();
	else
		AimComponent.Recalculate();
}

simulated function ApplyLaserAim()
{
	AimComponent.AimAdjustTime *= 1.5;
	AimComponent.AimSpread.Max *= 0.8;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != bOldLaserOn)
	{
		OnLaserSwitched();

		bOldLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
    
	CheckSetNetAim();

	if (ThirdPersonActor!=None)
		SARAttachment(ThirdPersonActor).bLaserOn = bLaserOn;

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

	if ( ThirdPersonActor != None )
		SARAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
	{
		LaserDot = Spawn(class'M806LaserDot',,,Loc);
		if (LaserDot != None)
			class'BallisticEmitter'.static.ScaleEmitter(LaserDot, 1.5);
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			SARAttachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
}

simulated function Destroyed ()
{
	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();
	Super.Destroyed();
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
	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2 && ReloadState != RS_GearSwitch)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(HitLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = class'BUtil'.static.ConvertFOVs(Instigator.Location + Instigator.EyePosition(), Instigator.GetViewRotation(), End, Instigator.Controller.FovAngle, DisplayFOV, 400);

	if (!bStriking && ReloadState == RS_None && ClientState == WS_ReadyToFire &&
	   ((FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > -0.05) || (!FireMode[0].IsFiring() && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)) && ReloadState != RS_GearSwitch)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}
	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 3;
	Scale3D.Z = 3;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	local int i;

	super.RenderOverlays(Canvas);

	DrawLaserSight(Canvas);

	if (UziBrassList.length < 1)
		return;

    bDrawingFirstPerson = true;
    for (i=UziBrassList.length-1;i>=0;i--)
    {
    	if (UziBrassList[i].Actor == None)
    		continue;
	    Canvas.DrawActor(UziBrassList[i].Actor, false, false, Instigator.Controller.FovAngle);
    	if (UziBrassList[i].KillTime <= level.TimeSeconds)
    	{
    		UziBrassList[i].Actor.bHidden=false;
    		UziBrassList.Remove(i,1);
    	}
    }
    bDrawingFirstPerson = false;
}

simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
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
	if (level.TimeSeconds >= FireMode[1].NextFireTime && FRand() > 0.6)
		return 1;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticInstantFire(BFireMode[0]).DecayRange.Min, BallisticInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

simulated function bool ReadyToFire(int Mode)
{
    local int alt;

    if ( Mode == 0 )
        alt = 1;
    else
        alt = 0;

	if (FireMode[Mode] == None)
		return false;

    if ( ((FireMode[alt] != None && FireMode[alt] != FireMode[Mode]) && FireMode[alt].bIsFiring)
		|| !FireMode[Mode].AllowFire()
		|| (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime) )
    {
        return false;
    }

	return true;
}

defaultproperties
{
	bStockOpen=True // the weapon expects this to be the default - please don't change it
	AIRating=0.72
	CurrentRating=0.72
	LaserOnSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	LaserOffSound=Sound'BW_Core_WeaponSound.M806.M806LSight'
	StockOpenAnim="StockOn"
	StockCloseAnim="StockOff"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BW_Core_WeaponTex.ui.BigIcon_SAR12'
	BigIconCoords=(Y1=24,Y2=250)
	SightFXClass=Class'BallisticProV55.SARSightDot'
	
	bWT_Bullet=True
	bWT_Machinegun=True
	ManualLines(0)="Automatic 5.56mm fire. Slightly shorter range than full-size assault rifles. Low damage and moderate recoil by default."
	ManualLines(1)="Engages the frontal flash device. Inflicts a medium-duration blind upon enemies. The effect is more potent the closer the foe is both to the point of aim and to the user."
	ManualLines(2)="The Weapon Function key engages or disengages the stock. By default, the stock is engaged. Disengaging the stock grants the SAR-12 superior hipfire and shortens the time taken to aim the weapon, but recoil becomes worse and no stabilization bonus is given for crouching.||Effective at close to medium range, depending upon specialisation."
	SpecialInfo(0)=(Info="240.0;25.0;0.8;90.0;0.0;1.0;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XK2.XK2-Putaway')
	MeleeFireClass=Class'BallisticProV55.SARMeleeFire'
	CockAnimPostReload="ReloadEndCock"
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-Cock')
	ReloadAnimRate=1.100000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.SAR.SAR-ClipIn')
	ClipInFrame=0.650000
	WeaponModes(0)=(ModeName="Auto",ModeID="WM_FullAuto")
	WeaponModes(1)=(ModeName="Burst",ModeID="WM_Burst",Value=4.000000,RecoilParamsIndex=1,AimParamsIndex=1)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightPivot=(Pitch=350)
	SightOffset=(X=20.000000,Y=-0.010000,Z=12.400000)
	SightDisplayFOV=25.000000
	GunLength=16.000000
	ParamsClasses(0)=Class'SARWeaponParamsComp'
	ParamsClasses(1)=Class'SARWeaponParamsClassic'
	ParamsClasses(2)=Class'SARWeaponParamsRealistic'
    ParamsClasses(3)=Class'SARWeaponParamsTactical'

	FireModeClass(0)=Class'BallisticProV55.SARPrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.SARFlashFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),StartSize1=70,StartSize2=82)
    NDCrosshairInfo=(SpreadRatios=(Y1=0.800000,Y2=1.000000),MaxScale=6.000000)
     
	SelectForce="SwitchToAssaultRifle"
	bShowChargingBar=True
	Description="With a growing number of operations and battles taking place in urban and industial enviroments, the UTC realized that their ground infantry units were in dire need of a more effective, balanced weapon system for indoor combat. UTC soldiers fighting in the close confines of urban structures and industrial installatons needed a highly compact, reliable and manouverable weapon, but it needed the power to blast through light walls and take down the agile alien forces they were faced with.||The result was the development of the Sub-Assault Rifle, the most well known of which is the S-AR 12. These weapons have the power of an assault rifle, usually using rifle ammunition such as 5.56mm rounds, and the manouverability of a compact sub-machinegun. Accuracy was not an issue due to the extremely short range of most of the encounters in urban combat."
	Priority=32
	HudColor=(G=200,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	GroupOffset=4
	PickupClass=Class'BallisticProV55.SARPickup'
	PlayerViewOffset=(X=5.000000,Y=9.000000,Z=-11.000000)
	AttachmentClass=Class'BallisticProV55.SARAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.ui.SmallIcon_SAR12'
	IconCoords=(X2=127,Y2=31)
	ItemName="Sub-Assault Rifle 12"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=130.000000
	LightRadius=3.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_SAR12'
	DrawScale=0.300000
	SoundPitch=56
	SoundRadius=32.000000
}

//=============================================================================
// AM67Pistol
//
// A powerful sidearm designed for close combat. The .50 bulelts are very
// deadly up, but weaken at range. Secondary is a blinging flash attachment.
//
// Realistic AM67 uses a laser instead of the flash
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class AM67Pistol extends BallisticHandgun;


// Standard Laser
var()	bool		bHasLaserSight;
var()   bool			bLaserOn, bOldLaserOn;
var()   bool			bStriking;
var()   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

// Kill Laser
var	  bool			bHasCombatLaser;
var   Emitter		LaserBlast;
var() float			LaserAmmo;
var() float			LaserChargeRate;

replication
{
	reliable if (Role == ROLE_Authority)
		bHasCombatLaser, bLaserOn, LaserAmmo;
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	
	bHasCombatLaser=false;
	bHasLaserSight=false;

	if (InStr(WeaponParams.LayoutTags, "combat_laser") != -1)
	{
		bHasCombatLaser=true;
	}

	if (InStr(WeaponParams.LayoutTags, "target_laser") != -1)
	{
		bHasLaserSight=true;
		bShowChargingBar=false;
	}
}

//simulated function bool SlaveCanUseMode(int Mode) {return (Mode == 0) || Othergun.class==class || ;}
simulated function bool MasterCanSendMode(int Mode) {return (Mode == 0) || Othergun.class==class || level.TimeSeconds <= FireMode[1].NextFireTime;}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return True;
	return super.CanAlternate(Mode);
}

simulated function bool CanSynch(byte Mode)
{
	return false;
	if (Mode != 0)
		return false;
	return super.CanSynch(Mode);
}

simulated function OnAimParamsChanged()
{
	Super.OnAimParamsChanged();

	if (bLaserOn)
		ApplyLaserAim();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (bNeedCock)
		BringUpTime = 0.4;
	super.BringUp(PrevWeapon);
	BringUpTime = default.BringUpTime;
	
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
	{
		if (bHasCombatLaser)
			Laser = Spawn(class'LaserActor_GRSNine');
		else
			Laser = Spawn(class'LaserActor');
	}
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
	{
		LaserBlast = Spawn(class'BallisticProV55.GRS9LaserOnFX');
		class'DGVEmitter'.static.ScaleEmitter(LaserBlast, DrawScale);
	}
	if (Instigator != None && bHasLaserSight && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if ( ThirdPersonActor != None )
		AM67Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}

simulated function float ChargeBar()
{
	if (bHasCombatLaser)
	{
		return FClamp(LaserAmmo/default.LaserAmmo, 0, 1);
	}
	else
	{
		if (level.TimeSeconds >= FireMode[1].NextFireTime)
		{
			if (FireMode[1].bIsFiring)
				return FMin(1, FireMode[1].HoldTime / FireMode[1].MaxHoldTime);
			return FMin(1, AM67SecondaryFire(FireMode[1]).DecayCharge / FireMode[1].MaxHoldTime);
		}
		return (FireMode[1].NextFireTime - level.TimeSeconds) / FireMode[1].FireRate;
	}
}

//=======================================================================
// Laser handling
//=======================================================================

simulated event Tick (float DT)
{
	super.Tick(DT);
	if (bHasCombatLaser)
	{
		if (LaserAmmo < default.LaserAmmo && ( FireMode[1]==None || !FireMode[1].IsFiring() ))
			LaserAmmo = FMin(default.LaserAmmo, LaserAmmo + DT*LaserChargeRate);
		if (bLaserOn && AM67Attachment(ThirdPersonActor) != none)
			AM67Attachment(ThirdPersonActor).LaserSizeAdjust = LaserAmmo;
	}
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
	AimComponent.AimAdjustTime *= 0.65;
	AimComponent.AimSpread.Max *= 0.65;
	AimComponent.AimSpread.Min *= 0.65;
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
function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;

	if (ThirdPersonActor != None)
		AM67Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	
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
		if (!bHasCombatLaser)
			PlaySound(LaserOnSound,,0.7,,32);
	}
	else
	{
		KillLaserDot();
		if (!bHasCombatLaser)
			PlaySound(LaserOffSound,,0.7,,32);
	}
	
	PlayIdle();
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
simulated function SpawnLaserDot(optional vector Loc)
{
	if (LaserDot == None)
	{
		if (bHasCombatLaser)
			LaserDot = Spawn(class'BallisticProV55.IE_GRS9LaserHit',,,Loc);
		else
			LaserDot = Spawn(class'M806LaserDot',,,Loc);
		if (LaserDot != None)
			class'BallisticEmitter'.static.ScaleEmitter(LaserDot, 1.5);
	}
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

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			AM67Attachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}
	return false;
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

	if ((ClientState == WS_Hidden) || (!bLaserOn))
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip2').Origin;

	End = Start + Normal(Vector(AimDir))*4000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('tip2');
		Laser.SetRotation(AimDir);
	}

	if (LaserBlast != None && bHasCombatLaser)
	{
		LaserBlast.SetLocation(Laser.Location);
		LaserBlast.SetRotation(Laser.Rotation);
		Canvas.DrawActor(LaserBlast, false, false, DisplayFOV);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	if (bHasCombatLaser)
	{
		Scale3D.Y = 2.0 * (1 + 4*FMax(0, LaserAmmo - 0.5));
		Scale3D.Z = Scale3D.Y;
	}
	else
	{
		Scale3D.Y = 3;
		Scale3D.Z = 3;
	}
	
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);

	if (IsInState('Lowered'))
		return;

	DrawLaserSight(Canvas);
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Dist;
	
	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return 0;
	
	
	Dist = VSize(B.Enemy.Location - Instigator.Location);
		
	if (bNoaltfire)
		return 0;
	else if (bHasCombatLaser)
	{
		if (LaserAmmo < 0.3 || level.TimeSeconds - AM67SecondaryFire(FireMode[1]).StopFireTime < 0.8)
			return 0;

		if (Dist > 3000)
			return 0;
		Result = FRand()*0.2 + FMin(1.0, LaserAmmo / (default.LaserAmmo/2));
		if (Dist < 500)
			Result += 0.5;
		else if (Dist > 1500)
			Result -= 0.3;
		if (Result > 0.5)
			return 1;
	}
	else
	{
		if (level.TimeSeconds >= FireMode[1].NextFireTime && FRand() > 0.6 && Dist < 1200)
			return 1;
	}
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, 1536, 2048); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.7;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.7;	}
// End AI Stuff =====

defaultproperties
{
    LaserChargeRate=0.125000
    LaserAmmo=1.000000

	AIRating=0.8
	CurrentRating=0.8
	AIReloadTime=1.500000

	AttachmentClass=Class'BallisticProV55.AM67Attachment'
	
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_AM67'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Pullout',Volume=0.155000)
	BringUpTime=0.900000

	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipHit')
	ClipInFrame=0.650000
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipIn')
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-ClipOut')

	CockSound=(Sound=Sound'BW_Core_WeaponSound.AM67.AM67-Cock')
	CurrentWeaponMode=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	Description="Another of Enravion's fine creations, the AM67 Assault Pistol was designed for close quarters combat against Cryon and Skrith warriors.|Initially constructed before the second war, Enravion produced the AM67, primarily for anti-Cryon operations, but it later proved to perform well in close-quarters combat when terran forces were ambushed by the stealthy Skrith warriors."
	DrawScale=0.3
	FireModeClass(0)=Class'BallisticProV55.AM67PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.AM67SecondaryFire'
	GroupOffset=6
	HudColor=(B=25,G=150,R=50)
	IconCoords=(X2=127,Y2=31)
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_AM67'
	InventoryGroup=2
	ItemName="AM67 Assault Pistol"

	LightBrightness=150.000000
	LightEffect=LE_NonIncidence
	LightHue=30
	LightRadius=4.000000
	LightSaturation=150
	LightType=LT_Pulse
	MagAmmo=8
	WeaponModes(1)=(bUnavailable=True)
	WeaponModes(2)=(bUnavailable=True)
	ManualLines(0)="High-powered bullet fire. Recoil is high."
	ManualLines(1)="Engages the integrated flash device. The fire key must be held until the flash triggers. Blinds enemies for a short duration. Enemies closer both to the player and to the point of aim will be blinded for longer."
	ManualLines(2)="Effective at close and medium range."
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.AM67_FPm'
	ParamsClasses(0)=Class'AM67WeaponParamsComp'
	ParamsClasses(1)=Class'AM67WeaponParamsClassic'
	ParamsClasses(2)=Class'AM67WeaponParamsRealistic'
    ParamsClasses(3)=Class'AM67WeaponParamsTactical'
	PickupClass=Class'BallisticProV55.AM67Pickup'
	PlayerViewOffset=(X=20.00,Y=3.00,Z=-8.00)
	SightOffset=(X=-24,Y=0.06,Z=4.43)
	SightAnimScale=0.3
	SightBobScale=0.5f 
	
	Priority=24
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M806.M806Putaway',Volume=0.155000)
	PutDownTime=0.600000

	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,Color1=(R=0,A=194),Color2=(R=0),StartSize1=80,StartSize2=26)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))

	SelectForce="SwitchToAssaultRifle"
	SightFXClass=Class'BallisticProV55.AM67SightLEDs'

	SightingTime=0.250000
	SpecialInfo(0)=(Info="120.0;15.0;0.8;50.0;0.0;0.5;-999.0")
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	bNoCrosshairInScope=True
	bShouldDualInLoadout=False
	bUseDualReload=False
	bShowChargingBar=True
	bWT_Bullet=True
}

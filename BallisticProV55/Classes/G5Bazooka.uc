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
class G5Bazooka extends BallisticWeapon;

#EXEC OBJ LOAD FILE=BW_Core_WeaponTex.utx

var() BUtil.FullSound	HatchSound;
var   bool				bCamView;
var   Pawn				Target;
var   float				TargetTime;
var() float				LockOnTime;
var	  bool				bLockedOn, bLockedOld;
var() BUtil.FullSound	LockOnSound;
var() BUtil.FullSound	LockOffSound;
var() BUtil.IntRange	LaserAimSpread;

var   Actor			CurrentRocket;			//Current rocket of interest. The rocket that can be used as camera or directed with laser

var   float			LastSendTargetTime;
var   vector		TargetLocation;
var   bool			bLaserOn, bLaserOld;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

replication
{
	reliable if(Role==ROLE_Authority)
		CurrentRocket, Target, bLockedOn, bLaserOn;

	reliable if(Role<ROLE_Authority)
		ServerSetRocketTarget;

	reliable if(Role==ROLE_Authority)
		ClientSetCurrentRocket, ClientRocketDie;
}

simulated function OutOfAmmo()
{
    if ( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo()  || ( CurrentRocket != None && (bLaserOn || bCamView) ))
        return;

    DoAutoSwitch();
}

//============================================================
// Laser management
//============================================================
function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bLaserOn;

	G5Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
	OnLaserSwitched();
}

simulated function ClientSwitchLaser()
{
	TickLaser (0.05);
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
	OnLaserSwitched();
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
	AimComponent.AimSpread = LaserAimSpread;
	AimComponent.AimAdjustTime *= 1.5f;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_G5Painter');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();

	if ( ThirdPersonActor != None )
		G5Attachment(ThirdPersonActor).bLaserOn = bLaserOn;

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');
}

function ServerSetRocketTarget(vector Loc)
{
	TargetLocation = Loc;
	if (CurrentRocket != None && G5SeekerRocket(CurrentRocket) != None)
		G5SeekerRocket(CurrentRocket).SetTargetLocation(Loc);
	if (ThirdPersonActor != None)
		G5Attachment(ThirdPersonActor).LaserEndLoc = Loc;
}

simulated function TickLaser ( float DT )
{
	local vector Start, End, HitLocation, HitNormal, AimDir;
	local Actor Other;

	if ((ClientState == WS_Hidden) || Instigator == None || !bLaserOn || bScopeView ||
		(bCamView && bScopeHeld) || (bCamView && Currentrocket != None && PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
		return;

	if ( Instigator.IsFirstPerson() && (ReloadState != RS_None || ClientState != WS_ReadyToFire || Level.TimeSeconds - FireMode[0].NextFireTime <= 0.2) )
	{
		AimDir = Vector(GetBoneRotation('tip2'));
		Start = Instigator.Location + Instigator.EyePosition();
	}
	else
		AimDir = BallisticFire(FireMode[0]).GetFireDir(Start);

	End = Start + Normal(AimDir)*10000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (G5MortarDamageHull(Other) != None && Other.Owner == Instigator)
		Other = FireMode[0].Trace (HitLocation, HitNormal, End, HitLocation + Normal(AimDir)*Other.CollisionRadius * 3, true);
	if (Other == None)
		HitLocation = End;

	if (Role == ROLE_Authority)
		ServerSetRocketTarget(HitLocation);
	else
	{
		if ( ThirdPersonActor != None )
			G5Attachment(ThirdPersonActor).LaserEndLoc = HitLocation;
		TargetLocation = HitLocation;
		if (level.TimeSeconds - LastSendTargetTime > 0.04)
		{
			LastSendTargetTime = level.TimeSeconds;
			ServerSetRocketTarget(HitLocation);
		}
	}
}

// Draw a laser beam and dot to show exact path of bullets before they're fired
simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Scale3D, Loc;

	if ((ClientState == WS_Hidden) || !bLaserOn || bScopeView || Instigator == None || Instigator.Controller == None || Laser==None)
		return;

	Loc = GetBoneCoords('tip2').Origin;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		SpawnLaserDot(TargetLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
		LaserDot.SetLocation(TargetLocation);
	Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(TargetLocation, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && Level.TimeSeconds - FireMode[0].NextFireTime > 0.2)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
		Laser.SetRotation(GetBoneRotation('tip2'));

	Scale3D.X = VSize(HitLocation-Loc)/128;
	Scale3D.Y = 1.5;
	Scale3D.Z = 1.5;
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

// Azarael - improved ironsights
simulated function UpdateNetAim()
{
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (!bLaserOn || bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

//============================================================
// Scope view
//============================================================

simulated function OnScopeViewChanged()
{
	Super.OnScopeViewChanged();

	if (!bScopeView)
	{
		if (Target != None && TargetTime >= LockOnTime)
			class'BUtil'.static.PlayFullSound(self, LockOffSound);

		Target = None;
		TargetTime = 0;
	}
}

simulated function StartScopeZoom()
{
	if (ZoomInSound.Sound != None)	
		class'BUtil'.static.PlayFullSound(self, ZoomInSound);

	if (!bCamView && Instigator.Controller.IsA( 'PlayerController' ))
        PlayerZoom(PlayerController(Instigator.Controller));
}

// Scope up anim just ended. Either go into scope view or move the scope back down again
simulated function ScopeUpAnimEnd()
{
 	if (bCamView)
 		CameraView();
 	else
 		super.ScopeUpAnimEnd();
}

// Scope down anim has just ended. Play idle anims like normal
simulated function ScopeDownAnimEnd()
{
	if (MagAmmo == 1 && bNeedCock && (!bLaserOn || CurrentRocket==None || G5SeekerRocket(CurrentRocket) == None) )
		CommonCockGun();
	else
		super.ScopeDownAnimEnd();
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();

		if (ThirdPersonActor != None)
			G5Attachment(ThirdPersonActor).bLaserOn = false;

		if (MagAmmo < 2)
			SetBoneScale (0, 0.0, 'Rocket');
		if (bCamView)
			PlayerView();
		return true;
	}
	return false;
}

simulated event OldRenderOverlays (Canvas C)
{
	if (!Instigator.IsLocallyControlled())
		return;
	if (bScopeView)
	    DrawTargeting(C);
	Super.RenderOverlays(C);
	DrawLaserSight(C);
}

simulated function WeaponTick(float DT)
{
	local float BestAim, BestDist;
	local Vector Start;
	local Pawn Targ;
	local bool bWasLockedOn;

	Super.WeaponTick(DT);

	if (Instigator != None && Instigator.IsLocallyControlled())
		TickLaser(DT);

	if (!bScopeView || CurrentWeaponMode != 1 || Role < ROLE_Authority)
		return;

	bWasLockedOn = TargetTime >= LockOnTime;

	Start = Instigator.Location + Instigator.EyePosition();
	BestAim = 0.995;
	Targ = Instigator.Controller.PickTarget(BestAim, BestDist, Vector(Instigator.GetViewRotation()), Start, 20000);
	if (Targ != None)
	{
		if (Targ != Target)
		{
			Target = Targ;
			TargetTime = 0;
		}
		else if (Vehicle(Targ) != None)
			TargetTime += 1.2 * DT * (BestAim-0.95) * 20;
		else
			TargetTime += DT * (BestAim-0.95) * 20;
	}
	else
	{
		TargetTime = FMax(0, TargetTime - DT * 0.5);
	}
	if (Instigator.IsLocallyControlled())
	{
		if (!bWasLockedOn && TargetTime >= LockOnTime)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else if (TargetTime < LockOnTime && bWasLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	bLockedOn = TargetTime >= LockOnTime;
}

simulated event PostNetReceive()
{
	if (level.NetMode != NM_Client)
		return;
	if (bLaserOn != bLaserOld)
	{
		bLaserOld = bLaserOn;
		ClientSwitchLaser();
	}
	if (bLockedOn != bLockedOld)
	{
		bLockedOld = bLockedOn;
		if (bLockedOn)
		    class'BUtil'.static.PlayFullSound(self, LockOnSound);
		else
		    class'BUtil'.static.PlayFullSound(self, LockOffSound);
	}
	Super.PostNetReceive();
}

simulated event DrawTargeting (Canvas C)
{
	local Vector V, V2, X, Y, Z;
	local float ScaleFactor;

	if (Target == None || !bLockedOn)
		return;

	ScaleFactor = C.ClipX / 1600;
	GetViewAxes(X, Y, Z);
	V  = C.WorldToScreen(Target.Location - Y*Target.CollisionRadius + Z*Target.CollisionHeight);
	V.X -= 32*ScaleFactor;
	V.Y -= 32*ScaleFactor;
	C.SetPos(V.X, V.Y);
	V2 = C.WorldToScreen(Target.Location + Y*Target.CollisionRadius - Z*Target.CollisionHeight);
	C.SetDrawColor(255,255,255,255);
//	C.DrawTile(Texture'BW_Core_WeaponTex.G5.G5Targetbox', V2.X - V.X, V2.Y - V.Y, 0, 0, 1, 1);
	C.DrawTileStretched(Texture'BW_Core_WeaponTex.G5.G5Targetbox', (V2.X - V.X) + 32*ScaleFactor, (V2.Y - V.Y) + 32*ScaleFactor);
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
		LaserDot = Spawn(class'G5LaserDot',,,Loc);
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
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Dist, Rating;

	B = Bot(Instigator.Controller);
	
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();
		
	// anti-vehicle specialist
	if (Vehicle(B.Enemy) != None)
		return 1.2;
		
	Rating = Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 1024) // danger close
		return 0.4;
	
	// projectile
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, 3072, 4096); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.5;	}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

exec simulated function WeaponSpecial(optional byte i)
{
	bScopeHeld=true;
	bPendingSightUp=false;

	if (bCamView && (CurrentRocket == None || PlayerController(Instigator.Controller).ViewTarget == CurrentRocket))
	{
		PlayerView();
		bScopeHeld=false;
		if (bScopeView)
			StopScopeView();
		return;
	}
	if (bScopeView)
	{
		if (bCamView)
		{
			bScopeHeld=false;
			StopScopeView();
		}
		else CameraView();
		return;
	}


	if (Instigator.Physics == PHYS_Falling || (SprintControl != None && SprintControl.bSprinting))
		return;

	if (AimComponent.AllowADS() && CurrentRocket != None)
	{
		PlayScopeUp();

		ReloadState = RS_None;
		ServerWeaponSpecial(i);
		bCamView=true;
		if (G5Rocket(CurrentRocket)!=None)
			G5Rocket(CurrentRocket).OnDie = RocketDie;
	}
}
exec simulated function WeaponSpecialRelease(optional byte i)
{
	super.ScopeViewRelease();
}

function ServerWeaponSpecial(optional byte i)
{
	bServerReloading=false;
	ReloadState = RS_None;
}

simulated function ClientSetCurrentRocket(Actor Proj)
{
	if (level.NetMode == NM_Client && !bCamView)
	{
		if (G5Rocket(Proj) != None)
			G5Rocket(Proj).OnDie = RocketDie;
		CurrentRocket = Proj;
	}
}
simulated function SetCurrentRocket(Actor Proj)
{
	if (!bCamView)
	{
		if (G5Rocket(Proj) != None)
			G5Rocket(Proj).OnDie = RocketDie;
		CurrentRocket = Proj;
		ClientSetCurrentRocket(Proj);
	}
}

// Back to player
simulated function PlayerView()
{
	PlayerController(Instigator.Controller).SetViewTarget( Instigator );
    PlayerController(Instigator.Controller).DesiredFOV = PlayerController(Instigator.Controller).DefaultFOV;
	if (CurrentRocket != None)
		CurrentRocket.bOwnerNoSee=false;
	if (bScopeView)
		StopScopeView();
	else
		PlayScopeDown();
	bCamView=false;
}
// View from CurrentRocket
simulated function CameraView()
{
	if (bScopeView && Instigator.Controller.IsA( 'PlayerController' ))
		PlayerController(Instigator.Controller).EndZoom();
	PlayerController(Instigator.Controller).SetViewTarget(CurrentRocket);
	CurrentRocket.bOwnerNoSee=true;
}
// Draw cam view stuff if in cam view...
simulated event RenderOverlays( Canvas Canvas )
{
	// Do stuff for camera view
	if ( CurrentRocket != None && PlayerController(Instigator.Controller).ViewTarget == CurrentRocket )
    {
		Instigator.SetViewRotation(CurrentRocket.Rotation);
		// Noise
		Canvas.SetDrawColor(255,255,255,255);
		Canvas.Style = ERenderStyle.STY_Alpha;
		Canvas.SetPos(0,0);
		Canvas.DrawColor.A = 48;
		Canvas.DrawTile( Material'BW_Core_WeaponTex.M50.Noise1', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 256, 256 ); // !! hardcoded size
		// Tunnel vision
		Canvas.DrawColor.A = 255;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( Material'BW_Core_WeaponTex.M50.M50CamView', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 1024, 1024 ); // !! hardcoded size
	}
    else
        OldRenderOverlays(Canvas);
}

exec simulated function CockGun(optional byte Type)	{ if (bNeedCock)	super.CockGun(Type);	}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn && anim == 'ReloadLoop')
	{
		PlayShovelEnd();
		ReloadState = RS_EndShovel;
		return;
	}

	if (Anim == ZoomInAnim && bCamView)
		CameraView();
	else
		Super.AnimEnd(Channel);
}

simulated function Notify_CockAfterFire()
{
	bPreventReload=false;
	if (class'BallisticReplicationInfo'.default.bNoReloading)
	{
		if (AmmoAmount(0) > 0 && bNeedCock && (!bLaserOn || CurrentRocket==None || G5SeekerRocket(CurrentRocket) == None) )
			CommonCockGun(1);
	}
	else if ( MagAmmo == 1 && bNeedCock && (!bLaserOn || CurrentRocket==None || G5SeekerRocket(CurrentRocket) == None) )
		CommonCockGun(1);
}

simulated function ClientRocketDie(Actor Rocket)
{
	if (level.netMode == NM_Client)
		RocketDie(Rocket);
}
simulated function RocketDie(Actor Rocket)
{
	if (Role == ROLE_Authority && Instigator!= None && !Instigator.IsLocallyControlled())
		ClientRocketDie(Rocket);
	if (bCamView && Rocket == CurrentRocket)
		PlayerView();

	if (class'BallisticReplicationInfo'.default.bNoReloading)
	{
		if (AmmoAmount(0) > 0 && bNeedCock && (Rocket == CurrentRocket || CurrentRocket==None || !bLaserOn))
			CommonCockGun(1);
	}
	else if (MagAmmo == 1 && bNeedCock && (Rocket == CurrentRocket || CurrentRocket==None || !bLaserOn))
		CommonCockGun(1);
}

simulated function PlayReload()
{
	bNeedCock=false;
	if (bScopeView && Instigator.Controller.IsA( 'PlayerController' ))
	{
		PlayerController(Instigator.Controller).EndZoom();
		class'BUtil'.static.PlayFullSound(self, ZoomOutSound);
	}

	SetBoneScale (0, 1.0, 'Rocket');
	if (MagAmmo < 1)
		PlayAnim('StartReloadEmpty', StartShovelAnimRate, , 0);
	else
		PlayAnim('StartReload', ReloadAnimRate, , 0);
}
simulated function PlayShovelLoop()
{
	if (MagAmmo < 1)
	{
		ClipInSound = default.ClipInSound;
		PlayAnim('ReloadLoopEmpty', ReloadAnimRate, , 0);
	}
	else
	{
		ClipInSound = default.ClipOutSound;
		PlayAnim('ReloadLoop', ReloadAnimRate, , 0);
	}
}
simulated function PlayShovelEnd()
{
	if (MagAmmo < 2)
		SetBoneScale (0, 0.0, 'Rocket');
	Super.PlayShovelEnd();
}

simulated function Notify_G5HatchOpen ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, HatchSound);
	G5PrimaryFire(FireMode[0]).FlashHatchSmoke();
}
simulated function Notify_G5HideRocket ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticReplicationInfo'.default.bNoReloading || AmmoAmount(0) < 2)
		SetBoneScale (0, 0.0, 'Rocket');
}

defaultproperties
{
	HatchSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever',Volume=0.700000,Pitch=1.000000)
	LockOnTime=1.500000
	LockOnSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-TargetOn',Volume=0.500000,Pitch=1.000000)
	LockOffSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-TargetOff',Volume=0.500000,Pitch=1.000000)
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=4.000000
	LaserAimSpread=(Min=0,Max=256)
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_G5'
	BigIconCoords=(Y1=36,Y2=230)
	
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_Projectile=True
	bWT_Super=True
	ManualLines(0)="Fires a rocket. These rockets have an arming delay and will ricochet off surfaces when unarmed.|In Rocket mode, the rocket flies directly to the point of aim.|In Mortar mode, the rocket will fly upwards and then strike downwards upon the point of aim.|When scoped and in Mortar mode, targets focused directly upon by the weapon's scope may be highlighted in red; when this happens, the next Mortar shot will track the target until line of sight is broken. The target is notified of the lockon when the rocket is fired."
	ManualLines(1)="Toggles the guidance laser. With the guidance laser active, rockets will fly towards the point indicated by the laser at any given time."
	ManualLines(2)="When firing a mortar rocket. the Weapon Function key will cause the player to view through the rocket's nose camera.|As a bazooka, the G5 has no recoil. With the laser in use, its hipfire is stable, however it will always be lowered when the player jumps. The weapon is effective at medium to long range and with height advantage."
	SpecialInfo(0)=(Info="300.0;35.0;1.0;80.0;0.8;0.0;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Putaway')
	CockAnimRate=1.250000
	CockSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Lever')
	ReloadAnim="ReloadLoop"
	ReloadAnimRate=1.250000
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-Load')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.G5.G5-LoadHatch')
	bCanSkipReload=True
	bShovelLoad=True
	StartShovelAnim="StartReload"
	StartShovelAnimRate=1.250000
	EndShovelAnim="FinishReload"
	EndShovelAnimRate=1.250000
	WeaponModes(0)=(ModeName="Rocket")
	WeaponModes(1)=(ModeName="Mortar",ModeID="WM_SemiAuto")
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0

	MinZoom=2.000000
	MaxZoom=8.000000
	ZoomStages=2
	ScopeXScale=1.333000
	ZoomInAnim="ZoomIn"
	ZoomOutAnim="ZoomOut"
	ScopeViewTex=Texture'BW_Core_WeaponTex.G5.G5ScopeView'
	ZoomInSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
	ZoomOutSound=(Sound=Sound'BW_Core_WeaponSound.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
	FullZoomFOV=10.000000

	NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.G5OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.G5InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=228),Color2=(B=0,G=255,R=255,A=228),StartSize1=97,StartSize2=103)
 

	bNoCrosshairInScope=True
	SightOffset=(X=-3.000000,Y=-6.000000,Z=4.500000)
	SightingTime=0.500000
	ParamsClasses(0)=Class'G5WeaponParams'
	ParamsClasses(1)=Class'G5WeaponParamsClassic' //todo: seeker stats
	ParamsClasses(2)=Class'G5WeaponParamsRealistic' //todo: seeker stats
    ParamsClasses(3)=Class'G5WeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.G5PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.G5SecondaryFire'
	SelectAnimRate=0.600000
	PutDownAnimRate=0.800000
	PutDownTime=0.800000
	BringUpTime=1.000000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.800000
	CurrentRating=0.800000
	Description="Based on the original design by the legendary maniac Pirate, Var Dehidra, the G5 has undergone many alterations to become what it is today. The original bandit version was constructed by Var Dehidra to blast open armored cash transportation vehicles. Its name is derived from one of Dehidra's favourite targets, the G5 CTV 4x. It is now a very deadly weapon, used to destroy everything from tanks and structures to Skrith hordes and aircraft. The bombardement attack is a recent addition, replacing the original, primitive heat seeking function that caused it to target CTVs or backfire on the pirates' own craft, provided mainly for use in outdoor environments to destroy all manner of moving targets. The latest model also features a laser-painter device, allowing the user to guide the rocket wherever they wish."
	Priority=44
	HudColor=(B=25,G=150,R=50)
	CenteredOffsetY=10.000000
	CenteredRoll=0
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	PickupClass=Class'BallisticProV55.G5Pickup'
	PlayerViewOffset=(X=10.000000,Y=10.500000,Z=-6.000000)
	AttachmentClass=Class'BallisticProV55.G5Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_G5'
	IconCoords=(X2=127,Y2=31)
	ItemName="G5 Missile Launcher"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=25
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_G5Bazooka'
	DrawScale=0.300000
}

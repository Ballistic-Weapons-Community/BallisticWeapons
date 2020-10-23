//=============================================================================
// SMATAA Recoilless.
//
// Portable artillery system. Fires a high speed shaped charge that decimates
// armor. Instant hit is almost always a kill.
// Comes with the all-new suicide alt fire!
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LAWLauncher extends BallisticWeapon;

#EXEC OBJ LOAD FILE=BallisticRecolors4TexPro.utx

var() BUtil.FullSound	HatchSound;


var   bool          bRunOffsetting;
var	bool		  	bInUse;
var() rotator       RunOffset;

var   Emitter		LaserDot;
var   bool			bLaserOn;
var   LaserActor	Laser;
var   Emitter		LaserBlast;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;


replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function OutOfAmmo()
{
	local int channel;
	local name anim;
	local float frame, rate;
	
    if ( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo() )
        return;

	GetAnimParams(channel, anim, frame, rate);
	
	if (bPreventReload)
		return;
	
    DoAutoSwitch();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	ServerSwitchlaser(true);
	Super.BringUp(PrevWeapon);
	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'LaserActor_LAW');
	if (Instigator != None && LaserBlast == None && PlayerController(Instigator.Controller) != None)
		LaserBlast = Spawn(class'LAWLaserBlast');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if (class'BallisticReplicationInfo'.default.bNoReloading && AmmoAmount(0) > 1)
		SetBoneScale (0, 1.0, 'Rocket');

	if ( ThirdPersonActor != None )
		LAWAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
	if (ThirdPersonActor!=None)
		LAWAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (bLaserOn)
	{
		SpawnLaserDot();
		PlaySound(LaserOnSound,,3.7,,32);
	}
	else
	{
		KillLaserDot();
		PlaySound(LaserOffSound,,3.7,,32);
	}
	if (!IsinState('DualAction') && !IsinState('PendingDualAction'))
		PlayIdle();
	bUseNetAim = default.bUseNetAim || bScopeView || bLaserOn;
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
		LaserDot = Spawn(class'LAWLaserDot',,,Loc);
}

simulated function PlayIdle()
{
	Super.PlayIdle();
	if (bPendingSightUp || SightingState != SS_None || !CanPlayAnim(IdleAnim, ,"IDLE"))
		return;
	FreezeAnimAt(0.0);
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		if (MagAmmo < 2)
			SetBoneScale (0, 0.0, 'Rocket');
		KillLaserDot();
		if (ThirdPersonActor != None)
			LAWAttachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}

	return false;
}

//Can't sight while run offsetting.
simulated function bool CheckScope()
{
	if (level.TimeSeconds < NextCheckScopeTime)
		return true;

	NextCheckScopeTime = level.TimeSeconds + 0.25;
	
	if ((ReloadState != RS_None && ReloadState != RS_Cocking) || bRunOffsetting || (Instigator.Controller.bRun == 0 && Instigator.Physics == PHYS_Walking) || (Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || (SprintControl != None && SprintControl.bSprinting)) //should stop recoil issues where player takes momentum and knocked out of scope, also helps dodge
	{
		StopScopeView();
		return false;
	}
	return true;
}

simulated function bool CanUseSights()
{
	if ((Instigator.Physics == PHYS_Falling && VSize(Instigator.Velocity) > Instigator.GroundSpeed * 1.5) || bRunOffsetting || (SprintControl != None && SprintControl.bSprinting) || ClientState == WS_BringUp || ClientState == WS_PutDown || ReloadState != RS_None)
		return false;
	return true;
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
		AimDir = GetBoneRotation('tip2');
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

simulated event RenderOverlays (Canvas C)
{
	if (!bScopeView)
	{
		Super.RenderOverlays(C);
		DrawLaserSight(C);
		if (SightFX != None)
			RenderSightFX(C);
		return;
	}
	if (!bNoMeshInScope)
	{
		Super.RenderOverlays(C);
		if (SightFX != None)
			RenderSightFX(C);
	}
	else
	{
		SetLocation(Instigator.Location + Instigator.CalcDrawOffset(self));
		SetRotation(Instigator.GetViewRotation());
	}

	// Draw Scope View
    if (ScopeViewTex != None)
    {
   		C.SetDrawColor(255,255,255,255);
		C.SetPos(C.OrgX, C.OrgY);
		
		C.ColorModulate.W = 1;
		
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);

		C.SetPos((C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeY*ScopeXScale), C.SizeY, 0, 0, 1024, 1024);

		C.SetPos(C.SizeX - (C.SizeX - (C.SizeY*ScopeXScale))/2, C.OrgY);
		C.DrawTile(ScopeViewTex, (C.SizeX - (C.SizeY*ScopeXScale))/2, C.SizeY, 0, 0, 1, 1024);
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

// AI Interface =====
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.5, Dist, 1024, 3072); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.9;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

simulated function Notify_G5HatchOpen ()
{
	if (Level.NetMode == NM_DedicatedServer)
		return;
	class'BUtil'.static.PlayFullSound(self, HatchSound);
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
	 InventorySize=24
     HatchSound=(Sound=Sound'BallisticSounds2.M75.M75Cliphit',Volume=0.700000,Pitch=1.000000)
     RunOffset=(Pitch=-4000,Yaw=-2000)
     LaserOnSound=Sound'PackageSounds4Pro.AH104.AH104-SightOn'
     LaserOffSound=Sound'PackageSounds4Pro.AH104.AH104-SightOff'
	 PlayerSpeedFactor=0.900000
	 SightMoveSpeedFactor=0.8
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BallisticRecolors4TexPro.LAW.BigIcon_LAW'
     BigIconCoords=(Y1=36,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Projectile=True
     bWT_Super=True
     ManualLines(0)="Launches a nuclear rocket. Travel time is moderate. Deals extreme damage within a wide radius."
     ManualLines(1)="Fires a shockwave rocket in an arc. Upon impact, the rocket generates shockwaves which penetrate walls and deal damage to targets in a very wide radius. Damage is reduced if the target is obscured from the rocket. The rocket can be destroyed by enemy fire whilst so placed."
     ManualLines(2)="Effective against groups and at controlling areas."
     SpecialInfo(0)=(Info="500.0;60.0;1.0;80.0;2.0;0.0;1.5")
     BringUpSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-Draw',Volume=1.100000)
     PutDownSound=(Sound=Sound'BWBP4-Sounds.Artillery.Art-Undeploy',Volume=1.100000)
     MagAmmo=1
     CockSound=(Sound=Sound'BallisticSounds2.G5.G5-Lever')
     ClipHitSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-Cock',Volume=2.100000)
     ClipOutSound=(Sound=Sound'PackageSounds4ProExp.LAW.LAW-TubeUnlock',Volume=2.100000)
     ClipInSound=(Sound=Sound'PackageSounds4ProExp.LAW.Law-TubeLock',Volume=2.100000)
     bNonCocking=True
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     ZoomType=ZT_Logarithmic
     ScopeXScale=1.330000
     ScopeViewTex=Texture'BallisticRecolors4TexPro.LAW.LAW-ScopeView'
     ZoomInSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomIn',Volume=0.500000,Pitch=1.000000)
     ZoomOutSound=(Sound=Sound'BallisticSounds2.R78.R78ZoomOut',Volume=0.500000,Pitch=1.000000)
     FullZoomFOV=10.000000
     bNoMeshInScope=True
     bNoCrosshairInScope=True
     SightOffset=(Y=6.000000,Z=15.000000)
     SightingTime=0.600000
     MinZoom=2.000000
     MaxZoom=8.000000
     ZoomStages=6


	Begin Object Class=RecoilParams Name=LAWRecoilParams
		YawFactor=0.000000
		DeclineTime=1.000000
		DeclineDelay=0.000000
	End Object
	RecoilParamsList(0)=RecoilParams'LAWRecoilParams'

	Begin Object Class=AimParams Name=ArenaAimParams
		AimSpread=(Min=512,Max=1536)
		ADSMultiplier=0.500000
		SprintOffset=(Pitch=-6000,Yaw=-8000)
		JumpOffset=(Pitch=-7000)
		AimAdjustTime=0.750000
		AimDamageThreshold=300.000000
		ChaosDeclineTime=2.800000
		ChaosSpeedThreshold=1200.00000
	End Object
	AimParamsList(0)=AimParams'ArenaAimParams'
	 
     FireModeClass(0)=Class'BWBPRecolorsPro.LAWPrimaryFire'
     FireModeClass(1)=Class'BWBPRecolorsPro.LAWSecondaryFire'
     PutDownTime=2.500000
     BringUpTime=3.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.90000
     CurrentRating=0.90000
     Description="The FGM-70 LAW represents an advance in portable nuclear technology. Using clean miniature nuclear rockets with no fallout, it is suitable for general deployment within the common soldiery. Able to inflict devastation either immediately through an explosion or over time through generating penetrative shockwaves, the FGM-70 can change the course of combat."
     Priority=164
     HudColor=(G=200,R=0)
     CenteredOffsetY=10.000000
     CenteredRoll=0
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=8
     PickupClass=Class'BWBPRecolorsPro.LAWPickup'
     PlayerViewOffset=(X=10.000000,Z=-7.000000)
     BobDamping=1.800000
     AttachmentClass=Class'BWBPRecolorsPro.LAWAttachment'
     IconMaterial=Texture'BallisticRecolors4TexPro.LAW.SmallIcon_LAW'
     IconCoords=(X2=127,Y2=31)
     ItemName="FGM-70 'Shockwave' LAW"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BallisticRecolors4AnimProExp.LAW_FP'
     DrawScale=0.400000
}

//=============================================================================
// M806Pistol.
//
// Semi Automatic pistol with decent damage, 12 round clip, good accracy when
// used carefully, but mainly, its the default weapon.
// Secondary fixes to unpredictable aiming by providing a laser sight so that
// the user knows where to expect the bullets.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M806Pistol extends BallisticHandgun;

var   bool			bLaserOn;
var   LaserActor	Laser;
var() Sound			LaserOnSound;
var() Sound			LaserOffSound;
var   Emitter		LaserDot;

replication
{
	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function bool SlaveCanUseMode(int Mode) {return Mode == 0;}
simulated function bool MasterCanSendMode(int Mode) {return Mode == 0;}

simulated function bool CanAlternate(int Mode)
{
	if (Mode != 0)
		return false;
	return super.CanAlternate(Mode);
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
			AimAdjustTime = default.AimAdjustTime * 1.5;
		else
			AimAdjustTime = default.AimAdjustTime;
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	bLaserOn = bNewLaserOn;
	bUseNetAim = bLaserOn;
	if (ThirdPersonActor!=None)
		M806Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
	if (bLaserOn)
		AimAdjustTime = default.AimAdjustTime * 1.5;
	else
		AimAdjustTime = default.AimAdjustTime;
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
	bUseNetAim = bLaserOn;
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
		M806Attachment(ThirdPersonActor).bLaserOn = bLaserOn;
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
			M806Attachment(ThirdPersonActor).bLaserOn = false;
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
simulated function SetScopeBehavior()
{
	super.SetScopeBehavior();

	bUseNetAim = bScopeView || bLaserOn;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()	{	return 0;	}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;
	local vector Dir;

	if (IsSlave())
		return 0;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = AIRating;
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	else if (Dist < 500 && B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.2;
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     LaserOnSound=Sound'BallisticSounds2.M806.M806LSight'
     LaserOffSound=Sound'BallisticSounds2.M806.M806LSight'
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     AIReloadTime=1.500000
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M806'
     SightFXClass=Class'BallisticProV55.M806SightLEDs'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     SpecialInfo(0)=(Info="0.0;8.0;-999.0;25.0;0.0;0.0;-999.0")
     BringUpSound=(Sound=Sound'BallisticSounds2.M806.M806Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M806.M806Putaway')
     MagAmmo=12
     CockSound=(Sound=Sound'BallisticSounds2.M806.M806-Cock')
     ClipHitSound=(Sound=Sound'BallisticSounds2.M806.M806-ClipHit')
     ClipOutSound=(Sound=Sound'BallisticSounds2.M806.M806-ClipOut')
     ClipInSound=(Sound=Sound'BallisticSounds2.M806.M806-ClipIn')
     ClipInFrame=0.650000
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     bNoCrosshairInScope=True
     SightPivot=(Pitch=300)
     SightOffset=(X=-4.000000,Z=5.100000)
     SightDisplayFOV=40.000000
     SightingTime=0.200000
     SightAimFactor=0.100000
     JumpChaos=0.200000
     AimAdjustTime=0.450000
     ViewAimFactor=0.050000
     ViewRecoilFactor=0.200000
     ChaosDeclineTime=0.320000
     ChaosSpeedThreshold=3000.000000
     ChaosAimSpread=384
     RecoilYawFactor=0.000000
     RecoilXFactor=0.250000
     RecoilYFactor=0.250000
     RecoilDeclineTime=0.500000
     RecoilDeclineDelay=0.200000
     FireModeClass(0)=Class'BallisticProV55.M806PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.M806SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="M806 High Velocity Pistol||Manufacturer: Enravion Combat Solutions|Primary: Powerful single shot|Secondary: Toggle Laser Sight||The M806 is one of the few sidearms capable of making a full-grown Skrith whimper. Although long used by law enforcment organizations, military forces and ordinary civillians, it gained recognition when an elite commando unit was forced to use it on a difficult mission to disable a heavily armoured, Cryon infantry Division. Poor logistics planning left them with a wealth of ammo for the sidearm and little else, but the pistol was so effective in the mission it quickly grew in favour amongst the UTC Infantry Corps. The M806 is capable of massive damage when targetted at the right area and is a generally reliable, backup weapon. Use of a laser sight turns it into a real weapon by allowing the soldier to accurately direct its powerful bullets."
     Priority=19
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=2
     GroupOffset=5
     PickupClass=Class'BallisticProV55.M806Pickup'
     PlayerViewOffset=(X=3.000000,Y=7.000000,Z=-7.000000)
     AttachmentClass=Class'BallisticProV55.M806Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M806'
     IconCoords=(X2=127,Y2=31)
     ItemName="M806A2 Pistol"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BallisticAnims2.M806Pistol'
     DrawScale=0.080000
}

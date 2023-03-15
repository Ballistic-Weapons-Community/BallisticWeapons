//=============================================================================
// XMV500Minigun.
//
// Almighty beast of a weapon, this spews out bullets at the unholy rate of
// sixty rounds per second. It comes with a variable fire rate, 20, 40 or 60
// rps and semi-auto fire.
//
// The minigun was really challenging because we had to develop some advanced
// new systems to allow for the demanded features. These included support for
// high fire rates(likely higher than PC's FPS) and a new turret system.
//
// The RoF is done by firing as fast as possible normally and firing multiple
// bullets at once when there aren't enough frames. To fire multiple shots in
// one frame an interpolater is added to figure out where the bullets mil most
// likely be aimed, based on current view rotation speed as well as all the
// aiming system vars... Hell of a thing, but... it works...
//
// For turrets, a versatile, general purpose turret system was developed and
// will be used for more than just this weapon in the future.
//
// One of the most difficult weapons of v2.0, this is at least a devastating
// piece of hardware being able to hoze down an area with bullets and leave no
// room for enemies to dodge. The deployed mode eliminates the restrictive
// recoil, but the user must be stationary.
//
// Kab
//=============================================================================
class XMV500Minigun extends BallisticWeapon
	transient
	HideDropDown
	CacheExempt;

#exec OBJ LOAD FILE=BW_Core_WeaponTex.utx
#exec OBJ LOAD FILE=BWBP_Camos_Tex.utx


var   float DesiredSpeed, BarrelSpeed;
var   int	BarrelTurn;
var() sound BarrelSpinSound;
var() Sound BarrelStopSound;
var() Sound BarrelStartSound;
var() Sound DeploySound;
var() Sound UndeploySound;
var   bool bRunOffsetting;
var() rotator RunOffset;
var	  float   	RotationSpeeds[5];


var   bool			bLaserOn;

var   LaserActor	Laser;
var float		lastModeChangeTime;
var() Sound			LaserOnSound;
var() Sound			ModeCycleSound;
var() Sound			LaserOffSound;

var   Emitter		LaserDot;

replication
{
	reliable if (Role < ROLE_Authority)
		SetServerTurnVelocity;

	reliable if (Role == ROLE_Authority)
		bLaserOn;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	if (Instigator != None && Laser == None && PlayerController(Instigator.Controller) != None)
		Laser = Spawn(class'BallisticProV55.LaserActor');
	if (Instigator != None && LaserDot == None && PlayerController(Instigator.Controller) != None)
		SpawnLaserDot();
	if (Instigator != None && AIController(Instigator.Controller) != None)
		ServerSwitchLaser(FRand() > 0.5);

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}
	else
	{
		IdleAnim = 'Idle';
		ReloadAnim = 'Reload';
	}

	if ( ThirdPersonActor != None )
		XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = bLaserOn;

      bRunOffsetting=false;
}


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
		XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
	OnLaserSwitched();
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
		LaserDot = Spawn(class'BallisticProV55.M806LaserDot',,,Loc);
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
	Loc = GetBoneCoords('ejector').Origin;

	End = Start + Normal(Vector(AimDir))*5000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') /*&& Level.TimeSeconds - FireMode[0].NextFireTime > 0.2*/)
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
		AimDir = GetBoneRotation('ejector');
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

function SetServerTurnVelocity (int NewTVYaw, int NewTVPitch)
{
	XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw = NewTVYaw;
	XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch = NewTVPitch;
}

simulated event PreBeginPlay()
{
	super.PreBeginPlay();
	if (Instigator!=None && Instigator.IsLocallyControlled())
		Shader'BWBP_Camos_Tex.XMVCamos.XMV500_Barrels_SD'.FallbackMaterial = Texture'BWBP_Camos_Tex.XMVCamos.XMV500_Barrels';
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local string s;

	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,128);
	s = "XMV500Minigun: TraceCount: "$XMV500MinigunPrimaryFire(FireMode[0]).TraceCount$ ", FireRate: "$1.0/FireMode[0].FireRate$"TurnVelocity: "$XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Pitch$", "$XMV500MinigunPrimaryFire(FireMode[0]).TurnVelocity.Yaw;
	Canvas.DrawText(s);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event PostBeginPlay()
{
	super.PostbeginPlay();
	XMV500MinigunPrimaryFire(FireMode[0]).Minigun = self;
}

simulated event WeaponTick (float DT)
{
	local rotator BT;

	BT.Roll = BarrelTurn;

	SetBoneRotation('Barrels', BT);

	DesiredSpeed = RotationSpeeds[CurrentWeaponMode];

	super.WeaponTick(DT);


	if (SprintControl != None)
	{
		//if sprinting or running
		if ((Instigator.Base != none && VSize(Instigator.velocity - Instigator.base.velocity) > 220 && !bRunOffsetting && CurrentWeaponMode != 1) || (!BCRepClass.default.bNoJumpOffset && SprintControl != None && SprintControl.bSprinting) )
		{
			AimComponent.OnPlayerSprint();
			bRunOffsetting=true;
		}
		else if (Instigator.Base != none && CurrentWeaponMode == 1 && SprintControl == None && SprintControl.bSprinting)
		{
			//SetNewAimOffset(default.AimOffset, AimAdjustTime);
			bRunOffsetting=false;
		}
		else if (Instigator.Base != none && ( VSize(Instigator.velocity - Instigator.base.velocity) <= 220 || CurrentWeaponMode == 1 ) && bRunOffsetting)
		{
			//SetNewAimOffset(default.AimOffset, AimAdjustTime);
			bRunOffsetting=false;
		}
	}
	else
	{
		if (Instigator.Base != none && VSize(Instigator.velocity - Instigator.base.velocity) > 220 && !bRunOffsetting && CurrentWeaponMode != 1 )
			{
				AimComponent.OnPlayerSprint();
				bRunOffsetting=true;
			}
			else if (Instigator.Base != none && ( VSize(Instigator.velocity - Instigator.base.velocity) <= 220 || CurrentWeaponMode == 1 ) && bRunOffsetting)
			{
				//SetNewAimOffset(default.AimOffset, AimAdjustTime);
				bRunOffsetting=false;
			}
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		KillLaserDot();
		if (ThirdPersonActor != None)
			XMV500MinigunAttachment(ThirdPersonActor).bLaserOn = false;
		AmbientSound = None;
		BarrelSpeed = 0;
		return true;
	}
	return false;
}

simulated event Tick (float DT)
{
	local float OldBarrelTurn;

	super.Tick(DT);

	if (FireMode[0].IsFiring())
	{
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.2*DT, 0.65*DT);
		BarrelTurn += BarrelSpeed * 655360 * DT;
	}
	else if (BarrelSpeed > 0)
	{
		BarrelSpeed = FMax(BarrelSpeed-0.075*DT, 0.01);
		OldBarrelTurn = BarrelTurn;
		BarrelTurn += BarrelSpeed * 655360 * DT;
		if (BarrelSpeed <= 0.025 && int(OldBarrelTurn/10922.66667) < int(BarrelTurn/10922.66667))
		{
			BarrelTurn = int(BarrelTurn/10922.66667) * 10922.66667;
			BarrelSpeed = 0;
			PlaySound(BarrelStopSound, SLOT_None, 0.5, , 32, 1.0, true);
			AmbientSound = None;
		}
	}
	if (BarrelSpeed > 0)
	{
		AmbientSound = BarrelSpinSound;
		SoundPitch = 32 + 96 * BarrelSpeed;
	}

	if (ThirdPersonActor != None)
		XMV500MinigunAttachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}

//TODO: Set az crosshair to red or something
simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	/*if (!FireMode[0].AllowFire() || bRunOffsetting )
	{
		CrosshairCfg.Color1.A = default.CrosshairCfg.Color1.A / 3;
		CrosshairCfg.Color2.A = default.CrosshairCfg.Color2.A / 3;
	}
	else
	{
		CrosshairCfg.Color1.A = default.CrosshairCfg.Color1.A;
		CrosshairCfg.Color2.A = default.CrosshairCfg.Color2.A;
	}
*/
	Super.NewDrawWeaponInfo (C, YPos);
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode > 0 && FireCount >= 1)
		return false;
	return super.CheckWeaponMode(Mode);
}

simulated function ServerSwitchWeaponMode (byte NewMode)
{
      PlaySound(ModeCycleSound,,4.7,,32);

	NewMode = CurrentWeaponMode + 1;
	while (NewMode != CurrentWeaponMode && (NewMode >= WeaponModes.length || WeaponModes[NewMode].bUnavailable) )
	{
		if (NewMode >= WeaponModes.length)
			NewMode = 0;
		else
			NewMode++;
	}
	if (!WeaponModes[NewMode].bUnavailable)
		CurrentWeaponMode = NewMode;
}


simulated function string GetHUDAmmoText(int Mode)
{
	return string(Ammo[Mode].AmmoAmount);
}

simulated function bool HasAmmo()
{
	//First Check the magazine
	if (FireMode[0] != None && MagAmmo >= FireMode[0].AmmoPerFire)
		return true;
	//If it is a non-mag or the magazine is empty
	if (Ammo[0] != None && FireMode[0] != None && Ammo[0].AmmoAmount >= FireMode[0].AmmoPerFire)
			return true;
	return false;	//This weapon is empty
}


// Targeted hurt radius moved here to avoid crashing

simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, optional Pawn ExcludedPawn )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims.Role == ROLE_Authority) && !Victims.IsA('FluidSurfaceInfo') && (ExcludedPawn == None || Victims != ExcludedPawn))
		{
			dir = Victims.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				(damageScale * Momentum * dir),
				DamageType
			);
		}
	}
	bHurtEntry = false;
}

simulated function float ChargeBar()
{
     return BarrelSpeed / DesiredSpeed;
}

//================================= Auto Turret ========================

function Notify_Deploy()
{
	local vector HitLoc, HitNorm, Start, End;
	local actor T;
	local Rotator CompressedEq;
    local BallisticAutoTurret Turret;
    local int Forward;

	if (Instigator.HeadVolume.bWaterVolume)
		return;
	// Trace forward and then down. make sure turret is being deployed:
	//   on world geometry, at least 30 units away, on level ground, not on the other side of an obstacle
	// BallisticPro specific: Can be deployed upon sandbags providing that sandbag is not hosting
	// another weapon already. When deployed upon sandbags, the weapon is automatically deployed 
	// to the centre of the bags.
	
	Start = Instigator.Location + Instigator.EyePosition();
	for (Forward=75;Forward>=45;Forward-=15)
	{
		End = Start + vector(Instigator.Rotation) * Forward;
		T = Trace(HitLoc, HitNorm, End, Start, true, vect(6,6,6));
		if (T != None && VSize(HitLoc - Start) < 30)
			return;
		if (T == None)
			HitLoc = End;
		End = HitLoc - vect(0,0,100);
		T = Trace(HitLoc, HitNorm, End, HitLoc, true, vect(6,6,6));
		if (T != None && (T.bWorldGeometry && (Sandbag(T) == None || Sandbag(T).AttachedWeapon == None)) && HitNorm.Z >= 0.9 && FastTrace(HitLoc, Start))
			break;
		if (Forward <= 45)
			return;
	}

	FireMode[1].bIsFiring = false;
   	FireMode[1].StopFiring();

	if(Sandbag(T) != None)
	{
		HitLoc = T.Location;
		HitLoc.Z += class'XMV500AutoTurret'.default.CollisionHeight + 15;
	}
	
	else
	{
		HitLoc.Z += class'XMV500AutoTurret'.default.CollisionHeight - 9;
	}
	
	CompressedEq = Instigator.Rotation;
		
	//Rotator compression causes disparity between server and client rotations,
	//which then plays hob with the turret's aim.
	//Do the compression first then use that to spawn the turret.
	
	CompressedEq.Pitch = (CompressedEq.Pitch >> 8) & 255;
	CompressedEq.Yaw = (CompressedEq.Yaw >> 8) & 255;
	CompressedEq.Pitch = (CompressedEq.Pitch << 8);
	CompressedEq.Yaw = (CompressedEq.Yaw << 8);

	Turret = Spawn(class'XMV500AutoTurret', None,, HitLoc, CompressedEq);
	
    if (Turret != None)
    {
		Turret.InitDeployedTurretFor(self);
		Turret.TryToDrive(Instigator);
		Destroy();
    }
    
    else
		log("Notify_Deploy: Could not spawn turret for XMV850 Minigun");
}


// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy != None) )
		return 0;

	if (Instigator.bIsCrouched && B.Squad.IsDefending(B) && fRand() > 0.6)
		return 1;

	return 0;
}
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
	if (Dist > 1000)
		Result -= (Dist-1000) / 3000;
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.2;
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping && Dist > 500)
		Result -= 0.4;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -1.3;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -1.4;	}
// End AI Stuff =====

defaultproperties
{
     BarrelSpinSound=Sound'BWBP_SKC_SoundsExp.550.Mini-Rotor'
     BarrelStopSound=Sound'BWBP_SKC_SoundsExp.550.Mini-Down'
     BarrelStartSound=Sound'BWBP_SKC_SoundsExp.550.Mini-Up'
     DeploySound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Deploy'
     UndeploySound=Sound'BW_Core_WeaponSound.XMV-850.XMV-UnDeploy'
     RunOffset=(Pitch=-1500,Yaw=-3000)
     LaserOnSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOn'
     ModeCycleSound=Sound'BWBP_SKC_Sounds.AH104.AH104-ModeCycle'
     LaserOffSound=Sound'BWBP_SKC_Sounds.AH104.AH104-SightOff'
     PlayerSpeedFactor=0.750000
     PlayerJumpFactor=0.750000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny',SkinNum=0)
     AIReloadTime=4.000000
     BigIconMaterial=Texture'BWBP_SKC_TexExp.XMV500.BigIcon_XMV500'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Bullet=True
     bWT_Machinegun=True
     bWT_Super=True
     SpecialInfo(0)=(Info="480.0;55.0;2.0;100.0;0.5;0.5;0.7")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-Putaway')
     MagAmmo=800
     CockSound=(Sound=Sound'BW_Core_WeaponSound.M353.M353-Cock')
     ReloadAnimRate=0.900000
     ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
     ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipOut')
     ClipInSound=(Sound=Sound'BW_Core_WeaponSound.XMV-850.XMV-ClipIn')
     ClipInFrame=0.650000
     bNonCocking=True
	 bShowChargingBar=True
     WeaponModes(0)=(ModeName="600 RPM",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="1200 RPM",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="2400 RPM",ModeID="WM_FullAuto")
	 WeaponModes(3)=(ModeName="3600 RPM",ModeID="WM_FullAuto",bUnavailable=True)
	 WeaponModes(4)=(ModeName="4800 RPM",ModeID="WM_FullAuto",bUnavailable=True)
	 RotationSpeeds(0)=0.16 // 600 RPM - 600 revolutions per minute x 6 shots (0.2)
	 RotationSpeeds(1)=0.33 // 1200 RPM - 1200 revolutions per minute x 6 shots ( (0.4)
     RotationSpeeds(2)=0.66  // 2400 RPM - 2400 revolutions per minute x 6 shots (0.7)
	 RotationSpeeds(3)=1.00  // 3600 RPM - 3600 revolutions per minute x 6 shots
	 RotationSpeeds(4)=1.32  // 4800 RPM - 4800 revolutions per minute x 6 shots
     CurrentWeaponMode=0
     SightPivot=(Pitch=512,Roll=1024)
     SightOffset=(X=0.000000,Y=-17.000000,Z=75.000000)
     SightDisplayFOV=50.000000
	 ParamsClasses(0)=Class'XMV500WeaponParams'
	 ParamsClasses(1)=Class'XMV500WeaponParamsClassic'
     FireModeClass(0)=Class'BWBP_SKC_Pro.XMV500MinigunPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.XMV500MinigunSecondaryFire'
     SelectAnimRate=0.750000
     PutDownTime=0.800000
     BringUpTime=2.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.700000
     CurrentRating=0.700000
     Description="XMB-500 Smart Minigun|Manuacturer: Enravion Combat Solutions|Primary: Auto fire||The XMB-500 Personal Suppression System is a prototype weapon being developed by Enravion as a low-recoil, precision minigun. The XMB-500 has been designed for ease of use with infantry and boasts firerates of 600 to 2400 RPM; combined with the potent incendiary rounds, the accurate XMB-500 is perfect for cutting down large amounts of enemy troops. This weapon has excellent accuracy when stationary but unfortunately cannot be fired safely at the higher speeds while moving. To prevent damage to the user and the weapon, the XMB-500 will automatically lock when mobile at cyclic speeds over 600 RPM. It should be noted that the speed sensor will malfunction if submerged in liquid or not properly cared for."
     DisplayFOV=52.000000
     Priority=48
     //CustomCrossHairColor=(A=219)
     //CustomCrossHairScale=1.008803
     //CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=6
     GroupOffset=3
     PickupClass=Class'BWBP_SKC_Pro.XMV500Pickup'
     PlayerViewOffset=(X=30.000000,Y=8.000000,Z=-45.000000)
     BobDamping=1.400000
     AttachmentClass=Class'BWBP_SKC_Pro.XMV500MinigunAttachment'
     IconMaterial=Texture'BWBP_SKC_TexExp.XMV500.SmallIcon_XMV500'
     IconCoords=(X2=127,Y2=25)
     ItemName="[B] XMB-500 Smart Minigun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_XMB501'
     DrawScale=0.600000
     SoundRadius=128.000000
}

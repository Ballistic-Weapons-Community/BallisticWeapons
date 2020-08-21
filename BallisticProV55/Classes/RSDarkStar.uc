//============================================================================
// RSDarkStar.
//
// The evil equivalent of the the Nova Staff. A very powerful weapon with
// multiple attack modes. Players killed with the Dark Star produce a soul which
// can be collected. When enough souls have been collected, super powers can be
// unleashed.
//
//
// Each staff is a projectile weapon with lower damage
// than normal, and must be powered up with souls.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkStar extends BallisticWeapon;

var	int			MaxSoulPower;

var float		BladeAlpha;
var float		DesiredBladeAlpha;
var float		BladeShiftSpeed;

var actor		DiamondGlow, Arc1;

var float		lastModeChangeTime;

var RSDarkChainsawPanner	ChainsawPanner;
var float					ChainSpeed;

var   RSDarkFlameSpray		Flame;

var bool		bLatchedOn;

var   float			SoulPower;
var   bool			bOnRampage;
//var() Sound			RampageSound;
var   RSDarkHorns	Horns;
var   actor			RampageGlow;

var   RSDarkNovaControl	DNControl;

//var MotionBlur			MBlur;

// BladesOpen
// PetalRoot: Holder

replication
{
	reliable if (Role == ROLE_Authority && bNetOwner)
		SoulPower;
	reliable if (Role == ROLE_Authority)
		bLatchedOn;
}

simulated function PostNetBeginPlay()
{
	local RSDarkNovaControl DNC;

	super.PostNetBeginPlay();

	if (Role == ROLE_Authority && DNControl == None)
	{
		foreach DynamicActors (class'RSDarkNovaControl', DNC)
		{
			DNControl = DNC;
			return;
		}
		DNControl = Spawn(class'RSDarkNovaControl', None);
	}
}

simulated function AnimEnded (int Channel, name anim, float frame, float rate)
{
	if (Anim == ZoomInAnim)
	{
		SightingState = SS_Active;
		ScopeUpAnimEnd();
		return;
	}
	else if (Anim == ZoomOutAnim)
	{
		SightingState = SS_None;
		ScopeDownAnimEnd();
		return;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
        if (anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim)) // rocket hack
			SafePlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        else if (FireMode[1]!=None && anim== FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim))
            SafePlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        else if (MeleeState < MS_Held)
        {
			if (anim != 'SawAttack' && anim != 'SawIdle')
				bPreventReload=false;
        }

		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		ReAim(0.05);
	}

	if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function SetScopeBehavior()
{
	bUseNetAim = default.bUseNetAim || bScopeView;

	if (bScopeView)
	{
		ViewAimFactor = 1.0;
		ViewRecoilFactor = 1.0;
		AimAdjustTime *= 2;

		AimSpread = 0;
		ChaosAimSpread *= SightAimFactor;
		ChaosDeclineTime *= 2.0;
		ChaosSpeedThreshold *= 0.7;
	}
	else
	{
		//PositionSights will handle this for clients
		if(Level.NetMode == NM_DedicatedServer)
		{
			ViewAimFactor = default.ViewAimFactor;
			ViewRecoilFactor = default.ViewRecoilFactor;
		}

		AimAdjustTime = default.AimAdjustTime;
		AimSpread = default.AimSpread;
		AimSpread *= BCRepClass.default.AccuracyScale;
		ChaosAimSpread = default.ChaosAimSpread;
		ChaosAimSpread *= BCRepClass.default.AccuracyScale;
		ChaosDeclineTime = default.ChaosDeclineTime;
		ChaosSpeedThreshold = default.ChaosSpeedThreshold;
	}
}

simulated function bool CanUseSights()
{
	if (FireMode[1].IsFiring())
		return false;
	return super.CanUseSights();
}

function AddSoul(float Amount)
{
	SoulPower = FClamp(SoulPower+Amount, 0, MaxSoulPower + 0.2f);
}

function ServerWeaponSpecial(optional byte i)
{
	if (SoulPower >= MaxSoulPower)
	{
		StartRampage();
		ClientWeaponSpecial(1);
	}
}
simulated function ClientWeaponSpecial(optional byte i)
{
	if (i > 0)
		StartRampage();
	else
		EndRampage();
}

// See if firing modes will let us fire another round or not
simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return true;
	return Super.CheckWeaponMode(Mode);
}

simulated function StartRampage()
{
	if (bOnRampage)
		return;
	bOnRampage = true;
	RSDarkAttachment(ThirdPersonActor).bRampage = true;

	RSDarkPrimaryFire(BFireMode[0]).ModePowerDrain *= 0.4;

	if (Role == ROLE_Authority)
	{
		Instigator.GroundSpeed *= 1.25;
		PlayerSpeedFactor = 1.25;
	}

	if (level.NetMode != NM_DedicatedServer)
	{
		Horns = spawn(class'RSDarkHorns',Instigator);
		if (Horns != None)
			Instigator.AttachToBone(Horns, 'head');
		if (RampageGlow != None)
			RampageGlow.Destroy();
	    if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    	{
    		RampageGlow = None;
			class'BUtil'.static.InitMuzzleFlash (RampageGlow, class'RSDarkRampageGlow', DrawScale, self, 'tip');
		}
	}
}

simulated function EndRampage()
{
	if (!bOnRampage)
		return;
	bOnRampage = false;
	RSDarkAttachment(ThirdPersonActor).bRampage = false;

	if (Role == ROLE_Authority)
	{
		Instigator.GroundSpeed /= 1.25;
		PlayerSpeedFactor = 1;
	}

	Instigator.AmbientSound = None;

	if (Horns != None)
		Horns.Destroy();

	if (RampageGlow != None)
		RampageGlow.Destroy();

	SoulPower = 0;
}

simulated event Tick(float DT)
{
	super.Tick(DT);

	if (bOnRampage && Instigator.Weapon != self)
		EndRampage();
}

simulated function float GetModifiedJumpZ(Pawn P)
{
	if (bOnRampage)
		return super.GetModifiedJumpZ(P) * 2.0;

	return super.GetModifiedJumpZ(P);
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	// less momentum when holding melee
	if (FireMode[1].IsFiring())
		Momentum *= 0.5;
	
	if (bOnRampage)
	{
		Damage *= 0.4;
		Momentum *= 0.5;
	}

	super.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function SetBladesOpen(float Alpha)
{
	BladeAlpha = FClamp(Alpha, 0.0, 1.0);
	AnimBlendParams(1, BladeAlpha, 0.0, 0.2, 'Holder');
	LoopAnim('BladesOpen',, 0.0, 1);
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(128,0,255);
	Canvas.DrawText("DarkStar: ChainSpeed: "$ChainSpeed$", BladeAlpha: "$BladeAlpha);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated event WeaponTick(float DT)
{
	local float AccelLimit;

	if (!Instigator.IsFirstPerson() && SightingState != SS_None)
		PositionSights();
	TickAim(DT);

	TickSighting(DT);

	if (!BCRepClass.default.bNoLongGun && GunLength > 0)
		TickLongGun(DT);
	if (AimDisplacementEndTime > Level.TimeSeconds || AimDisplacementFactor > 0)
		TickDisplacement(DT);
	TickFireCounter(DT);

	if (!bNoMag && level.TimeSeconds > BotTryReloadTime && AIController(Instigator.Controller) != None && (!Instigator.Controller.LineOfSightTo(AIController(Instigator.Controller).Enemy)) && BotShouldReload() )
	{
		BotTryReloadTime = level.TimeSeconds + 1.0;
		BotReload();
	}
	//Kab
	if (Instigator.Base != none)
        AimAdjustTime = (default.AimAdjustTime * 2) - (default.AimAdjustTime * (FMin(VSize(Instigator.Velocity - Instigator.Base.Velocity), 375) / 350));
    else
        AimAdjustTime = default.AimAdjustTime;

	if (bOnRampage)
	{
		SoulPower -= DT/8;
		if (SoulPower <= 0)
			EndRampage();
	}

	if (BladeAlpha != DesiredBladeAlpha)
		SetBladesOpen(BladeAlpha + FClamp(DesiredBladeAlpha - BladeAlpha, -BladeShiftSpeed*DT, BladeShiftSpeed*DT));

	if (FireMode[0].IsFiring())
	{
		ChainSpeed = 0;
	}
	else if (FireMode[1].IsFiring())
	{
		DesiredBladeAlpha = 0;
		BladeShiftSpeed = 4;

		if (BladeAlpha <= 0)
		{
			if (bLatchedOn && ChainSpeed != 1.5)
			{
				AccelLimit = (0.5 + 4.0*(ChainSpeed/2))*DT;
				ChainSpeed += FClamp(1.5 - ChainSpeed, -AccelLimit, AccelLimit);
			}
			
			else if (!bLatchedOn && ChainSpeed != 2)
			{
				AccelLimit = (0.5 + ChainSpeed) * DT;
				ChainSpeed += FClamp(2 - ChainSpeed, -AccelLimit, AccelLimit);
			}
		}
	}
	else if (ClientState == WS_ReadyToFire && FireMode[1].NextFireTime < level.TimeSeconds - 1)
	{
		if (ChainSpeed != 0)
		{
			AccelLimit = (0.5 + 1.5*(ChainSpeed/2))*DT;
			ChainSpeed += FClamp(-ChainSpeed, -AccelLimit, AccelLimit);
		}
		else
		{
			DesiredBladeAlpha = 1;
			BladeShiftSpeed = 3;
		}
	}
	if (DesiredBladeAlpha == 0)
		SoundPitch = 32 + 32 * ChainSpeed;
	else
		SoundPitch = default.SoundPitch;

	if (ChainsawPanner!=None)
		ChainsawPanner.PanRate = -ChainSpeed;

	if (BladeAlpha > 0)
	{
		if (Arc1 == None)
			class'BUtil'.static.InitMuzzleFlash (Arc1, class'RSDarkArcs', DrawScale, self, 'tip');
	}
	if (Arc1 != None)
	{
		if (BladeAlpha <= 0)
		{
			Arc1.Destroy();
			Arc1 = None;
		}
		else
		{
			RSDarkArcs(Arc1).SetGap(BladeAlpha);
		}
	}

	if (ThirdPersonActor != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		if (Flame != None)
		{
			Flame.SetLocation(RSDarkAttachment(ThirdPersonActor).GetTipLocation());
			Flame.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
		}
	}
}

simulated event RenderOverlays(Canvas C)
{
	super.RenderOverlays(C);
	if (Flame != None)
	{
		Flame.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32));
		Flame.SetRotation(rotator(Vector(GetAimPivot() + GetRecoilPivot()) >> GetPlayerAim()));
	}
}

function ServerSwitchWeaponMode (byte NewMode)
{
	if (CurrentWeaponMode > 0 && FireMode[0].IsFiring())
		return;
	super.ServerSwitchWeaponMode (NewMode);

	if (CurrentWeaponMode == 0)
	{
		RecoilXFactor=0.8;
		RecoilYFactor=1.5;
		RecoilDeclineDelay=0.8;
	}

	else
	{
		RecoilXFactor = default.RecoilXFactor;
		RecoilYFactor = default.RecoilYFactor;
		RecoilDeclineDelay = default.RecoilDeclineDelay;
	}

	if (CurrentWeaponMode == 0)
		AimSpread=1024;
	else if (CurrentWeaponMode == 4)
		AimSpread=1280;
	else AimSpread=default.AimSpread;
}
	
simulated function ClientSwitchWeaponModes (byte newMode)
{
	Super.ClientSwitchWeaponModes(newMode);

	if (newMode == 0)
	{
		RecoilXFactor=0.8;
		RecoilYFactor=1.5;
		RecoilDeclineDelay=0.8;
	}

	else
	{
		RecoilXFactor = default.RecoilXFactor;
		RecoilYFactor = default.RecoilYFactor;
		RecoilDeclineDelay = default.RecoilDeclineDelay;
	}

	if (newMode == 0)
		AimSpread=1024;
	else if (newMode == 4)
		AimSpread=1280;
	else AimSpread=default.AimSpread;
}

// Scales a RangeVector
static function ScaleRV (out RangeVector RV, float Scale)
{
	RV.X.Max*=Scale;	RV.Y.Max*=Scale;	RV.Z.Max*=Scale;
	RV.X.Min*=Scale;	RV.Y.Min*=Scale;	RV.Z.Min*=Scale;
}

// Scales the parameters of an emitter to resize it
static function ScaleEmitter (Emitter TheOne, float Scale)
{
	local int i, j;

	for (i=0;i<TheOne.Emitters.Length;i++)
	{
		ScaleRV (TheOne.Emitters[i].StartVelocityRange, Scale);
		TheOne.Emitters[i].SphereRadiusRange.Min*=Scale; TheOne.Emitters[i].SphereRadiusRange.Max*=Scale;
		TheOne.Emitters[i].StartVelocityRadialRange.Min*=Scale; TheOne.Emitters[i].StartVelocityRadialRange.Max*=Scale;
		TheOne.Emitters[i].MaxAbsVelocity *= Scale;
		ScaleRV (TheOne.Emitters[i].StartSizeRange, Scale);
		TheOne.Emitters[i].Acceleration *= Scale;
		ScaleRV (TheOne.Emitters[i].StartLocationRange, Scale);
		TheOne.Emitters[i].StartLocationOffset *= Scale;
		ScaleRV (TheOne.Emitters[i].MeshScaleRange, Scale);
		ScaleRV (TheOne.Emitters[i].VelocityScaleRange, Scale);
		ScaleRV (TheOne.Emitters[i].VelocityLossRange, Scale);
		if (BeamEmitter(TheOne.Emitters[i]) != None)
		{
			for (j=0;j<BeamEmitter(TheOne.Emitters[i]).BeamEndPoints.length;j++)
				ScaleRV (BeamEmitter(TheOne.Emitters[i]).BeamEndPoints[j].Offset, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).LowFrequencyNoiseRange, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).HighFrequencyNoiseRange, Scale);
			ScaleRV (BeamEmitter(TheOne.Emitters[i]).DynamicHFNoiseRange, Scale);
			BeamEmitter(TheOne.Emitters[i]).BeamDistanceRange.Max *= Scale;	BeamEmitter(TheOne.Emitters[i]).BeamDistanceRange.Min *= Scale;
		}
	}
}

// Scales Emitter flashes and inits DGVEmitter flashes
static function InitEmitterFlash (Emitter F, float FlashScale)
{
	if (F == None)
		return;
	class'RSDarkStar'.static.ScaleEmitter(F, FlashScale);
	if (DGVEmitter(F) != None)
		DGVEmitter(F).InitDGV();
	return;
}
// Handy function for spawning, attaching and initializing emiiter and non-emitter muzzle flashes
static function InitMuzzleFlash (out Actor Flash, class<actor> FlashClass, float FlashScale, Actor OwnedBy, name AttachBone)
{
	if (Flash != None || OwnedBy == None || FlashClass == None)
		return;
	// Spawn, Attach, Scale, Initialize emitter flashes
	Flash = OwnedBy.Spawn(FlashClass, OwnedBy);
	if (Emitter(Flash) != None)
		class'RSDarkStar'.static.InitEmitterFlash(Emitter(Flash), FlashScale);
	Flash.SetDrawScale(FlashScale);
	OwnedBy.AttachToBone(Flash, AttachBone);
}

exec function SetSpawnOffset (vector V)
{
	if (V == vect(0,0,0))
		Instigator.ClientMessage("SpawnOffset = " $ RSDarkPrimaryFire(FireMode[0]).SpawnOffset);
	else
		RSDarkPrimaryFire(FireMode[0]).SpawnOffset = V;
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
 	ChainsawPanner = RSDarkChainsawPanner(Level.ObjectPool.AllocateObject(class'RSDarkChainsawPanner'));
 	if (ChainsawPanner!=None)
 		Skins[3] = ChainsawPanner;
}
simulated function PlayIdle()
{
	super.PlayIdle();
	if (ChainSpeed <=0)
	{
		DesiredBladeAlpha = 1;
		BladeShiftSpeed = 3;
	}
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);

	ChainSpeed = 0;
	DesiredBladeAlpha = 0;
	SetBladesOpen(0);

	if (DiamondGlow != None)
		DiamondGlow.Destroy();
    if (Instigator.IsLocallyControlled() && level.DetailMode >= DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2)
    {
    	DiamondGlow = None;

		class'BUtil'.static.InitMuzzleFlash (DiamondGlow, class'RSDarkCoverGlow', DrawScale, self, 'crystal');
	}
}

simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bOnRampage)
			EndRampage();

		DesiredBladeAlpha = 0;
		BladeShiftSpeed = 3;
//		SetBladesOpen(1);
		return true;
	}
	return false;
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
	{
		class'BUtil'.static.KillEmitterEffect (DiamondGlow);
	}
	super.Timer();
}

exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

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

simulated function Destroyed()
{
	if (Flame != None)
		Flame.bHidden=false;

 	if (ChainsawPanner!=None)
 		level.ObjectPool.FreeObject(ChainsawPanner);

	if (Instigator.AmbientSound == UsedAmbientSound || Instigator.AmbientSound == RSDarkPrimaryFire(FireMode[0]).FireSoundLoop)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}

	if (bOnRampage)
		EndRampage();

	if (DiamondGlow != None)
		DiamondGlow.Destroy();

	if (Arc1 != None)
		Arc1.Destroy();

	if (RampageGlow != None)
		RampageGlow.Destroy();

	if (Horns !=None)
		Horns.Destroy();

	super.Destroyed();
}

simulated function FirePressed(float F)
{
	if (bNeedReload && MagAmmo > 0)
		bNeedReload = false;
	super.FirePressed(F);
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

simulated function TickLongGun (float DT)
{
	local Actor		T;
	local Vector	HitLoc, HitNorm, Start;
	local float		Dist;

	LongGunFactor += FClamp(NewLongGunFactor - LongGunFactor, -DT/AimAdjustTime, DT/AimAdjustTime);

	Start = Instigator.Location + Instigator.EyePosition();
	T = Trace(HitLoc, HitNorm, Start + vector(Instigator.GetViewRotation()) * (GunLength+Instigator.CollisionRadius), Start, true);
	if (T == None || T.Base == Instigator || (Projectile(T)!=None))
	{
		if (bPendingSightUp && SightingState < SS_Raising && NewLongGunFactor > 0)
			ScopeBackUp(0.5);
		NewLongGunFactor = 0;
	}
	else
	{
		Dist = VSize(HitLoc - Start)-Instigator.CollisionRadius;
		if (Dist < GunLength)
		{
			if (bScopeView)
				TemporaryScopeDown(0.5);
			NewLongGunFactor = Acos(Dist / GunLength)/1.570796;
		}
	}
}

simulated function float ChargeBar()
{
	return SoulPower/MaxSoulPower;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other,Pickup);

	if(RSDarkPickup(Pickup) != None)
		AddSoul(RSDarkPickup(Pickup).SoulPower);
}

function DropFrom(vector StartLocation)
{
    local int m;
	local Pickup Pickup;

    if (!bCanThrow)// || !HasAmmo())
        return;

	if (AmbientSound != None)
		AmbientSound = None;

    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }

	if ( Instigator != None )
		DetachFromPawn(Instigator);

	Pickup = Spawn(PickupClass,self,, StartLocation);
	if ( Pickup != None )
	{
        if (Instigator.Health > 0)
            WeaponPickup(Pickup).bThrown = true;
    	Pickup.InitDroppedPickupFor(self);
	    Pickup.Velocity = Velocity;
		if(RSDarkPickup(Pickup) != None)
			RSDarkPickup(Pickup).SoulPower = SoulPower;
    }
    Destroy();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;

	Dist = VSize(Instigator.Location - B.Enemy.Location);
	
	if (MagAmmo < 1 || ReloadState != RS_None || Dist < FireMode[1].MaxRange())
		return 1;

	if (level.TimeSeconds - lastModeChangeTime < 1.4 - B.Skill*0.15)
		return 0;

	if (Dist > 2048 && MagAmmo > 4)
	{
		if (CurrentWeaponMode != 0)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 0;
			RSDarkPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}
	else
	{
		if (CurrentWeaponMode != 1)
		{
			lastModeChangeTime = level.TimeSeconds;
			CurrentWeaponMode = 1;
			RSDarkPrimaryFire(FireMode[0]).SwitchWeaponMode(CurrentWeaponMode);
		}
	}

	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Dist;
	
	if (Instigator != None && Instigator.Health < 50)
		return 0.3; // dark star eats hp to fire

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		if (RecommendHeal(B))
			return 1.2;
	}

	if (B.Enemy == None)
		return Super.GetAIRating();

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	return class'BUtil'.static.DistanceAtten(Super.GetAIRating(), 0.5, Dist, 3072, 3072); 
}

exec simulated function Reload (optional byte i)
{
	if (ClientState == WS_ReadyToFire && ReloadState == RS_None)
		ServerStartReload(i);
}

simulated function AddBonusAmmo()
{
	Ammo[0].AddAmmo(1);
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
function float SuggestAttackStyle()	{	 return 0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.2;	}
// End AI Stuff =====

defaultproperties
{
	MaxSoulPower=3
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP4-Tex.DarkStar.BigIcon_DarkStar'
     BigIconCoords=(Y1=28,Y2=225)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     ManualLines(0)="Slow Bolts deal moderate damage, gain damage over range, set the enemy alight, blocking healing, and steal 20% of damage dealt as HP, but cost HP equal to 20% of their base damage to use.|Rapid Fire bolts have high damage, gain damage over range and steal 20% of damage dealt as HP, but cost HP equal to 10% of their base damage to use.|The Flamer mode deals low damage to all enemies within the projected flames, costing low soul power, and prevents them from healing.|Fire Bombs deal severe damage in a wide radius, costing high soul power."
     ManualLines(1)="Engages the chainsaw. This weapon deals high sustained damage, displaces the enemy's aim, leeches damage dealt as HP for the user and reduces damage taken from frontal melee attacks by 75%."
     ManualLines(2)="All of this weapon's modes have the potential to inflict damage to the wielder. Enemies killed by this weapon leave souls behind. These can be collected to power the Flamer, Immolation and Fire Bomb modes. Use of those modes without external soul power will consume the user's soul, dealing significant backlash damage.||With full soul power, the weapon can enter rampage mode, reducing all damage taken and increasing both speed and jump height. In this mode, soul power will drain over time.||Very effective at close and medium range."
     SpecialInfo(0)=(Info="300.0;40.0;1.0;80.0;0.0;1.0;1.0")
     BringUpSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-Pullout')
     PutDownSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-Putaway')
     MagAmmo=24
     ReloadAnimRate=1.250000
     ClipHitSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-GemHit',Volume=0.700000)
     ClipOutSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-GemOut',Volume=0.700000)
     ClipInSound=(Sound=Sound'BWBP4-Sounds.DarkStar.Dark-GemIn',Volume=0.700000)
     ClipInFrame=0.700000
     WeaponModes(0)=(ModeName="Bolt",ModeID="WM_FullAuto")
     WeaponModes(1)=(ModeName="Rapid Fire",ModeID="WM_FullAuto")
     WeaponModes(2)=(ModeName="Flame")
     WeaponModes(3)=(ModeName="Cone Immolation",ModeID="WM_FullAuto",bUnavailable=True)
     WeaponModes(4)=(ModeName="Fire Bomb",ModeID="WM_FullAuto")
     CurrentWeaponMode=0
     bNotifyModeSwitch=True
     SightPivot=(Pitch=1024)
     SightOffset=(X=-22.000000,Z=10.000000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     GunLength=128.000000
     SprintOffSet=(Pitch=-1024,Yaw=-1024)
     ChaosDeclineTime=1.250000
	 
	 ViewRecoilFactor=0.3
     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.060000),(InVal=0.200000,OutVal=0.080000),(InVal=0.300000,OutVal=0.180000),(InVal=0.600000,OutVal=0.240000),(InVal=0.700000,OutVal=0.30000),(InVal=1.000000,OutVal=0.35)))
     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.050000),(InVal=0.200000,OutVal=0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=0.600000),(InVal=0.700000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.10000
     RecoilYFactor=0.100000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.250000
     FireModeClass(0)=Class'BallisticProV55.RSDarkPrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.RSDarkMeleeFire'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.70000
     CurrentRating=0.70000
     bShowChargingBar=True
     Description="Towards the end of the first war, the UTC launched a fierce assault on the substantial Skrith facility set up just outside the rim of the large crater in secter-547b on a distant outworld planet. The skrith facility appeared to be a kind of temple combined with a mine where extensive excavations had been taking place. Deep below the temple, the UTC discovered ruins of an ancient alien city. In the deepest recesses of the Skrith excavation, they found a very strange artifact in the middle of being extracted from solid, fused stone. The artifact was then fully extracted and analysed by UTC scientists. Is was made of an incredibly strong material and, judging by its design, it seemed to be an ancient alien weapon. Despite countless tests, they failed to access the device's internal mechanisms or gain any further useful information."
     Priority=38
     HudColor=(B=25,G=25,R=200)
     InventoryGroup=5
     GroupOffset=2
     PickupClass=Class'BallisticProV55.RSDarkPickup'
     PlayerViewOffset=(X=5.000000,Y=6.000000,Z=-6.000000)
     AttachmentClass=Class'BallisticProV55.RSDarkAttachment'
     IconMaterial=Texture'BWBP4-Tex.DarkStar.SmallIcon_DarkStar'
     IconCoords=(X2=127,Y2=31)
     ItemName="Dark Star"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightSaturation=64
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP4-Anims.DarkStar'
     DrawScale=0.300000
     Skins(0)=Shader'BallisticWeapons2.Hands.Hands-Shiny'
     Skins(1)=Shader'BWBP4-Tex.DarkStar.DarkStar-Shiny'
     Skins(2)=Shader'BWBP4-Tex.DarkStar.DarkStarDiamond_SD'
     Skins(3)=Texture'BWBP4-Tex.DarkStar.DarkStarChain'
     bFullVolume=True
     SoundRadius=32.000000
}

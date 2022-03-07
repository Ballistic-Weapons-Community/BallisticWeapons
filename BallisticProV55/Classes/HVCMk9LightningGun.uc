//=============================================================================
// HVCMk9LightningGun
//
// A unique weapon that generates lightning, more or less...
// Uses a different method of detecting enemies that bascially ignores bad
// aiming. It strikes all players within a certain distance that are more or
// less in front of the muzzle. Fires a steady steam of lightning at all
// targets while primary is held. This creates a 'holding' effect which holds
// targets at a certain range and keeps them wherever the weapon is aimed.
// Although the actual lightning is not too damaging, the disorientating effect
// along with the fact that enemies can't escape, makes this a very deadly toy.
// Skilled players will also be able to figure out that by being able to hold
// enemies, they can move them around quite freely and throw, pull and slam
// them with devastating effect!
//
// Secondary is a chaged single blast that is directed at the exact spot the
// gun is aimed. The slow rate of fire comes with a very high damage and an
// unfortunate overloading discharge that will fry the user!
//
// Also not recomended for aquatic operations, cause it can't hurt people who
// unless the user dives in himself, but that mey be the last thing he does.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9LightningGun extends BallisticWeapon;

var float		HeatLevel;			// Current Heat level, duh...
var bool		bIsVenting;			// Busy venting
var() Sound		VentingSound;		// Sound to loop when venting
var() Sound		OverHeatSound;		// Sound to play when it overheats

var bool		bWaterBurn;			// busy getting damaged in water

var HvCMk9_TrackingZap		StreamEffect;

var bool	bArcOOA;			// Arcs have been killed cause ammo is out
var Actor	Arc1;				// The decorative side arc
var Actor	Arc2;				// The top arcs
var Actor	Arc3;
var Actor	Spiral;				// Red spiral that activates when charging secondary
var Actor	ClawSpark1;			// Sparks attached to claws when tracking enemy
var Actor	ClawSpark2;
var float	ClawAlpha;			// An alpha amount for claw movement interpolation
var float	RotorSpin;			// Rotation of rotor

var Emitter		FreeZap;		// The free zap emitter
var bool		bCanKillZap;	// Free zap is being killed and can be destroyed if needed, but we still want it rendered till then

var float		NextChangeMindTime;	// For AI
replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientOverCharge, ClientSetHeat;
}


simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BCRepClass.default.GameStyle == 1)
		HVCMk9PrimaryFire(FireMode[0]).GotoState('BranchingFire');
	else
		HVCMk9PrimaryFire(FireMode[0]).GotoState('DirectFire');
}

// -----------------------------------------------
// Events and target related stuff called from firemodes

simulated function ClientOverCharge()
{
	if (Firemode[0].bIsFiring)
		StopFire(0);
	if (Firemode[1].bIsFiring)
		StopFire(1);
}

// [2.5] Get the tracking zap emitter from attachment
simulated function HVCMk9_TrackingZapClassic GetTargetZap()
{
	if (ThirdPersonActor == None)
		return None;
	return HVCMk9Attachment(ThirdPersonActor).TargetZap;
}
// [2.5] Activate the target zap and/or give it the list of targets (Server->Attachment->Client)
simulated function SetTargetZap(array<actor> Ts, array<vector> Vs)
{
	if (!FireMode[0].IsFiring())
		return;
	if (Role == ROLE_Authority)
		HVCMk9Attachment(ThirdPersonActor).SetTargetZap(Ts, Vs);
	if (!Instigator.IsLocallyControlled())
		return;
	if (level.DetailMode > DM_High)
	{	if (ClawSpark1 == None)	class'BUtil'.static.InitMuzzleFlash (ClawSpark1, class'HVCMk9_ClawArc', DrawScale, self, 'ClawTip1');
		if (ClawSpark2 == None)	class'BUtil'.static.InitMuzzleFlash (ClawSpark2, class'HVCMk9_ClawArc', DrawScale, self, 'ClawTip2');	}
}
// [2.5] Activate free zap (Server->Attachment->Client)
simulated function SetFreeZap()
{
	if (Role == ROLE_Authority)
		HVCMk9Attachment(ThirdPersonActor).SetFreeZap();
	if (!Instigator.IsLocallyControlled())
		return;
	if (FreeZap != None)
	{	if (bCanKillZap)	FreeZap.Destroy();
		else				return;
	}
	KillTargetZap();
	FreeZap = spawn(class'HVCMk9_FreeZap', self);
	FreeZap.bHidden = true;
	bCanKillZap = false;
}
// [2.5] Kill all zaps (Server->Attachment->Client)
simulated function KillZap()
{
	if (Role == ROLE_Authority)
		HVCMk9Attachment(ThirdPersonActor).KillZap();
	if (Instigator.IsLocallyControlled())
	{	KillTargetZap();		KillFreeZap();		}
}
// [2.5] Kill the target zap (local only)
simulated function KillTargetZap()
{
	if (ClawSpark1 != None)		Emitter(ClawSpark1).Kill();
	if (ClawSpark2 != None)		Emitter(ClawSpark2).Kill();
	Instigator.SoundPitch=64;
}
// [2.5] Kill the free zap (local only)
simulated function KillFreeZap()
{
	if (FreeZap != None)
	{	FreeZap.Kill();	bCanKillZap = true;	}
}


// -----------------------------------------------
// Heat stuff

simulated function float ChargeBar()
{
	return HeatLevel / 10;
}
simulated event Tick (float DT)
{
	local int i;
	
	if (BCRepClass.default.GameStyle != 1)
	{
		if (HeatLevel > 0)
		{
			if (bIsVenting)
				Heatlevel = FMax(HeatLevel - 4 * DT, 0);
			else
				Heatlevel = FMax(HeatLevel - 0.4 * DT, 0);
		}
	}
	else //[2.5] Heat and target management
	{
		if (HeatLevel > 0)
		{
			if (bIsVenting)
				Heatlevel = FMax(HeatLevel - 2.5 * DT, 0);
			else
				Heatlevel = FMax(HeatLevel - 0.25 * DT, 0);
		}
		if (HVCMk9PrimaryFire(FireMode[0]) != None)
		{
			for(i=0;i<HVCMk9PrimaryFire(FireMode[0]).OldTargets.length;i++)
			{
				if (HVCMk9PrimaryFire(FireMode[0]).OldTargets[i].Vic == None)
				{
					HVCMk9PrimaryFire(FireMode[0]).OldTargets.Remove(i, 1);
					i--;
				}
				else
					HVCMk9PrimaryFire(FireMode[0]).OldTargets[i].Zaps = FMax(0, HVCMk9PrimaryFire(FireMode[0]).OldTargets[i].Zaps-DT);
			}
			for(i=0;i<HVCMk9PrimaryFire(FireMode[0]).OldLures.length;i++)
			{
				if (HVCMk9PrimaryFire(FireMode[0]).OldLures[i].Loc == vect(0,0,0))
				{
					HVCMk9PrimaryFire(FireMode[0]).OldLures.Remove(i, 1);
					i--;
				}
				else
				{
					HVCMk9PrimaryFire(FireMode[0]).OldLures[i].Zaps -= -DT;
					if (HVCMk9PrimaryFire(FireMode[0]).OldLures[i].Zaps <= 0)
					{
						HVCMk9PrimaryFire(FireMode[0]).OldLures.Remove(i, 1);
						i--;
					}
				}
			}
		}
	}
	super.Tick(DT);
}

simulated function AddHeat(float Amount)
{
	HeatLevel += Amount;
	if (HeatLevel >= 10 && HeatLevel < 12)
	{
		Heatlevel = 12;
		class'BallisticDamageType'.static.GenericHurt (Instigator, 20+Rand(40), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DT_HVCOverheat');
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None )
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		if (HVCMk9Pickup(Pickup) != None)
			HeatLevel = FMax( 0.0, HVCMk9Pickup(Pickup).HeatLevel - (level.TimeSeconds - HVCMk9Pickup(Pickup).HeatTime) * 0.25 );
		if (level.NetMode == NM_ListenServer || level.NetMode == NM_DedicatedServer)
			ClientSetHeat(HeatLevel);
    }
    else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

// -----------------------------------------------
// Effects interpolation and tickers

simulated event Timer()
{
	if (Instigator.Weapon != self)
		return;
	if (!bWaterBurn || Clientstate == WS_BringUp || Clientstate == WS_PutDown)
		super.Timer();
	else if (Role == ROLE_Authority && Instigator != None && AmmoAmount(0) > 0)
	{
		ConsumeAmmo(0, 2);
		class'BallisticDamageType'.static.GenericHurt (Instigator, 2, Instigator, Location, vect(0,0,0), class'DT_HVCDunk');
	}
}

simulated event WeaponTick(float DT)
{
	local vector End;

	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None)
	{
		if (HeatLevel > 0)
		{
			if (  BotShouldReload() && !Instigator.Controller.LineOfSightTo(AIController(Instigator.Controller).Enemy) && !IsGoingToVent())
				BotReload();
		}
		else if (bIsVenting)
			ReloadRelease();
	}

	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		if (AmmoAmount(0) > 0)
			AddHeat(DT*0.5);
		if (!bWaterBurn && Role == ROLE_Authority && (Clientstate == WS_ReadyToFire || !Instigator.IsLocallyControlled()))
		{
			bWaterBurn=true;
			SetTimer(0.4, true);
		}
	}
	else if (bWaterBurn)
	{
		bWaterBurn = false;
		if (TimerRate == 0.2)
			SetTimer(0.0, false);

	}
	if (!Instigator.IsLocallyControlled())
		return;

	if ((BCRepClass.default.GameStyle != 1 && GetTargetZap() != None) || FireMode[1].bIsFiring)	
	{	
		if (ClawAlpha < 1)
		{
			ClawAlpha = FClamp(ClawAlpha + DT, 0, 1);
			SetBoneRotation('Claw1', rot(-8192,0,0),0,ClawAlpha);
			SetBoneRotation('Claw2', rot(-8192,0,0),0,ClawAlpha);
			SetBoneRotation('Claw3', rot(-8192,0,0),0,ClawAlpha);
			SetBoneRotation('Claw1B', rot(-8192,0,0),0,ClawAlpha);
			SetBoneRotation('Claw2B', rot(-8192,0,0),0,ClawAlpha);
			SetBoneRotation('Claw3B', rot(-8192,0,0),0,ClawAlpha);
		}	
	}
	else if (ClawAlpha > 0)
	{
		ClawAlpha = FClamp(ClawAlpha - DT/3, 0, 1);
		SetBoneRotation('Claw1', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw1B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3B', rot(-8192,0,0),0,ClawAlpha);
	}
	if (level.DetailMode>DM_Low)
	{
		if (AmmoAmount(0) < 1 && !FireMode[1].bIsFiring)	{	if (!bArcOOA)
		{
			bArcOOA=true;
			if (Arc1 != None)	Arc1.Destroy();
			if (Arc2 != None)	Arc2.Destroy();
			if (Arc3 != None)	Arc3.Destroy();
		}	}
		else if (bArcOOA)
		{
			bArcOOA = false;
			InitArcs();
		}

		if (FireMode[1].bIsFiring)
		{
			if (Arc1==None||Arc2==None||Arc3==None)
				InitArcs();
			HVCMk9_SideArc(Arc1).SetColorShift(HVCMk9SecondaryFire(FireMode[1]).ChargePower);
			HVCMk9_TopArc(Arc2).SetColorShift(HVCMk9SecondaryFire(FireMode[1]).ChargePower);
			HVCMk9_TopArc(Arc3).SetColorShift(HVCMk9SecondaryFire(FireMode[1]).ChargePower);
		}
		if (!bArcOOA)
		{
			RotorSpin += DT*(65536 + 65536 * ClawAlpha);
			SetBoneRotation('Spinner', rot(0,0,1)*RotorSpin,0,1.f);
		}
	}

	if (ClawSpark1 != None)
	{
		End = GetBoneCoords('tip').Origin + vector(Instigator.GetViewRotation()) * 96;
		BeamEmitter(Emitter(ClawSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		if (ClawSpark2 != None)
			BeamEmitter(Emitter(ClawSpark2).Emitters[0]).BeamEndPoints[0].Offset = BeamEmitter(Emitter(ClawSpark1).Emitters[0]).BeamEndPoints[0].Offset;
	}
}

simulated event RenderOverlays (Canvas C)
{
	local vector End, X,Y,Z;
	if (Spiral != None)
		Spiral.SetRelativeRotation(rot(0,0,1)*RotorSpin);

	Super.RenderOverlays(C);
	
	
	if (BCRepClass.default.GameStyle != 1)
	{
		if (StreamEffect != None)
		{
			StreamEffect.bHidden = true;
			StreamEffect.SetLocation(ConvertFOVs(GetBoneCoords('Muzzle').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
			StreamEffect.UpdateEndpoint();
			C.DrawActor(StreamEffect, false, false, Instigator.Controller.FovAngle);
		}
	}
	else //[2.5] Multi-target zap rendering
	{
		if (FreeZap != None)
		{
			GetViewAxes(X,Y,Z);
			FreeZap.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
			FreeZap.SetRotation(rotator(Vector(GetAimPivot()*0.5) >> Instigator.GetViewRotation()));
			End = X * 1000;
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Min -= 500 * Abs(X.Z);
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.X.Max += 500 * Abs(X.Z);
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Min -= 500 * Abs(X.X);
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Y.Max += 500 * Abs(X.X);
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Min -= 500 * (1-Abs(X.Z));
			BeamEmitter(FreeZap.Emitters[0]).BeamEndPoints[0].Offset.Z.Max += 500 * (1-Abs(X.Z));

			BeamEmitter(FreeZap.Emitters[2]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End+vect(100,100,100), End-vect(100,100,100));

			C.DrawActor(FreeZap, false, false, Instigator.Controller.FovAngle);
		}
		if (GetTargetZap() != None)
		{
			GetTargetZap().bHidden = true;
			GetTargetZap().SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 96));
			GetTargetZap().UpdateTargets();
			C.DrawActor(GetTargetZap(), false, false, Instigator.Controller.FovAngle);
		}
	}
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

// -----------------------------------------------
// The arc effects and stuff

simulated function BringUp(optional Weapon PrevWeapon)
{
	bIsVenting = false;

	super.BringUp(PrevWeapon);

	AmbientSound = None;
	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
	if (AmmoAmount(0) > 0 && level.DetailMode>DM_Low)
		InitArcs();
}
simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bIsVenting)
		{
			if (level.NetMode == NM_Client)
				bIsVenting = false;
			ServerReloadRelease();
		}

		if (Arc1 != None)	Arc1.Destroy();
		if (Arc2 != None)	Arc2.Destroy();
		if (Arc3 != None)	Arc3.Destroy();
		bWaterBurn=false;
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
		return true;
	}
	return false;
}
simulated function ResetArcs()
{
	if (level.DetailMode>DM_Low)
	{
		Emitter(Spiral).kill();
		Spiral = None;
		if (Arc1==None && bArcOOA)
			return;
		InitArcs();
		HVCMk9_SideArc(Arc1).SetColorShift(0);
		HVCMk9_TopArc(Arc2).SetColorShift(0);
		HVCMk9_TopArc(Arc3).SetColorShift(0);
	}
}
simulated function InitArcs()
{
	if (Arc1 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc1, class'HVCMk9_SideArc', DrawScale, self, 'Arc3');
	if (Arc2 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc2, class'HVCMk9_TopArc',  DrawScale, self, 'Arc1');
	if (Arc3 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc3, class'HVCMk9_TopArc',  DrawScale, self, 'Arc2');
}

// -----------------------------------------------
// Reload / Venting stuff
simulated function bool IsGoingToVent()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == 'StartReload')
 		return true;
	return false;
}

exec simulated function Reload(optional byte i)
{
	if (!IsFiring())
		SafePlayAnim('StartReload', 1.0, 0.1);
}
simulated function Notify_LGArcOff()
{
	Instigator.AmbientSound = VentingSound;
	Instigator.SoundVolume = 128;
	if (Arc1 != None)
	{	Emitter(Arc1).Kill();	Arc1=None;	}
	if (Arc2 != None)
	{	Emitter(Arc2).Kill();	Arc2=None;	}
	if (Arc3 != None)
	{	Emitter(Arc3).Kill();	Arc3=None;	}
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'StartReload')
	{
		if (level.NetMode == NM_Client)
			bIsVenting = true;
		ServerStartReload();
	}
	super.AnimEnd(Channel);
}
function ServerStartReload (optional byte i)
{
	if (!Instigator.IsLocallyControlled())
	{	Instigator.AmbientSound = VentingSound;
		Instigator.SoundVolume = 128;	}
	bIsVenting = true;
}
simulated function PlayIdle()
{
    if (bIsVenting)
		SafeLoopAnim('ReloadLoop', 0.5, IdleTweenTime, ,"IDLE");
	else
		super.PlayIdle();
}

exec simulated function ReloadRelease(optional byte i)
{
    local name anim;
    local float frame, rate;

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	if (!bIsVenting)
	{
		GetAnimParams(0, anim, frame, rate);
		if (Anim != 'StartReload')
			return;
		SafePlayAnim('EndReload', 1.0, 0.2);
		if (frame < 0.5)
			SetAnimFrame(1-frame);
	}
	else
		SafePlayAnim('EndReload', 1.0, 0.2);

	if (level.NetMode == NM_Client)
		bIsVenting = false;
	ServerReloadRelease();
}
simulated function Notify_LGArcOn()
{
	if (AmmoAmount(0) > 0 && level.DetailMode>DM_Low)
		InitArcs();
}
function ServerReloadRelease(optional byte i)
{
	if (!Instigator.IsLocallyControlled())
	{	Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;	}
	bIsVenting = false;
}
// End Venting -----------------------------------


simulated function Destroyed()
{
	if (FreeZap != None)
		FreeZap.Destroy();
	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
	if (ClawSpark1 != None)
		ClawSpark1.Destroy();
	if (ClawSpark2 != None)
		ClawSpark2.Destroy();
	if (Spiral != None)
		Spiral.Destroy();
	if (Instigator.AmbientSound == UsedAmbientSound || Instigator.AmbientSound == VentingSound)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}
	super.Destroyed();
}

// AI Interface =====
// Is reloading a good idea???
function bool BotShouldReload ()
{
	if ( (!bIsVenting) && (HeatLevel > 2) && (Level.TimeSeconds - AIController(Instigator.Controller).LastSeenTime > AIReloadTime) &&
		 (Level.TimeSeconds - Instigator.LastPainTime > AIReloadTime) )
		return true;
	return false;
}
// Makes a bot reload if they have the skill or its forced
// Allows clever bots to reload when they get the chance and dumb ones only when they have to
function bool BotReload(optional bool bForced)
{
	if (bForced || AIController(Instigator.Controller).Skill >= Rand(4))
	{
		Reload();
		return true;
	}
	return false;
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
    local float Dist;
    local vector HitLocation, HitNormal, projStart;
    local actor HitActor;
    local int EC;
    local AIController B;
    local actor Victims;

    if ( (Instigator == None) || (Instigator.Controller == None) )
        return false;

    // check that target is within range
    Dist = VSize(Instigator.Location - Other.Location);
    if (Dist > FireMode[1].MaxRange())
	{
		BotReload();
        return false;
	}
    // check that can see target
    if (BotShouldReload() && !Instigator.Controller.LineOfSightTo(Other) && !IsGoingToVent())
	{
		BotReload();
        return false;
	}

	if (HeatLevel >= 10 && !IsGoingToVent())
	{
		BotReload();
        return false;
	}

	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		B = AIController(Instigator.Controller);
		if (B != None && B.Skill >= Rand(4))
		{
			ForEach Instigator.PhysicsVolume.TouchingActors(class'Actor', Victims)
			{
				if (Pawn(Victims) != None)
				{
					Dist = VSize(Victims.location - Instigator.location);
					if (Dist > 1900)
						continue;
					if (level.Game.bTeamGame && Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller))
					{
						if (B.Skill >= Rand(4) && TeamGame(level.Game) != None && TeamGame(level.Game).FriendlyFireScale > 0.1)
							return false;
					}
					else
						EC += Min(1500, 2000 - Dist);
				}
			}
			if (EC < 1990)
				return false;
		}
	}
	if (bIsVenting && HeatLevel < 10 && AIController(Instigator.Controller).Skill >= Rand(5) && (Level.TimeSeconds - Instigator.LastPainTime < 0.5))
		ReloadRelease();
	if (bIsVenting && AIController(Instigator.Controller).Skill + Rand(2) >= HeatLevel)
		ReloadRelease();

    // check that would hit target, and not a friendly
	if (level.Game.bTeamGame)
	{
    	projStart = Instigator.Location + Instigator.EyePosition();
		HitActor = Trace(HitLocation, HitNormal, Other.Location + Other.CollisionHeight * vect(0,0,0.8), projStart, true);
    	if ( (HitActor == None) || (HitActor == Other) || (Pawn(HitActor) == None)
			|| (Pawn(HitActor).Controller == None) || !Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller) )
        	return true;
	    return false;
    }
   	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Result, Dist;
	local Controller C;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Rand(2);

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (level.Game.bTeamGame && Rand(7) < B.Skill)
	{
		for (C=level.ControllerList;C!=None;C=C.nextController)
			if (Instigator.Controller.SameTeamAs(C) && C.Pawn != None && Normal(C.Pawn.Location - Instigator.Location) Dot Normal(B.Enemy.Location - Instigator.Location) > 0.75)
				return 1;
	}
	Result = FRand()-0.1;
	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		if (B.Enemy.PhysicsVolume == Instigator.PhysicsVolume && Dist > 200)
			Result -= 0.5;
		else if (Dist < 200)
			Result += 0.4;
		if (Result > 0.5)
			return 1;
		return 0;
	}

	// Stubborn ass bots want to keep zapping
	if (NextChangeMindTime > level.TimeSeconds)
		return 0;

	if (HeatLevel > 5)
		Result -= 0.1 * B.Skill * ((HeatLevel-5)/5);
	if (Dist > 1150)
		Result += 0.08 * B.Skill;
	else if (Dist < 500)
		result -= 0.05 * B.Skill;
	if (VSize(B.Enemy.Velocity) < 100)
		Result += 0.3;
	Result += 0.4 * (FMax(0.0, Normal(B.Enemy.Velocity) Dot vector(Instigator.GetViewRotation())) * 2 - 1);

	if (Result > 0.5)
		return 1;
	NextChangeMindTime = level.TimeSeconds + 4;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Result = Super.GetAIRating();
	if (Instigator.PhysicsVolume.bWaterVolume)
		Result -= 0.15 * B.Skill;
	
	// super effective at all ranges
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====

defaultproperties
{
	VentingSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Coolant'
	OverheatSound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	UsedAmbientSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
	AIReloadTime=0.200000
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_HVCMk9'
	BigIconCoords=(Y1=32,Y2=223)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	bWT_Hazardous=True
	bWT_Energy=True
	bWT_Super=True
	ManualLines(0)="Projects a continuous stream of lightning. Good damage, no recoil, long range and perfect hip accuracy."
	ManualLines(1)="Charges up the weapon to unleash a searing bolt of red lightning. Like the primary, has no recoil and perfect hip accuracy."
	ManualLines(2)="Holding Reload will cool off the weapon, reducing the heat buildup and preventing the threat of overcharge.||Will not function correctly underwater. Causes the user and nearby targets to be electrocuted if so used.||The HVC-Mk9 does not possess any iron sights.||This weapon is effective at all ranges."
	SpecialInfo(0)=(Info="360.0;40.0;1.0;90.0;0.0;0.5;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-Pullout',Volume=0.750000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway',Volume=0.600000)
	bNoMag=True
	WeaponModes(0)=(ModeName="Stream",ModeID="WM_None")
	WeaponModes(1)=(bUnavailable=True,Value=4.000000)
	WeaponModes(2)=(bUnavailable=True)
	CurrentWeaponMode=0
	bUseSights=False
	SightPivot=(Pitch=1024)
	SightOffset=(X=-12.000000,Z=26.000000)
	SightDisplayFOV=40.000000
	ParamsClasses(0)=Class'HVCMk9WeaponParams'
	ParamsClasses(1)=Class'HVCMk9WeaponParams' \\todo: lots of state code
	FireModeClass(0)=Class'BallisticProV55.HVCMk9PrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.HVCMk9SecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M806OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.M353InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,G=61,R=28,A=164),Color2=(G=53,A=224),StartSize1=94,StartSize2=87)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.700000
	
	PutDownTime=0.500000
	BringUpTime=1.000000
	AIRating=0.90000
	CurrentRating=0.900000
	bShowChargingBar=True
	Description="Krao, the mindless, virtually limitless alien swarm used by the Skrith has caused the appearance of weapons such as shotguns and heavy spread weapons, as well as many unusual designs and inventions, including electrical armaments. The HVC (High Voltage Cannon) Mk9 is one such device, making its first appearance during the second Human-Skrith war. Designed by Nexron Defence, pioneers in terran energy weapon technology, the HVC is indeed suited to destroying Krao drones in vast quantities. In battlefield trials, the 'lightning gun' has proven to be highly effective in close combat against Krao and occasionally proving useful against Cryons and even Skrith.|Using a large energy cell mounted on the user's backpack, it can produce extremely high-voltage charges of electricity."
	Priority=45
	HudColor=(B=255,G=150,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	PickupClass=Class'BallisticProV55.HVCMk9Pickup'
	PlayerViewOffset=(X=-4.000000,Y=10.000000,Z=-10.000000)
	AttachmentClass=Class'BallisticProV55.HVCMk9Attachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Lighter.SmallIcon_LG'
	IconCoords=(X2=127,Y2=31)
	ItemName="HVC-Mk9 Lightning Gun"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_HVC'
	DrawScale=0.250000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	bFullVolume=True
	SoundVolume=64
	SoundRadius=128.000000
}

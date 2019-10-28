//=============================================================================
// HVCMk9SecondaryFire.
//
// A powerful, short range charges instant hit type fire. Can overcharge and
// and hurt nearby actors as well as instigator is it's held to long.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVCMk9SecondaryFire extends BallisticInstantFire;

var() bool	 bDoOverCharge;
var   bool	 bPendingOwnerZap;
var   float	 PendingZapFactor;

var() Sound 	ChargeSound;

var   float	ChargePower;

//Spiral muzzle flash and looped idle anim (charging)
simulated function PlayPreFire()
{
	if (HVCMk9LightningGun(Weapon).Spiral == None)
		class'bUtil'.static.InitMuzzleFlash(HVCMk9LightningGun(Weapon).Spiral, class'HVCMk9_RedSpiral', Weapon.DrawScale, Weapon, 'drum');
	BW.SafeLoopAnim('Idle', 2.0, TweenTime, ,"IDLE");
}

function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	KickForce = ChargePower * default.KickForce;
	return super.GetDamage (Other, HitLocation, Dir, Victim, DT) * ChargePower;
}

//resets arc colours, play fire anim and sound
function PlayFiring()
{
	HVCMk9LightningGun(Weapon).ResetArcs();

	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
}

//manages velocity recoil, heat output, resetting sound volume, state reset and then fires
simulated event ModeDoFire()
{
	local float f;

	f = ChargePower;
	VelocityRecoil = default.VelocityRecoil * f;
	HVCMk9LightningGun(Weapon).AddHeat(1.2);
	if (Instigator == None)
		return;
	Instigator.SoundVolume = Weapon.default.SoundVolume;
	Instigator.SoundPitch = Weapon.default.SoundPitch;
	Instigator.AmbientSound = BW.UsedAmbientSound;
	GotoState('');
	super.ModeDoFire();
	ChargePower=0;
	if (bDoOverCharge)
	{
		NextFireTime += 2.0;
		bDoOverCharge = false;
	}
}

//can only fire if charged, not venting and below required heat
simulated function bool AllowFire()
{
	if (ChargePower > 0)
		return true;
	if ((HoldTime <= 0 && HVCMk9LightningGun(Weapon).HeatLevel >= 10) || HVCMk9LightningGun(Weapon).bIsVenting || !super.AllowFire())
		return false;
	return true;
}

//if firing, add heat, modify sound pitch with charge level and check for overcharging
simulated event ModeTick(float DT)
{
	super.ModeTick(DT);
	if (!bIsFiring)
		return;
	if (Instigator.PhysicsVolume.bWaterVolume)
		HVCMk9LightningGun(Weapon).AddHeat(DT*3);
	else
		HVCMk9LightningGun(Weapon).AddHeat(DT*0.75);
	Instigator.SoundPitch = 56 + ChargePower*32;
	if (Weapon.Role == Role_Authority && !bDoOverCharge && HVCMk9LightningGun(Weapon).HeatLevel > 10)
	{
		bDoOverCharge = true;
		HVCMk9LightningGun(Weapon).ClientOverCharge();
		Weapon.ServerStopFire(ThisModeNum);
	}
}

//fire held - Go to charging state, manage sound volume
simulated function ModeHoldFire()
{
	Instigator.AmbientSound = ChargeSound;
	Instigator.SoundVolume = 255;
	Instigator.SoundPitch = 56;
	GotoState('Charging');
	Super.ModeHoldFire();
}

state Charging
{
	function BeginState()
	{
		SetTimer(0.2,true);
		Timer();
	}
	
	//deduct ammo for charge
	event Timer()
	{
		if (Weapon.AmmoAmount(0) > 0 && ChargePower < 1)
		{
			if (Weapon.Role == ROLE_Authority)
				Weapon.ConsumeAmmo(0, 1);
			ChargePower = FMin(1.0, ChargePower + 0.05);
		}
	}
	function EndState()
	{
		SetTimer(0.0,false);
	}
}

//manages self damage
event Timer()
{
	if (bPendingOwnerZap)
	{
		bPendingOwnerZap=false;
		class'BallisticDamageType'.static.GenericHurt (Instigator, PendingZapFactor*180, Instigator, Instigator.Location + vector(Instigator.GetViewRotation()) * Instigator.CollisionRadius, KickForce * PendingZapFactor * vector(Instigator.GetViewRotation()), class'DT_HVCOverheat');
	}
}

//if we aren't overheated, go to old trace - else blow shit up
function DoTrace (Vector Start, Rotator Dir)
{
	local actor Victims;
	local vector X;
	local float f;

	if (!bDoOverCharge)
	{
		OldDoTrace(Start, Dir);
		return;
	}
	X = vector(Dir);
	SendFireEffect(level, Start+X*64, -X, 0);
//	f = FMin(1.0,HoldTime/4);
	f = ChargePower;
	foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, 192, Start + X * 64 )
		if(!Victims.IsA('FluidSurfaceInfo') && !Victims.bWorldGeometry && Victims.bCanBeDamaged)
		{
			if (Victims == Instigator)
			{
				PendingZapFactor = f;
				bPendingOwnerZap = true;
				SetTimer(0.15, false);
			}
			else
				class'BallisticDamageType'.static.GenericHurt (Victims, f*180, Instigator, Victims.Location - X * Victims.CollisionRadius, f * KickForce * X, class'DT_HVCOverheat');
		}
}

// Do the trace to find out where bullet really goes
function OldDoTrace (Vector InitialStart, Rotator Dir)
{
	local int						PenCount, WallCount;
	local Vector					End, X, HitLocation, HitNormal, Start, WaterHitLoc, LastHitLoc;
	local Material					HitMaterial;
	local float						Dist;
	local Actor						Other, LastOther;
	local bool						bHitWall;

	// Work out the range
	Dist = TraceRange.Min + FRand() * (TraceRange.Max - TraceRange.Min);

	Start = InitialStart;
	X = Normal(Vector(Dir));
	End = Start + X * Dist;
	LastHitLoc = End;
	Weapon.bTraceWater=true;

	while (Dist > 0)		// Loop traces in case we need to go through stuff
	{
		// Do the trace
		Other = Trace (HitLocation, HitNormal, End, Start, true, , HitMaterial);
		Weapon.bTraceWater=false;
		Dist -= VSize(HitLocation - Start);
		if (Level.NetMode == NM_Client && (Other.Role != Role_Authority || Other.bWorldGeometry))
			break;
		if (Other != None)
		{
			// Water
			if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
			{
				SendFireEffect(Other, HitLocation, HitNormal, 9);
				bHitWall = true;
				break;
			}
			else
				LastHitLoc = HitLocation;
			// Got something interesting
			if (!Other.bWorldGeometry && Other != LastOther)
			{
				DoDamage(Other, HitLocation, InitialStart, X, PenCount, WallCount);
				LastOther = Other;
				SendFireEffect(Other, HitLocation, HitNormal, 9);
				bHitWall = true;
				break;
			}
			// Do impact effect
			if (Other.bWorldGeometry || Mover(Other) != None)
			{
				bHitWall = ImpactEffect (HitLocation, HitNormal, HitMaterial, Other, WaterHitLoc);
				break;
			}
			// Still in the same guy
			if (Other == Instigator || Other == LastOther)
			{
				Start = HitLocation + (X * FMax(32, Other.CollisionRadius * 2));
				End = Start + X * Dist;
				Weapon.bTraceWater=true;
				continue;
			}
			break;
		}
		else
		{
			LastHitLoc = End;
			break;
		}
	}
	// Never hit a wall, so just tell the attachment to spawn muzzle flashes and play anims, etc
	if (!bHitWall)
		NoHitEffect(X, InitialStart, LastHitLoc, WaterHitLoc);
	else
		TargetedHurtRadius(100*ChargePower, 192, class'DT_HVCRedLightning', 2000, HitLocation, Other);
}
// Tells the attachment to play fire anims and so on, but without impact effects
function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc)
{
	if (Weapon != None && level.NetMode != NM_Client)
	{
		SendFireEffect(none, Dir, vect(0,0,0), 0, WaterHitLoc);
	}
}
simulated function TargetedHurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation, Optional actor Victim )
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	foreach Instigator.VisibleCollidingActors( class 'Actor', Victims, DamageRadius, HitLocation )
	{
		if( (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) && Victims != Victim)
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
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	HVCMk9Attachment(Weapon.ThirdPersonActor).ChargePower = 255*ChargePower;
	super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
}

defaultproperties
{
     ChargeSound=Sound'BWBP2-Sounds.LightningGun.LG-Charge'
     Damage=200.000000
     DamageHead=200.000000
     DamageLimb=200.000000
     DamageType=Class'BallisticProV55.DT_HVCRedLightning'
     DamageTypeHead=Class'BallisticProV55.DT_HVCRedLightning'
     DamageTypeArm=Class'BallisticProV55.DT_HVCRedLightning'
     KickForce=80000
     bNoPositionalDamage=True
     MuzzleFlashClass=Class'BallisticProV55.HVCMk9RedMuzzleFlash'
     RecoilPerShot=96.000000
     VelocityRecoil=1600.000000
     BallisticFireSound=(Sound=Sound'BWBP2-Sounds2.LightningGun.LG-SecFire',Volume=0.900000)
     bFireOnRelease=True
     FireAnim="Fire2"
     FireEndAnim=
     FireRate=0.700000
     AmmoClass=Class'BallisticProV55.Ammo_HVCCells'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=1.000000
     WarnTargetPct=0.200000
}

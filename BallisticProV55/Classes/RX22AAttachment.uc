//=============================================================================
// RX22AAttachment.
//
// Thrid person attachment for RX22AFlamer. Bit more than your average attachment here...
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AAttachment extends BallisticAttachment;

var   Actor		Ignition;
var   bool		bIgnited;

var   RX22ASpray		Flame;
var   RX22ATank			GasTank;
var   RX22AGasSpray		GasSpray;

struct FlameHit			// Info about a flame hit event
{
	var vector			HitLoc;	// Where it hit
	var vector			HitNorm;// Normal for hit
	var float			HitTime;// When to make it happen
};

var   array<FlameHit>		FlameHits;		// Shots fired, used to time impacts

var   Emitter	FlameHitFX;				// Emitter moved to flame hit locations
var   float		KillFlameTime;			// When FlameHit should be killed


simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
	Super.SetOverlayMaterial(mat, time, bOverride);
	if ( GasTank != None )
		GasTank.SetOverlayMaterial(mat, time, bOverride);
}

simulated function Hide(bool NewbHidden)
{
	super.Hide(NewbHidden);
	if (GasTank!= None)
		GasTank.bHidden = NewbHidden;
}

simulated function DoFlameHit(vector Loc, vector Norm)
{
	if (FlameHitFX == None)
		FlameHitFX = Spawn(class'RX22AFireHit',,,Loc, rotator(Norm));
	else
	{
		FlameHitFX.SetLocation(Loc);
		FlameHitFX.SetRotation(rotator(Norm));
	}
	KillFlameTime = level.TimeSeconds + 0.12;
}

simulated function EndFlameHit()
{
	if (FlameHitFX != None)
	{
		FlameHitFX.Kill();
		FlameHitFX = None;
	}
}

simulated event PostBeginPlay()
{
	super.PostBeginPlay();

	if (Role == ROLE_Authority)
	{
		GasTank = Spawn(class'RX22ATank',Instigator,,Instigator.Location - vector(Instigator.Rotation+rot(0,5000,0) )*14 + vect(0,0,24));
		GasTank.Instigator = Instigator;
		GasTank.Weapon = RX22AFlamer(Instigator.Weapon);
		if (level.NetMode == NM_DedicatedServer)
			GasTank.SetBase(Instigator);
	}
}

simulated function FlashMuzzleFlash(byte Mode)
{
	if (Mode != 0)
		return;

	super.FlashMuzzleFlash(Mode);
	if (Ignition == None || Ignition.bDeleteMe )
		class'BUtil'.static.InitMuzzleFlash (Ignition, class'RX22AIgniter', DrawScale*FlashScale, self, 'tip2');
	if (Ignition != None && !bIgnited)
	{
		Ignition.Trigger(self, Instigator);
		bIgnited = true;
	}
}

simulated event Timer()
{
	super.Timer();
	StopSpray();
	bIgnited = false;
}

simulated event Tick(float DT)
{
	local int i;

	super.Tick(DT);

	for (i=0;i<FlameHits.length;i++)
		if (level.TimeSeconds >= FlameHits[i].HitTime)
		{
			DoFlameHit(FlameHits[i].HitLoc, FlameHits[i].HitNorm);
			FlameHits.Remove(i,1);
			i--;
		}
	if (FlameHitFX != None && level.TimeSeconds >= KillFlameTime)
		EndFlameHit();
}

simulated function InstantFireEffects(byte Mode)
{
	local vector Dir, End;
	local int i;

	if (level.NetMode == NM_DedicatedServer)
		return;

	if (Mode == 0)
	{
		if (GasSpray != None)
		{
			GasSpray.Kill();
			GasSpray.bHidden = false;
			GasSpray = None;
		}
		if (Flame == None)
			Flame = Spawn(class'RX22ASpray',Instigator,,GetTipLocation(), rotator(mHitLocation - GetTipLocation()));
		if (Instigator.IsFirstPerson())
			Flame.bHidden = true;
		else
		{
			Flame.bHidden = false;
			Flame.SetLocation(GetTipLocation());
			Flame.SetRotation(Rotator(mHitLocation - Flame.Location));
		}
		Flame.SetFlameRange(VSize(mHitLocation - Flame.Location));
		if (RX22AFlamer(Instigator.Weapon) != None)
			RX22AFlamer(Instigator.Weapon).Flame = Flame;
		FlyByEffects(Mode, mHitLocation);

		if (level.NetMode == NM_Client)
		{
			Dir = Normal(mHitLocation - (Instigator.Location + Instigator.EyePosition()));
			End = mHitLocation + Dir*20;
			mHitActor = Trace(mHitLocation, mHitNormal, End, End - Dir*40, false);
		}
		if (mHitActor != None)
		{
			i = FlameHits.length;
			FlameHits.length = i + 1;
			FlameHits[i].HitLoc = mHitLocation;
			FlameHits[i].HitNorm = mHitNormal;
			FlameHits[i].HitTime = level.TimeSeconds + VSize(Instigator.Location - mHitLocation) / 3600;
		}
	}
	else if (Mode == 1)
	{
		if (Flame != None)
		{
			Flame.Kill();
			Flame.bHidden = false;
			Flame = None;
		}

		if (GasSpray == None)
			GasSpray = Spawn(class'RX22AGasSpray',Instigator,,GetTipLocation(), rotator(mHitLocation - GetTipLocation()));
		if (Instigator.IsFirstPerson())
			GasSpray.bHidden = true;
		else
		{
			GasSpray.bHidden = false;
			GasSpray.SetLocation(GetTipLocation());
			GasSpray.SetRotation(Rotator(mHitLocation - GasSpray.Location));
		}
		GasSpray.SetFlameRange(VSize(mHitLocation - GasSpray.Location));
		if (RX22AFlamer(Instigator.Weapon) != None)
			RX22AFlamer(Instigator.Weapon).GasSpray = GasSpray;
	}
}

simulated function StopSpray()
{
	if (Flame != None)
	{
		Flame.Kill();
		Flame.bHidden = false;
		Flame = None;
	}
	if (Instigator != None && RX22AFlamer(Instigator.Weapon) != None)
		Instigator.Weapon.AmbientSound = None;

	if (GasSpray != None)
	{
		GasSpray.Kill();
		GasSpray.bHidden = false;
		GasSpray = None;
	}
	if (MuzzleFlash != None)
	{
		Emitter(MuzzleFlash).Kill();
		MuzzleFlash = None;
	}
	if (AltMuzzleFlash != None)
	{
		Emitter(AltMuzzleFlash).Kill();
		AltMuzzleFlash = None;
	}
}

simulated event Destroyed()
{
	EndFlameHit();
	if (GasTank != None)
		GasTank.AttachmentDestroyed();
	if (Ignition != None)
		Ignition.Destroy();
	if (Flame != None)
		Flame.Kill();
	if (GasSpray != None)
		GasSpray.Kill();
	super.Destroyed();
}

defaultproperties
{
     MuzzleFlashClass=Class'BallisticProV55.RX22AMuzzleFlame'
     WeaponLightTime=0.300000
     FlashScale=2.000000
     FlyBySound=(Sound=Sound'BallisticSounds2.RX22A.RX22A-FlyBy',Volume=0.700000)
     ReloadAnim="Reload_MG"
	 ReloadAnimRate=1.050000
     bHeavy=True
     bRapidFire=True
     bAltRapidFire=True
     Mesh=SkeletalMesh'BallisticAnims2.RX22A-3rd'
     DrawScale=0.250000
}

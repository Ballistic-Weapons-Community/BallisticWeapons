//=============================================================================
// AH104 Secondary Fire
//
// A very potent, but ammo draining flame stream that incinerates players
// Uses trace / projectile combo for hit detection.
//
// by Azarael and Sarge
// adapting code by Nolan "Dark Carnivour" Richert
// Aspects of which are copyright (c) 2006 RuneStorm. All rights reserved.
//=============================================================================
class AH104SecondaryFire extends BallisticInstantFire;

var  	Actor						MuzzleFlame;
var   	bool						bIgnited;
var 	Sound						FireSoundLoop;
var BUtil.FullSound 				FlameEndSound;
const FLAMERINTERVAL = 0.2f;

simulated function bool AllowFire()
{
	if (!CheckReloading() || Instigator.HeadVolume.bWaterVolume)
	{
		if (bIgnited)
			StopFiring();
		return false;		// Is weapon busy reloading
	}
	if (AH104Pistol(BW).AltMagAmmo < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		if (bIgnited)
			StopFiring();
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

event Timer()
{
	super.Timer();
	if ( bIgnited && (!IsFiring() || Weapon.GetFireMode(0).IsFiring() ) )
	{
		StopFlaming();
	}
}

function StopFiring()
{
	bIgnited = false;
	Instigator.AmbientSound = None;
	Weapon.PlayOwnedSound(FlameEndSound.Sound,FlameEndSound.Slot,FlameEndSound.Volume,FlameEndSound.bNoOverride,FlameEndSound.Radius,FlameEndSound.Pitch,FlameEndSound.bAtten);
	NextFireTime = Level.TimeSeconds + FLAMERINTERVAL;
	if (MuzzleFlame != None)
	{
		Emitter(MuzzleFlame).Kill();
		MuzzleFlame = None;
	}
}

function StopFlaming()
{
	bIgnited = false;
	
	if (MuzzleFlame != None)
	{	
		Emitter(MuzzleFlame).Kill();	
		MuzzleFlame = None;	
	}

	Instigator.AmbientSound = BW.UsedAmbientSound;
}

function float MaxRange()	{	return 800;	}

function DoFireEffect()
{
	local Vector Start, Dir, End, HitLocation, HitNormal;
	local Rotator Aim;
	local actor Other;
	local float Dist;
	local int i;
	local AH104FlameProjectile Prj;

	// the to-hit trace always starts right in front of the eye
	Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);

	Dir = Vector(Aim);
	End = Start + (Dir*MaxRange());

	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		if (Other == None || Other.bWorldGeometry || Mover(Other) != none || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
			break;
		Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
	}
	Weapon.bTraceWater=false;

	if (Other == None)
		HitLocation = End;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		Other = None;

	Dist = VSize(HitLocation-Start);

	Prj = Spawn (class'AH104FlameProjectile',Instigator,, Start, Rotator(HitLocation-Start));
	
	if (Prj != None)
	{
		Prj.Instigator = Instigator;
		Prj.InitFlame(HitLocation);
		Prj.bHitWall = Other != None;
	}

	AH104Attachment(Weapon.ThirdPersonActor).AH104UpdateFlameHit(Other, HitLocation, HitNormal);
	
	AH104Pistol(BW).AltMagAmmo--;

	Super(BallisticFire).DoFireEffect();
}

//Do the spread on the client side
function PlayFiring()
{
	ClientPlayForceFeedback(FireForce);  // jdf
	FireCount++;

	if (FireSoundLoop != None)
		Instigator.AmbientSound = FireSoundLoop;

	if (!bIgnited)
	{
		//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	if (MuzzleFlame == None)
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlame, class'RX22AMuzzleFlame', Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

//server
function ServerPlayFiring()
{
	if (!bIgnited)
	{
		//BW.SafeLoopAnim(FireLoopAnim, FireAnimRate, TweenTime, ,"FIRE");
		bIgnited = true;
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	if (FireCount == 0 && FireSoundLoop != None)
		Instigator.AmbientSound = FireSoundLoop;
}

simulated function DestroyEffects()
{
	Super.DestroyEffects();
	if (MuzzleFlame != None)
		MuzzleFlame.Destroy();
}

defaultproperties
{
	FlameEndSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopEnd',Volume=0.500000,Radius=64.000000,Slot=SLOT_Interact,Pitch=1.000000,bAtten=True)
	FireSoundLoop=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoop'
	FlashBone="'"
	FireAnim="FireAltContinuous"
	FireChaos=0.050000
	bPawnRapidFireAnim=True
	FireRate=0.050000
	AmmoClass=Class'BallisticProV55.Ammo_FlamerGas'
	AmmoPerFire=0
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameLoopStart',Volume=1.350000)
	DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.AH104.AH104-FlameDryFire',Volume=1.350000)
	ShakeRotMag=(X=64.000000,Y=64.000000,Z=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-8.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=1.500000
	WarnTargetPct=0.200000
}

//=============================================================================
// AK47PrimaryFire.
//
// High powered automatic fire. Hits like the SRS but has less accuracy.
// Good for close and mid range, bad at long range.
// Has better than average penetration.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91PrimaryFire extends BallisticInstantFire;

simulated event ModeTick(float DT)
{
	Super.ModeTick(DT);

	if (Weapon.SoundPitch != 56)
	{
		if (Instigator.DrivenVehicle!=None)
			Weapon.SoundPitch = 56;
		else
			Weapon.SoundPitch = Max(56, Weapon.SoundPitch - 8*DT);
	}
}

function PlayFiring()
{
	Super.PlayFiring();
	Weapon.SoundPitch = Min(150, Weapon.SoundPitch + 8);
	
	AK91ChargeRifle(BW).AddHeat(HeatPerShot);
}

function Supercharger_ChargeControl GetChargeControl()
{
	return AK91ChargeRifle(Weapon).GetChargeControl();
}

function DoFireEffect()
{
    local Vector Start, Dir, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local float Dist;
	local int i;

    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();
	Aim = GetFireAim(Start);
	Aim = Rotator(GetFireSpread() >> Aim);

	DoTrace(Start, Aim);

    Dir = Vector(Aim);
	End = Start + (Dir*MaxRange());
	Weapon.bTraceWater=true;
	for (i=0;i<20;i++)
	{
		Other = Trace(HitLocation, HitNormal, End, Start, true);
		if (Other == None || Other.bWorldGeometry || Mover(Other) != none || Vehicle(Other)!=None || FluidSurfaceInfo(Other) != None || (PhysicsVolume(Other) != None && PhysicsVolume(Other).bWaterVolume))
			break;
		Start = HitLocation + Dir * FMax(32, (Other.CollisionRadius*2 + 4));
	}
	Weapon.bTraceWater=false;

	if (Other == None)
		HitLocation = End;
	if ( (FluidSurfaceInfo(Other) != None) || ((PhysicsVolume(Other) != None) && PhysicsVolume(Other).bWaterVolume) )
		Other = None;

	Dist = VSize(HitLocation-Start);


	if (Other != None && (Other.bWorldGeometry || Mover(Other) != none))
		GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, Other, 2);
	else
		GetChargeControl().FireShot(Start, HitLocation, Dist, Other != None, HitNormal, Instigator, None, 2);
	
	SendFireEffect(Other, HitLocation, HitNormal, 0);

	Super(BallisticFire).DoFireEffect();
	
	if (level.Netmode == NM_DedicatedServer && !Instigator.IsLocallyControlled())
	{
		AK91ChargeRifle(Weapon).AddHeat(HeatPerShot);
	}
}


// The base DoTrace does the hits and penetration. The shot's hit effect is sent by DoFireEffect, with the zap
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	return true;
}

function NoHitEffect (Vector Dir, optional vector Start, optional vector HitLocation, optional vector WaterHitLoc);

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);

	if (class'BallisticReplicationInfo'.static.IsArena())
		AK91ChargeRifle(BW).AddHeat(0.57);
}

defaultproperties
{
	HeatPerShot=0.45
	TraceRange=(Min=12000.000000,Max=13000.000000)
	KickForce=22000
	PenetrateForce=180
	bPenetrate=True
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
	bCockAfterEmpty=False
	MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
	FlashScaleFactor=0.400000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassBone="ejector"
	XInaccuracy=3.200000
	YInaccuracy=3.200000
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.rpk940.rpk-Fire',Volume=1.500000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	FireEndAnim=
	TweenTime=0.000000
	FireRate=0.140000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_AK762mm'
	ShakeRotMag=(X=128.000000,Y=64.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-30.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	WarnTargetPct=0.200000
	aimerror=900.000000
}

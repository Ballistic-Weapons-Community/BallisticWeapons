//=============================================================================
// CYLOPrimaryFire.
//
// For some really odd reason my UDE isn't liking the class names, so I have to
// change the names for UDE to recognize them every once in a while...
// Firestorm:
// Explosive rounds with longer range than normal, but overheats the weapon.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOPrimaryFire extends BallisticProInstantFire;

var	bool	    bVariableFirerate;
var	bool		bCanOverheat;
var bool		bRadiusDamage;
var bool		bPlayerRadiusDamage;

simulated function bool AllowFire()
{
	if ((bCanOverheat && CYLOUAW(Weapon).HeatLevel >= 12) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	if (bCanOverheat)
		CYLOUAW(BW).AddHeat(HeatPerShot);
}

function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.Netmode == NM_DedicatedServer && bCanOverheat)
		CYLOUAW(BW).AddHeat(HeatPerShot);
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim != None && Victim.bProjTarget && bPlayerRadiusDamage)
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(Damage, 210, class'DTCYLOFirestormExplosion', 200, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(Damage, 420, class'DTCYLOFirestormExplosion', 200, HitLocation, Pawn(Victim));
	}
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if (!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if (bRadiusDamage && (Other == None || Other.bWorldGeometry))
		BW.TargetedHurtRadius(2, 64, class'DTCYLOFirestormRifle', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
		
	return true;
}

simulated event ModeDoFire()
{
	if (bVariableFirerate)
	{
		if (level.Netmode == NM_Standalone)
		{
			FireRate = Params.FireInterval + (FRand() * 0.15);
		}
		else
		{
			CYLOUAW(BW).SetFireRate(Params.FireInterval + (FRand() * 0.15));
		}
	}
	Super.ModeDoFire();
}

defaultproperties
{
	TraceRange=(Min=8000.000000,Max=12000.000000)
	HeatPerShot=0.900000
	DamageType=Class'BWBP_SKC_Pro.DTCYLORifle'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLORifleHead'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLORifle'
	PenetrateForce=180
	bPenetrate=True
	RunningSpeedThresh=1000.000000
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.Misc.ClipEnd-1',Volume=0.800000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
	bCockAfterEmpty=True
	MuzzleFlashClass=Class'BallisticProV55.XK2FlashEmitter'
	FlashBone="Muzzle"
	FlashScaleFactor=0.500000
	FireRecoil=220.000000
	FireChaos=0.032000
	FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.160000,OutVal=1),(InVal=0.250000,OutVal=1.500000),(InVal=0.500000,OutVal=2.250000),(InVal=0.750000,OutVal=3.500000),(InVal=1.000000,OutVal=5.000000)))
	XInaccuracy=96.000000
	YInaccuracy=96.000000
	JamSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.900000)
	BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
	bPawnRapidFireAnim=True
	PreFireAnim=
	FireEndAnim=
	FireRate=0.1050000
	UnjamMethod=UJM_Fire
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_CYLO'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.00)
	ShakeOffsetRate=(X=-100.000000)
	ShakeOffsetTime=2.000000
	 
	WarnTargetPct=0.200000
	aimerror=900.000000
}

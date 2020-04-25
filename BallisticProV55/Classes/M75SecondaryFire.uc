//=============================================================================
// M75PrimaryFire.
//
// Slow, powerful Railgun fire for the M75. Power of the shot varies depending
// on how long the weapon has been left to charge. Charge affects Damage, Kick
// Trail intensity and how far it can fire through walls.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M75SecondaryFire extends BallisticRailgunFire;

const MAX_RAIL_POWER = 1.4f; // charges in 2 seconds, 0.8s hold time grace
var   	float 		RailPower;
var		float		RailDamageBonus;

var		float		RailMaxWallSizeBonus;
var		int			RailMaxWallsBonus;
var		int			RailPenetrateForceBonus;
var		float		RailKickForceBonus;
var		float		RailRecoilPerShotPenalty;

simulated event ModeDoFire()
{
	MaxWallSize 	= default.MaxWallSize 		+ RailMaxWallSizeBonus 		* Square(RailPower);
	MaxWalls 		= default.MaxWalls 			+ RailMaxWallsBonus 		* RailPower;
	PenetrateForce 	= default.PenetrateForce 	+ RailPenetrateForceBonus 	* RailPower;
	KickForce 		= default.KickForce 		+ RailKickForceBonus 		* RailPower;
	RecoilPerShot 	= default.RecoilPerShot 	+ RailRecoilPerShotPenalty 	* RailPower;

	Super.ModeDoFire();

	RailPower = 0.0;
	
	Weapon.ThirdPersonActor.SoundPitch =  32;
	//Weapon.SoundPitch = 32 + RailPower * 12;
	Weapon.ThirdPersonActor.SoundVolume =  64;
	//Weapon.SoundVolume = 64 + 190 * RailPower;
	Weapon.ThirdPersonActor.SoundRadius = 128;
}

simulated function ModeTick(float DeltaTime)
{	
	if (bIsFiring)
	{
		RailPower = FMin(MAX_RAIL_POWER, RailPower + 0.5 * DeltaTime);

		if (RailPower >= MAX_RAIL_POWER)
		{
			RailPower = 1.0f;
			bIsFiring = false;
		}
	}
	
	else if (RailPower > 0)
		RailPower = FMax(0, RailPower - DeltaTime);
		
	Super.ModeTick(DeltaTime);
	
	if (RailPower > 0 && RailPower <= 1.0f)
	{
		Weapon.ThirdPersonActor.SoundPitch =  32 + RailPower * 12;
		//Weapon.SoundPitch = 32 + RailPower * 12;
		
		Weapon.ThirdPersonActor.SoundVolume =  64 + 190 * RailPower;
		//Weapon.SoundVolume = 64 + 190 * RailPower;
		
		Weapon.ThirdPersonActor.SoundRadius = 128 + 768 * RailPower;
	}

}

function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	return Super.GetDamage(Other, HitLocation, Dir, Victim, DT) *  (1 + (Square(RailPower) * 0.6));
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	M75Attachment(Weapon.ThirdPersonActor).RailPower = 64 + 191*RailPower;
	super.SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
}

simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	BallisticWeapon(Weapon).TargetedHurtRadius(60.0*RailPower, 48+48.0*RailPower, DamageType, 5000, HitLocation, Pawn(Other));
	return super.ImpactEffect(HitLocation, HitNormal, HitMat, Other, WaterHitLoc);
}

function WallEnterEffect (vector HitLocation, vector HitNormal, vector X, actor other, Material HitMat)
{
	BallisticWeapon(Weapon).TargetedHurtRadius(60.0*RailPower, 48+192.0*RailPower, DamageType, 5000, HitLocation, Pawn(Other));
	super.WallEnterEffect(HitLocation, HitNormal, X, other, HitMat);
}

defaultproperties
{
	 TraceRange=(Min=30000.000000,Max=30000.000000)
	 
	 MaxWalls=5
	 RailMaxWallsBonus=10

	 MaxWallSize=256
	 RailMaxWallSizeBonus=768

	 Damage=120.000000
     DamageHead=150.000000
	 DamageLimb=120.000000
	 RailDamageBonus=50
	 
     DamageType=Class'BallisticProV55.DTM75RailgunCharged'
     DamageTypeHead=Class'BallisticProV55.DTM75RailgunChargedHead'
	 DamageTypeArm=Class'BallisticProV55.DTM75RailgunCharged'

	 KickForce=30000
	 RailKickForceBonus=120000

	 bPenetrate=True
	 PenetrateForce=700
	 RailPenetrateForceBonus=2500


     MuzzleFlashClass=Class'BallisticProV55.M75FlashEmitter'
     BrassClass=Class'BallisticProV55.Brass_Railgun'
	 BrassOffset=(X=-33.000000,Y=-4.000000,Z=-4.000000)
	 
	 RecoilPerShot=1024.000000
	 RailRecoilPerShotPenalty=3072.000000
	 VelocityRecoil=1300.000000
	 FireChaos=0.750000
	 
	 BallisticFireSound=(Sound=Sound'BallisticSounds3.M75.M75Fire',Radius=768.000000)
	 
     bFireOnRelease=True
	 FireEndAnim="'"
	 
	 FireRate=1.500000
	 
	 AmmoClass=Class'BallisticProV55.Ammo_20mmRailgun'
	 
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.3
     WarnTargetPct=0.75
     aimerror=800.000000
}

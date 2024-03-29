//=============================================================================
// R9PrimaryFire.
//
// Accurate medium-high power rifle fire.
// Unwieldy from the hip.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class R9PrimaryFire extends BallisticProInstantFire;

#exec OBJ LOAD File="BW_Core_WeaponSound.uax"

var BUtil.FullSound FreezeFireSound, LaserFireSound;

/*function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 1)
		GoToState('Freeze');
	else if (NewMode == 2)
		GoToState('Laser');
	else
	{
		Damage = default.Damage;
		GoToState('');
	}
}*/

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	if (BW.CurrentWeaponMode == 1)
	{
		super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);

		if (Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
		{
			class'BCSprintControl'.static.AddSlowTo(Pawn(Victim), 0.7, 1);
		}
		return;		
	}
	else if (BW.CurrentWeaponMode == 2)
	{
		if (Pawn(Victim) != None && Pawn(Victim).bProjTarget)
			Damage += R9RangerRifle(BW).ManageHeatInteraction(Pawn(Victim), HeatPerShot);	
	}
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

/*state Freeze
{
	function BeginState()
	{
		Damage = 40;
	}
	function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{	
		super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
		
		if (Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
		{
			class'BCSprintControl'.static.AddSlowTo(Pawn(Victim), 0.7, 1);
		}
	}
}

state Laser
{
	function BeginState()
	{
		Damage = 35;
	}
	//Deals increased damage to targets which have already been heated up by a previous strike.
	function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{	
		if (Pawn(Victim) != None && Pawn(Victim).bProjTarget)
		Damage += R9RangerRifle(BW).ManageHeatInteraction(Pawn(Victim), HeatPerShot);
		
		super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	}
}*/

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		if (BW.CurrentWeaponMode == 1)
			Weapon.PlayOwnedSound(FreezeFireSound.Sound,BallisticFireSound.Slot,FreezeFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		else if (BW.CurrentWeaponMode == 2)
			Weapon.PlayOwnedSound(LaserFireSound.Sound,BallisticFireSound.Slot,LaserFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	CheckClipFinished();

	PlayFireAnimations();
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	PlayFireAnimations();
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
	{
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
		if (BW.CurrentWeaponMode == 2)
			Weapon.PlayOwnedSound(LaserFireSound.Sound,BallisticFireSound.Slot,LaserFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	}
	CheckClipFinished();
}

defaultproperties
{
	RangeAtten=0.5
	FreezeFireSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
	LaserFireSound=(Sound=Sound'BW_Core_WeaponSound.R9.EnergyRelayExplode',Volume=3.000000,Radius=256.000000)
	HeatPerShot=45
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BallisticProV55.DTR9Rifle'
	DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
	DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
	KickForce=6000
	PenetrateForce=150
	bPenetrate=True
	ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.800000,Radius=24.000000,Pitch=1.250000,bAtten=True)
	DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
	bCockAfterEmpty=True
	MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
	FlashScaleFactor=1.400000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	BrassOffset=(X=-40.000000,Y=-2.000000,Z=6.000000)
	AimedFireAnim="AimedFire"
	FireRecoil=192.000000
	FireChaos=0.450000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.USSR.USSR-Fire',Volume=0.800000)
	FireEndAnim=
	FireRate=0.225000
	AmmoClass=Class'BallisticProV55.Ammo_348Rifle'
	
	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-15.00)
	ShakeOffsetRate=(X=-300.000000)
	ShakeOffsetTime=2.000000
	
	// AI
	bInstantHit=True
	bLeadTarget=False
	bTossed=False
	bSplashDamage=False
	bRecommendSplashDamage=False
	BotRefireRate=0.7
	WarnTargetPct=0.4
	aimerror=800.000000
}

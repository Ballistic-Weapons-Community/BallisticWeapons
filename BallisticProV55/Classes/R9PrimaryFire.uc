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

var BUtil.FullSound FreezeFireSound, LaserFireSound;
var int	HeatPerShot;

#exec OBJ LOAD File="BW_Core_WeaponSound.uax"

function SwitchWeaponMode (byte NewMode)
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
}

state Freeze
{
	function BeginState()
	{
		Damage = 40;
	}
	function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
	{	
		local Inv_Slowdown Slow;

		super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
		
		if (Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
		{
			Slow = Inv_Slowdown(Pawn(Victim).FindInventoryType(class'Inv_Slowdown'));

			if (Slow == None)
			{
				Pawn(Victim).CreateInventory("BallisticProV55.Inv_Slowdown");
				Slow = Inv_Slowdown(Pawn(Victim).FindInventoryType(class'Inv_Slowdown'));
			}

			Slow.AddSlow(0.7, 1);
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
}

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

	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (AimedFireAnim != '')
	{
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
		if (BW.BlendFire())		
			BW.SafePlayAnim(AimedFireAnim, FireAnimRate, TweenTime, 1, "AIMEDFIRE");
	}

	else
	{
		if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
			BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
		else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	}
	
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
     WallPenetrationForce=64.000000
     
     Damage=45.000000
     HeadMult=1.5
     LimbMult=0.85
     
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTR9Rifle'
     DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
     DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.800000,Radius=48.000000,Pitch=1.250000,bAtten=True)
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
	 BotRefireRate=0.7
     WarnTargetPct=0.4
     aimerror=800.000000
}

//=============================================================================
// R9PrimaryFire.
//
// Accurate medium-high power rifle fire.
// Unwieldy from the hip.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class R9A1PrimaryFire extends BallisticProInstantFire;

var BUtil.FullSound FreezeFireSound, LaserFireSound;
var int	HeatPerShot;

#exec OBJ LOAD File="BallisticProSounds.uax"

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
	function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
	{
		local Inv_Slowdown Slow;

		super.DoDamage (Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount);
		if (Pawn(other) != None && Pawn(Other).Health > 0 && Vehicle(Other) == None)
		{
			Slow = Inv_Slowdown(Pawn(Other).FindInventoryType(class'Inv_Slowdown'));

			if (Slow == None)
			{
				Pawn(Other).CreateInventory("BallisticProV55.Inv_Slowdown");
				Slow = Inv_Slowdown(Pawn(Other).FindInventoryType(class'Inv_Slowdown'));
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
	function DoDamage (Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
	{
		local float							Dmg;
		local class<DamageType>	HitDT;
		local Actor							Victim;
		local Vector						BoneTestLocation, ClosestLocation;
		local	int								Bonus;
		
		//Locational damage code from Mr Evil under test here
		if(Other.IsA('xPawn'))
		{
			//Find a point on the victim's Z axis at the same height as the HitLocation.
			ClosestLocation = Other.Location;
			ClosestLocation.Z += (HitLocation - Other.Location).Z;
			
			//Extend the shot along its direction to a point where it is closest to the victim's Z axis.
			BoneTestLocation = Dir;
			BoneTestLocation *= VSize(ClosestLocation - HitLocation);
			BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(HitLocation - TraceStart);
			BoneTestLocation += HitLocation;
			
			Dmg = GetDamage(Other, BoneTestLocation, Dir, Victim, HitDT);
		}
		
		else Dmg = GetDamage(Other, HitLocation, Dir, Victim, HitDT);

		if (RangeAtten != 1.0)
			Dmg *= Lerp(VSize(HitLocation-TraceStart)/TraceRange.Max, 1, RangeAtten);
		if (WaterRangeAtten != 1.0 && WaterHitLocation != vect(0,0,0))
			Dmg *= Lerp(VSize(HitLocation-WaterHitLocation) / (TraceRange.Max*WaterRangeFactor), 1, WaterRangeAtten);
		if (PenetrateCount > 0)
			Dmg *= PDamageFactor ** PenetrateCount;
		if (WallCount > 0)
			Dmg *= WallPDamageFactor ** WallCount;

		if (Pawn(Other) != None && Pawn(Other).bProjTarget)
			Bonus = R9A1RangerRifle(BW).ManageHeatInteraction(Pawn(Other), HeatPerShot);
			
		class'BallisticDamageType'.static.GenericHurt (Victim, Dmg + Bonus, Instigator, HitLocation, KickForce * Dir, HitDT);
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
		
	if (!BW.bNoMeshInScope)
	{
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
     FreezeFireSound=(Sound=Sound'BallisticSounds2.A42.A42-Impact',Volume=0.700000,Radius=384.000000,Pitch=1.400000)
     LaserFireSound=(Sound=Sound'BallisticProSounds.R9.EnergyRelayExplode',Volume=3.000000,Radius=256.000000)
     HeatPerShot=45
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=64.000000
     MaxWalls=2
     Damage=65.000000
     DamageHead=130.000000
     DamageLimb=65.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticProV55.DTR9Rifle'
     DamageTypeHead=Class'BallisticProV55.DTR9RifleHead'
     DamageTypeArm=Class'BallisticProV55.DTR9Rifle'
     KickForce=6000
     PenetrateForce=150
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.NRP57.NRP57-ClipOut',Volume=0.800000,Radius=48.000000,Pitch=1.250000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BallisticProV55.R9FlashEmitter'
     FlashScaleFactor=1.400000
     BrassClass=Class'BallisticProV55.Brass_Rifle'
     BrassOffset=(X=-40.000000,Y=-2.000000,Z=6.000000)
     AimedFireAnim="AimedFire"
     RecoilPerShot=384.000000
     FireChaos=0.450000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.USSR.USSR-Fire',Volume=0.800000)
     FireEndAnim=
     FireRate=0.300000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_R9A1'
     ShakeRotMag=(X=400.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.150000
     WarnTargetPct=0.050000
     aimerror=800.000000
}

//=============================================================================
// SX45PrimaryFire.
//
// Powerful, but slow .45 fire. Can install an elemental amp that charges the gun.
// Amp will run out of juice and need replacement.
//
// by SK, adapted from Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class SX45PrimaryFire extends BallisticProInstantFire;

var(SX45) Actor						MuzzleFlashAmp1;		
var(SX45) Actor						MuzzleFlashAmp2;		
var(SX45) class<Actor>				MuzzleFlashClassAmp1;	
var(SX45) class<Actor>				MuzzleFlashClassAmp2;	
var(SX45) Name						AmpFlashBone;
var(SX45) float						AmpFlashScaleFactor1;
var(SX45) float						AmpFlashScaleFactor2;
var(SX45) bool						bAmped;
var(SX45) float						AmpDrainPerShot;

/*simulated function bool AllowFire()
{
	if ((bAmped && SX45Pistol(Weapon).AmpCharge <= 0) || !super.AllowFire())
	{
		return false;
	}
	return true;
}*/

// Effect related functions ------------------------------------------------
// Spawn the muzzleflash actor
function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
    if ((MuzzleFlashClassAmp1 != None) && ((MuzzleFlashAmp1 == None) || MuzzleFlashAmp1.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp1, MuzzleFlashClassAmp1, Weapon.DrawScale*AmpFlashScaleFactor1, weapon, AmpFlashBone);
    if ((MuzzleFlashClassAmp2 != None) && ((MuzzleFlashAmp2 == None) || MuzzleFlashAmp2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp2, MuzzleFlashClassAmp2, Weapon.DrawScale*AmpFlashScaleFactor2, weapon, AmpFlashBone);

}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (MuzzleFlashAmp1 != None && SX45Pistol(Weapon).CurrentWeaponMode == 1)
       	MuzzleFlashAmp1.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp2 != None && SX45Pistol(Weapon).CurrentWeaponMode == 2)
        MuzzleFlashAmp2.Trigger(Weapon, Instigator);
	else
		MuzzleFlash.Trigger(Weapon, Instigator);
		
	if (!bBrassOnCock)
		EjectBrass();
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp1);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp2);
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (NewMode == 0) //Standard Fire
	{
		FlashBone=FlashBone;
		bAmped=False;
	}
	else if (NewMode == 1) //Cryo Amp
	{
		FlashBone=AmpFlashBone;
		bAmped=True;
	}
	else if (NewMode == 2) //RAD Amp
	{
		FlashBone=AmpFlashBone;
		bAmped=True;
	}
	else
	{
		FlashBone=FlashBone;
		bAmped=False;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

}


//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'FireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
	
	if (bAmped)
		SX45Pistol(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		SX45Pistol(BW).AddHeat(AmpDrainPerShot);
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
    local Inv_Slowdown Slow;

    super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
    if (Pawn(Target) != None && Pawn(Target).Health > 0 && Vehicle(Target) == None && SX45Pistol(Weapon).CurrentWeaponMode == 1)
    {
        Slow = Inv_Slowdown(Pawn(Target).FindInventoryType(class'Inv_Slowdown'));

        if (Slow == None)
        {
            Pawn(Target).CreateInventory("BallisticProV55.Inv_Slowdown");
            Slow = Inv_Slowdown(Pawn(Target).FindInventoryType(class'Inv_Slowdown'));
        }

        Slow.AddSlow(0.7, 0.35);
    }
	else if (Pawn(Target) != None && Pawn(Target).bProjTarget && SX45Pistol(Weapon).CurrentWeaponMode == 2)
		TryPlague(Target);
}

function bool AllowPlague(Actor Other)
{
	return 
		Pawn(Other) != None 
		&& Pawn(Other).Health > 0 
		&& Vehicle(Other) == None 
		&& (Pawn(Other).GetTeamNum() == 255 || Pawn(Other).GetTeamNum() != Instigator.GetTeamNum())
		&& Level.TimeSeconds - Pawn(Other).SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime;
}

function TryPlague(Actor Other)
{
	local SX45PlagueEffect RPE;
	
	if (AllowPlague(Other))
	{
		foreach Other.BasedActors(class'SX45PlagueEffect', RPE)
		{
			RPE.ExtendDuration(2);
		}
		if (RPE == None)
		{
			RPE = Spawn(class'SX45PlagueEffect',Other,,Other.Location);// + vect(0,0,-30));
			RPE.Initialize(Other);
			if (Instigator!=None)
			{
				RPE.Instigator = Instigator;
				RPE.InstigatorController = Instigator.Controller;
			}
		}
	}
}

defaultproperties
{
	 AmpDrainPerShot=-0.85
	 AmpFlashBone="tip2"
     AmpFlashScaleFactor1=1.000000
	 AmpFlashScaleFactor2=2.500000
	 FlashBone="tip"
	 FlashScaleFactor=0.9
	 TraceRange=(Min=4000.000000,Max=4000.000000)
	 DecayRange=(Min=768.000000,Max=2048.000000)
	 RangeAtten=0.3
     WallPenetrationForce=8.000000
     Damage=32.000000
     HeadMult=1.5f
     LimbMult=0.5f
     WaterRangeAtten=0.400000
     DamageType=Class'BWBP_SKC_Pro.DTSX45Pistol'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTSX45PistolHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTSX45Pistol'
     PenetrateForce=135
     bPenetrate=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.SX45FlashEmitter'
	 MuzzleFlashClassAmp1=Class'BWBP_SKC_Pro.SX45CryoFlash'
     MuzzleFlashClassAmp2=Class'BWBP_SKC_Pro.SX45RadMuzzleFlash'
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-14.000000,Z=-5.000000)
     FireRecoil=192.000000
     FireChaos=0.250000
     XInaccuracy=96.000000
     YInaccuracy=96.000000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.SX45.SX45-Fire',Volume=1.200000)
     bPawnRapidFireAnim=True
	 FireEndAnim=
     FireAnimRate=1
	 AimedFireAnim="SightFire"
     FireRate=0.20000
     AmmoClass=Class'BallisticProV55.Ammo_45HV'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     BotRefireRate=0.750000
}

//=============================================================================
// PS9mPrimaryFire.
//
// Automatic tranq fire. Rapid fire and hard to control.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class PS9mPrimaryFire extends BallisticProInstantFire;

simulated event ModeDoFire()
{
	if (!AllowFire() || PS9mPistol(Weapon).bLoaded)
		return;
	super.ModeDoFire();
}

function bool DoTazerBlurEffect(Actor Victim)
{
	local int i;
	local MRS138ViewMesser VM;

	if (Pawn(Victim) == None || Pawn(Victim).Health < 1 || Pawn(Victim).LastPainTime != Victim.level.TimeSeconds)
		return false;
	if (PlayerController(Pawn(Victim).Controller) != None)
	{
		for (i=0;i<Pawn(Victim).Controller.Attached.length;i++)
			if (MRS138ViewMesser(Pawn(Victim).Controller.Attached[i]) != None)
			{
				MRS138ViewMesser(Pawn(Victim).Controller.Attached[i]).AddImpulse();
				i=-1;
				break;
			}
		if (i != -1)
		{
			VM = Spawn(class'MRS138ViewMesser',Pawn(Victim).Controller);
			VM.SetBase(Pawn(Victim).Controller);
			VM.AddImpulse();
		}
	}
	else if (AIController(Pawn(Victim).Controller) != None)
	{
		AIController(Pawn(Victim).Controller).Startle(Weapon.Instigator);
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Controller), 2, 5);
	}
	return false;
}

     function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	if (Victim.bCanBeDamaged)
		DoTazerBlurEffect(Victim);
}

defaultproperties
{
     TraceRange=(Min=3000.000000)
     WallPenetrationForce=0
     
     Damage=12.000000
     DamageHead=24.000000
     DamageLimb=12.000000
     DamageType=Class'BWBPRecolorsPro.DT_PS9MDart'
     DamageTypeHead=Class'BWBPRecolorsPro.DT_PS9MDartHead'
     DamageTypeArm=Class'BWBPRecolorsPro.DT_PS9MDart'
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BallisticSounds2.D49.D49-DryFire',Volume=0.700000)
     MuzzleFlashClass=Class'BWBPRecolorsPro.VSKSilencedFlash'
     FlashScaleFactor=0.800000
     BrassClass=Class'BWBPRecolorsPro.Brass_Tranq'
     BrassOffset=(X=-20.000000,Y=1.000000)
     RecoilPerShot=128.000000
     FireChaos=0.150000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'PackageSounds4ProExp.Stealth.Stealth-Fire',Volume=0.25,Radius=16,Slot=SLOT_Interact,bNoOverride=False)
     bAISilent=True
     FireEndAnim=
     FireRate=0.070000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_TranqP'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}

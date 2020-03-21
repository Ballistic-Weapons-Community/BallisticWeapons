//=============================================================================
// MRS138SecondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRS138MeleeFire extends BallisticMeleeFire;

simulated function ModeHoldFire()
{
	MRS138Shotgun(Weapon).StartTazer();
	Super.ModeHoldFire();
}

simulated event ModeDoFire()
{
	MRS138Shotgun(Weapon).TazerTime = level.TimeSeconds;
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
		class'BC_BotStoopidizer'.static.DoBotStun(AIController(Pawn(Victim).Controller), 2, 15);
	}
	return false;
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if ( Victim.bCanBeDamaged )
	{
		DoTazerBlurEffect(Victim);
		MRS138Attachment(Weapon.ThirdPersonActor).TazerHitActor(HitLocation);
	}
}

defaultproperties
{
     DamageHead=75.000000
     DamageLimb=75.000000
     DamageType=Class'BallisticProV55.DTMRS138Tazer'
     DamageTypeHead=Class'BallisticProV55.DTMRS138Tazer'
     DamageTypeArm=Class'BallisticProV55.DTMRS138Tazer'
     KickForce=80000
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=SoundGroup'BWAddPack-RS-Sounds.MRS38.RSS-ElectroSwing',Radius=256.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepAttack"
     FireAnim="Attack"
     TweenTime=0.000000
     FireRate=0.750000
     AmmoClass=Class'BallisticProV55.Ammo_MRS138Shells'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}

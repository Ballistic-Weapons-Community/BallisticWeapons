//=============================================================================
// VSKPrimaryFire.
//
// Automatic tranq fire. Damage and firerate change when scoped.
// Tranq fire when unscoped is far less accurate due to less pressure behind dart.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class VSKPrimaryFire extends BallisticInstantFire;

var() sound		ScopedFireSound;
var() sound		RegularFireSound;
var() bool		bDOT;

simulated function SwitchScopedMode (byte NewMode)
{
	if (NewMode == 0)
	{
		BallisticFireSound.Sound=ScopedFireSound;
		FireRecoil=128;
		Damage = 50;
		FireChaos = 0.1;
	}
	
	else if (NewMode == 1)
	{
		BallisticFireSound.Sound=RegularFireSound;
		FireRecoil=88;
		Damage = default.Damage;
		FireChaos = 0.05;
	}
	else
	{
		BallisticFireSound.Sound=RegularFireSound;
		FireRecoil=88;
		Damage = default.Damage;
		FireChaos = 0.05;
	}
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;

	Load=AmmoPerFire;
}

simulated function IgniteActor(Actor A)
{
	local VSKActorPoison PF;

	PF = Spawn(class'VSKActorPoison');
	PF.Instigator = Instigator;
	PF.Initialize(A);
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
	if (xPawn(Victim) !=None && bDOT)
	{
		IgniteActor(Victim);
	}
	class'BallisticDamageType'.static.GenericHurt(Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	if ( Victim.bCanBeDamaged && bDOT)
	{
		DoTazerBlurEffect(Victim);
	}
}

defaultproperties
{
     ScopedFireSound=SoundGroup'BWBP_SKC_SoundsExp.VSK.VSK-SuperShot'
     RegularFireSound=SoundGroup'BWBP_SKC_SoundsExp.VSK.VSK-Shot'
     TraceRange=(Min=12000.000000,Max=15000.000000)
	 WallPenetrationForce=0
     Damage=35
     DamageType=Class'BWBP_SKC_Pro.DT_VSKTranq'
     DamageTypeHead=Class'BWBP_SKC_Pro.DT_VSKTranqHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DT_VSKTranq'
     KickForce=20000
     PenetrateForce=150
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.D49.D49-DryFire',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_SKC_Pro.VSKSilencedFlash'
     FlashScaleFactor=0.500000
     BrassClass=Class'BWBP_SKC_Pro.Brass_Tranq'
     FlashBone="tip2"
     BrassOffset=(X=-80.000000,Y=1.000000)
     FireRecoil=88.000000
     XInaccuracy=1.750000
     YInaccuracy=1.750000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_SoundsExp.VSK.VSK-SuperShot',Volume=1.100000,Slot=SLOT_Interact,bNoOverride=False)
     bAISilent=True
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.600000
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_Tranq'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     WarnTargetPct=0.200000
     aimerror=900.000000
}

//=============================================================================
// Defib Fists Primary.
//
// Rapid, two handed jabs with reasonable range. Everything is timed by notifys
// from the anims
//
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class DefibFistsPrimaryFire extends BallisticMeleeFire;

var bool bPunchLeft;
var BUtil.FullSound DischargedFireSound;

event ModeDoFire()
{
	local float f;

	Super.ModeDoFire();

	f = FRand();
	if (f > 0.50)
	{
		if (bPunchLeft)
			FireAnim = 'PunchL1';
		else
			FireAnim = 'PunchR1';		
	}
	else
	{
		if (bPunchLeft)
			FireAnim = 'PunchL2';
		else
			FireAnim = 'PunchR2';	
	}

	if (bPunchLeft)
		bPunchLeft=False;
	else
		bPunchLeft=True;	
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (DefibFists(BW).bDischarged)
		Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();

	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{		
	if (FireCount > 0 && Weapon.HasAnim(FireLoopAnim))
		BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
	else BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (DefibFists(BW).bDischarged)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

simulated function bool HasAmmo()
{
	return true;
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local int PrevHealth;
	local BallisticPawn BPawn;

	if (Mover(Target) != None || Vehicle(Target) != None)
		return;

	BPawn = BallisticPawn(Target);

	if(IsValidHealTarget(BPawn))
	{
		if (DefibFists(BW).ElectroCharge >= 30)
		{
			PrevHealth = BPawn.Health;
			BPawn.GiveAttributedHealth(15, BPawn.HealthMax, Instigator);
			DefibFists(Weapon).PointsHealed += BPawn.Health - PrevHealth;
			DefibFists(BW).ElectroCharge -= 30;
			DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
		}
		return;
	}

	if (DefibFists(Weapon).ElectroCharge < 15)
		Damage /= 3;

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (DefibFists(BW).ElectroCharge >= 30)
		DefibFists(BW).ElectroCharge -= 30;

	DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return false;

	if(Target.Health<=0)
		return false;
	
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return false;

	if(Vehicle(Target)!=None)
		return false;

	return (Target.Controller!=None && Instigator.Controller.SameTeamAs(Target.Controller));
}

defaultproperties
{
     DischargedFireSound=(Sound=Sound'BallisticSounds3.M763.M763Swing',Radius=32.000000,bAtten=True)
     FatiguePerStrike=0.015000
     Damage=40.000000
     DamageHead=40.000000
     DamageLimb=40.000000
     DamageType=Class'BWBPOtherPackPro.DTShockGauntlet'
     DamageTypeHead=Class'BWBPOtherPackPro.DTShockGauntlet'
     DamageTypeArm=Class'BWBPOtherPackPro.DTShockGauntlet'
     KickForce=40000
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BWAddPack-RS-Sounds.MRS38.RSS-ElectroSwing',Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="PunchL1"
     FireAnimRate=1.250000
     FireRate=0.400000
     AmmoClass=Class'BWBPOtherPackPro.Ammo_DefibCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}

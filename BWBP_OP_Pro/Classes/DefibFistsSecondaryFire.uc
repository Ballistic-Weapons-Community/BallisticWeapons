//=============================================================================
// Defib Fists Secondary.
//
// Devastating uppercut which can also heal allies.
// by Casey "Xavious" Johnson and Azarael
//=============================================================================
class DefibFistsSecondaryFire extends BallisticMeleeFire;

var int				ElectroDamageBonus, ElectroHeal;
var int				RequiredBonusCharge, RequiredShockwaveCharge;
var bool 			bCharged;
var BUtil.FullSound DischargedFireSound;

simulated function bool HasAmmo()
{
	return true;
}
	
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local BallisticPawn BPawn;
	local int PrevHealth;

	if (Mover(Target) != None || Vehicle(Target) != None)
		return;

	BPawn = BallisticPawn(Target);

	if(IsValidHealTarget(BPawn))
	{
		if (DefibFists(BW).ElectroCharge >= RequiredBonusCharge)
		{
			PrevHealth = BPawn.ShieldStrength;
			BPawn.GiveAttributedShield(ElectroHeal, Instigator);
			DefibFists(Weapon).PointsHealed += BPawn.ShieldStrength - PrevHealth;
			DefibFists(BW).ElectroCharge -= RequiredBonusCharge;
			DefibFists(BW).LastRegen = Level.TimeSeconds + 0.5;
			return;
		}
	}

	if (DefibFists(Weapon).ElectroCharge >= RequiredBonusCharge)
	{
		Damage += ElectroDamageBonus;
		DefibFists(Weapon).ElectroCharge -= RequiredBonusCharge;
	}

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Pawn(Target).AddVelocity(vect(0, 0, 450));
		
	DefibFists(BW).LastRegen = Level.TimeSeconds + 1;
}

function DoFireEffect()
{
	if (DefibFists(Weapon).ElectroCharge >= RequiredShockwaveCharge)
	{
		DefibFists(Weapon).ElectroShockWave(30, 350, class'DTShockGauntletWave', 50000, Instigator.Location);
		DefibFists(Weapon).ElectroCharge -= 30;
		DefibFistsAttachment(Weapon.ThirdPersonActor).DoWave(true);
	}
	Super(BallisticMeleeFire).DoFireEffect();
}

function bool IsValidHealTarget(Pawn Target)
{
	if(Target==None||Target==Instigator)
		return False;

	if(Target.Health<=0)
		return False;
		
	if (!Target.bProjTarget)
		return false;

	if(!Level.Game.bTeamGame)
		return False;

	if(Vehicle(Target)!=None)
		return False;

	return (Target.Controller!=None&&Instigator.Controller.SameTeamAs(Target.Controller));
}

//// server propagation of firing ////
function ServerPlayFiring()
{
	if (DefibFists(BW).ElectroCharge < 10)
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

	if (DefibFists(BW).ElectroCharge < 10)
			Weapon.PlayOwnedSound(DischargedFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);
	else if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

defaultproperties
{
	 DischargedFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Radius=32.000000,batten=false)
	 RequiredBonusCharge=33
	 RequiredShockwaveCharge=75
	 ElectroDamageBonus=50
	 ElectroHeal=25
     FatiguePerStrike=0.150000
     bCanBackstab=False
     TraceRange=(Min=130,Max=130)
     DamageType=Class'BWBP_OP_Pro.DTShockGauntletAlt'
     DamageTypeHead=Class'BWBP_OP_Pro.DTShockGauntletAlt'
     DamageTypeArm=Class'BWBP_OP_Pro.DTShockGauntletAlt'
     KickForce=2500
     bUseWeaponMag=False
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.MRS38.RSS-ElectroSwing',Radius=32.000000,batten=false)
     bAISilent=True
     PreFireAnim="UppercutPrep"
     FireAnim="Uppercut"
     FireAnimRate=1.500000
     FireRate=1.000000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_DefibCharge'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=384.000000)
     ShakeRotRate=(X=3500.000000,Y=3500.000000,Z=3500.000000)
     ShakeRotTime=2.000000
     BotRefireRate=0.800000
     WarnTargetPct=0.050000
}

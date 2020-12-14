//=============================================================================
// ICISPrimaryFire.
//
// Self injection with the stimulant pack
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class ICISPrimaryFire extends BallisticFire;

const BASE_HEAL = 2;
const MAX_HEAL = 10;
const TICKS_PER_RAMP = 3;

var int TickCount;

function StartBerserk()
{
}

function StopBerserk()
{
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		// Will weapon mode allow further firing
    if (Instigator.Health >= BallisticPawn(Instigator).HealthMax) // reached max hp
        return false;

	return Weapon.AmmoAmount(ThisModeNum) > AmmoPerFire;
}

function DoFireEffect()
{
    BallisticPawn(Instigator).GiveAttributedHealth(Min(BASE_HEAL + TickCount / TICKS_PER_RAMP, MAX_HEAL), BallisticPawn(Instigator).HealthMax, Instigator);
    ++TickCount;
}

function StopFiring()
{	
	TickCount = 0;
}

defaultproperties
{
     BallisticFireSound=(Sound=SoundGroup'BW_Core_WeaponSound.X4.X4_Melee',Radius=0.000000,bAtten=True)
     bAISilent=True
     EffectString="Heals over time."
     PreFireTime=0.65
     PreFireAnim="PrepHealLoop"
     FireLoopAnim="HealLoopA"
     FireEndAnim="HealLoopEnd"
     FireRate=0.35
     AmmoClass=Class'BWBPRecolorsPro.Ammo_ICISStim'
     AmmoPerFire=4
     ShakeRotMag=(X=32.000000,Y=8.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=1.500000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
}

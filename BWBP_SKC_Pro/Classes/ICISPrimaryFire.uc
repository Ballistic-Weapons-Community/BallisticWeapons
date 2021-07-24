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

var() sound		        FireSoundLoop;
var float               Damage;
var class<DamageType>   DamageType;

var int                 TickCount;

function StartBerserk()
{
}

function StopBerserk()
{
}

function PlayFiring()
{
	super.PlayFiring();
	if (FireSoundLoop != None)
		Instigator.AmbientSound = FireSoundLoop;
}

function StopFiring()
{
	Instigator.AmbientSound = None;
    TickCount = 0;

    if (BW.Role == ROLE_Authority)
        BW.RemoveSpeedModification(1.2);
}

// Check if there is ammo in clip if we use weapon's mag or is there some in inventory if we don't
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		            // Is weapon busy reloading
	if (!CheckWeaponMode())
		return false;		            // Will weapon mode allow further firing
    if (Instigator.Health <= 2)         // avoid suicide
        return false;

	return Weapon.AmmoAmount(ThisModeNum) > AmmoPerFire;
}

function DoFireEffect()
{
    if (TickCount == 0)
    {
        if (BW.Role == ROLE_Authority)
            BW.AddSpeedModification(1.2);
    }

    class'BallisticDamageType'.static.GenericHurt (Instigator, Damage, Instigator, Instigator.Location, vect(0,0,0), DamageType);

    //BallisticPawn(Instigator).GiveAttributedHealth(Min(BASE_HEAL + TickCount / TICKS_PER_RAMP, MAX_HEAL), BallisticPawn(Instigator).HealthMax, Instigator);
    ++TickCount;
}

defaultproperties
{
    bAISilent=True
    EffectString="Increases movement speed by 20% and resistance to damage by 25%, but damages the user over time."
    Damage=1
    PreFireAnimRate=1.5
    PreFireTime=0.43
    FireEndAnimRate=1.5
    PreFireAnim="PrepHealLoop"
    FireLoopAnim="HealLoopA"
    FireEndAnim="HealLoopEnd"
    FireRate=0.5
    DamageType=class'DT_ICISWithdrawal'
    AmmoClass=Class'BWBP_SKC_Pro.Ammo_ICISStim'
    AmmoPerFire=4
    ShakeRotMag=(X=32.000000,Y=8.000000)
    ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
    ShakeRotTime=1.500000
    ShakeOffsetMag=(X=-3.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=1.500000
}

//=============================================================================
// Fifty9secondaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9SecondaryFire extends BallisticMeleeFire;

var() Array<name> SliceAnims;
var int SliceAnim;

function ServerPlayFiring()
{
	BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
	// Slightly modified Code from original PlayFiring()
/*    if (FireCount > 0)
    {
        if (Weapon.HasAnim(FireLoopAnim))
            BW.SafePlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0, ,"FIRE");
        else
            BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    }
    else
*/        BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()
}

function NotifiedDoFireEffect()
{
	Super.DoFireEffect();
}

function DoFireEffect()
{
}

simulated event ModeDoFire()
{
	FireAnim = SliceAnims[SliceAnim];
	SliceAnim++;
	if (SliceAnim >= SliceAnims.Length)
		SliceAnim = 0;

	Super.ModeDoFire();
}

simulated function bool HasAmmo()
{
	return true;
}

defaultproperties
{
     SliceAnims(0)="Melee1"
     SliceAnims(1)="Melee2"
     FatiguePerStrike=0.090000
     bCanBackstab=False
     TraceRange=(Min=140.000000,Max=140.000000)
     Damage=45.000000
     
     
     DamageType=Class'BallisticProV55.DTFifty9Blade'
     DamageTypeHead=Class'BallisticProV55.DTFifty9BladeHead'
     DamageTypeArm=Class'BallisticProV55.DTFifty9Blade'
     HookStopFactor=1.700000
     HookPullForce=100.000000
     bUseWeaponMag=False
     bIgnoreReload=True
     BallisticFireSound=(Sound=SoundGroup'BallisticSounds3.UZI.Melee',Volume=0.5,Radius=32.000000,bAtten=True)
     bAISilent=True
     FireAnim="Melee1"
     FireAnimRate=1.5
     FireRate=0.300000
     AmmoClass=Class'BallisticProV55.Ammo_FiftyNine'
     AmmoPerFire=0
     ShakeRotMag=(X=64.000000,Y=128.000000)
     ShakeRotRate=(X=2500.000000,Y=2500.000000,Z=2500.000000)
     ShakeRotTime=2.500000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.3
}

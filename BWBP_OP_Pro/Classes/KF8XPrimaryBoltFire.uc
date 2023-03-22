//=============================================================================
// KF8XPrimaryBoltFire.
//
// A poison bolt version of the KF8X, it is not instant hit.
//
// by SK
// uses code by Logan "BlackEagle" Richert & Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class KF8XPrimaryBoltFire extends BallisticProjectileFire;

var() Name		NoMagFireAnim;

//// server propagation of firing. Changes to animation selection to accommodate different ammo counts //// 
function ServerPlayFiring()
{
	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
	
	if (BW.MagAmmo == 1)
		BW.SafePlayAnim(EmptyFireAnim, FireAnimRate, TweenTime, ,"FIRE");
		
	else if (BW.bNoMag)
		BW.SafePlayAnim(NoMagFireAnim, FireAnimRate, TweenTime, ,"FIRE");
		
	else
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
}

//Do the spread on the client side. Changes to animation selection to accommodate different ammo counts
function PlayFiring()
{
	if (ScopeDownOn == SDO_Fire)
		BW.TemporaryScopeDown(0.5, 0.9);
		
	if (BW.MagAmmo == 1)
		BW.SafePlayAnim(EmptyFireAnim, FireAnimRate, TweenTime, ,"FIRE");
		
	else if (BW.bNoMag)
		BW.SafePlayAnim(NoMagFireAnim, FireAnimRate, TweenTime, ,"FIRE");
		
	else
		BW.SafePlayAnim(FireAnim, FireAnimRate, TweenTime, ,"FIRE");
	
    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;
	// End code from normal PlayFiring()

	if (BallisticFireSound.Sound != None)
		Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	CheckClipFinished();
}

defaultproperties
{
     SpawnOffset=(X=15.000000,Y=10.000000,Z=-9.000000)
     XInaccuracy=6.000000
     YInaccuracy=6.000000
	 BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.XBow.XBow-Fire',Volume=1.000000,Radius=64.000000)
     bModeExclusive=False
     PreFireAnim=
	 FireAnim="FireCycleRotate"
	 EmptyFireAnim="FireCycle"
	 NoMagFireAnim="FireCycle"
     FireForce="AssaultRifleAltFire"
     FireRate=1.500000
	 AmmoClass=Class'BWBP_OP_Pro.Ammo_KF8XDarts'
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-20.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     ProjectileClass=Class'BWBP_OP_Pro.KF8XToxicBolt'
     BotRefireRate=0.300000
     WarnTargetPct=0.300000
}

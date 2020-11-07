class BX85PrimaryFire extends BallisticProInstantFire;

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
	TraceRange=(Min=30000.000000,Max=30000.000000)
	WallPenetrationForce=0.000000
	
	Damage=95.000000
	
	
	WaterRangeAtten=0.600000
	DamageType=Class'DTBX85Bolt'
	DamageTypeHead=Class'DTBX85Bolt'
	DamageTypeArm=Class'DTBX85Bolt'
	KickForce=6000
	PenetrateForce=0
	bPenetrate=False
	FireChaos=0.150000
	BallisticFireSound=(Sound=Sound'BWBPOtherPackSound.XBow.XBow-Fire',Volume=1.000000,Radius=64.000000)
	PreFireAnim=
	FireAnim="FireCycleRotate"
	EmptyFireAnim="FireCycle"
	NoMagFireAnim="FireCycle"
	FireAnimRate=2.00000
	FireForce="AssaultRifleAltFire"
	FireRate=1.500000
	AmmoClass=Class'BWBPOtherPackPro.Ammo_BX85Darts'
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-20.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.500000
	WarnTargetPct=0.500000
}

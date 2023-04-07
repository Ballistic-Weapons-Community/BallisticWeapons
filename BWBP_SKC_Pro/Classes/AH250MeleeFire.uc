//=============================================================================
// Melee attack for AH2xx family
//=============================================================================
class AH250MeleeFire extends BallisticMeleeFire;

simulated function ModeHoldFire()
{
	Super.ModeHoldFire();
	BW.GunLength=1;
}

simulated event ModeDoFire()
{
	super.ModeDoFire();
	BW.GunLength = BW.default.GunLength;
}

simulated function bool HasAmmo()
{
	return true;
}

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo == 0)
	{
		PreFireAnim = 'OpenPrepPistolWhip';
		FireAnim = 'OpenPistolWhip';
	}
	else
	{
		PreFireAnim = 'PrepPistolWhip';
		FireAnim = 'PistolWhip';
	}
	super.PlayFiring();
}

defaultproperties
{
     SwipePoints(0)=(Weight=6,offset=(Pitch=6000,Yaw=4000))
     SwipePoints(1)=(offset=(Pitch=4500,Yaw=3000))
     SwipePoints(2)=(Weight=4,offset=(Pitch=3000,Yaw=2000))
     SwipePoints(3)=(Weight=3,offset=(Pitch=1500,Yaw=1000))
     SwipePoints(4)=(offset=(Yaw=0))
     SwipePoints(5)=(Weight=1,offset=(Pitch=-1500,Yaw=-1500))
     SwipePoints(6)=(offset=(Pitch=-3000))
     WallHitPoint=4
     TraceRange=(Min=130.000000,Max=130.000000)     
	 DamageType=Class'BWBP_SKC_Pro.DTEagle250Melee'
     DamageTypeHead=Class'BWBP_SKC_Pro.DTEagle250MeleeHead'
     DamageTypeArm=Class'BWBP_SKC_Pro.DTEagle250Melee'
     bUseWeaponMag=False
     bReleaseFireOnDie=False
     bIgnoreReload=True
     ScopeDownOn=SDO_PreFire
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M763.M763Swing',Volume=0.5,Radius=12.000000,bAtten=True)
     bAISilent=True
     bFireOnRelease=True
     PreFireAnim="PrepPistolWhip"
     FireAnim="PistolWhip"
     TweenTime=0.000000
     AmmoClass=Class'BallisticProV55.Ammo_44Magnum'
     AmmoPerFire=0
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.050000
}
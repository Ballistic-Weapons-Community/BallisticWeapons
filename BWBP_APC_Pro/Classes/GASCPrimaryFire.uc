//=============================================================================
// GASCPrimaryFire.
//
// Decent pistol shots that are accurate if the gun is steady enough
//
// by Logan "BlackEagle" Richert.
// uses code by Nolan "Dark Carnivour" Richert.
// Copyright� 2011 RuneStorm. All Rights Reserved.
//=============================================================================
class GASCPrimaryFire extends BallisticProInstantFire;

//Do the spread on the client side
function PlayFiring()
{
	if (BW.MagAmmo - ConsumedLoad < 1)
	{
		BW.IdleAnim = 'IdleOpen';
		BW.ReloadAnim = 'ReloadOpen';
		AimedFireAnim = 'SightFireOpen';
		FireAnim = 'FireOpen';
	}
	else
	{
		BW.IdleAnim = 'Idle';
		BW.ReloadAnim = 'Reload';
		AimedFireAnim = 'SightFire';
		FireAnim = 'Fire';
	}
	super.PlayFiring();
}


function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
	if (Victim.bProjTarget && class'BallisticReplicationInfo'.static.IsArena())
	{
		if (BallisticShield(Victim) != None)
			BW.TargetedHurtRadius(2, 64, class'DTGASCPistol', 50, HitLocation, Pawn(Victim));
		else
			BW.TargetedHurtRadius(2, 64, class'DTGASCPistol', 50, HitLocation, Pawn(Victim));
	}
}

// Does something to make the effects appear
simulated function bool ImpactEffect(vector HitLocation, vector HitNormal, Material HitMat, Actor Other, optional vector WaterHitLoc)
{
	local int Surf;

	if ((!Other.bWorldGeometry && Mover(Other) == None && Pawn(Other) == None) || level.NetMode == NM_Client)
		return false;

	if (Vehicle(Other) != None)
		Surf = 3;
	else if (HitMat == None)
		Surf = int(Other.SurfaceType);
	else
		Surf = int(HitMat.SurfaceType);
		
	if (Other == None || Other.bWorldGeometry && class'BallisticReplicationInfo'.static.IsArena())
		BW.TargetedHurtRadius(2, 64, class'DTGASCPistol', 50, HitLocation);

	// Tell the attachment to spawn effects and so on
	SendFireEffect(Other, HitLocation, HitNormal, Surf, WaterHitLoc);
	if (!bAISilent)
		Instigator.MakeNoise(1.0);
	return true;
}

defaultproperties
{
	 DecayRange=(Min=512,Max=1536)
     TraceRange=(Min=4000.000000,Max=4000.000000)
     WallPenetrationForce=8.000000
     Damage=26.000000
     RangeAtten=0.200000
     WaterRangeAtten=0.500000
     DamageType=Class'BWBP_APC_Pro.DTGASCPistol'
     DamageTypeHead=Class'BWBP_APC_Pro.DTGASCPistolHead'
     DamageTypeArm=Class'BWBP_APC_Pro.DTGASCPistol'
     PenetrateForce=150
     bPenetrate=True
     MuzzleFlashClass=Class'BWBP_APC_Pro.GASCFlashEmitter'
     FlashScaleFactor=0.10000
     BrassClass=Class'BallisticProV55.Brass_Pistol'
     BrassOffset=(X=-10.000000)
     AimedFireAnim="SightFire"
     FireRecoil=64.000000
     FireChaos=0.100000
     XInaccuracy=32.000000
     YInaccuracy=32.000000
     BallisticFireSound=(Sound=Sound'BWBP_CC_Sounds.GASC.GASC-Fire',Volume=0.800000)
     FireEndAnim=
     FireAnimRate=1.450000
     FireRate=0.095000
     AmmoClass=Class'BWBP_APC_Pro.Ammo_GASCClip'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-5.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.900000
     WarnTargetPct=0.300000
}

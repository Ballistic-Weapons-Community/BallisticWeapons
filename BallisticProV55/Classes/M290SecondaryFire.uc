//=============================================================================
// M290SecondaryFire.
//
// Individual barrel fire for M290. Smaller spread than primary and wastes less
// ammo, but does less damage. The two individual barrels can be fired
// seperately before the gun needs to be cocked again.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M290SecondaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor

event ModeDoFire()
{
	if (AllowFire())
	{
		if (!M290Shotgun(Weapon).bLeftLoaded)
		{
			bCockAfterFire=true;
			M290Shotgun(Weapon).bRightLoaded=false;
			FireAnim='FireRight';
			AimedFireAnim='FireRight';
		}
		else
		{
			bCockAfterFire=false;
			M290Shotgun(Weapon).bLeftLoaded=false;
			FireAnim='FireLeft';
			AimedFireAnim='FireLeft';
		}
	}
	super.ModeDoFire();
}
simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	M290Attachment(Weapon.ThirdPersonActor).M290UpdateHit(Other, HitLocation, HitNormal, Surf, !M290Shotgun(Weapon).bRightLoaded);
}

function EjectBrass()
{
	BrassBone='EjectorL';
	BrassClass=Class'Brass_M290Left';
	super.EjectBrass();
	BrassBone='EjectorR';
	BrassClass=Class'Brass_M290Right';
	super.EjectBrass();
}

function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local Actor MuzzleSmoke;
	local vector Start, X, Y, Z;

    if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (!M290Shotgun(Weapon).bRightLoaded && MuzzleFlash2 != None)
    {
		C = Weapon.GetBoneCoords('tip2');
        MuzzleFlash2.Trigger(Weapon, Instigator);
    }
    else if (MuzzleFlash != None)
    {
		C = Weapon.GetBoneCoords('tip');
        MuzzleFlash.Trigger(Weapon, Instigator);
    }
    if (!class'BallisticMod'.default.bMuzzleSmoke)
    	return;
    Weapon.GetViewAxes(X,Y,Z);
//	Start = C.Origin + C.XAxis * -80 + C.YAxis * 3 + C.ZAxis * 0;
	Start = C.Origin + X * -180 + Y * 3;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(X));

	if (!bBrassOnCock)
		EjectBrass();
}

defaultproperties
{
	 HipSpreadFactor=2
     TraceCount=10
     TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=2560.000000,Max=2560.000000)
     DamageType=Class'BallisticProV55.DTM290Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTM290ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTM290Shotgun'
     KickForce=600
     PenetrateForce=100
     bPenetrate=True
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashScaleFactor=2
     BrassClass=Class'BallisticProV55.Brass_M290Left'
     BrassBone="EjectorR"
     bBrassOnCock=True
     BrassOffset=(X=-30.000000,Y=-5.000000,Z=5.000000)
     FireRecoil=768.000000
     FirePushbackForce=600.000000
     FireChaos=0.250000
     XInaccuracy=256.000000
     YInaccuracy=256.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.M290.M290SingleFire',Volume=1.200000)
     FireAnim="FireRight"
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-12.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.7
     WarnTargetPct=0.5
}

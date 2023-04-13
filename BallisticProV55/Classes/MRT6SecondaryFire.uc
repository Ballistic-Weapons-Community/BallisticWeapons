//=============================================================================
// MRT6SecondaryFire.
//
// Single barrel MRT6 fire. Improved spread and range, but half damage. Two
// shots(one for each barrel) can be fired with this fire before cocking is
// needed.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class MRT6SecondaryFire extends BallisticProShotgunFire;

var() Actor						MuzzleFlash2;		// The muzzleflash actor

event ModeDoFire()
{
	if (AllowFire())
	{
		if (!MRT6Shotgun(Weapon).bLeftLoaded)
		{
			bCockAfterFire=true;
			MRT6Shotgun(Weapon).bRightLoaded=false;
			FireAnim='FireRight';
			AimedFireAnim='FireRight';
		}
		else
		{
			bCockAfterFire=false;
			MRT6Shotgun(Weapon).bLeftLoaded=false;
			FireAnim='FireLeft';
			AimedFireAnim='FireLeft';
		}
	}
	super.ModeDoFire();
}


simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	MRT6Attachment(Weapon.ThirdPersonActor).MRT6UpdateHit(Other, HitLocation, HitNormal, Surf, !MRT6Shotgun(Weapon).bRightLoaded);
}

function EjectBrass()
{
	BrassBone='EjectorL';
	BrassClass=Class'Brass_MRT6Left';
	super.EjectBrass();
	BrassBone='EjectorR';
	BrassClass=Class'Brass_MRT6Right';
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
	local vector Start;
	local Actor MuzzleSmoke;

    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    if (!MRT6Shotgun(Weapon).bRightLoaded && MuzzleFlash2 != None)
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
	Start = C.Origin + C.XAxis * -5 + C.YAxis * 3 + C.ZAxis * 0;
	MuzzleSmoke = Spawn(class'MRT6Smoke', weapon,, Start, Rotator(C.XAxis));

	if (!bBrassOnCock)
		EjectBrass();
}

defaultproperties
{
     HipSpreadFactor=1.250000
     TraceCount=7
     TracerClass=Class'BallisticProV55.TraceEmitter_MRTsix'
     ImpactManager=Class'BallisticProV55.IM_Shell'
     TraceRange=(Min=5000.000000,Max=5000.000000)
     DamageType=Class'BallisticProV55.DTMRT6Shotgun'
     DamageTypeHead=Class'BallisticProV55.DTMRT6ShotgunHead'
     DamageTypeArm=Class'BallisticProV55.DTMRT6Shotgun'
     KickForce=400
     PenetrateForce=100
     bPenetrate=True
     bCockAfterFire=True
     MuzzleFlashClass=Class'BallisticProV55.MRT6FlashEmitter'
     FlashScaleFactor=1.200000
     BrassClass=Class'BallisticProV55.Brass_MRT6Left'
     BrassBone="EjectorR"
     bBrassOnCock=True
     BrassOffset=(X=15.000000,Y=-13.000000,Z=7.000000)
     FireRecoil=378.000000
     FirePushbackForce=600.000000
     FireChaos=0.200000
     XInaccuracy=378.000000
     YInaccuracy=378.000000
     BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.MRT6.MRT6SingleFire')
     FireAnim="FireRight"
     FireRate=0.400000
     AmmoClass=Class'BallisticProV55.Ammo_12Gauge'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-30.000000)
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

//=============================================================================
// Fifty9PrimaryFire.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Fifty9PrimaryFire extends BallisticRangeAttenFire;

//Spawn shell casing for first person
function EjectBrass()
{
	local vector Start, X, Y, Z;
	local Coords C;
	local actor BrassActor;

	if (Level.NetMode == NM_DedicatedServer)
		return;
	if (!class'BallisticMod'.default.bEjectBrass || Level.DetailMode < DM_High)
		return;
	if (BrassClass == None)
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
	if (AIController(Instigator.Controller) != None)
		return;
	C = Weapon.GetBoneCoords(BrassBone);
//	Start = C.Origin + C.XAxis * BrassOffset.X + C.YAxis * BrassOffset.Y + C.ZAxis * BrassOffset.Z;
    Weapon.GetViewAxes(X,Y,Z);
	Start = C.Origin + X * BrassOffset.X + Y * BrassOffset.Y + Z * BrassOffset.Z;
	BrassActor = Spawn(BrassClass, weapon,, Start, Rotator(C.XAxis));
	if (BrassActor != None)
	{
		BrassActor.bHidden=true;
		Fifty9MachinePistol(Weapon).UziBrassList.length = Fifty9MachinePistol(Weapon).UziBrassList.length + 1;
		Fifty9MachinePistol(Weapon).UziBrassList[Fifty9MachinePistol(Weapon).UziBrassList.length-1].Actor = BrassActor;
		Fifty9MachinePistol(Weapon).UziBrassList[Fifty9MachinePistol(Weapon).UziBrassList.length-1].KillTime = level.TimeSeconds + 0.15;
	}
}

defaultproperties
{
     CutOffDistance=1280.000000
     CutOffStartRange=512.000000
     WaterRangeFactor=0.400000
     MaxWallSize=24.000000
     MaxWalls=2
     Damage=24.000000
     DamageHead=48.000000
     DamageLimb=24.000000
     RangeAtten=0.250000
     WaterRangeAtten=0.300000
     DamageType=Class'BallisticProV55.DTFifty9SMG'
     DamageTypeHead=Class'BallisticProV55.DTFifty9SMGHead'
     DamageTypeArm=Class'BallisticProV55.DTFifty9SMG'
     PenetrateForce=135
     bPenetrate=True
     ClipFinishSound=(Sound=Sound'BallisticSounds3.Misc.ClipEnd-2',Volume=0.800000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BallisticSounds3.Misc.DryPistol',Volume=0.700000)
     bDryUncock=True
     MuzzleFlashClass=Class'BallisticProV55.Fifty9FlashEmitter'
     FlashScaleFactor=0.400000
     BrassClass=Class'BallisticProV55.Brass_Uzi'
     BrassOffset=(X=-18.000000)
     AimedFireAnim="SightFire"
     RecoilPerShot=140.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=64.000000
     YInaccuracy=64.000000
     BallisticFireSound=(Sound=Sound'BallisticSounds3.UZI.UZI-Fire',Volume=0.900000)
     bPawnRapidFireAnim=True
     FireRate=0.072000
     AmmoClass=Class'BallisticProV55.Ammo_FiftyNine'
     ShakeRotMag=(X=64.000000,Y=32.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-3.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
	 
	 // AI
	 bInstantHit=True
	 bLeadTarget=False
	 bTossed=False
	 bSplashDamage=False
	 bRecommendSplashDamage=False
	 BotRefireRate=0.99
     WarnTargetPct=0.2
}

//=============================================================================
// MACPrimaryFire.
//
// Powerful artillery shell with high recoil
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class MACPrimaryFire extends BallisticProProjectileFire;

simulated function LaunchBeacon(optional byte i)
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;

    Weapon.GetViewAxes(X,Y,Z);

    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);
	Spawn(class'MACBeacon', Weapon, , StartTrace, Aim);
}

simulated function TurretLaunchBeacon()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;

    Weapon.GetViewAxes(X,Y,Z);

    Start = Instigator.Location + Instigator.EyePosition() + X*55;

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);
		
	Spawn(class'MACBeacon', Weapon, , StartTrace, Aim);
}

function PlayFiring()
{
	super.PlayFiring();
	MACWeapon(Weapon).PlayFiring();
}

function DoFireEffect()
{
	if (Instigator != none && Vehicle(Instigator) != None)
	{
		SpawnOffset.X = 30;
		SpawnOffset.Z = -14;
		DoTurretFireEffect();
	}
	else
	{
		SpawnOffset.X = 28;
		SpawnOffset.Z = 0;
		super.DoFireEffect();
		if (!BW.bScopeView && Instigator != None)
		{
			if (Instigator.Physics == PHYS_Falling)
				Instigator.TakeDamage(80, Instigator, Instigator.Location, -Vector(Instigator.GetViewRotation())*4000, class'DT_MACSelf');
			else Instigator.TakeDamage(50, Instigator, Instigator.Location, -Vector(Instigator.GetViewRotation())*4000, class'DT_MACSelf');
		}
	}
}

function DoTurretFireEffect()
{
    local Vector StartTrace, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;

    Weapon.GetViewAxes(X,Y,Z);
    
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition() + X*55;

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other != None)
		Aim = Rotator(HitLocation-StartTrace);
    SpawnProjectile(StartTrace, Aim);

	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
	Super(BallisticFire).DoFireEffect();
}

defaultproperties
{
	SpawnOffset=(X=18.000000,Y=4.000000)
	MuzzleFlashClass=Class'BallisticProV55.R78FlashEmitter'
	FlashScaleFactor=2.500000
	BrassClass=Class'BallisticProV55.Brass_HAMR'
	BrassBone="EmptyShell"
	bBrassOnCock=True
	FireRecoil=2048.000000
	FirePushbackForce=1000.000000
	FireChaos=0.550000
	BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.Artillery.Art-Fire',Radius=768.000000)
	FireEndAnim=
	FireRate=1.350000
	AmmoClass=Class'BallisticProV55.Ammo_MAC'
	ShakeRotMag=(X=128.000000,Y=64.000000,Z=16.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.500000
	ShakeOffsetMag=(X=-25.00)
	ShakeOffsetRate=(X=-500.000000)
	ShakeOffsetTime=2.500000
	ProjectileClass=Class'BallisticProV55.MACShell'
	// AI
	bInstantHit=False
	bLeadTarget=True
	bTossed=True
	bSplashDamage=True
	bRecommendSplashDamage=True
	BotRefireRate=0.7
	WarnTargetPct=0.75
}

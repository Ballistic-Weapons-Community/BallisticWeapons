class MACTW_PrimaryFire extends MACPrimaryFire;

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
//	MacWeapon(Weapon).AddBeacon(Spawn(class'MACBeacon_Heavy', Weapon, , StartTrace, Aim), StartTrace, Aim);
	Spawn(class'MACBeacon_Heavy', Weapon, , StartTrace, Aim);
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

	Spawn(class'MACBeacon_Heavy', Weapon, , StartTrace, Aim);
}

simulated function ModeDoFire ()
{
    Super.ModeDoFire();
	if(Instigator != None  && class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo) != None)
		class'Mut_Ballistic'.static.GetBPRI(Instigator.PlayerReplicationInfo).AddFireStat(load, BW.InventoryGroup);
}

defaultproperties
{
     RecoilPerShot=256.000000
     FireRate=0.800000
}

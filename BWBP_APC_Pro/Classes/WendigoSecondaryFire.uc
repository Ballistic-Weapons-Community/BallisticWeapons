//=============================================================================
// CYLOSecondaryFire.
//
// A semi-auto shotgun that uses its own magazine.
//
// by Casey 'Xavious' Johnson and Marc 'Sergeant Kelly'
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class WendigoSecondaryFire extends BallisticProProjectileFire;

function DoFireEffect()
{
    local Vector StartTrace, StartProj, X, Y, Z, Start, End, HitLocation, HitNormal;
    local Rotator Aim;
	local actor Other;
	local actor Other2;

    Weapon.GetViewAxes(X,Y,Z);
	
    // the to-hit trace always starts right in front of the eye
    Start = Instigator.Location + Instigator.EyePosition();

    StartTrace = Start + X*SpawnOffset.X + Z*SpawnOffset.Z;
    if ( !Weapon.WeaponCentered() )
	    StartTrace = StartTrace + Weapon.Hand * Y*SpawnOffset.Y;

    // Inserted Epic code segment.
    // check if projectile would spawn through a wall and adjust start location accordingly
    Other = Trace (HitLocation, HitNormal, StartTrace, Start, true);
	
	if (Other != None)
       StartProj = HitLocation;

	Aim = GetFireAim(StartTrace);
	Aim = Rotator(GetFireSpread() >> Aim);

	End = Start + (Vector(Aim)*MaxRange());
	Other2 = Trace (HitLocation, HitNormal, End, Start, true);

	if (Other == None)
	{
		if (Other2 != None)
			Aim = Rotator(HitLocation-StartTrace);
		SpawnProjectile(StartTrace, Aim);
	}
	else //If too close, fire at wall instead.
		SpawnProjectile(StartProj, Aim);


	SendFireEffect(none, vect(0,0,0), StartTrace, 0);
}

defaultproperties
{
     AmmoClass=Class'BWBP_SKC_Pro.Ammo_HVPCCells'
     AmmoPerFire=20
     MuzzleFlashClass=Class'BWBP_SKC_Pro.PlasmaFlashEmitter'
     FlashBone="Tip2"
     FireRecoil=768.000000
     FirePushbackForce=150.000000
     FireChaos=0.500000
     XInaccuracy=128.000000
     YInaccuracy=128.000000
     BallisticFireSound=(Sound=Sound'BWBP_SKC_Sounds.Misc.LS14-EnergyRocket2',Volume=1.300000,Radius=256.000000)
     FireAnim="FireAlt"
     FireEndAnim=
     FireRate=0.900000
	 FlashScaleFactor=0.750000
	 ProjectileClass=Class'BWBP_APC_Pro.Wendigo_EMPTorpedo'
     ShakeRotMag=(X=128.000000,Y=64.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-12.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=2.000000
     BotRefireRate=0.700000
     WarnTargetPct=0.500000
}

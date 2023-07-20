class CX85SecondaryFire extends BallisticProInstantFire;

//===========================================================================
// AllowFire
//
// Check alternate magazine.
//===========================================================================
simulated function bool AllowFire()
{
	if (!CheckReloading())
		return false;		// Is weapon busy reloading
	if (CX85AssaultWeapon(BW).AltAmmo < 1)
	{
		if (!bPlayedDryFire && DryFireSound.Sound != None)
		{
			Weapon.PlayOwnedSound(DryFireSound.Sound,DryFireSound.Slot,DryFireSound.Volume,DryFireSound.bNoOverride,DryFireSound.Radius,DryFireSound.Pitch,DryFireSound.bAtten);
			bPlayedDryFire=true;
		}
		BW.bNeedReload = BW.MayNeedReload(ThisModeNum, 0);

		BW.EmptyFire(ThisModeNum);
		return false;		// Is there ammo in weapon's mag
	}
    return true;
}

//===========================================================================
// DoFireEffect
//
// Decrement weapon's dart reserve on fire.
//===========================================================================
function DoFireEffect()
{
	Super.DoFireEffect();
	CX85AssaultWeapon(BW).AltAmmo--;
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
    local int i;
	local CX85DartDirect Proj, MasterProj;
    local Rotator R;
	local float             BoneDist;

	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
	
    if (Damage > 0 && Pawn(Target) != None && Pawn(Target).Health > 0)
	{
        R = Rotator(MomentumDir);
        R.Roll = Rand(65536);
        
        //If we already have a dart attached, it becomes a slave of the existing one.
        foreach Target.BasedActors(class'CX85DartDirect', Proj)
        {
            if (Proj.Instigator == Instigator)
            {
                MasterProj = Proj;
                break;
            }
        }

        if (MasterProj != None)
        {
            Proj = Spawn (class'CX85DartDirect',MasterProj,, HitLocation, R);
            Proj.Tracked = Pawn(Target);
        }
        else
        {
            CX85AssaultWeapon(BW).bPendingReceive=True; //Weapon needs to wait for acknowledgement for the leader dart, which is used clientside for tracking.
            Proj = Spawn (class'CX85DartDirect',BW,, HitLocation, R);
            Proj.Tracked = Pawn(Target);
            Proj.SetMaster();
        }

        Proj.Instigator = Instigator;
        Proj.SetPhysics(PHYS_None);
        Proj.bHardAttach = true;
        if (Target != Instigator && Target.DrawType == DT_Mesh)
            Target.AttachToBone(Proj, Target.GetClosestBone(HitLocation, MomentumDir, BoneDist));
        else
            Proj.SetBase(Target);

        Proj.SetRotation(R);
        Proj.Velocity = vect(0,0,0);    
	}
}

defaultproperties
{
    bUseWeaponMag=False
    FlashBone="tip2"
    FireRecoil=256.000000

	TraceRange=(Min=30000.000000,Max=30000.000000)
    MaxWaterTraceRange=5000

    DamageType=Class'DTCX85Dart'
    DamageTypeHead=Class'DTCX85Dart'
    DamageTypeArm=Class'DTCX85Dart'
    PenetrateForce=0
    bPenetrate=False
    FireChaos=0.500000
    BallisticFireSound=(Sound=Sound'BW_Core_WeaponSound.OA-SMG.OA-SMG_FireDart',Volume=1.350000)
    PreFireAnim=
    FireAnim="FireAlt"
    FireForce="AssaultRifleAltFire"
    FireRate=0.350000
    AmmoClass=Class'BWBP_OP_Pro.Ammo_CX85Darts'
    AmmoPerFire=0
    ShakeRotTime=2.000000
    ShakeOffsetMag=(X=-8.000000)
    ShakeOffsetRate=(X=-1000.000000)
    ShakeOffsetTime=2.000000
    BotRefireRate=0.300000
    WarnTargetPct=0.300000
}

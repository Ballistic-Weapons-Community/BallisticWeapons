//=============================================================================
// M575PrimaryFire.
//
// Powerful automatic fire. Stronger than the M353 but weaker than the M925.
// Can mount an amp for a temporary power and freeze boost.
// Optics afford this gun better accuracy than its peers.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M575PrimaryFire extends BallisticProInstantFire;

var(M575) Actor						MuzzleFlashAmp;		
var(M575) class<Actor>				MuzzleFlashClassAmp;	
var(M575) Name						AmpFlashBone;
var(M575) float						AmpFlashScaleFactor;
var(M575) bool						bAmped;
var(M575) float						AmpDrainPerShot;

function InitEffects()
{
	if (AIController(Instigator.Controller) != None)
		return;
    if ((MuzzleFlashClass != None) && ((MuzzleFlash == None) || MuzzleFlash.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, FlashBone);
	if ((MuzzleFlashClassAmp != None) && ((MuzzleFlashAmp == None) || MuzzleFlashAmp.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlashAmp, MuzzleFlashClassAmp, Weapon.DrawScale*AmpFlashScaleFactor, weapon, FlashBone);
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;
    if (!M575Machinegun(Weapon).bAmped && MuzzleFlash != None)
        MuzzleFlash.Trigger(Weapon, Instigator);
    else if (MuzzleFlashAmp != None && M575Machinegun(Weapon).CurrentWeaponMode == 4)
       	MuzzleFlashAmp.Trigger(Weapon, Instigator);

	if (!bBrassOnCock)
		EjectBrass();
}

simulated function SwitchWeaponMode (byte NewMode)
{
	if (Weapon.bBerserk)
		FireRate *= 0.75;
	if ( Level.GRI.WeaponBerserk > 1.0 )
	    FireRate /= Level.GRI.WeaponBerserk;
		
	if (NewMode == 4) 
	{
		bAmped=True;
        
		WaterRangeAtten=0.600000;
		DecayRange.Max = 4200.000000;
		DecayRange.Min = 1500.000000;
		WallPenetrationForce=24.000000;
	}
	else
	{
		bAmped=False;//Standard Fire
	}
}

function ApplyDamage(Actor Victim, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
    super.ApplyDamage (Victim, Damage, Instigator, HitLocation, MomentumDir, DamageType);

    if (bAmped && Pawn(Victim) != None && Pawn(Victim).Health > 0 && Vehicle(Victim) == None)
    {
        class'BCSprintControl'.static.AddSlowTo(Pawn(Victim), 0.7, 0.5);
    }
}

simulated function SendFireEffect(Actor Other, vector HitLocation, vector HitNormal, int Surf, optional vector WaterHitLoc)
{
	if (!bAmped)
		BallisticAttachment(Weapon.ThirdPersonActor).BallisticUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
	else
		M575Attachment(Weapon.ThirdPersonActor).IceUpdateHit(Other, HitLocation, HitNormal, Surf, , WaterHitLoc);
}

function ServerPlayFiring()
{
	Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,BallisticFireSound.bNoOverride,BallisticFireSound.Radius,BallisticFireSound.Pitch,BallisticFireSound.bAtten);

	PlayFireAnimations();

	CheckClipFinished();
}

function PlayFiring()
{
	PlayFireAnimations();

    ClientPlayForceFeedback(FireForce);  // jdf
    FireCount++;

	Weapon.PlayOwnedSound(BallisticFireSound.Sound,BallisticFireSound.Slot,BallisticFireSound.Volume,,BallisticFireSound.Radius);

	CheckClipFinished();
	
	if (bAmped)
		M575Machinegun(BW).AddHeat(AmpDrainPerShot);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		M575Machinegun(BW).AddHeat(AmpDrainPerShot);
}

// Remove effects
simulated function DestroyEffects()
{
	Super.DestroyEffects();

	class'BUtil'.static.KillEmitterEffect (MuzzleFlash);
	class'BUtil'.static.KillEmitterEffect (MuzzleFlashAmp);
}

event ModeDoFire()
{
    if (!AllowFire())
        return;

	BallisticMachinegun(Weapon).SetBeltVisibility(BallisticMachinegun(Weapon).MagAmmo);
	Super.ModeDoFire();
}

simulated function vector GetFireDir(out Vector StartTrace)
{
    if (BallisticTurret(Instigator) != None)
    	StartTrace = Instigator.Location + Instigator.EyePosition() + Vector(Instigator.GetViewRotation()) * 64;
	return super.GetFireDir(StartTrace);
}

defaultproperties
{
     TraceRange=(Min=15000.000000,Max=15000.000000)
	 AmpDrainPerShot=-0.1
	 AmpFlashBone="tip2"
     AmpFlashScaleFactor=0.700000
     MuzzleFlashClassAmp=Class'BWBP_SKC_Pro.SX45CryoFlash'
	 
     WaterRangeAtten=0.800000
     DamageType=Class'BWBP_OP_Pro.DTM575MG'
     DamageTypeHead=Class'BWBP_OP_Pro.DTM575MGHead'
     DamageTypeArm=Class'BWBP_OP_Pro.DTM575MG'
     KickForce=2000
     PenetrateForce=150
     bPenetrate=True
     DryFireSound=(Sound=Sound'BW_Core_WeaponSound.Misc.DryRifle',Volume=0.700000)
     bCockAfterEmpty=True
     MuzzleFlashClass=Class'BWBP_OP_Pro.M575FlashEmitter'
	 FlashBone="tip"
     FlashScaleFactor=0.300000
     BrassClass=Class'BallisticProV55.Brass_MG'
     BrassOffset=(X=6.000000,Y=10.000000)
     AimedFireAnim="SightFire"
     FireRecoil=80.000000
     FireChaosCurve=(Points=((InVal=0,OutVal=1),(InVal=0.240000,OutVal=1),(InVal=0.350000,OutVal=1.500000),(InVal=0.660000,OutVal=2.250000),(InVal=1.000000,OutVal=3.500000)))
     XInaccuracy=16.000000
     YInaccuracy=16.000000
     BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.M575.M575-Fire',Volume=1.600000,Slot=SLOT_Interact,bNoOverride=False)
     bPawnRapidFireAnim=True
     FireEndAnim=
     FireRate=0.082000
     AmmoClass=Class'BWBP_OP_Pro.Ammo_762mmBelt'
     ShakeRotMag=(X=64.000000,Y=64.000000,Z=128.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=2.000000
     ShakeOffsetMag=(X=-10.000000)
     ShakeOffsetRate=(X=-1000.000000)
     ShakeOffsetTime=1.500000
     WarnTargetPct=0.200000
     aimerror=900.000000
}

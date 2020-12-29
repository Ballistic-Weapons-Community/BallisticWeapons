//=============================================================================
// LS-14 Primary Fire.
//
// Laser weapon with overheating mechanism. Deals more damage the lower the weapon's heat level is.
// Does not cut out if maximum heat is reached.
//
// Azarael note: This is pretty bright. Maybe use this elsewhere
//=============================================================================
class LS14PrimaryFire extends BallisticProInstantFire;


var() Actor			MuzzleFlash2;		// The muzzleflash actor
var   bool			bSecondBarrel;
var   bool			bIsDouble;
var() sound			SpecialFireSound;

var()	float			HeatPerShot;

var 	float 			SelfHeatPerShot, SelfHeatDeclineDelay;

simulated function bool AllowFire()
{
	if ((LS14Carbine(Weapon).SelfHeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	LS14Carbine(BW).AddHeat(SelfHeatPerShot, SelfHeatDeclineDelay);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		LS14Carbine(BW).AddHeat(SelfHeatPerShot, SelfHeatDeclineDelay);
}

function InitEffects()
{
	super.InitEffects();
    if ((MuzzleFlashClass != None) && ((MuzzleFlash2 == None) || MuzzleFlash2.bDeleteMe) )
		class'BUtil'.static.InitMuzzleFlash (MuzzleFlash2, MuzzleFlashClass, Weapon.DrawScale*FlashScaleFactor, weapon, 'tip2');
}

simulated function SwitchWeaponMode (byte NewMode)
{
	Super.SwitchWeaponMode(NewMode);
	
	if (NewMode == 0)
	{
		bIsDouble=false;
		HeatPerShot=default.HeatPerShot;
		SelfHeatPerShot=default.SelfHeatPerShot;
		SelfHeatDeclineDelay=default.SelfHeatDeclineDelay;
	}
	
	else
	{
		bIsDouble=true;
		HeatPerShot=45;
		SelfHeatPerShot=default.SelfHeatPerShot*2.5;
		SelfHeatDeclineDelay=default.SelfHeatDeclineDelay*2;
	}
}

//The LS-14 deals increased damage to targets which have already been heated up by a previous strike.
function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{	
	if (Pawn(Target) != None && Pawn(Target).bProjTarget)
		Damage += LS14Carbine(BW).ManageHeatInteraction(Pawn(Target), HeatPerShot);
	
	super.ApplyDamage (Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);
}

simulated event ModeDoFire()
{
	if (bIsDouble) 
		BallisticFireSound.Sound=SpecialFireSound;
	else
		BallisticFireSound.Sound=default.BallisticFireSound.sound;

	if (AllowFire() && !LS14Carbine(Weapon).bIsReloadingGrenade)
	{
		if (bIsDouble)
			FireAnim='FireBig';
		else
			FireAnim='Fire';

		if (!bSecondBarrel)
		{
			bSecondBarrel=true;
			LS14Carbine(Weapon).bBarrelsOnline=true;
		}
		else
		{
			bSecondBarrel=false;
			LS14Carbine(Weapon).bBarrelsOnline=false;
		}
		
		super.ModeDoFire();	
	}
	
	if (LS14Carbine(Weapon).bIsReloadingGrenade)
		LS14Carbine(Weapon).bWantsToShoot=true;
}

//Trigger muzzleflash emitter
function FlashMuzzleFlash()
{
	local Coords C;
	local vector Start, X, Y, Z;

    	if ((Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
	if (!Instigator.IsFirstPerson() || PlayerController(Instigator.Controller).ViewTarget != Instigator)
		return;

    	if ((bIsDouble) && MuzzleFlash2 !=None && MuzzleFlash != None)
	{
        	MuzzleFlash2.Trigger(Weapon, Instigator);
        	MuzzleFlash.Trigger(Weapon, Instigator);
	}

    	if (bSecondBarrel && MuzzleFlash2 != None) //Checks to alternate
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
	Start = C.Origin + X * -180 + Y * 3;
}

defaultproperties
{
	 SelfHeatPerShot=0.900000
	 SelfHeatDeclineDelay=0.5
     SpecialFireSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireDouble'
     HeatPerShot=15.000000
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WallPenetrationForce=0.000000
     
     Damage=15.000000
     
     
     DamageType=Class'BWBPRecolorsPro.DTLS14Body'
     DamageTypeHead=Class'BWBPRecolorsPro.DTLS14Head'
     DamageTypeArm=Class'BWBPRecolorsPro.DTLS14Limb'
     PenetrateForce=500
     bPenetrate=True
     FireModes(0)=(mDamage=45,mDamageType=Class'BWBPRecolorsPro.DTLS14Twin',mDamageTypeHead=Class'BWBPRecolorsPro.DTLS14Twin',mFireRate=0.500000,mFireChaos=1.000000,mRecoil=512.000000,mAmmoPerFire=2,bModeInstantHit=True)
     ClipFinishSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
     DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
     MuzzleFlashClass=Class'BWBPRecolorsPro.LS14FlashEmitter'
     FlashScaleFactor=0.400000
     FireRecoil=150.000000
     FireChaos=0.300000
     BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
     FireEndAnim=
     FireRate=0.150000
     AmmoClass=Class'BWBPRecolorsPro.Ammo_Laser'
     ShakeRotMag=(X=200.000000,Y=16.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=1.000000
     ShakeOffsetMag=(X=-2.500000)
     ShakeOffsetRate=(X=-500.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.99
     WarnTargetPct=0.30000
     aimerror=800.000000
}

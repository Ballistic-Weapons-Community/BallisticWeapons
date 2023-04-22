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
var		bool		bAnimatedOverheat; //overheat plays special anims

var() sound			SpecialFireSound;

var()	float		HeatPerShot;
var()	float		HeatPerShotDouble;

var 	float 			SelfHeatPerShot, SelfHeatPerShotDouble, SelfHeatDeclineDelay;



simulated function bool AllowFire()
{
	if ((LS14Carbine(Weapon).SelfHeatLevel >= 10) || !super.AllowFire())
		return false;
	return true;
}

function PlayFiring()
{
	Super.PlayFiring();
	LS14Carbine(BW).AddHeat(SelfHeatPerShot, 0, SelfHeatDeclineDelay);
}

// Get aim then run trace...
function DoFireEffect()
{
	Super.DoFireEffect();
	if (Level.NetMode == NM_DedicatedServer)
		LS14Carbine(BW).AddHeat(SelfHeatPerShot, 0, SelfHeatDeclineDelay);
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
		HeatPerShot=default.HeatPerShotDouble;
		SelfHeatPerShot=default.SelfHeatPerShotDouble;
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
		//[2.5] Classic Heat Anims
		if (bAnimatedOverheat)
		{
			if (LS14Carbine(Weapon).SelfHeatLevel >= 8.5)
				FireAnim='Overheat';
			else if (bIsDouble && LS14Carbine(Weapon).SelfHeatLevel >= 6.5)
				FireAnim='FiddleOne';
			else if ((LS14Carbine(Weapon).SelfHeatLevel > 6.5 && LS14Carbine(Weapon).SelfHeatLevel < 8.5) || bIsDouble)
				FireAnim='FireBig';
			else
				FireAnim='Fire';
		}
		else
		{
			if (bIsDouble)
				FireAnim='FireBig';
			else
				FireAnim='Fire';
		}

		AimedFireAnim = FireAnim;

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
	SelfHeatPerShot=0.600000
	SelfHeatPerShotDouble=1.500000
	SelfHeatDeclineDelay=0.5
	bAnimatedOverheat=False
	SpecialFireSound=Sound'BWBP_SKC_Sounds.LS14.Gauss-FireDouble'
	HeatPerShot=10.000000
	HeatPerShotDouble=45
	TraceRange=(Min=30000.000000,Max=30000.000000)
	DamageType=Class'BWBP_SKC_Pro.DTLS14Body'
	DamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Head'
	DamageTypeArm=Class'BWBP_SKC_Pro.DTLS14Limb'
	PenetrateForce=500
	bPenetrate=True
	FireModes(0)=(mDamage=40,mDamageType=Class'BWBP_SKC_Pro.DTLS14Twin',mDamageTypeHead=Class'BWBP_SKC_Pro.DTLS14Twin',mFireRate=0.500000,mFireChaos=1.000000,mRecoil=512.000000,mAmmoPerFire=2,bModeInstantHit=True)
	ClipFinishSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-LastShot',Volume=1.000000,Radius=48.000000,bAtten=True)
	DryFireSound=(Sound=Sound'BWBP_SKC_Sounds.LS14.Gauss-Empty',Volume=1.200000)
	MuzzleFlashClass=Class'BWBP_SKC_Pro.LS14FlashEmitter'
	FlashScaleFactor=0.400000
	FireRecoil=150.000000
	FireChaos=0.300000
	BallisticFireSound=(Sound=SoundGroup'BWBP_SKC_Sounds.LS14.Gauss-Fire',Volume=0.900000)
	FireEndAnim=
	FireRate=0.150000
	AmmoClass=Class'BWBP_SKC_Pro.Ammo_Laser'

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-60.000000)
	ShakeOffsetTime=2.000000

	BotRefireRate=0.99
	WarnTargetPct=0.30000
	aimerror=800.000000
}

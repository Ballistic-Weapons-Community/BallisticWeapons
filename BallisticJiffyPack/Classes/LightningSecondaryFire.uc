//=============================================================================
// R78PrimaryFire.
//
// Very accurate, long ranged and powerful bullet fire. Headshots are
// especially dangerous.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class LightningSecondaryFire extends BallisticProInstantFire;

var   	float 					ChargePower;	//Charge power of secondary fire - affects damage, ammo usage and conductivity
var() 	BUtil.FullSound			LightningSound;	//Crackling sound to play
var   	int 					TransferCDamage;	//Damage to transfer to LightningConductor actor
var		float					ChargeGainPerSecond, ChargeDecayPerSecond, ChargeOvertime, MaxChargeOvertime;
var		bool 					AmmoHasBeenCalculated;

simulated event ModeDoFire()
{
	TransferCDamage = default.Damage * (1 + (0.25*ChargePower));

	Load = CalculateAmmoUse();
	AmmoHasBeenCalculated = true;
	
	super.ModeDoFire();
}

simulated function int CalculateAmmoUse()
{	
	if (ChargePower >= BW.MagAmmo)
		return BW.MagAmmo;

	return Max(1, int(ChargePower));
}

simulated function float GetChargeFactor()
{
	return ChargePower / BW.default.MagAmmo;
}

simulated function ModeTick(float DeltaTime)
{	
	if (bIsFiring)
	{
		ChargePower = FMin(BW.MagAmmo, ChargePower + ChargeGainPerSecond * DeltaTime);
		
		if (ChargePower >= BW.MagAmmo)
			ChargeOvertime += DeltaTime;
		
		if (ChargeOvertime >= MaxChargeOvertime)
			bIsFiring = false;
	}
	else if (ChargePower > 0 && AmmoHasBeenCalculated)
	{
		ChargePower = FMax(0.0, ChargePower - ChargeDecayPerSecond * DeltaTime);
		if (ChargePower == 0)
			AmmoHasBeenCalculated = false;
			
		ChargeOvertime = 0;
	}
	
	Super.ModeTick(DeltaTime);
}

function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	local float DefDmg;
	DefDmg = Super.GetDamage(Other, HitLocation, Dir, Victim, DT);
	
	return DefDmg * (1 + (0.25*ChargePower));
}

simulated function ServerPlayFiring()
{
	super.ServerPlayFiring();
	if (LightningSound.Sound != None)
		Weapon.PlayOwnedSound(LightningSound.Sound,LightningSound.Slot,LightningSound.Volume,LightningSound.bNoOverride,LightningSound.Radius,LightningSound.Pitch,LightningSound.bAtten);
}

simulated function PlayFiring()
{
	super.PlayFiring();
	if (LightningSound.Sound != None)
		Weapon.PlayOwnedSound(LightningSound.Sound,LightningSound.Slot,LightningSound.Volume,LightningSound.bNoOverride,LightningSound.Radius,LightningSound.Pitch,LightningSound.bAtten);
}

function ApplyDamage(Actor Target, int Damage, Pawn Instigator, vector HitLocation, vector MomentumDir, class<DamageType> DamageType)
{
	local LightningConductor LConductor;

	super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);

	if (!class'LightningConductor'.static.ValidTarget(Instigator, Pawn(Target), Instigator.Level))
		return;

	//Initiates Lightning Conduction actor
	LConductor = Spawn(class'LightningConductor',Instigator,,HitLocation);

	if (LConductor != None)
	{
		LConductor.Instigator = Instigator;
		LConductor.Damage = TransferCDamage;
		LConductor.ChargePower = ChargePower;
		LConductor.Initialize(Pawn(Target));
	}
}

defaultproperties
{
	MaxChargeOvertime = 3.0f
	ChargeGainPerSecond = 2.5f
	ChargeDecayPerSecond = 9.0f
	LightningSound=(Sound=Sound'BWBPJiffyPackSounds.Lightning.LightningGunCrackle',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
	TraceRange=(Min=30000.000000,Max=30000.000000)
    MaxWaterTraceRange=30000
	Damage=80.000000
	DamageHead=120.000000
	DamageLimb=60.000000
	WaterRangeAtten=0.800000
	DamageType=Class'BallisticJiffyPack.DT_LightningRifle'
	DamageTypeHead=Class'BallisticJiffyPack.DT_LightningHead'
	DamageTypeArm=Class'BallisticJiffyPack.DT_LightningRifle'
	KickForce=6000
	PDamageFactor=0.800000
	MuzzleFlashClass=Class'BallisticJiffyPack.LightningFlashEmitter'
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	RecoilPerShot=1536.000000
	VelocityRecoil=255.000000
	FireChaos=0.800000
	BallisticFireSound=(Sound=Sound'BWBPJiffyPackSounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
	bFireOnRelease=True
	FireEndAnim=
	FireRate=1.050000
	AmmoClass=Class'BallisticJiffyPack.Ammo_LightningRifle'
	AmmoPerFire=1
	ShakeRotMag=(X=400.000000,Y=32.000000)
	ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-5.000000)
	ShakeOffsetRate=(X=-1000.000000)
	ShakeOffsetTime=2.000000
	BotRefireRate=0.400000
	WarnTargetPct=0.500000
	aimerror=800.000000
}

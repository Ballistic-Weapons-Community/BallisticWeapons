class LightningSecondaryFire extends BallisticProInstantFire;

var()	Name					ChargeAnim;		//Animation to use when charging
var() 	BUtil.FullSound			LightningSound;	//Crackling sound to play
var() 	Sound					ChargeLoopSound; //Sound to play/scale pitch when charging
var		byte					ChargeSoundPitch;
var   	int 					TransferCDamage;	//Damage to transfer to LightningConductor actor
var		float					ChargeGainPerSecond, ChargeDecayPerSecond, ChargeOvertime, MaxChargeOvertime;
var		bool 					AmmoHasBeenCalculated;

simulated function ModeDoFire()
{
    if (BW.Role == ROLE_Authority)
	    TransferCDamage = default.Damage * (1 + (0.25 * LightningRifle(BW).ChargePower));

	Load = CalculateAmmoUse();
	AmmoHasBeenCalculated = true;
	
	super.ModeDoFire();
}

simulated function PlayStartHold()
{	
	Weapon.AmbientSound = ChargeLoopSound;
	Weapon.ThirdPersonActor.AmbientSound = ChargeLoopSound;

	AdjustChargeVolume();

	BW.bPreventReload=True;
	BW.SafeLoopAnim(ChargeAnim, 1.0, TweenTime, ,"IDLE");
}

simulated function AdjustChargeVolume()
{
	Weapon.SoundVolume = 127 + LightningRifle(BW).ChargePower * 32;
	Weapon.SoundPitch = ChargeSoundPitch * (1 + FMax(LightningRifle(BW).ChargePower, 0.1)/4);
	
	Weapon.ThirdPersonActor.SoundVolume = 127 + LightningRifle(BW).ChargePower * 32;
	Weapon.ThirdPersonActor.SoundPitch = ChargeSoundPitch * (1 + FMax(LightningRifle(BW).ChargePower,0.1)/4);
}

simulated function int CalculateAmmoUse()
{	
	if (LightningRifle(BW).ChargePower >= BW.MagAmmo)
		return BW.MagAmmo;

	return Max(1, int(LightningRifle(BW).ChargePower));
}

simulated function ModeTick(float DeltaTime)
{	
	if (bIsFiring)
	{
		//Scale charge
		LightningRifle(BW).SetChargePower(FMin(Min(BW.MagAmmo, class'LightningRifle'.default.MaxCharge), LightningRifle(BW).ChargePower + ChargeGainPerSecond * DeltaTime));
		
		if (LightningRifle(BW).ChargePower >= Min(BW.MagAmmo, class'LightningRifle'.default.MaxCharge))
			ChargeOvertime += DeltaTime;
		
		if (ChargeOvertime >= MaxChargeOvertime)
			bIsFiring = false;
	}
	else if (LightningRifle(BW).ChargePower > 0 && AmmoHasBeenCalculated)
	{
		LightningRifle(BW).SetChargePower(FMax(0.0, LightningRifle(BW).ChargePower - ChargeDecayPerSecond * DeltaTime));
		if (LightningRifle(BW).ChargePower == 0)
		{
			AmmoHasBeenCalculated = false;
			
			Weapon.AmbientSound = None;
			Weapon.ThirdPersonActor.AmbientSound = None;
		}
			
		ChargeOvertime = 0;
	}
	
	if (Weapon.AmbientSound != None && Weapon.ThirdPersonActor.AmbientSound != None)
		AdjustChargeVolume();
		
		
	Super.ModeTick(DeltaTime);
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

    Damage *= (1 + (0.125*LightningRifle(BW).ChargePower));

	super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);

	if (!class'LightningConductor'.static.ValidTarget(Instigator, Pawn(Target), Instigator.Level))
		return;

	//Initiates Lightning Conduction actor
	LConductor = Spawn(class'LightningConductor',Instigator,,HitLocation);

	if (LConductor != None)
	{
		LConductor.Instigator = Instigator;
		LConductor.Damage = TransferCDamage;
		LConductor.ChargePower = LightningRifle(BW).ChargePower;
		LConductor.Initialize(Pawn(Target));
	}

    else 
    {
        log("ApplyDamage: Failed to spawn lightning conductor");
    }
}

defaultproperties
{
	ChargeAnim="ChargeLoop"
	ChargeLoopSound=Sound'IndoorAmbience.machinery18'
	ChargeSoundPitch=32
	MaxChargeOvertime=3.0f
	ChargeGainPerSecond=2.5f
	ChargeDecayPerSecond=9.0f
	LightningSound=(Sound=Sound'BWBPJiffyPackSounds.Lightning.LightningGunCrackle',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
	TraceRange=(Min=30000.000000,Max=30000.000000)
	MaxWaterTraceRange=30000
	Damage=80.000000
	HeadMult=1.5f
    LimbMult=0.9f
	
	WaterRangeAtten=0.800000
	DamageType=Class'BWBPOtherPackPro.DT_LightningRifle'
	DamageTypeHead=Class'BWBPOtherPackPro.DT_LightningHead'
	DamageTypeArm=Class'BWBPOtherPackPro.DT_LightningRifle'
	KickForce=6000
	PDamageFactor=0.800000
	MuzzleFlashClass=Class'BWBPOtherPackPro.LightningFlashEmitter'
	FlashScaleFactor=0.600000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	FireRecoil=1024.000000
	FirePushbackForce=256.000000
	FireChaos=0.800000
	BallisticFireSound=(Sound=Sound'BWBPJiffyPackSounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
	bFireOnRelease=True
	FireAnim="FireCharged"
	FireRate=1.050000
	FireAnimRate=0.800000
	AmmoClass=Class'BWBPOtherPackPro.Ammo_LightningRifle'
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

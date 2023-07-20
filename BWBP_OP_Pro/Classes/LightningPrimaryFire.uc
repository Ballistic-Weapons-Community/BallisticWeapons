class LightningPrimaryFire extends BallisticProInstantFire;

const CHARGE_TO_AMMO_FACTOR = 4f;
const AMMO_TO_CHARGE_FACTOR = 0.25f;

var()	Name					ChargeAnim;		//Animation to use when charging
var() 	BUtil.FullSound			LightningSound;	//Crackling sound to play
var() 	Sound					ChargeLoopSound; //Sound to play
var()   byte                    ChargeLoopSoundVolume; 
var		byte					ChargeSoundPitch;
var		float					ChargeGainPerSecond, ChargeDecayPerSecond, ChargeOvertime, MaxChargeOvertime;
var		bool 					bAmmoHasBeenCalculated;
var     float                   MaxDamageBonus;
var     float                   TransferDamageMultiplier;
var     int                     FullChargeAmmo;

final function float CalcBonusDamageFactor()
{
   return (1 + (LightningRifle(BW).ChargePower * MaxDamageBonus));
}

simulated function ModeDoFire()
{
	Load = CalculateAmmoUse();
	bAmmoHasBeenCalculated = true;
	
	super.ModeDoFire();
}

simulated function PlayStartHold()
{	
    if (BW.Role == ROLE_Authority)
    {	
        Instigator.AmbientSound = ChargeLoopSound;
        Instigator.SoundVolume = ChargeLoopSoundVolume;
        Instigator.SoundPitch = ChargeSoundPitch;
    }

	AdjustChargeVolume();

	BW.bPreventReload=True;
	BW.SafeLoopAnim(ChargeAnim, 1.0, TweenTime, ,"IDLE");
}

function AdjustChargeVolume()
{
	Instigator.SoundVolume  = 127 + LightningRifle(BW).ChargePower * 64;
	Instigator.SoundPitch   = ChargeSoundPitch * (1 + FMax(LightningRifle(BW).ChargePower, 0.1)/2);
}

simulated function int CalculateAmmoUse()
{	
    local int load;

	load = Max(1, int(LightningRifle(BW).ChargePower * FullChargeAmmo));

    return Min(BW.MagAmmo, load);
}

simulated function ModeTick(float DeltaTime)
{	
    local float max_allowed_charge;

	if (bIsFiring)
	{
        max_allowed_charge = FMin(BW.MagAmmo * AMMO_TO_CHARGE_FACTOR, 1f);

		//Scale charge
		LightningRifle(BW).SetChargePower(FMin(max_allowed_charge, LightningRifle(BW).ChargePower + ChargeGainPerSecond * DeltaTime));
		
		if (LightningRifle(BW).ChargePower >= max_allowed_charge)
        {			
            ChargeOvertime += DeltaTime;
            
            if (ChargeOvertime >= MaxChargeOvertime)
                bIsFiring = false;
        }
	}

	else if (LightningRifle(BW).ChargePower > 0 && bAmmoHasBeenCalculated)
	{
		LightningRifle(BW).SetChargePower(FMax(0.0, LightningRifle(BW).ChargePower - ChargeDecayPerSecond * DeltaTime));

		if (LightningRifle(BW).ChargePower == 0)
		{
			bAmmoHasBeenCalculated = false;
			
            if (Weapon.Role == ROLE_Authority)
            {
                Instigator.AmbientSound = None;
                Instigator.SoundVolume = Instigator.Default.SoundVolume;
                Instigator.SoundPitch = Instigator.default.SoundPitch;
            }
		}
			
		ChargeOvertime = 0;
	}
	
	if (Weapon.Role == ROLE_Authority && Instigator.AmbientSound == ChargeLoopSound)
		AdjustChargeVolume();
		
	Super.ModeTick(DeltaTime);
}

function ServerPlayFiring()
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

    Damage *= CalcBonusDamageFactor();

	super.ApplyDamage(Target, Damage, Instigator, HitLocation, MomentumDir, DamageType);

	// lightning projectiles handle this by themselves, apparently
	if (LightningProjectile(Target) != None)
		return;

	if (!class'LightningConductor'.static.ValidTarget(Instigator, Pawn(Target), Instigator.Level))
		return;

	//Initiates Lightning Conduction actor
	LConductor = Spawn(class'LightningConductor',Instigator,,HitLocation);

	if (LConductor != None)
	{
		LConductor.Instigator = Instigator;
		LConductor.Damage = Damage * TransferDamageMultiplier;
		LConductor.ChargePower = LightningRifle(BW).ChargePower;
		LConductor.Initialize(Target);
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
    ChargeLoopSoundVolume=200
	ChargeSoundPitch=32

    // gameplay for charge
	MaxChargeOvertime=1f
	ChargeGainPerSecond=1f
    ChargeDecayPerSecond=4f
    FullChargeAmmo=4
    MaxDamageBonus=0.5f
    TransferDamageMultiplier=0.67f

	LightningSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunCrackle',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
	TraceRange=(Min=30000.000000,Max=30000.000000)
	MaxWaterTraceRange=30000
	WaterRangeAtten=0.800000
	DamageType=Class'BWBP_OP_Pro.DT_LightningRifle'
	DamageTypeHead=Class'BWBP_OP_Pro.DT_LightningHead'
	DamageTypeArm=Class'BWBP_OP_Pro.DT_LightningRifle'
	PDamageFactor=0.800000
	MuzzleFlashClass=Class'BWBP_OP_Pro.LightningFlashEmitter'
	FlashScaleFactor=0.600000
	BrassClass=Class'BallisticProV55.Brass_Rifle'
	bBrassOnCock=True
	BrassOffset=(X=-10.000000,Y=1.000000,Z=-1.000000)
	FireRecoil=1024.000000
	FirePushbackForce=256.000000
	FireChaos=0.800000
	BallisticFireSound=(Sound=Sound'BWBP_OP_Sounds.Lightning.LightningGunShot',Volume=1.600000,Radius=1024.000000)
	bFireOnRelease=True
	FireAnim="FireCharged"
	FireRate=0.850000
	FireAnimRate=0.800000
	AmmoClass=Class'BWBP_OP_Pro.Ammo_LightningRifle'
	AmmoPerFire=1

	ShakeRotMag=(X=48.000000)
	ShakeRotRate=(X=640.000000)
	ShakeRotTime=2.000000
	ShakeOffsetMag=(X=-3.00)
	ShakeOffsetRate=(X=-70.000000)
	ShakeOffsetTime=2.000000
	
	BotRefireRate=0.400000
	WarnTargetPct=0.500000
	aimerror=800.000000
}

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

var   float 					ChargePower;	//Charge power of secondary fire - affects damage, ammo usage and conductivity
var() BUtil.FullSound			LightningSound;	//Crackling sound to play
var   int 						TransferCDamage;	//Damage to transfer to LightningConductor actor
var   int						NewAmmoUse;

simulated event ModeDoFire()
{
	TransferCDamage = default.Damage + 3*default.Damage*ChargePower;
	
	super.ModeDoFire();
}

simulated function ModeTick(float DeltaTime)
{	
	if (bIsFiring)
	{
		ChargePower = FMin(1.0, ChargePower + 0.5*DeltaTime);
		
		NewAmmoUse = FMin(BW.MagAmmo, 3*ChargePower);
		
		if (ChargePower >= 1 || NewAmmoUse >= BW.MagAmmo)
		{
				
			Load = NewAmmoUse;
			
			bIsFiring = false;
		}
	}
	else if (ChargePower > 0)
	{
		ChargePower = FMax(0.0, ChargePower - 3*DeltaTime);
		if (ChargePower < 0)
		{
			ChargePower = 0;
		}
	}
	
	Super.ModeTick(DeltaTime);

}

function float GetDamage (Actor Other, vector HitLocation, vector Dir, out Actor Victim, optional out class<DamageType> DT)
{
	local float DefDmg;
	DefDmg = Super.GetDamage(Other, HitLocation, Dir, Victim, DT);
	
	return (DefDmg + 3*DefDmg*ChargePower);
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

simulated function DoDamage(Actor Other, vector HitLocation, vector TraceStart, vector Dir, int PenetrateCount, int WallCount, optional vector WaterHitLocation)
{
	local LightningConductor LConductor;

	super.DoDamage(Other, HitLocation, TraceStart, Dir, PenetrateCount, WallCount, WaterHitLocation);

	//Initiates Lightning Conduction actor
	if (ValidTarget(Pawn(Other)))
	{
		LConductor = Spawn(class'LightningConductor',Instigator,,HitLocation);
		if (LConductor!=None)
		{
			LConductor.Instigator = Instigator;
			LConductor.Damage = TransferCDamage;
			LConductor.CollidingPawn = Pawn(Other);
			LConductor.Initialize();
		}
	}
}

simulated function bool ValidTarget(Pawn Other)
{
	local byte Team, InTeam;
	Team = Instigator.Controller.GetTeamNum();
	InTeam = Other.Controller.GetTeamNum();
	
	//true check
	
	/*if(Other != None && Other.bProjTarget && Other.Controller != None && Level.TimeSeconds - Other.SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime && (InTeam == 255 || InTeam != Team))
		return true;*/
	
	//test check - works on uncontrolled pawns
	
	if(Other != None && Other.bProjTarget && Level.TimeSeconds - Other.SpawnTime > DeathMatch(Level.Game).SpawnProtectionTime && (InTeam == 255 || InTeam != Team))
		return true;
	
	return false;
}

defaultproperties
{
	 LightningSound=(Sound=Sound'BWBPJiffyPackSounds.Lightning.LightningGunCrackle',Volume=0.800000,Radius=1024.000000,Pitch=1.000000,bNoOverride=True)
     TraceRange=(Min=30000.000000,Max=30000.000000)
     WaterRangeFactor=0.800000
     MaxWallSize=48.000000
     MaxWalls=1
     Damage=35.000000
     DamageHead=55.000000
     DamageLimb=23.000000
     WaterRangeAtten=0.800000
     DamageType=Class'BallisticJiffyPack.DT_LightningRifle'
     DamageTypeHead=Class'BallisticJiffyPack.DT_LightningHead'
     DamageTypeArm=Class'BallisticJiffyPack.DT_LightningRifle'
     KickForce=6000
     PDamageFactor=0.800000
     bCockAfterFire=True
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
     FireRate=0.300000
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

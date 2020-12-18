//=============================================================================
// CYLO Mk2 UAW
//
// The upgraded version of the CYLO Urban Assault Rifle. Fires incendiary rounds instead of the normals.
// Has blade as secondary.
// The gun can overheat with use and will jam and damage the player if heat is too high.
// When the gun is overheated it does more damage.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class CYLOAssaultWeapon extends CYLOUAW;

//Heating
var float				HeatLevel;					// Current Heat level, duh...
var bool				bCriticalHeat;				// Heat is at critical levels
var float 				HeatDeclineDelay;		
var() Sound				OverHeatSound;				// Sound to play when it overheats
var() Sound				HighHeatSound;				// Sound to play when heat is dangerous
var() Sound				MedHeatSound;				// Sound to play when heat is moderate
var Actor 				GlowFX;						// Code from the BFG.
var float				NextChangeMindTime;			// For AI

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientOverCharge, ClientSetHeat;
}

simulated function PostBeginPlay()
{
	Super(BallisticWeapon).PostBeginPlay();
}

simulated function ClientOverCharge()
{
	if (Firemode[0].bIsFiring)
		StopFire(1);
}

// Heat stuff
simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (HeatLevel >= 7 && Instigator.IsLocallyControlled() && GlowFX == None && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'CYLOFirestormRedGlow', DrawScale, self, 'tip');
	else if (HeatLevel < 7)
	{
		if (GlowFX != None)
			Emitter(GlowFX).kill();
	}
}

simulated function float ChargeBar()
{
	return HeatLevel / 12;
}

simulated event Tick (float DT)
{
	if (HeatLevel > 0 && Level.TimeSeconds > LastFireTime + HeatDeclineDelay)
		Heatlevel = FMax(HeatLevel - 6 * DT, 0);

	super.Tick(DT);
}

simulated function AddHeat(float Amount)
{
	if (bBerserk)
		Amount *= 0.75;

	HeatLevel += Amount;
	
	if (HeatLevel >= 11.75)
	{
		Heatlevel = 12;
		PlaySound(OverHeatSound,,3.7,,32);
		if (Instigator.Physics != PHYS_Falling)
			class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTCYLOFirestormOverheat');
		else class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, vect(0,0,0), class'DTCYLOFirestormOverheat');
		return;
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    local int m;
    local weapon w;
    local bool bPossiblySwitch, bJustSpawned;

    Instigator = Other;
    W = Weapon(Other.FindInventoryType(class));
    if ( W == None )
    {
		bJustSpawned = true;
        Super(Inventory).GiveTo(Other);
        bPossiblySwitch = true;
        W = self;
		if (Pickup != None && BallisticWeaponPickup(Pickup) != None)
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		if (CYLOFirestormPickup(Pickup) != None)
			HeatLevel = FMax( 0.0, CYLOFirestormPickup(Pickup).HeatLevel - (level.TimeSeconds - CYLOFirestormPickup(Pickup).HeatTime) * 2.55 );
		if (level.NetMode == NM_ListenServer || level.NetMode == NM_DedicatedServer)
			ClientSetHeat(HeatLevel);
    }
    else if ( !W.HasAmmo() )
	    bPossiblySwitch = true;

    if ( Pickup == None )
        bPossiblySwitch = true;

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if ( FireMode[m] != None )
        {
            FireMode[m].Instigator = Instigator;
            GiveAmmo(m,WeaponPickup(Pickup),bJustSpawned);
        }
    }
	
	if (MeleeFireMode != None)
		MeleeFireMode.Instigator = Instigator;

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect (GlowFX);
	super.Timer();
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 1;

	if (HeatLevel > 10)
		return 1;
		
	if (AmmoAmount(1) < 1)
		return 0;
		
	else if (MagAmmo < 1)
		return 1;
		
	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	if (Dist < 512)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	
	local float Dist;
	local float Rating;

	B = Bot(Instigator.Controller);
	
	if ( B == None )
		return AIRating;

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	// danger close
	if (Dist < 256)
		return 0.2;
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, BallisticRangeAttenFire(BFireMode[0]).CutOffStartRange, BallisticRangeAttenFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

simulated function Notify_BrassOut()
{
//	BFireMode[0].EjectBrass();
}

defaultproperties
{
	HeatDeclineDelay=0.200000
	OverheatSound=Sound'PackageSounds4Pro.CYLO.CYLO-OverHeat'
	HighHeatSound=Sound'PackageSounds4Pro.CYLO.CYLO-HighHeat'
	MedHeatSound=Sound'PackageSounds4Pro.CYLO.CYLO-MedHeat'
	bWT_Hazardous=True
	BigIconMaterial=Texture'BallisticRecolors3TexPro.CYLO.BigIcon_CYLOMk2'
	ManualLines(0)="Automatic explosive round fire. While these rounds completely lack any penetrative ability, they explode on impact with players, dealing 70% of their base damage to nearby targets. This makes the CYLO Firestorm V effective against groups of players."
	ManualLines(1)="Melee attack. The damage of this attack increases to its maximum over 1.5 seconds of holding the altfire key. It inflicts more damage on a backstab."
	ManualLines(2)="Not recommended for close range use as its explosive rounds can damage the user. Effective at medium range."
	SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.2;0.7;0.4")
	MeleeFireClass=Class'BWBPRecolorsPro.CYLOFirestormMeleeFire'
	WeaponModes(1)=(bUnavailable=True)
	SightPivot=(Pitch=900)
	SightOffset=(X=15.000000,Y=13.565000,Z=24.785000)
	bNoCrosshairInScope=True
	GunLength=16.500000
	ParamsClass=Class'CYLOFirestormWeaponParams' 
	FireModeClass(0)=Class'BWBPRecolorsPro.CYLOFirestormPrimaryFire'
	FireModeClass(1)=Class'BWBPRecolorsPro.CYLOFirestormSecondaryFire'
	bShowChargingBar=True
	Description="The CYLO Firestorm V is an upgraded version of Dipheox's most popular weapon. The V has been redesigned from the ground up for maximum efficiency and can now chamber the fearsome 5.56mm incendiary rounds. Upgrades to the ammo feed and clip lock greatly reduce the chance of jams and ensures a more stable rate of fire, however these have been known to malfunction under excessive stress. Likewise, prolonged use of the incendiary ammunition should be avoided due to potential damage to the barrel and control mechanisms.||While not as versatile as its shotgun equipped cousin, the CYLO Firestorm is still very deadly in urban combat. Proper training with the bayonet can turn the gun itself into a deadly melee weapon."
	HudColor=(G=50)
	GroupOffset=9
	AIRating=0.7
	CurrentRating=0.7
	PickupClass=Class'BWBPRecolorsPro.CYLOFirestormPickup'
	AttachmentClass=Class'BWBPRecolorsPro.CYLOFirestormAttachment'
	IconMaterial=Texture'BallisticRecolors3TexPro.CYLO.SmallIcon_CYLOMk2'
	ItemName="CYLO Firestorm V"
	Mesh=SkeletalMesh'BallisticRecolors4AnimPro.CYLOFirestorm_FP'
}

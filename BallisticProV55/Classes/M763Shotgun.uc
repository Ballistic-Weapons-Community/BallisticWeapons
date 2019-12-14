//=============================================================================
// M763Shotgun.
//
// The M763 pump-action shotgun, aka the Avenger
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class M763Shotgun extends BallisticProShotgun;

var M763GasControl GC;
var bool bAltLoaded;

var Name SingleLoadAnim;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerLoadShell;
}

function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,0);
    Canvas.DrawText("bNeedCock: "$bNeedCock$", bAltLoaded: "$bAltLoaded);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	GC = Spawn(class'M763GasControl', self);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	GunLength = default.GunLength;
}

simulated function Notify_CockStart()
{
	if (ReloadState == RS_None)	return;
		ReloadState = RS_Cocking;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated event AnimEnded (int Channel, name anim, float frame, float rate) 
{
	if (MeleeFireMode != None && anim == MeleeFireMode.FireAnim)
	{
		if (MeleeState == MS_StrikePending)
			MeleeState = MS_Pending;
		else MeleeState = MS_None;
		ReloadState = RS_None;
		if (Role == ROLE_Authority)
			bServerReloading=False;
		bPreventReload=false;
	}
	
	//Phase out Channel 1 if a sight fire animation has just ended.
	if (anim == BFireMode[0].AimedFireAnim || anim == BFireMode[1].AimedFireAnim)
	{
		AnimBlendParams(1, 0);
		//Cut the basic fire anim if it's too long.
		if (SightingState > FireAnimCutThreshold && SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
		bPreventReload=False;
	}

	// Modified stuff from Engine.Weapon
	if ((ClientState == WS_ReadyToFire || (ClientState == WS_None && Instigator.Weapon == self)) && ReloadState == RS_None)
    {
		if (MeleeState < MS_Held)
			bPreventReload=false;
		if (Channel == 0 && (bNeedReload || ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))) && MeleeState < MS_Held)
			PlayIdle();
    }
	// End stuff from Engine.Weapon

	if (ReloadState == RS_None)
		return;
	
	// Start Shovel ended, move on to Shovel loop
	else if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	else if (ReloadState == RS_PostShellIn)
	{
		if (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1 )
		{
			PlayShovelEnd();
			ReloadState = RS_EndShovel;
			return;
		}
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// End of reloading, either cock the gun or go to idle
	else if (ReloadState == RS_EndShovel)
	{
		if (bNeedCock && MagAmmo > 0)
			CommonCockGun();
		else
		{
			bNeedCock=false;
			ReloadState = RS_None;
			ReloadFinished();
			PlayIdle();
			ReAim(0.05);
		}
		return;
	}
	//Cock anim ended, goto idle
	else if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		
		if (Anim == SingleLoadAnim)
			bAltLoaded = True;
		
		else
			bAltLoaded=False;
		
		PlayIdle();
		ReAim(0.05);
	}
	
	else if (ReloadState == RS_GearSwitch)
	{
		if (Role == ROLE_Authority)
			bServerReloading=false;
		ReloadState = RS_None;
		PlayIdle();
	}
}

simulated function float RateSelf()
{
	if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount <=0 && MagAmmo <= 0)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
	return CurrentRating;
}

// Fire pressed. Change weapon if out of ammo, reload if empty mag or skip reloading if possible
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (F == 0 && bNeedReload && ClientState == WS_ReadyToFire)
		return;
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	
	if (F == 0)
	{
		if (reloadState == RS_None && (bNeedCock || bAltLoaded) && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
		{
			CommonCockGun();
			if (Level.NetMode == NM_Client)
				ServerCockGun();
		}
	}
		
	else if(ReloadState == RS_None && !bAltLoaded && HasNonMagAmmo(1) && !IsFiring() && Level.TimeSeconds > FireMode[1].NextFireTime)
	{
		CommonLoadShell();
		if (Level.NetMode == NM_Client)
			ServerLoadShell();
	}
}

simulated function CommonLoadShell()
{
	if (Role == ROLE_Authority)
		bServerReloading=true;
	ReloadState = RS_Cocking;
	if (CurrentWeaponMode==0)
		PlayAnim(SingleLoadAnim,1.6, 0.0);
}

function ServerLoadShell()
{
	CommonLoadShell();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 250)
		return 0;
	if (Dist < FireMode[1].MaxRange() && FRand() > 0.3)
		return 1;
	if (vector(B.Enemy.Rotation) dot Normal(Dir) < 0.0 && (VSize(B.Enemy.Velocity) < 100 || Normal(B.Enemy.Velocity) dot Normal(Instigator.Velocity) < 0.5))
		return 1;
	return Rand(2);
}

function GiveTo(Pawn Other, optional Pickup Pickup)
{
	Super.GiveTo(Other, Pickup);
	
	if (GC != None)
		GC.Instigator = Other;
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.35, Dist, BallisticProShotgunFire(BFireMode[0]).CutOffStartRange, BallisticProShotgunFire(BFireMode[0]).CutOffDistance); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 0.5;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
	return -0.5;
}

// End AI Stuff =====

simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");
}

// Animation notify for when cocking action starts. Used to time sounds
simulated function Notify_CockAimed()
{
	bNeedCock = False;
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Destroyed()
{
	if (GC.Clouds.Length == 0)
		GC.Destroy();
	Super.Destroyed();
}

defaultproperties
{
     SingleLoadAnim="LoadSingle"
     TeamSkins(0)=(RedTex=Shader'BallisticWeapons2.Hands.RedHand-Shiny',BlueTex=Shader'BallisticWeapons2.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BallisticUI2.Icons.BigIcon_M763'
     BigIconCoords=(Y1=35,Y2=230)
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Shotgun=True
     ManualLines(0)="Long-ranged shotgun fire. Tight spread, good damage and moderate fire rate. Sustained damage output is lower than that of shorter-ranged shotguns."
     ManualLines(1)="Loads a gas shell. Once loaded, the gas shell can be fired, generating a linear cloud of toxic gas in front of the weapon. Anyone standing in this cloud will receive damage over time."
     ManualLines(2)="Has a melee attack. The damage of the attack increases the longer altfire is held, up to 1.5 seconds for maximum damage output. As a blunt attack, has lower base damage compared to bayonets but inflicts a short-duration blinding effect when striking. This attack inflicts more damage from behind.||As a shotgun, has poor penetration.||Most effective at medium range."
     SpecialInfo(0)=(Info="120.0;20.0;0.7;50.0;0.0;0.5;0.0")
     MeleeFireClass=Class'BallisticProV55.M763MeleeFire'
     BringUpSound=(Sound=Sound'BallisticSounds2.M763.M763Pullout')
     PutDownSound=(Sound=Sound'BallisticSounds2.M763.M763Putaway')
	 PutDownAnimRate=1.5
	 PutDownTime=0.35
     MagAmmo=7
     CockAnimRate=1.700000
     CockSound=(Sound=Sound'BallisticSounds2.M763.M763Cock1')
     ReloadAnim="ReloadLoop"
     ReloadAnimRate=1.100000
     ClipInSound=(Sound=Sound'BallisticSounds2.M763.M763LoadShell1')
     ClipInFrame=0.375000
     bCockOnEmpty=True
     bCanSkipReload=True
     bAltTriggerReload=True
     bShovelLoad=True
     StartShovelAnim="ReloadStart"
     StartShovelAnimRate=1.100000
     EndShovelAnim="ReloadEnd"
     EndShovelEmptyAnim="ReloadEndEmpty"
     EndShovelAnimRate=1.100000
     WeaponModes(0)=(ModeName="Single Fire")
     WeaponModes(1)=(bUnavailable=True)
     WeaponModes(2)=(bUnavailable=True)
     CurrentWeaponMode=0
     SightPivot=(Pitch=32)
     SightOffset=(X=5.000000,Z=11.500000)
     SightDisplayFOV=40.000000
     SightingTime=0.300000
     GunLength=48.000000
     SprintOffSet=(Pitch=-1000,Yaw=-2048)
     AimSpread=0
     ChaosDeclineTime=0.750000
     ChaosSpeedThreshold=850.000000
     ChaosAimSpread=0
     RecoilXCurve=(Points=(,(InVal=0.200000,OutVal=-0.150000),(InVal=0.300000,OutVal=0.050000),(InVal=0.650000,OutVal=-0.350000),(InVal=0.800000,OutVal=0.100000),(InVal=1.000000)))
     RecoilYCurve=(Points=(,(InVal=0.150000,OutVal=0.100000),(InVal=0.250000,OutVal=0.400000),(InVal=0.600000,OutVal=0.700000),(InVal=1.000000,OutVal=1.000000)))
     RecoilXFactor=0.300000
     RecoilYFactor=0.200000
     RecoilMinRandFactor=0.350000
     RecoilDeclineTime=1.500000
     RecoilDeclineDelay=0.800000
     FireModeClass(0)=Class'BallisticProV55.M763PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.M763SecondaryFire'
     AIRating=0.750000
     CurrentRating=0.750000
     Description="The Avenger single barreled shotgun is the standard spread weapon of the UTC infantry divisions. Its high damage, reliability and good range for a shotgun have made this gun one of the humans' favourites; the M763 has blown open more Krao drones than can be counted. After its many successes, even during trials by the UTC's Reunited Jamaican Army, defending from wave upon wave of Krao minions during the 'Red Storm' Skrith invasion, the Avenger became the standard issue shotgun and a favorite of many forces including the UTC RJA Division."
     Priority=37
     HudColor=(B=255,R=200)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=7
     GroupOffset=2
     PickupClass=Class'BallisticProV55.M763Pickup'
     PlayerViewOffset=(Y=12.000000,Z=-12.000000)
     AttachmentClass=Class'BallisticProV55.M763Attachment'
     IconMaterial=Texture'BallisticUI2.Icons.SmallIcon_M763'
     IconCoords=(X2=127,Y2=31)
     ItemName="M763 Shotgun"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=25
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=5.000000
     Mesh=SkeletalMesh'BallisticProAnims.M763_FP'
     DrawScale=0.500000
}

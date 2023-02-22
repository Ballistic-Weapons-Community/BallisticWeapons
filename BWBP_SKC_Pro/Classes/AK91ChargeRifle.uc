//=============================================================================
// AK91ChargeRifle.
//
// A dangerously reverse engineered amp/supercharger gun.
// Primary fire does damage, increases gun heat, and supercharges enemies.
// At high heat, use alt fire to fire a supercharger blast! This'll blow them up...
// ...and probably you too.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class AK91ChargeRifle extends BallisticWeapon;

//Gun Heat
var float		HeatLevel, MaxHeatLevel; // Current Heat level, duh...
var() Sound		OverHeatSound;		// Sound to play when it overheats
var() Sound		HighHeatSound;		// Sound to play when heat is dangerous
var Actor GlowFX;

var   Emitter		LaserDot;
var   bool			bLaserOn;
var bool		bFirstDraw;

var name			BulletBone;
var name			BulletBone2;

var   Supercharger_ChargeControl	ChargeControl;

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat, ChargeControl;
}


// ====================================
// Heat stuff
//=====================================

simulated function float ChargeBar()
{
	return HeatLevel / MaxHeatLevel;
}
simulated event Tick (float DT)
{
	if (HeatLevel > 0)
	{
		Heatlevel = FMax(HeatLevel - 0.35 * DT, 0);
	}

	super.Tick(DT);
}


simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (HeatLevel >= 5 && Instigator.IsLocallyControlled() && GlowFX == None && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'HMCBarrelGlow', DrawScale, self, 'LAM');
		//class'BUtil'.static.InitMuzzleFlash (GlowFX, class'HMCBarrelGlow', DrawScale, self, 'tip3');
	else if (HeatLevel < 5)
	{
		if (GlowFX != None)
			Emitter(GlowFX).kill();
	}
	
//	if (GlowFX != None)
//		HMCBarrelGlow(GlowFX).ScaleEmitter(HMCBarrelGlow(GlowFX),HeatLevel/10);

}

simulated function AddHeat(float Amount)
{
	HeatLevel = FClamp(HeatLevel + Amount, 0, MaxHeatLevel);
	AK91PrimaryFire(FireMode[0]).FireRate = AK91PrimaryFire(FireMode[0]).Params.FireInterval;
	
	if (HeatLevel >= 9.5)
	{
		AK91PrimaryFire(FireMode[0]).FireRate *= 1.5;
	}
	
	if (HeatLevel >= 5.0)
	{
		PlaySound(HighHeatSound,,1.0*(HeatLevel/10),,32);
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
		if (AK91Pickup(Pickup) != None)
			HeatLevel = FMax( 0.0, AK91Pickup(Pickup).HeatLevel - (level.TimeSeconds - AK91Pickup(Pickup).HeatTime) * 0.25 );
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

	if ( (Instigator.Weapon != None) && Instigator.Weapon.IsFiring() )
		bPossiblySwitch = false;

	if ( Instigator.Weapon != W )
		W.ClientWeaponSet(bPossiblySwitch);

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

//==========================================
// Supercharging stuff
//==========================================


simulated function PostNetBeginPlay()
{
	local Supercharger_ChargeControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && ChargeControl == None)
	{
		foreach DynamicActors (class'Supercharger_ChargeControl', FC)
		{
			ChargeControl = FC;
			return;
		}
		ChargeControl = Spawn(class'Supercharger_ChargeControl', None);
	}
}

function Supercharger_ChargeControl GetChargeControl()
{
	return ChargeControl;
}

//==========================================
function ConicalBlast(float DamageAmount, float DamageRadius, vector Aim)
{
	local actor Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry )
		return;

	bHurtEntry = true;
	foreach CollidingActors( class 'Actor', Victims, DamageRadius, Location )
	{
		if( (Victims != Instigator) && (Victims.Role == ROLE_Authority) && (!Victims.IsA('FluidSurfaceInfo')) )
		{
			if ( Aim dot Normal (Victims.Location - Location) < 0.5)
				continue;

			if (!FastTrace(Victims.Location, Location))
				continue;

			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));

			log("HeatLevel is  "$HeatLevel);
			log("HeatLevel int is  "$int(HeatLevel));
			dir = dir/dist;
			//damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				DamageAmount * int(Heatlevel),
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				vect(0,0,0),
				class'DT_AK91Zapped'
			);

			if (Pawn(Victims) != None)
			{
				ChargeControl.FireSinge(Pawn(Victims), Instigator, 2, int(HeatLevel)); //The 2 designates this weapon is an AK91, used for death messages, adds HeatLevel # of zaps
				if ( Pawn(Victims).bProjTarget)
					Pawn(Victims).AddVelocity(vect(0,0,200) + (Normal(Victims.Acceleration) * -FMin(Pawn(Victims).GroundSpeed, VSize(Victims.Velocity)) + Normal(dir) * 3000 * damageScale));
			}

			if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, class'DT_AK91Zapped', 0.0f, Location);
		}
	}
	bHurtEntry = false;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'Fire' || Anim == 'ReloadEmpty')
	{
		if (MagAmmo - BFireMode[0].ConsumedLoad < 2)
		{
			SetBoneScale(2,0.0,BulletBone);
			SetBoneScale(3,0.0,BulletBone2);
		}
	}
	super.AnimEnd(Channel);
}



simulated function BringUp(optional Weapon PrevWeapon)
{

	if (bFirstDraw && MagAmmo > 0)
	{
     	BringUpTime=2.0;
     	SelectAnim='PulloutFancy';
		bFirstDraw=false;
	}
	else
	{
     	BringUpTime=default.BringUpTime;
		SelectAnim='Pullout';
	}

	if (MagAmmo - BFireMode[0].ConsumedLoad < 1)
	{

		SetBoneScale(2,0.0,BulletBone);
		SetBoneScale(3,0.0,BulletBone2);
		ReloadAnim = 'ReloadEmpty';
	}
	else
	{
		ReloadAnim = 'Reload';
	}

	super.BringUp(PrevWeapon);
	SoundPitch = 56;

}

simulated function Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();
	super.Destroyed();
}


simulated function PlayCocking(optional byte Type)
{
	if (Type == 2)
		PlayAnim('ReloadEndCock', CockAnimRate, 0.2);
	else
		PlayAnim(CockAnim, CockAnimRate, 0.2);
}


simulated function PlayReload()
{
    if (MagAmmo < 1)
    {
       ReloadAnim='ReloadEmpty';
    }
    else
    {
       ReloadAnim='Reload';
    }

	SafePlayAnim(ReloadAnim, ReloadAnimRate, , 0, "RELOAD");
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipUp()
{
	SetBoneScale(2,1.0,BulletBone);
	SetBoneScale(3,1.0,BulletBone2);
}

simulated function Notify_ClipOut()
{
	Super.Notify_ClipOut();

	if(MagAmmo < 1)
	{
	SetBoneScale(2,0.0,BulletBone);
	SetBoneScale(3,0.0,BulletBone2);
	}
}



simulated function float RateSelf()
{
	if (!HasAmmo())
		CurrentRating = 0;
	else if (Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Instigator.Controller.RateWeapon(self)*0.3;
	else
		return Super.RateSelf();
	return CurrentRating;
}
// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	/*if (B.Skill > Rand(6))
	{
		if (Chaos < 0.1 || Chaos < 0.5 && VSize(B.Enemy.Location - Instigator.Location) > 500)
			return 1;
	}*/
	else if (FRand() > 0.75)
		return 1;
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Result, Dist;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);

	Result = Super.GetAIRating();
	if (Dist < 500)
		Result -= 1-Dist/500;
	else if (Dist < 3000)
		Result += (Dist-1000) / 2000;
	else
		Result = (Result + 0.66) - (Dist-3000) / 2500;
	if (Result < 0.34)
	{
		if (CurrentWeaponMode != 2)
		{
			CurrentWeaponMode = 2;
		}
	}

	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.0;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

defaultproperties
{
     bShowChargingBar=True
	 MaxHeatLevel=10
     OverHeatSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
	 HighHeatSound=Sound'BWBP_SKC_Sounds.Misc.CXMS-FireSingle'
     UsedAmbientSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     AIReloadTime=1.000000
     BigIconMaterial=Texture'BWBP_SKC_Tex.AK91.BigIcon_AK91'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     BulletBone="Bullet1"
     BulletBone2="Bullet2"
     bWT_Bullet=True
     SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.5;0.8;0.0")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
     MagAmmo=30
     CockAnimPostReload="ReloadEndCock"
     CockSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-Cock',Volume=1.500000)
     ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipHit',Volume=1.500000)
     ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipOut',Volume=1.500000)
     ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.AK47.AK47-ClipIn',Volume=1.500000)
     ClipInFrame=0.650000
     bNeedCock=False
     bCockOnEmpty=False
     bNoCrosshairInScope=True
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(ModeName="Semi-Auto",ModeID="WM_SemiAuto",Value=1.000000)
     CurrentWeaponMode=2
     SightPivot=(Pitch=64)
     SightOffset=(X=-5.000000,Y=-10.020000,Z=20.600000)
     SightDisplayFOV=20.000000
	 ParamsClasses(0)=Class'AK91WeaponParamsArena'
	 ParamsClasses(1)=Class'AK91WeaponParamsClassic'
	 ParamsClasses(2)=Class'AK91WeaponParamsRealistic'
     SightingTime=0.300000
     FireModeClass(0)=Class'BWBP_SKC_Pro.AK91PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.AK91SecondaryFire'
	 NDCrosshairCfg=(Pic1=None,Pic2=None,USize1=128,VSize1=128,USize2=128,VSize2=128,Color1=(B=0,G=0,R=255,A=255),Color2=(B=0,G=255,R=255,A=255),StartSize1=96,StartSize2=96)
	 NDCrosshairInfo=(SpreadRatios=(X1=0.500000,Y1=0.500000,X2=0.500000,Y2=0.750000),SizeFactors=(X1=1.000000,Y1=1.000000,X2=1.000000,Y2=1.000000),MaxScale=4.000000,CurrentScale=0.000000)
     BringUpTime=0.900000
     PutDownTime=0.700000
	 CockingBringUpTime=2.000000
     IdleAnimRate=0.400000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
	 //Description=""War, war never changes. But technology does as the fight against the Skrith wages on, cultivated in various weapon research facilities across the galaxies.  While some built from the ground up, others have been reverse engineered from the enemy factions. Most of them work after hard work and dedication, then there's ZTV Exports.  Legendary for their reliable and hard hitting weapons, but even they need to catch up in the arms race. Against their code of ethics, the brilliant minds at ZTV somehow managed to reverse engineer the AMP system and slap it onto their older AK91 models, causing it to hit much harder than before.  However, they also found that it can be overloaded with unstable energy particles that can severely harm the user unless they somehow purge it.  With the war raging on, ZTV Exports are willing to risk the chance in order to save the motherland.""
     Description="AK-91 Charge Rifle||Manufacturer: Zavod Tochnogo Voorujeniya (ZTV Export)|Primary: 7.62 AP Rounds|Secondary: Emergency Vent||The AK-91 was designed by ZTV using reverse-engineered amplifier technology to augment the power of their existing AK-490 design. The amp works, but not without its drawbacks, it stores dangerous amounts of charge in an emergency capacitor that must be purged periodically to keep the weapon from catastrophically overheating."
     Priority=65
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
	 GroupOffset=11
     PickupClass=Class'BWBP_SKC_Pro.AK91Pickup'
     PlayerViewOffset=(X=5.000000,Y=7.000000,Z=-13.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKC_Pro.AK91Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.AK91.SmallIcon_AK91'
     IconCoords=(X2=127,Y2=31)
     ItemName="AK-91 Charge Rifle"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_AK91'
     DrawScale=0.350000
     SoundPitch=56
     SoundRadius=32.000000
}

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
class CYLOFirestormAssaultWeapon extends BallisticWeapon;

//Heating
var	bool			bVariableHeatProps;				// Heat changes weapon properties, used in Classic
var float			HeatLevel;					// Current Heat level, duh...
var bool			bCriticalHeat;				// Heat is at critical levels
var float 			HeatDeclineDelay;		
var() Sound			OverHeatSound;				// Sound to play when it overheats
var() Sound			HighHeatSound;				// Sound to play when heat is dangerous
var() Sound			MedHeatSound;				// Sound to play when heat is moderate
var Actor 			GlowFX;						// Code from the BFG.
var float			NextChangeMindTime;			// For AI

var() sound			MeleeFireSound;

var	bool			bAltNeedCock;			//Should SG cock after reloading
var	bool			bReloadingShotgun;	//Used to disable primary fire if reloading the shotgun
var() name			ShotgunLoadAnim, ShotgunEmptyLoadAnim;
var() name			ShotgunSGAnim;
var() name			CockSGAnim;
var() Sound			TubeOpenSound;
var() Sound			TubeInSound;
var() Sound			TubeCloseSound;
var() int	     	SGShells;
var byte			OldWeaponMode;
var() float			GunCockTime;		// Used so players cant interrupt the shotgun.

replication
{
	reliable if (Role == ROLE_Authority)
	    SGShells;
	reliable if (ROLE==ROLE_Authority)
		ClientOverCharge, ClientSetHeat;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (BCRepClass.default.GameStyle == 1)
	{
		bVariableHeatProps=true;
	}
}



function AdjustPlayerDamage( out int Damage, Pawn InstigatedBy, Vector HitLocation, out Vector Momentum, class<DamageType> DamageType)
{
	if (MeleeState >= MS_Held)
		Momentum *= 0.5;
	
	super.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType);
}

simulated function DrawWeaponInfo(Canvas C)
{
	NewDrawWeaponInfo(C, 0.705*C.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;

	DrawCrosshairs(C);

	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 45 * ScaleFactor;
	
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(6,SGShells);
	
    for( i=0; i<Count; i++ )
    {
		C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		C.DrawTile( Texture'BWBP_SKC_Tex.CYLO.CYLO-SGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
	}
	
	if (bSkipDrawWeaponInfo)
		return;

	// Draw the spare ammo amount
	C.Font = GetFontSizeIndex(C, -2 + int(2 * class'HUD'.default.HudScale));
	C.DrawColor = class'hud'.default.WhiteColor;
	if (!bNoMag)
	{
		Temp = GetHUDAmmoText(0);
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 20 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(Temp, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 120 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 130 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
		C.DrawText(WeaponModes[CurrentWeaponMode].ModeName, false);
	}

	// This is pretty damn disgusting, but the weapon seems to be the only way we can draw extra info on the HUD
	// Would be nice if someone could have a HUD function called along the inventory chain
	if (SprintControl != None && SprintControl.Stamina < SprintControl.MaxStamina)
	{
		SprintFactor = SprintControl.Stamina / SprintControl.MaxStamina;
		C.CurX = C.OrgX  + 5    * ScaleFactor * class'HUD'.default.HudScale;
		C.CurY = C.ClipY - 330  * ScaleFactor * class'HUD'.default.HudScale;
		if (SprintFactor < 0.2)
			C.SetDrawColor(255, 0, 0);
		else if (SprintFactor < 0.5)
			C.SetDrawColor(64, 128, 255);
		else
			C.SetDrawColor(0, 0, 255);
		C.DrawTile(Texture'Engine.MenuWhite', 200 * ScaleFactor * class'HUD'.default.HudScale * SprintFactor, 30 * ScaleFactor * class'HUD'.default.HudScale, 0, 0, 1, 1);
	}
}

//===========================================================================
// Shotgun handling.
//===========================================================================

//===========================================================================
// EmptyFire
//
// Cock shotgun if alt and needs cocking
//===========================================================================
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		//Do nothing!
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn) || (ReloadState == RS_PreClipOut)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	//mod
	else 
	{
		if (F == 0)
		{
			if (ReloadState == RS_None && bNeedCock && !bPreventReload && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
			{
				CommonCockGun(0);
				if (Level.NetMode == NM_Client)
					ServerCockGun(0);
			}
		}
		else if (ReloadState == RS_None && bAltNeedCock && !bPreventReload && SGShells > 0 && !IsFiring() && Level.TimeSeconds > FireMode[1].NextFireTime)
		{
			CommonCockGun(5);
			if (Level.NetMode == NM_Client)
				ServerCockGun(5);
		}
	}
}

//===========================================================================
// PlayCocking
//
// Cocks shotgun on 5
//===========================================================================
simulated function PlayCocking(optional byte Type)
{
	if (Type == 2 && HasAnim(CockAnimPostReload))
		SafePlayAnim(CockAnimPostReload, CockAnimRate, 0.2, , "RELOAD");
	else if (Type == 5)
		SafePlayAnim(CockSGAnim, CockAnimRate, 0.2, , "RELOAD");
	else
		SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None)
		TemporaryScopeDown(default.SightingTime);
}

//===========================================================================
// Reload notifies
//===========================================================================
simulated function Notify_TubeSlideOut()	
{	
	PlaySound(TubeOpenSound, SLOT_Misc, 0.5, ,64);	
	ReloadState = RS_PreClipIn;
}
simulated function Notify_TubeIn()          
{   
	local int AmmoNeeded;
	
	PlaySound(TubeInSound, SLOT_Misc, 0.5, ,64);    
	ReloadState = RS_PostClipIn; 
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.SGShells-SGShells;
		if (AmmoNeeded > Ammo[1].AmmoAmount)
			SGShells+=Ammo[1].AmmoAmount;
		else
			SGShells = default.SGShells;   
		Ammo[1].UseAmmo (AmmoNeeded, True);
	}
}
simulated function Notify_TubeSlideIn()	    
{	
	PlaySound(TubeCloseSound, SLOT_Misc, 0.5, ,64);	
}
simulated function Notify_SGCockEnd()	
{
	bAltNeedCock=false;
	ReloadState = RS_GearSwitch;					
}

simulated function bool IsReloadingShotgun()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == ShotgunLoadAnim)
 		return true;
	return false;
}

function bool BotShouldReloadShotgun ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);
	
	if (anim == CockSGAnim || anim == ShotgunEmptyLoadAnim)
	{
		bAltNeedCock=False;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
	}
	else
		Super.AnimEnd(Channel);
}

//===========================================================================
// ServerStartReload
//
// byte 1 reloads the shotgun.
//===========================================================================
function ServerStartReload (optional byte i)
{
	local int m;
	local array<byte> Loadings[2];
	
	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;
	if (i == 0 && MagAmmo >= default.MagAmmo)
	{
		if (bNeedCock)
		{
			ServerCockGun(0);
			return;
		}
	}
	// Escape on full shells
	if (i == 1 && SGShells >= default.SGShells)
	{
		if (bAltNeedCock)
		{
			ServerCockGun(5);
			return;
		}
	}
	
	if (MagAmmo < default.MagAmmo && Ammo[0].AmmoAmount > 0)
		Loadings[0] = 1;
	if (SGShells < default.SGShells && Ammo[1].AmmoAmount > 0)
		Loadings[1] = 1;
	if (Loadings[0] == 0 && Loadings[1] == 0)
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;
	
	if (i == 1)
		m = 0;
	else m = 1;
	
	if (BallisticAttachment(ThirdPersonActor) != None && BallisticAttachment(ThirdPersonActor).ReloadAnim != '')
		Instigator.SetAnimAction('ReloadGun');
		
	if (Loadings[i] == 1)
	{
		ClientStartReload(i);
		CommonStartReload(i);
	}
	
	else if (Loadings[m] == 1)
	{
		ClientStartReload(m);
		CommonStartReload(m);
	}
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1)
			CommonStartReload(1);
		else
			CommonStartReload(0);
	}
}

// Prepare to reload, set reload state, start anims. Called on client and server
simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_PreClipOut;
		PlayReloadAlt();
	}
	else
	{
		ReloadState = RS_PreClipOut;
		PlayReload();
	}

	if (bScopeView && Instigator.IsLocallyControlled())
		TemporaryScopeDown(default.SightingTime);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].ReloadingGun(i);

	if (i == 0)
	{
		if (bCockAfterReload)
			bNeedCock=true;
		if (bCockOnEmpty && MagAmmo < 1)
			bNeedCock=true;
	}
	bNeedReload=false;
}

simulated function PlayReloadAlt()
{
	if (SGShells == 0)
		SafePlayAnim(ShotgunEmptyLoadAnim, 1, , 0, "RELOAD");
	else
		SafePlayAnim(ShotgunLoadAnim, 1, , 0, "RELOAD");
}

//===========================================================================
// Heat Code
//
//===========================================================================

simulated function ClientOverCharge()
{
	if (Firemode[0].bIsFiring)
		StopFire(1);
}

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
	
	if (AIController(Instigator.Controller) != None && bAltNeedCock && AmmoAmount(1) > 0 && BotShouldReloadShotgun() && !IsReloadingShotgun())
		ServerStartReload(1);
	
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
		PlaySound(OverHeatSound,,0.7,,32);
		if (Instigator.Physics != PHYS_Falling)
			class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTCYLOFirestormOverheat');
		else class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, vect(0,0,0), class'DTCYLOFirestormOverheat');
		return;
	}
	if (bVariableHeatProps)
	{
		if (HeatLevel >= 9.75 && HeatLevel < 10)
		{
			Heatlevel = 12;
			PlaySound(OverHeatSound,,0.7,,32);
			if (level.Netmode != NM_DedicatedServer )
				BallisticInstantFire(FireMode[0]).JamChance=0.35;
			class'BallisticDamageType'.static.GenericHurt (Instigator, 3, Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTCYLOFirestormOverheat');
		}

		if (HeatLevel >= 9.0)
		{
			PlaySound(HighHeatSound,,1.0,,32);
			if (level.Netmode != NM_DedicatedServer )
				BallisticInstantFire(FireMode[0]).JamChance=0.25;
			BallisticInstantFire(FireMode[0]).FireRate=0.305500;
			BallisticInstantFire(FireMode[0]).Damage = 35;
			BallisticInstantFire(FireMode[0]).MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter';
			BallisticInstantFire(FireMode[0]).DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormHot';
			BallisticInstantFire(FireMode[0]).DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormHotHead';
			BallisticInstantFire(FireMode[0]).DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormHot';
		}
		if (HeatLevel >= 6.0)
		{
			PlaySound(MedHeatSound,,0.7,,32);
			if (level.Netmode != NM_DedicatedServer )
				BallisticInstantFire(FireMode[0]).JamChance=0.1;
			BallisticInstantFire(FireMode[0]).FireRate=0.155500;
			BallisticInstantFire(FireMode[0]).Damage = 30;
			BallisticInstantFire(FireMode[0]).MuzzleFlashClass=Class'BWBP_SKC_Pro.CYLOFirestormHeatEmitter';
			BallisticInstantFire(FireMode[0]).DamageType=Class'BWBP_SKC_Pro.DTCYLOFirestormHot';
			BallisticInstantFire(FireMode[0]).DamageTypeHead=Class'BWBP_SKC_Pro.DTCYLOFirestormHotHead';
			BallisticInstantFire(FireMode[0]).DamageTypeArm=Class'BWBP_SKC_Pro.DTCYLOFirestormHot';
		}
		else
		{
			if (level.Netmode != NM_DedicatedServer )
				BallisticInstantFire(FireMode[0]).JamChance=0.002;
			BallisticInstantFire(FireMode[0]).Damage = BallisticInstantFire(FireMode[0]).default.Damage;
			BallisticInstantFire(FireMode[0]).MuzzleFlashClass = BallisticInstantFire(FireMode[0]).default.MuzzleFlashClass;
			BallisticInstantFire(FireMode[0]).FireRate = BallisticInstantFire(FireMode[0]).Params.FireInterval;
			BallisticInstantFire(FireMode[0]).DamageType = BallisticInstantFire(FireMode[0]).default.DamageType;
			BallisticInstantFire(FireMode[0]).DamageTypeHead = BallisticInstantFire(FireMode[0]).default.DamageTypeHead;
			BallisticInstantFire(FireMode[0]).DamageTypeArm = BallisticInstantFire(FireMode[0]).default.DamageTypeArm;
		}
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
	ShotgunLoadAnim="ReloadSG"
	ShotgunEmptyLoadAnim="ReloadSGEmpty"
	CockSGAnim="CockSG"
	TubeOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	TubeInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	TubeCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	SGShells=6
	HeatDeclineDelay=0.200000
	OverheatSound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-OverHeat'
	HighHeatSound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-HighHeat'
	MedHeatSound=Sound'BWBP_SKC_Sounds.CYLO.CYLO-MedHeat'
	ShotgunLoadAnim="ReloadSG"
	ShotgunEmptyLoadAnim="ReloadSGEmpty"
	CockSGAnim="CockSG"
	TubeOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	TubeInSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	TubeCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	SGShells=6
	bWT_Hazardous=True
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SKC_Tex.CYLO.BigIcon_CYLOMk4'
	BigIconCoords=(X1=16,Y1=30)
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
	ManualLines(0)="Automatic explosive round fire. While these rounds completely lack any penetrative ability, they explode on impact with players, dealing 70% of their base damage to nearby targets. This makes the CYLO Firestorm V effective against groups of players."
	ManualLines(1)="Melee attack. The damage of this attack increases to its maximum over 1.5 seconds of holding the altfire key. It inflicts more damage on a backstab."
	ManualLines(2)="Not recommended for close range use as its explosive rounds can damage the user. Effective at medium range."
	SpecialInfo(0)=(Info="240.0;25.0;0.9;80.0;0.2;0.7;0.4")
	MeleeFireClass=Class'BWBP_SKC_Pro.CYLOFirestormMeleeFire'
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	MagAmmo=22
	CockAnimPostReload="Cock"
	CockAnimRate=1.400000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-Cock',Volume=1.500000)
	ClipHitSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50ClipHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagOut',Volume=1.500000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.CYLO.Cylo-MagIn',Volume=1.500000)
	ClipInFrame=0.700000
	SightPivot=(Pitch=900)
	SightOffset=(X=15.000000,Y=13.565000,Z=24.785000)
	bNoCrosshairInScope=True
	GunLength=16.500000
	ParamsClasses(0)=Class'CYLOFirestormWeaponParams' 
	ParamsClasses(1)=Class'CYLOFirestormWeaponParamsClassic' 
	ParamsClasses(2)=Class'CYLOFirestormWeaponParamsRealistic' 
	FireModeClass(0)=Class'BWBP_SKC_Pro.CYLOFirestormPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.CYLOFirestormSecondaryFire'
	bShowChargingBar=True
	HudColor=(G=50)
	SelectAnimRate=2.000000
	PutDownAnimRate=1.600000
	PutDownTime=0.330000
	BringUpTime=0.450000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.7
	CurrentRating=0.750000
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Burst Fire",ModeID="WM_Burst",Value=3.000000,bUnavailable=True)
	Description="The CYLO Firestorm V is an upgraded version of Dipheox's most popular weapon. The V has been redesigned from the ground up for maximum efficiency and can now chamber the fearsome 5.56mm incendiary rounds. Upgrades to the ammo feed and clip lock greatly reduce the chance of jams and ensures a more stable rate of fire, however these have been known to malfunction under excessive stress. Likewise, prolonged use of the incendiary ammunition should be avoided due to potential damage to the barrel and control mechanisms.||While not as versatile as its shotgun equipped cousin, the CYLO Firestorm is still very deadly in urban combat. Proper training with the bayonet can turn the gun itself into a deadly melee weapon."
	DisplayFOV=55.000000
	Priority=41
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=4
	GroupOffset=9
	PickupClass=Class'BWBP_SKC_Pro.CYLOFirestormPickup'
	PlayerViewOffset=(X=8.000000,Z=-14.000000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_SKC_Pro.CYLOFirestormAttachment'
	IconMaterial=Texture'BWBP_SKC_Tex.CYLO.SmallIcon_CYLOMk4'
	IconCoords=(X2=127,Y2=31)
	ItemName="CYLO Firestorm V"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_CYLOFirestorm'
	DrawScale=0.400000
}

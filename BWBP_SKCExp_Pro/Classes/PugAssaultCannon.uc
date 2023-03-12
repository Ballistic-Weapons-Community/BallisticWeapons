//=========================================================
// Pug Assault Cannon.
//
// Powerful autocannon. Primary fires BOLT rounds capable of inflicting heavy
// damage. Secondary can load and blast FRAG-12 grenades with significant
// blast radius.
//
// Originally written by Sergeant_Kelly based on code by DarkCarnivour.
// Partially rewritten for online compatibility by Azarael.
//==========================================================
class PugAssaultCannon extends BallisticWeapon;

var() Sound		GrenOpenSound;		//Sounds for rocket reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//


var() Sound		CockSoundQuick;		//
var() Sound		CockSoundAlt;			//
var() Sound		CockSoundAltQ;		// Quick cocking sound


var() Name		SGPrepAnim;			//Anim for loading a rocket
var() Name		CockingAnim;			//Restated here so the guns can call it
var() Name		ShovelAnim;			//Anim for shovelling, separated from basic reload anim here.

var   int       VisGrenades;			//Rockets currently visible in tube.
var   int       Grenades;				//Rockets currently in the gun.
var   bool		bAltNeedCock;			//Weapon ready for alt fire
var   byte		ShellIndex;

replication
{
	// Things the server should send to the client.
	reliable if(Role==ROLE_Authority)
		Grenades;
	reliable if (Role < ROLE_Authority)
		ServerLoadFrag;
}

// Add extra Ballistic info to the debug readout
simulated function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
	super.DisplayDebug(Canvas, YL, YPos);

    Canvas.SetDrawColor(255,128,0);
    Canvas.DrawText("bNeedCock: "$bNeedCock$", bAltNeedCock: "$bAltNeedCock);
    YPos += YL;
    Canvas.SetPos(4,YPos);
}

//Now adds initial ammo in all cases
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    if ( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
		Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        if (Ammo[m] == None)
        {
            Ammo[m] = Spawn(FireMode[m].AmmoClass, instigator);
            Instigator.AddInventory(Ammo[m]);
        }
		//Dropped pickup, just add ammo
        if ((WP != None) && (WP.bDropped || WP.AmmoAmount[m] > 0))
			Ammo[m].AddAmmo(WP.AmmoAmount[m]);
		//else add initial complement
		//if was just spawned and (wasn't dropped or there's no pickup) and (firemodes don't match)
		else if (bJustSpawned && (WP==None || !WP.bDropped) && (m == 0 || FireMode[m].AmmoClass != FireMode[0].AmmoClass))
		{
			if (m == 1)
			{
				if(Ammo[m].InitialAmount > default.Grenades)
					Ammo[m].AddAmmo(Ammo[m].InitialAmount - Grenades);
			}
			
			else Ammo[m].AddAmmo(Ammo[m].InitialAmount);
		}
        Ammo[m].GotoState('');
	}
}


//===================
// HUD draw for grenades
//===================

simulated function DrawWeaponInfo(Canvas Canvas)
{
	NewDrawWeaponInfo(Canvas, 0.705*Canvas.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
	local int i,Count;
	local float ScaleFactor2;

	local float		ScaleFactor, XL, YL, YL2, SprintFactor;
	local string	Temp;
	local int	TempNum;
	
	DrawCrosshairs(C);
	
	//FRAG-12s not accounted for in alternative HUD.
	ScaleFactor = C.ClipX / 1600;
	ScaleFactor2 = 99 * C.ClipX/3200;
	C.Style = ERenderStyle.STY_Alpha;
	C.DrawColor = class'HUD'.Default.WhiteColor;
	Count = Min(3,Grenades);
	
	if (Grenades > 0)
	{
		C.SetPos(C.ClipX - 1 * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
		
		if (!bAltNeedCock)
		{
			C.DrawColor = class'HUD'.default.RedColor;
			C.DrawTile( Texture'BWBP_SKC_Tex.Bulldog.Bulldog-FRAGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
			C.DrawColor = class'HUD'.default.WhiteColor;
		}
			
		else C.DrawTile( Texture'BWBP_SKC_Tex.Bulldog.Bulldog-FRAGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
			
		if (Grenades > 1)
			for( i=1; i<Count; i++ )
			{
				C.SetPos(C.ClipX - (0.5*i+1) * ScaleFactor2, C.ClipY - 100 * ScaleFactor * class'HUD'.default.HudScale);
				C.DrawTile( Texture'BWBP_SKC_Tex.Bulldog.Bulldog-FRAGIcon',ScaleFactor2, ScaleFactor2, 0, 0, 128, 128);
			}
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
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(Temp, false);
	}
	if (Ammo[1] != None && Ammo[1] != Ammo[0])
	{
		TempNum = Ammo[1].AmmoAmount;
		C.TextSize(TempNum, XL, YL);
		C.CurX = C.ClipX - 160 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 140 * ScaleFactor * class'HUD'.default.HudScale - YL;
		C.DrawText(TempNum, false);
	}

	if (CurrentWeaponMode < WeaponModes.length && !WeaponModes[CurrentWeaponMode].bUnavailable && WeaponModes[CurrentWeaponMode].ModeName != "")
	{
		C.Font = GetFontSizeIndex(C, -3 + int(2 * class'HUD'.default.HudScale));
		C.TextSize(WeaponModes[CurrentWeaponMode].ModeName, XL, YL2);
		C.CurX = C.ClipX - 15 * ScaleFactor * class'HUD'.default.HudScale - XL;
		C.CurY = C.ClipY - 150 * ScaleFactor * class'HUD'.default.HudScale - YL2 - YL;
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

//==============================
// FRAG-12 management functions
//==============================

simulated function FragFired()
{
	if (Role == ROLE_Authority)
		Grenades--;
		
	//bAltNeedCock = True;
}

//=============================================
// Notifies
//=============================================

simulated function Notify_PugShellIn()
{
	if (ReloadState == RS_Shovel)
	{
		ReloadState = RS_PostShellIn;
		if (Role == ROLE_Authority)
		{
			Ammo[1].UseAmmo (1, True);
			Grenades += 1;
		}
		
		PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);
	}
}

simulated function Notify_CockStart()
{
	/*if (!bAltNeedCock)
	{	
		PlayOwnedSound(CockSoundQuick,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
		PugPrimaryFire(FireMode[0]).EjectFRAGBrass();
		IdleAnim='Idle';
		if (Role == ROLE_Authority)
			Grenades--;
	}*/
	
	PlayOwnedSound(CockSound.Sound,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_FRAG12LoadStart()
{
	PlayOwnedSound(CockSoundAlt,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

simulated function Notify_FRAG12LoadStartQuick()
{
	PlayOwnedSound(CockSoundAltQ,CockSound.Slot,CockSound.Volume,CockSound.bNoOverride,CockSound.Radius,CockSound.Pitch,CockSound.bAtten);
}

//============================
// End notifies
//============================

simulated function BringUp(optional Weapon PrevWeapon)
{
	VisGrenades=Grenades;
	ShellIndex = FMin(Grenades-1, 2);
	super.BringUp(PrevWeapon);
}

//============================
// Reloading
//============================

simulated event AnimEnded (int Channel, name anim, float frame, float rate) 
{
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
        if ( /*(FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) && */MeleeState < MS_Held)
			bPreventReload = false;
		/*if (Channel == 0)
			PlayIdle();*/
	}

	// End stuff from Engine.Weapon

	// Start Shovel ended, move on to Shovel loop
	if (ReloadState == RS_StartShovel)
	{
		ReloadState = RS_Shovel;
		PlayShovelLoop();
		return;
	}
	// Shovel loop ended, start it again
	// This is only applicable to the Altfire
	if (ReloadState == RS_PostShellIn)
	{
		if (Grenades >= 3 || Ammo[1].AmmoAmount < 1)
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
	if (ReloadState == RS_PostClipIn || ReloadState == RS_EndShovel)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		PlayIdle();
		AimComponent.ReAim(0.05);
		return;
	}
	
	//Cock anim ended, goto idle
	if (ReloadState == RS_Cocking)
	{
		bNeedCock=false;
		ReloadState = RS_None;
		ReloadFinished();
		
		if (Anim != SGPrepAnim)
		{
			IdleAnim='Idle';
			//bAltNeedCock=True;
			PlayIdle();
		}
		
		AimComponent.ReAim(0.05);
	}
}


simulated function LoadGrenadeLoop()
{
	if (Ammo[1].AmmoAmount < 1 && Grenades > 3)
		return;
	if ((ReloadState == RS_None || ReloadState == RS_StartShovel)&& Ammo[1].AmmoAmount >= 1)
	{
		PlayAnim(StartShovelAnim, 1.0, , 0);
		ReloadState = RS_StartShovel;
	}
}

// Fire pressed. Change weapon if out of ammo, reload if empty mag or skip reloading if possible
simulated function FirePressed(float F)
{
	if (!HasAmmo())
		OutOfAmmo();
	else if (bNeedReload && ClientState == WS_ReadyToFire)
	{
		return;
	}
	else if (bCanSkipReload && ((ReloadState == RS_Shovel) || (ReloadState == RS_PostShellIn)))
	{
		ServerSkipReload();
		if (Level.NetMode == NM_Client)
			SkipReload();
	}
	
	/*if (F == 0)
	{
		if (ReloadState == RS_None && (bNeedCock || !bAltNeedCock) && MagAmmo > 0 && !IsFiring() && level.TimeSeconds > FireMode[0].NextfireTime)
		{
			CommonCockGun();
			if (Level.NetMode == NM_Client)
				ServerCockGun();
		}
	}
		
	else if(ReloadState == RS_None && bAltNeedCock && Grenades > 0 && !IsFiring() && Level.TimeSeconds > FireMode[1].NextFireTime)
	{
		CommonLoadFrag();
		if (Level.NetMode == NM_Client)
			ServerLoadFrag();
	}*/
}

simulated function CommonLoadFrag()
{
	if (bNonCocking)
		return;
	if (Role == ROLE_Authority)
		bServerReloading=true;
	ReloadState = RS_Cocking;
	PlayAnim(SGPrepAnim,1.0, 0.0);
}

function ServerLoadFrag()
{
	CommonLoadFrag();
}

simulated function CommonStartReload (optional byte i)
{
	local int m;
	if (ClientState == WS_BringUp)
		ClientState = WS_ReadyToFire;
	if (i == 1)
	{
		ReloadState = RS_StartShovel;
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

	/*if (bCockAfterReload)
		bNeedCock=true;
	if (bCockOnEmpty && MagAmmo < 1)
		bNeedCock=true;*/
	bNeedReload=false;
}

simulated function PlayCocking(optional byte Type)
{
	if (!bAltNeedCock)
		SafePlayAnim(CockAnim, 1.75, 0.2, , "RELOAD");
	else SafePlayAnim(CockAnim, CockAnimRate, 0.2, , "RELOAD");

	if (SightingState != SS_None)
		TemporaryScopeDown(default.SightingTime);
}

//Animation for alternate fire reload
simulated function PlayReloadAlt()
{
	SafePlayAnim(StartShovelAnim, StartShovelAnimRate, , 0, "RELOAD");
}

function ServerStartReload (optional byte i)
{
	local int m;

    // Weapon firing or animating
	if (bPreventReload)
		return;

    // Already performing reload
	if (ReloadState != RS_None)
		return;

    // primary full, alt reserves empty
	if (MagAmmo >= default.MagAmmo && (Ammo[1].AmmoAmount < 1 || Grenades >= 3)) 
		return;

    //alt full, primary reserves empty
	if (Grenades == 3 && Ammo[0].AmmoAmount < 1) 
		return;

    //all reserves empty
	if (Ammo[0].AmmoAmount < 1 && Ammo[1].AmmoAmount < 1) 
		return;

	for (m=0; m < NUM_FIRE_MODES; m++)
		if (FireMode[m] != None && FireMode[m].bIsFiring)
			StopFire(m);

	bServerReloading = true;

	if (Grenades < 3 && Ammo[1].AmmoAmount != 0 && (MagAmmo >= default.MagAmmo/2 || Ammo[0].AmmoAmount < 1))
	{
		CommonStartReload(1);	//Server animation
		ClientStartReload(1);
	}

	else
	{
		CommonStartReload(0);	//Server animation
		ClientStartReload(0);	//Client animation
	}
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && bAltNeedCock && AmmoAmount(1) > 0 && BotShouldReloadGrenade() && ReloadState == RS_None)
		LoadGrenadeLoop();
}

simulated function PlayShovelLoop()
{
	SafePlayAnim(ShovelAnim, ReloadAnimRate, 0.0, , "RELOAD");
}

//====================================
// End modified reload
//====================================

//====================================
// AI functions
//====================================

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
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

function byte BestMode()
{
	local Bot B;
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || bAltNeedCock)
		return 0;
	else if (MagAmmo < 1)
		return 1;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	Height = B.Enemy.Location.Z - Instigator.Location.Z;
	VDot = Normal(B.Enemy.Velocity) Dot Normal(Instigator.Location - B.Enemy.Location);

	Result = FRand()-0.3;
	// Too far for grenade
	if (Dist > 800)
		Result -= (Dist-800) / 2000;
	// Too close for grenade
	if (Dist < 500 &&  VDot > 0.3)
		result -= (500-Dist) / 1000;
	if (VSize(B.Enemy.Velocity) > 50)
	{
		// Straight lines
		if (Abs(VDot) > 0.8)
			Result += 0.1;
		// Enemy running away
		if (VDot < 0)
			Result -= 0.2;
		else
			Result += 0.2;
	}
	// Higher than enemy
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

function bool CanAttack(Actor Other)
{
	if (bAltNeedCock)
	{
		if (ReloadState != RS_None)
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenadeLoop();
			return false;
		}
	}
	return super.CanAttack(Other);
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
	
	return class'BUtil'.static.ReverseDistanceAtten(Rating, 0.75, Dist, 2048, 2048); 
}

function float SuggestAttackStyle()	{	return -0.5;	}
function float SuggestDefenseStyle()	{	return 0.5;	}

//=======================================
// End AI functions
//=======================================

defaultproperties
{
	AIRating=0.8
	CurrentRating=0.8
	GrenOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	GrenCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	CockSoundQuick=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-CockQuick'
	CockSoundAlt=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-CockAlt'
	CockSoundAltQ=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-CockAltQuick'
	SGPrepAnim="GrenadePrep"
	CockingAnim="Cock"
	ShovelAnim="ReloadGrenadeLoop"
	Grenades=3
	bAltNeedCock=False
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.500000
	BigIconMaterial=Texture'BWBP_SKC_TexExp.Pug.BigIcon_Pug'
	BigIconCoords=(Y2=230)
	bWT_Bullet=True
	bNeedCock=False
	bCockAfterReload=False
	bCockOnEmpty=False
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',pic2=Texture'BW_Core_WeaponTex.Crosshairs.M50OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=255,A=192),Color2=(B=0,G=255,R=255,A=255),StartSize1=61,StartSize2=22)
    NDCrosshairInfo=(SpreadRatios=(X1=0.750000,Y1=0.750000,X2=0.300000,Y2=0.300000))
    SpecialInfo(0)=(Info="120.0;15.0;0.8;70.0;0.75;0.5;0.0")
	BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-PullOut',Volume=1.800000)
	PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-PutAway',Volume=1.400000)
	CockAnimRate=1.000000
	CockSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-Cock',Volume=1.800000)
	ReloadAnimRate=1.000000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagHit')
	ClipOutSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagOut',Volume=1.100000)
	ClipInSound=(Sound=Sound'BWBP_SKC_Sounds.Bulldog.Bulldog-MagIn',Volume=2.100000)
	ClipInFrame=0.650000
	bCanSkipReload=True
	bAltTriggerReload=True
	StartShovelAnim="ReloadGrenadeStartMulti"
	EndShovelAnim="ReloadGrenadeFinishMulti"
	WeaponModes(1)=(ModeName="Laser-Auto",bUnavailable=True,Value=7.000000)
	WeaponModes(3)=(ModeName="FRAG-12 Loaded",bUnavailable=True,ModeID="WM_FullAuto")
	WeaponModes(4)=(ModeName="ERROR",bUnavailable=True,ModeID="WM_FullAuto")
	WeaponModes(5)=(ModeName="ERROR",bUnavailable=True,ModeID="WM_FullAuto")
	CurrentWeaponMode=0
	bNoCrosshairInScope=True
	SightOffset=(X=-18.000000,Y=4.475000,Z=6.800000)
	SightDisplayFOV=35.000000
	GunLength=48.000000
	ParamsClasses(0)=Class'PugWeaponParams'
	ParamsClasses(1)=Class'PugWeaponParamsClassic'
	ParamsClasses(2)=Class'PugWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SKCExp_Pro.PugPrimaryFire'
	FireModeClass(1)=Class'BWBP_SKCExp_Pro.PugSecondaryFire'
	PutDownAnimRate=1.700000
	PutDownTime=0.400000
	BringUpTime=0.900000
	SelectForce="SwitchToAssaultRifle"
	bSniping=True
	Description="No matter what year it is, there will always be those who don’t have the same ideals as the UTC troops. Even during the skrith wars, there’ll be conscientious objectors who oppose violence and they’ll adapt to suppressive tools like the PUG Suppression Cannon.  Designed to fire both rubber slugs and tear gas grenades, it was supposed to be a versatile tool to quell any riots; only it worked a little too well as the slugs managed to break bones and rupture vital organs while the gas suffocated those who got too close. The suppression cannon no longer is used in upholding the law, rather it has ironically found its way in troopers hands to flush out Skrith in their hiding holes."
	Priority=162
	HudColor=(B=25,G=25)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	GroupOffset=3
	PickupClass=Class'BWBP_SKCExp_Pro.PugPickup'
	PlayerViewOffset=(X=10.000000,Y=11.000000,Z=-21.000000)
	BobDamping=1.600000
	AttachmentClass=Class'BWBP_SKCExp_Pro.PugAttachment'
	IconMaterial=Texture'BWBP_SKC_TexExp.Pug.SmallIcon_Pug'
	IconCoords=(X2=127,Y2=31)
	ItemName="PUG-M2 Riot Cannon"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SKC_AnimExp.FPm_Pug'
	DrawScale=0.500000
}

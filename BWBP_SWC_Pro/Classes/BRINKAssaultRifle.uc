//=============================================================================
// MARS-3 (i.e. BRINK.)
//=============================================================================
class BRINKAssaultRifle extends BallisticWeapon;

#EXEC OBJ LOAD FILE=..\Textures\InterfaceContent.utx
#EXEC OBJ LOAD FILE=..\Textures\UT2003Fonts.utx
#EXEC OBJ LOAD FILE=..\Textures\AS_FX_TX.utx
#EXEC OBJ LOAD FILE=..\System\SkaarjPack_rc.u

var	int	                NumpadYOffset1; //Ammo tens
var	int	                NumpadYOffset2; //Ammo ones
var() ScriptedTexture   WeaponScreen;
var() int               ScreenIndex;
var() Material	        Screen;
var() Material	        ScreenBase;
var() Material	        Numbers;

var protected const color MyFontColor; //Why do I even need this?

var float RadarPulse,RadarScale;
var config float RadarPosX, RadarPosY;
var float LastDrawRadar;
var float MinEnemyDist;
var int Meters;
var() Sound RadarScanSound, RadarWarnSound;
var bool bRadar;
var() BUtil.FullSound	RadarOnSound;	// Sound when activating thermal mode
var() BUtil.FullSound	RadarOffSound;// Sound when deactivating thermal mode

var float RadarHeat, RadarHeatRate, RadarCoolRate, MaxRadarTime;

var() Sound		GrenOpenSound;		//Sounds for grenade reloading
var() Sound		GrenLoadSound;		//
var() Sound		GrenCloseSound;		//
var() name		GrenadeLoadAnim;	//Anim for grenade reload

var(BRINKAssaultRifle) name		ScopeBone;			// Bone to use for hiding scope

replication
{
	reliable if (Role == ROLE_Authority)
		ClientScreenStart, ClientGrenadePickedUp, MinEnemyDist, Meters, ClientNotify_ChangeRadarSkin, bRadar;
	reliable if (Role < ROLE_Authority)
		Notify_ChangeRadarSkin;
}

//=====================================================================
// SCREEN CODE
//=====================================================================

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
		{
			GenerateLayout(BallisticWeaponPickup(Pickup).LayoutIndex);
			GenerateCamo(BallisticWeaponPickup(Pickup).CamoIndex);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
		}
		else
		{
			GenerateLayout(255);
			GenerateCamo(255);
			if (Role == ROLE_Authority)
				ParamsClasses[GameStyleIndex].static.Initialize(self);
            MagAmmo = MagAmmo + (int(!bNonCocking) *  int(bMagPlusOne) * int(!bNeedCock));
		}

		Notify_ChangeRadarSkin();
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

function Notify_ChangeRadarSkin()
{
	//log("Notify_ChangeAmmoSkin");
	//log("CurrentWeaponMode: "$CurrentWeaponMode);
	if (bRadar)
	{
		Skins[ScreenIndex]=Shader'BWBP_SWC_Tex.BR1NK.RadarShader';
	}
	if (Role == ROLE_Authority)
		ClientNotify_ChangeRadarSkin();
}

simulated function ClientNotify_ChangeRadarSkin()
{
	//log("ClientNotify_ChangeAmmoSkin");
	//log("CurrentWeaponMode: "$CurrentWeaponMode);
	if (bRadar)
	{
		Skins[ScreenIndex]=Shader'BWBP_SWC_Tex.BR1NK.RadarShader';
	}
}

simulated function UpdatePrecacheMaterials()
{
	Level.AddPrecacheMaterial(Material'InterfaceContent.HUD.SkinA');
	Level.AddPrecacheMaterial(Material'AS_FX_TX.AssaultRadar');
	Super.UpdatePrecacheMaterials();
}

//Radar stuff taken from invasion
simulated function ShowTeamScorePassA(Canvas C)
{
	local float RadarWidth, PulseWidth, PulseBrightness;

	RadarScale = Default.RadarScale * class'HUD'.default.HUDScale;
	RadarWidth = 0.5 * RadarScale * C.ClipX;
	PulseWidth = RadarScale * C.ClipX;
	C.DrawColor = class'HUD'.default.BlueColor;//RedColor;
	C.Style = ERenderStyle.STY_Translucent;

	PulseBrightness = FMax(0,(1 - 2*RadarPulse) * 255.0);
	C.DrawColor.B = PulseBrightness; //.R
	C.SetPos(RadarPosX*C.ClipX - 0.5*PulseWidth,RadarPosY*C.ClipY+RadarWidth-0.5*PulseWidth);
	C.DrawTile( Material'InterfaceContent.SkinA', PulseWidth, PulseWidth, 0, 880, 142, 142);

	PulseWidth = RadarPulse * RadarScale * C.ClipX;
	C.DrawColor = class'HUD'.default.BlueColor;//RedColor;
	C.SetPos(RadarPosX*C.ClipX - 0.5*PulseWidth,RadarPosY*C.ClipY+RadarWidth-0.5*PulseWidth);
	C.DrawTile( Material'InterfaceContent.SkinA', PulseWidth, PulseWidth, 0, 880, 142, 142);

	C.Style = ERenderStyle.STY_Alpha;
	//C.DrawColor = class'HUD'.default.BlueColor;//GetTeamColor( Pawn(Owner).GetTeamNum() );
	C.DrawColor.R = 167;
	C.DrawColor.G = 218;
	C.DrawColor.B = 232;

	
	C.SetPos(RadarPosX*C.ClipX - RadarWidth,RadarPosY*C.ClipY+RadarWidth);
	C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 0, 512, 512, -512);
	C.SetPos(RadarPosX*C.ClipX,RadarPosY*C.ClipY+RadarWidth);
	C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 512, 512, -512, -512);
	C.SetPos(RadarPosX*C.ClipX - RadarWidth,RadarPosY*C.ClipY);
	C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 0, 0, 512, 512);
	C.SetPos(RadarPosX*C.ClipX,RadarPosY*C.ClipY);
	C.DrawTile( Material'AS_FX_TX.AssaultRadar', RadarWidth, RadarWidth, 512, 0, -512, 512);
}

//Radar stuff taken from invasion
simulated function ShowTeamScorePassC(Canvas C)
{
	local Pawn P;
	local float Dist, MaxDist, RadarWidth, PulseBrightness,Angle,DotSize,OffsetY,OffsetScale;
	local rotator Dir;
	local vector Start;
	

	Start = Pawn(Owner).Location;
	
	LastDrawRadar = Level.TimeSeconds;
	RadarWidth = 0.5 * /*Pawn(Owner).*/RadarScale * C.ClipX;
	DotSize = 24*C.ClipX * ((class'HUD'.default.HUDScale)/1600);

	MaxDist = 3000 * RadarPulse;
	C.Style = ERenderStyle.STY_Translucent;
	OffsetY = RadarPosY + RadarWidth/C.ClipY;
	MinEnemyDist = 3000;//5000;
	ForEach DynamicActors(class'Pawn',P)
		if ( P.Health > 0 )
		{
			Dist = VSize(Start - P.Location);
			if ( Dist < 3000 )
			{
				if ( Dist < MaxDist )
					PulseBrightness = 255 - 255*Abs(Dist*0.00033 - RadarPulse);
				else
					PulseBrightness = 255 - 255*Abs(Dist*0.00033 - RadarPulse - 1);
				if ( xPawn(P) != None && P != Owner ) 
				{
					
					MinEnemyDist = FMin(MinEnemyDist, Dist);
					C.DrawColor.R = PulseBrightness;
					C.DrawColor.G = PulseBrightness;
					C.DrawColor.B = PulseBrightness;//0;

					Dir = rotator(P.Location - Start);
					OffsetScale = RadarScale*Dist*0.000167;
			
					Angle = ((Dir.Yaw - Pawn(Owner).Rotation.Yaw) & 65535) * 6.2832/65536;
					//C.SetPos(RadarPosX * C.ClipX + OffsetScale * C.ClipX * sin(Angle) - 0.5*DotSize,OffsetY * C.ClipY - OffsetScale * C.ClipX * cos(Angle) - 0.5*DotSize/1.5);
					C.SetPos(RadarPosX * C.ClipX + OffsetScale * C.ClipX * sin(Angle) - 0.5*DotSize,OffsetY * C.ClipY - OffsetScale * C.ClipX * cos(Angle) - 0.5*DotSize);
					C.DrawTile(Material'InterfaceContent.Hud.SkinA',DotSize,DotSize,838,238,144,144);
					
				}
				else if ( xPawn(P) != None && P == Owner ) 
				{
					//Draw a separate dot for the player without messing with distance
					C.DrawColor.R = 128;
					C.DrawColor.G = 128;
					C.DrawColor.B = 255;
					Dir = rotator(P.Location - Start);
					OffsetScale = RadarScale*Dist*0.000167;
					
					Angle = ((Dir.Yaw - Pawn(Owner).Rotation.Yaw) & 65535) * 6.2832/65536;
					C.SetPos(RadarPosX * C.ClipX + OffsetScale * C.ClipX * sin(Angle) - 0.5*DotSize,
						OffsetY * C.ClipY - OffsetScale * C.ClipX * cos(Angle) - 0.5*DotSize);
					C.DrawTile(Material'InterfaceContent.Hud.SkinA',DotSize,DotSize,838,238,144,144);
				}
				else
				{
					C.DrawColor.R = 0;
					C.DrawColor.G = 0;
					C.DrawColor.B = PulseBrightness;
				}

			}
		}			
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None && !IsGrenadeLoaded()&& AmmoAmount(1) > 0 && BotShouldReloadGrenade() && !IsReloadingGrenade())
		LoadGrenade();

	if (bRadar) 
	{		
		RadarHeat = FMin(MaxRadarTime, RadarHeat + RadarHeatRate * DT);
		RadarPulse = RadarPulse + 0.75 * DT;//0.5 * DT;
		
		if (RadarHeat >= MaxRadarTime)
			ServerSwitchRadar(!bRadar);	
		else if ( RadarPulse >= 1 )
		{
			if ( MinEnemyDist < 3000 )
			{
				Meters = int(MinEnemyDist / 25.0);
				//if (Level.TimeSeconds - LastDrawRadar < 0.2) 
      				Pawn(Owner).PlaySound(RadarWarnSound,,FMin(2.0,1200.0 / MinEnemyDist),,,FClamp(2000.0 / MinEnemyDist,0.81,2.0));
				//log("In weapontick - playwarnsound");
			}
			else 
			{
      				Meters = -1;
      				Pawn(Owner).PlaySound(RadarScanSound,,1.0);
				//log("In weapontick - playscansound");
    			}
			RadarPulse = RadarPulse - 1;
		}
	}
	else
		RadarHeat = FMax(0, RadarHeat - RadarCoolRate * DT);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}

	Super.BringUp(PrevWeapon);

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}

simulated function float ChargeBar()
{
	return RadarHeat / MaxRadarTime;
}

function ServerWeaponSpecial(optional byte i)
{
	if (!bRadar && RadarHeat > 0)
		return;
		
	ServerSwitchRadar(!bRadar);
}

function ServerSwitchRadar(bool bNewRadar)
{
	bRadar = bNewRadar;
	Notify_ChangeRadarSkin();
	
	if (!bRadar)
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}
	
	UpdateScreen();
	
	if (Instigator.IsLocallyControlled())
		ClientSwitchRadar();
}

simulated function ClientSwitchRadar()
{
	if (bRadar)
	{
    	class'BUtil'.static.PlayFullSound(self, RadarOnSound);
	}
	else
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
			
    	class'BUtil'.static.PlayFullSound(self, RadarOffSound);
	}
	
	Notify_ChangeRadarSkin();
	UpdateScreen();
}

simulated event RenderOverlays (Canvas C)
{
	if (bRadar)
	{
		ShowTeamScorePassA(C);
		ShowTeamScorePassC(C);
	}
	
	NumpadYOffset1=(5+(MagAmmo/10)*49);
	NumpadYOffset2=(5+(MagAmmo%10)*49);
	
	Super.RenderOverlays(C);
}

simulated function ClientScreenStart()
{
	ScreenStart();
}

// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
		
	Skins[ScreenIndex] = Screen; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated function Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	Tex.DrawTile(0,0,256,128,0,0,256,128,ScreenBase, MyFontColor); //Basic screen

	Tex.DrawTile(40,65,128,128,45,NumpadYOffset1,50,50,Numbers, MyFontColor); //Ammo
	Tex.DrawTile(110,65,128,128,45,NumpadYOffset2,50,50,Numbers, MyFontColor);
}

simulated function UpdateScreen()
{
	if (Instigator != None && AIController(Instigator.Controller) != None) //Bots cannot update your screen
		return;

	if (Instigator.IsLocallyControlled())
	{
		WeaponScreen.Revision++;
	}
}

// Consume ammo from one of the possible sources depending on various factors
simulated function bool ConsumeMagAmmo(int Mode, float Load, optional bool bAmountNeededIsMax)
{
	if (bNoMag || (BFireMode[Mode] != None && BFireMode[Mode].bUseWeaponMag == false))
		ConsumeAmmo(Mode, Load, bAmountNeededIsMax);
	else
	{
		if (MagAmmo < Load)
			MagAmmo = 0;
		else
			MagAmmo -= Load;
	}
	UpdateScreen();
	return true;
}

// Animation notify for when the clip is stuck in
simulated function Notify_ClipIn()
{
	local int AmmoNeeded;

	if (ReloadState == RS_None)
		return;
	ReloadState = RS_PostClipIn;
	PlayOwnedSound(ClipInSound.Sound,ClipInSound.Slot,ClipInSound.Volume,ClipInSound.bNoOverride,ClipInSound.Radius,ClipInSound.Pitch,ClipInSound.bAtten);
	if (level.NetMode != NM_Client)
	{
		AmmoNeeded = default.MagAmmo-MagAmmo;
		if (AmmoNeeded > Ammo[0].AmmoAmount)
			MagAmmo+=Ammo[0].AmmoAmount;
		else
			MagAmmo = default.MagAmmo;
		Ammo[0].UseAmmo (AmmoNeeded, True);
	}
	UpdateScreen();
}

//=====================================================================
// GRENADE CODE
//=====================================================================

// Notifys for greande loading sounds
simulated function Notify_BRINKGrenOpen()	{	PlaySound(GrenOpenSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_BRINKGrenLoad()		{	PlaySound(GrenLoadSound, SLOT_Misc, 0.5, ,64);	}
simulated function Notify_BRINKGrenClose()	{	PlaySound(GrenCloseSound, SLOT_Misc, 0.5, ,64);BRINKSecondaryFire(FireMode[1]).bLoaded = true;FireMode[1].PreFireTime = FireMode[1].default.PreFireTime;		}

// A grenade has just been picked up. Loads one in if we're empty
function GrenadePickedUp ()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (Instigator.Weapon == self)
			LoadGrenade();
		else

			BRINKSecondaryFire(FireMode[1]).bLoaded=true;
	}
	if (!Instigator.IsLocallyControlled())
		ClientGrenadePickedUp();
}

simulated function ClientGrenadePickedUp()
{
	if (Ammo[1].AmmoAmount < Ammo[1].MaxAmmo)
	{
		if (ClientState == WS_ReadyToFire)
			LoadGrenade();
		else
			BRINKSecondaryFire(FireMode[1]).bLoaded=true;
	}
}

simulated function bool IsGrenadeLoaded()
{
	return BRINKSecondaryFire(FireMode[1]).bLoaded;
}

// Tell our ammo that this is the BRINK it must notify about grenade pickups
function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
	Super.GiveAmmo(m, WP, bJustSpawned);
	if (Ammo[1] != None && Ammo_BRINKGrenades(Ammo[1]) != None)
		Ammo_BRINKGrenades(Ammo[1]).DaF2K = self;
}

// Load in a grenade
simulated function LoadGrenade()
{
	if (Ammo[1].AmmoAmount < 1 || BRINKSecondaryFire(FireMode[1]).bLoaded)
	{
		if(!BRINKSecondaryFire(FireMode[1]).bLoaded)
			PlayIdle();
		return;
	}

	if (ReloadState == RS_None)
	{
		ReloadState = RS_GearSwitch;
		PlayAnim(GrenadeLoadAnim, 1.1, , 0);
	}
}

function ServerStartReload (optional byte i)
{
	local int channel;
	local name seq;
	local float frame, rate;

	if (bPreventReload)
		return;
	if (ReloadState != RS_None)
		return;

	GetAnimParams(channel, seq, frame, rate);
	if (seq == GrenadeLoadAnim)
		return;

	if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
	{
		if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
		{
			LoadGrenade();
			ClientStartReload(1);
		}
		return;
	}
	super.ServerStartReload();
}

simulated function ClientStartReload(optional byte i)
{
	if (Level.NetMode == NM_Client)
	{
		if (i == 1 || (MagAmmo >= default.MagAmmo || Ammo[0].AmmoAmount < 1))
		{
			if (AmmoAmount(1) > 0 && !IsReloadingGrenade())
				LoadGrenade();
		}
		else
			CommonStartReload(i);
	}
}

simulated function bool CheckWeaponMode (int Mode)
{
	if (Mode == 1)
		return FireCount < 1;
	return super.CheckWeaponMode(Mode);
}

function bool BotShouldReloadGrenade ()
{
	if ( (Level.TimeSeconds - Instigator.LastPainTime > 1.0) )
		return true;
	return false;
}

simulated function PlayReload()
{
	if (MagAmmo < 1)
		SetBoneScale (1, 0.0, 'Bullet');

	super.PlayReload();
}

simulated function Notify_ClipOutOfSight()
{
	SetBoneScale (1, 1.0, 'Bullet');
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;
		Instigator.SoundPitch = default.SoundPitch;
		Instigator.SoundRadius = default.SoundRadius;
		Instigator.bFullVolume = false;
		return true;
	}
	return false;
}

//=====================================================================
// AI INTERFACE CODE
//=====================================================================
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
	local float Result, Height, Dist, VDot;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (AmmoAmount(1) < 1 || !IsGrenadeLoaded())
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
//	if (Height < 0)
//		Result += 0.1;
	// Improve grenade acording to height, but temper using horizontal distance (bots really like grenades when right above you)
	Dist = VSize(B.Enemy.Location*vect(1,1,0) - Instigator.Location*vect(1,1,0));
	if (Height < -100)
		Result += Abs((Height/2) / Dist);

	if (Result > 0.5)
		return 1;
	return 0;
}

simulated function bool IsReloadingGrenade()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == GrenadeLoadAnim)
 		return true;
	return false;
}

function bool CanAttack(Actor Other)
{
	if (!IsGrenadeLoaded())
	{
		if (IsReloadingGrenade())
		{
			if ((Level.TimeSeconds - Instigator.LastPainTime > 1.0))
				return false;
		}
		else if (AmmoAmount(1) > 0 && BotShouldReloadGrenade())
		{
			LoadGrenade();
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.5, Dist, BallisticProInstantFire(BFireMode[0]).DecayRange.Min, BallisticProInstantFire(BFireMode[0]).DecayRange.Max); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.4;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.4;	}
// End AI Stuff =====

defaultproperties
{
	ScreenIndex=3
	WeaponScreen=ScriptedTexture'BWBP_SWC_Tex.BR1NK.PulseScreen'
	Screen=Shader'BWBP_SWC_Tex.BR1NK.PulseScreenTex_SD'
	ScreenBase=FinalBlend'ONSstructureTextures.CoreGroup.InvisibleFinal'
	//ScreenBase=Shader'BWBP_SWC_Tex.BR1NK.PulseScreenTex_SD'
	Numbers=Texture'BWBP_SKC_Tex.PUMA.PUMA-Numbers'
	MyFontColor=(B=255,G=255,R=255,A=255)

	RadarHeatRate=2.000000
	RadarCoolRate=1.000000
	MaxRadarTime=30.000000
    RadarOnSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOn',Volume=0.500000,Pitch=2.000000)
    RadarOffSound=(Sound=Sound'BW_Core_WeaponSound.M75.M75ThermalOff',Volume=0.500000,Pitch=2.000000)
    RadarScanSound=Sound'BWBP_SWC_Sounds.BR1NK.RadarScan'
    RadarWarnSound=Sound'BWBP_SWC_Sounds.BR1NK.RadarWarn'
	GrenOpenSound=Sound'BW_Core_WeaponSound.M50.M50GrenOpen'
	GrenLoadSound=Sound'BW_Core_WeaponSound.M50.M50GrenLoad'
	GrenCloseSound=Sound'BW_Core_WeaponSound.M50.M50GrenClose'
	GrenadeLoadAnim="GrenadeReload"
	ScopeBone="EOTech"
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	AIReloadTime=1.000000
	BigIconMaterial=Texture'BWBP_SWC_Tex.BR1NK.BigIcon_BR1NK'
	BigIconCoords=(X1=32,Y1=40,X2=475)
	bWT_Bullet=True
	ManualLines(0)="5.56mm fire. Has a fast fire rate and high sustained DPS, but high recoil, limiting its hipfire."
	ManualLines(1)="Launches a cryogenic grenade. Upon impact, freezes nearby enemies, slowing their movement. The effect is proportional to their distance from the epicentre. This attack will also extinguish the fires of an FP7 grenade."
	ManualLines(2)="The Weapon Special key attaches a suppressor. This reduces the recoil, but also the effective range. The flash is removed and the gunfire becomes less audible.||Effective at close to medium range."
	SpecialInfo(0)=(Info="320.0;25.0;1.0;110.0;0.8;0.5;0.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50Putaway')
	CockAnimPostReload="ReloadEndCock"
	CockAnimRate=0.95000
	CockSound=(Sound=Sound'BWBP_SWC_Sounds.BR1NK.BR1NK-Cock',Volume=1.100000,Radius=32.000000)
	ReloadAnimRate=0.950000
	ClipHitSound=(Sound=Sound'BWBP_SKC_Sounds.MARS.MARS-MagFiddle',Volume=1.200000,Radius=32.000000)
	ClipOutSound=(Sound=Sound'BWBP_SWC_Sounds.BR1NK.BR1NK-ClipOut',Volume=1.200000,Radius=32.000000)
	ClipInSound=(Sound=Sound'BWBP_SWC_Sounds.BR1NK.BR1NK-ClipIn',Volume=1.200000,Radius=32.000000)
	ClipInFrame=0.650000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc9',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.A73OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=255,R=129,A=140),Color2=(R=255,B=0,G=0,A=255),StartSize1=84,StartSize2=26)
    WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(ModeName="Double Barrel",Value=2.000000)
	WeaponModes(2)=(ModeName="Single Barrel")
	bNoCrosshairInScope=True
	bShowChargingBar=True
	SightOffset=(X=-7.000000,Y=-0.40000,Z=16.200000)
	ParamsClasses(0)=Class'BRINKAssaultRifleWeaponParamsArena'
	ParamsClasses(1)=Class'BRINKAssaultRifleWeaponParamsClassic'
	ParamsClasses(2)=Class'BRINKAssaultRifleWeaponParamsRealistic'
	FireModeClass(0)=Class'BWBP_SWC_Pro.BRINKPrimaryFire'
	FireModeClass(1)=Class'BWBP_SWC_Pro.BRINKSecondaryFire'
	PutDownTime=0.700000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.750000
	CurrentRating=0.750000
	Description="BR1-NK Combat Assault Rifle||Manufacturer: Black & Wood|Primary: Variable bullets (fully automatic)|Secondary: Launch Grenade|Special: Motion Tracker||The UTC space station 'Argent' was responsible for reverse engineering Skrith technology for use in the war. When Argent was taken by a regiment of Krao, the UTC commissioned Black & Wood to create a new weapon that would allow a small strike team to reclaim the outpost. The BR1-NK was given smaller rounds and a high rate of fire in order to quickly dispatch Krao swarms, as well as piercing rounds that could be shot through the Kraos' newly erected barriers. The high-velocity grenades were intentionally made less potent so as not to damage the facility. The one thing that made the weapon invaluable against the Krao, however, was the advanced motion tracker that the UTC soldiers used to avoid ambushes and any roaming Krao that hid in vents. Thanks to the BR1-NK, the UTC reclaimed the station with minimal damage and zero loss of life."
	Priority=65
	HudColor=(B=255,G=175,R=125)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=6
	PickupClass=Class'BWBP_SWC_Pro.BRINKPickup'
	PlayerViewOffset=(X=5.000000,Y=4.500000,Z=-11.500000)
	BobDamping=2.000000
	AttachmentClass=Class'BWBP_SWC_Pro.BRINKAttachment'
	IconMaterial=Texture'BWBP_SWC_Tex.BR1NK.SmallIcon_BR1NK'
	IconCoords=(X2=127,Y2=31)
	ItemName="BR1-NK Mod-2 LMR"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_BR1NK'
	DrawScale=0.250000
	RadarScale=0.200000
	RadarPosX=0.900000
	RadarPosY=0.250000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
}

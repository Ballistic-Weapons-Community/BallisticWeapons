//=============================================================================
// Supercharger_AssaultWeapon
//
// Advanced electrical weapon. Charges enemies and puts a DoT on.
// Overcharging enemies blows them up.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Supercharger_AssaultWeapon extends BallisticWeapon;

var   Supercharger_ChargeControl	ChargeControl;


//Scripted Ammo Screen Texture
var() ScriptedTexture WeaponScreen; //Scripted texture to write on
var() Material	WeaponScreenShader; //Scripted Texture with self illum applied
var() Material	ScreenBase;
var() Material	ScreenHeat;
var protected const color MyFontColor; //Why do I even need this?
var float HeatBar;

var float		HeatLevel;			// Current Heat level, duh...
var bool		bCriticalHeat;		// Heat is at critical levels
var() Sound		OverHeatSound;		// Sound to play when it overheats
var() Sound		HighHeatSound;		// Sound to play when heat is dangerous
var() Sound		MedHeatSound;		// Sound to play when heat is moderate
var() Sound		VentingSound;		// Sound to loop when venting
var Actor 			GlowFX;		// Code from the BFG.
var float		NextChangeMindTime;	// For AI

var bool		bWaterBurn;			// busy getting damaged in water
var bool		bIsVenting;

var Actor	ClawSpark1;			// Sparks attached to claws when tracking enemy
var Actor	ClawSpark2;
var float	ClawAlpha;			// An alpha amount for claw movement interpolation

var bool		bLatchedOn;


replication
{
	reliable if (Role==ROLE_Authority)
		ChargeControl, ClientOverCharge, ClientSetHeat, bLatchedOn, ClientScreenStart;
}


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

//========================== AMMO COUNTER NON-STATIC TEXTURE ============

simulated function ClientScreenStart()
{
	ScreenStart();
}
// Called on clients from camera when it gets to postnetbegin
simulated function ScreenStart()
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Client = self;
	Skins[2] = WeaponScreenShader; //Set up scripted texture.
	UpdateScreen();//Give it some numbers n shit
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;
}

simulated event RenderTexture( ScriptedTexture Tex )
{
	// 0 is full, 256 is empty
	HeatBar = 256-(((FMin(HeatLevel, 10))/10.0f)*256);

	Tex.DrawTile(0,0,256,256,0,0,256,256,ScreenBase, MyFontColor); //Basic screen

	Tex.DrawTile(HeatBar,0,256,256,0,0,256,512,ScreenHeat, MyFontColor); //Ammo

}
	
simulated function UpdateScreen()
{
	if (Instigator.IsLocallyControlled())
	{
			WeaponScreen.Revision++;
	}
}

simulated event RenderOverlays( Canvas Canvas )
{
	if (Instigator.IsLocallyControlled())
		WeaponScreen.Revision++;

	super.RenderOverlays(Canvas);
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

// ============== Heat stuff =================

simulated function ClientOverCharge()
{
	if (Firemode[0].bIsFiring)
		StopFire(0);
	if (Firemode[1].bIsFiring)
		StopFire(1);
}

simulated function float ChargeBar()
{
	return HeatLevel / 10;
}

simulated event Tick (float DT)
{
	if (HeatLevel > 0)
	{
		if (bIsVenting)
			Heatlevel = FMax(HeatLevel - 4 * DT, 0);
		else
			Heatlevel = FMax(HeatLevel - 0.4 * DT, 0);
	}

	super.Tick(DT);
}

simulated function AddHeat(float Amount)
{
	HeatLevel += Amount;
	if (HeatLevel >= 10 && HeatLevel < 12)
	{
		Heatlevel = 12;
		class'BallisticDamageType'.static.GenericHurt (Instigator, 20+Rand(40), Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DT_HVCOverheat');
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
		if (Supercharger_Pickup(Pickup) != None)
			HeatLevel = FMax( 0.0, Supercharger_Pickup(Pickup).HeatLevel - (level.TimeSeconds - Supercharger_Pickup(Pickup).HeatTime) * 0.25 );
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
		
	//Disable aim for weapons picked up by AI-controlled pawns
	bAimDisabled = default.bAimDisabled || !Instigator.IsHumanControlled();

    if ( !bJustSpawned )
	{
        for (m = 0; m < NUM_FIRE_MODES; m++)
			Ammo[m] = None;
		Destroy();
	}
}

// ======= effects ==================

// -----------------------------------------------
// Effects interpolation and tickers

simulated event Timer()
{
	if (Instigator.Weapon != self)
		return;
	if (!bWaterBurn || Clientstate == WS_BringUp || Clientstate == WS_PutDown)
		super.Timer();
	else if (Role == ROLE_Authority && Instigator != None && AmmoAmount(0) > 0)
	{
		ConsumeAmmo(0, 2);
		class'BallisticDamageType'.static.GenericHurt (Instigator, 2, Instigator, Location, vect(0,0,0), class'DT_HVCDunk');
	}
}

simulated event WeaponTick(float DT)
{
	local vector End;

	super.WeaponTick(DT);

	if (AIController(Instigator.Controller) != None)
	{
		if (HeatLevel > 0)
		{
			if (  BotShouldReload() && !Instigator.Controller.LineOfSightTo(AIController(Instigator.Controller).Enemy) && !IsGoingToVent())
				BotReload();
		}
		else if (bIsVenting)
			ReloadRelease();
	}

	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		if (AmmoAmount(0) > 0)
			AddHeat(DT*0.5);
		if (!bWaterBurn && Role == ROLE_Authority && (Clientstate == WS_ReadyToFire || !Instigator.IsLocallyControlled()))
		{
			bWaterBurn=true;
			SetTimer(0.4, true);
		}
	}
	else if (bWaterBurn)
	{
		bWaterBurn = false;
		if (TimerRate == 0.2)
			SetTimer(0.0, false);

	}
	if (!Instigator.IsLocallyControlled())
		return;

	if (ClawSpark1 != None)
	{
		End = GetBoneCoords('tip').Origin + vector(Instigator.GetViewRotation()) * 96;
		BeamEmitter(Emitter(ClawSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
	}
}
// -----------------------------------------------
// The arc effects and stuff

simulated function BringUp(optional Weapon PrevWeapon)
{
	bIsVenting = false;

	if (Instigator != None && AIController(Instigator.Controller) == None) //Player Screen ON
	{
		ScreenStart();
		if (!Instigator.IsLocallyControlled())
			ClientScreenStart();
	}

	super.BringUp(PrevWeapon);

	AmbientSound = None;
	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
}
simulated function bool PutDown()
{
	if (super.PutDown())
	{
		if (bIsVenting)
		{
			if (level.NetMode == NM_Client)
				bIsVenting = false;
			ServerReloadRelease();
		}

		bWaterBurn=false;
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
		return true;
	}
	return false;
}


// -----------------------------------------------
// Reload / Venting stuff
simulated function bool IsGoingToVent()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == 'StartReload')
 		return true;
	return false;
}

exec simulated function Reload(optional byte i)
{
	if (!IsFiring())
		SafePlayAnim('StartReload', 1.0, 0.1);
}
simulated function Notify_LGArcOff()
{
	Instigator.AmbientSound = VentingSound;
	Instigator.SoundVolume = 128;
}
simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'StartReload')
	{
		if (level.NetMode == NM_Client)
			bIsVenting = true;
		ServerStartReload();
	}
	super.AnimEnd(Channel);
}
function ServerStartReload (optional byte i)
{
	if (!Instigator.IsLocallyControlled())
	{	Instigator.AmbientSound = VentingSound;
		Instigator.SoundVolume = 128;	}
	bIsVenting = true;
}
simulated function PlayIdle()
{
    if (bIsVenting)
		SafeLoopAnim('ReloadLoop', 0.5, IdleTweenTime, ,"IDLE");
	else
		super.PlayIdle();
}

exec simulated function ReloadRelease(optional byte i)
{
    local name anim;
    local float frame, rate;

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	if (!bIsVenting)
	{
		GetAnimParams(0, anim, frame, rate);
		if (Anim != 'StartReload')
			return;
		SafePlayAnim('EndReload', 1.0, 0.2);
		if (frame < 0.5)
			SetAnimFrame(1-frame);
	}
	else
		SafePlayAnim('EndReload', 1.0, 0.2);

	if (level.NetMode == NM_Client)
		bIsVenting = false;
	ServerReloadRelease();
}
simulated function Notify_LGArcOn()
{

}
function ServerReloadRelease(optional byte i)
{
	if (!Instigator.IsLocallyControlled())
	{	Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;	}
	bIsVenting = false;
}
// End Venting -----------------------------------


simulated function Destroyed()
{
	if (Instigator != None && AIController(Instigator.Controller) == None)
		WeaponScreen.client=None;
	if (ClawSpark1 != None)
		ClawSpark1.Destroy();
	if (Instigator.AmbientSound == UsedAmbientSound || Instigator.AmbientSound == VentingSound)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}
	super.Destroyed();
}

// AI Interface =====
// Is reloading a good idea???
function bool BotShouldReload ()
{
	if ( (!bIsVenting) && (HeatLevel > 2) && (Level.TimeSeconds - AIController(Instigator.Controller).LastSeenTime > AIReloadTime) &&
		 (Level.TimeSeconds - Instigator.LastPainTime > AIReloadTime) )
		return true;
	return false;
}
// Makes a bot reload if they have the skill or its forced
// Allows clever bots to reload when they get the chance and dumb ones only when they have to
function bool BotReload(optional bool bForced)
{
	if (bForced || AIController(Instigator.Controller).Skill >= Rand(4))
	{
		Reload();
		return true;
	}
	return false;
}

// return false if out of range, can't see target, etc.
function bool CanAttack(Actor Other)
{
    local float Dist;
    local vector HitLocation, HitNormal, projStart;
    local actor HitActor;
    local int EC;
    local AIController B;
    local actor Victims;

    if ( (Instigator == None) || (Instigator.Controller == None) )
        return false;

    // check that target is within range
    Dist = VSize(Instigator.Location - Other.Location);
    if (Dist > FireMode[0].MaxRange())
	{
		BotReload();
        return false;
	}
    // check that can see target
    if (BotShouldReload() && !Instigator.Controller.LineOfSightTo(Other) && !IsGoingToVent())
	{
		BotReload();
        return false;
	}

	if (HeatLevel >= 10 && !IsGoingToVent())
	{
		BotReload();
        return false;
	}

	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		B = AIController(Instigator.Controller);
		if (B != None && B.Skill >= Rand(4))
		{
			ForEach Instigator.PhysicsVolume.TouchingActors(class'Actor', Victims)
			{
				if (Pawn(Victims) != None)
				{
					Dist = VSize(Victims.location - Instigator.location);
					if (Dist > 1900)
						continue;
					if (level.Game.bTeamGame && Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller))
					{
						if (B.Skill >= Rand(4) && TeamGame(level.Game) != None && TeamGame(level.Game).FriendlyFireScale > 0.1)
							return false;
					}
					else
						EC += Min(1500, 2000 - Dist);
				}
			}
			if (EC < 1990)
				return false;
		}
	}
	if (bIsVenting && HeatLevel < 10 && AIController(Instigator.Controller).Skill >= Rand(5) && (Level.TimeSeconds - Instigator.LastPainTime < 0.5))
		ReloadRelease();
	if (bIsVenting && AIController(Instigator.Controller).Skill + Rand(2) >= HeatLevel)
		ReloadRelease();

    // check that would hit target, and not a friendly
	if (level.Game.bTeamGame)
	{
    	projStart = Instigator.Location + Instigator.EyePosition();
		HitActor = Trace(HitLocation, HitNormal, Other.Location + Other.CollisionHeight * vect(0,0,0.8), projStart, true);
    	if ( (HitActor == None) || (HitActor == Other) || (Pawn(HitActor) == None)
			|| (Pawn(HitActor).Controller == None) || !Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller) )
        	return true;
	    return false;
    }
   	return true;
}

// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (!HasAmmoLoaded(0))
		return 1;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (Dist > 200)
		return 0;
	if (Dist < FireMode[1].MaxRange())
		return 1;
	return Rand(2);
}

function float GetAIRating()
{
	local Bot B;
	local float Result;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Result = Super.GetAIRating();
	if (Instigator.PhysicsVolume.bWaterVolume)
		Result -= 0.15 * B.Skill;
	
	// super effective at all ranges
	return Result;
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return -0.2;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.9;	}
// End AI Stuff =====


defaultproperties
{
	 MyFontColor=(R=255,G=255,B=255,A=255)
     WeaponScreen=ScriptedTexture'BWBP_SKC_Tex.SuperCharger.Supercharger-ScriptLCD'
     WeaponScreenShader=Shader'BWBP_SKC_Tex.SuperCharger.Supercharger-ScriptLCD-SD'
	 ScreenBase=Texture'BWBP_SKC_Tex.LS14.LS14-ScreenBase'
	 ScreenHeat=Texture'BWBP_SKC_Tex.SuperCharger.Supercharger-ScreenHeat'
	 
	VentingSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Coolant'
	OverheatSound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	UsedAmbientSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
    AIReloadTime=0.200000
    BigIconMaterial=Texture'BWBP_SKC_Tex.SuperCharger.BigIcon_Super'
	
	bWT_Hazardous=True
	bWT_Energy=True
    bWT_Splash=True
    bWT_RapidProj=True
    bWT_Projectile=True
    SpecialInfo(0)=(Info="360.0;40.0;1.0;90.0;0.0;0.5;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-Pullout',Volume=0.750000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway',Volume=0.600000)
    MagAmmo=100
    CockAnimPostReload="Idle"
    CockAnim="Idle"
    ClipInFrame=0.700000
    bNeedCock=False
    bCockOnEmpty=False
	bNonCocking=True
	bNoMag=True
	ParamsClasses(0)=Class'SuperchargerWeaponParamsComp'
	ParamsClasses(1)=Class'SuperchargerWeaponParamsClassic'
	ParamsClasses(2)=Class'SuperchargerWeaponParamsRealistic'
    ParamsClasses(3)=Class'SuperchargerWeaponParamsTactical'
    WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
    WeaponModes(1)=(ModeName="Max Safe Voltage",Value=5.000000)
    WeaponModes(2)=(ModeName="Overload")
	CurrentWeaponMode=2
	ScopeViewTex=Texture'BWBP_SKC_Tex.XM20.XM20-ScopeView'
    NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.R78OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.G5InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=0,A=255),Color2=(B=0,G=0,R=255,A=255),StartSize1=90,StartSize2=93)
    GunLength=16.500000
    LongGunPivot=(Pitch=2000,Yaw=-1024)
    LongGunOffset=(X=-10.000000,Y=0.000000,Z=-5.000000)
	PutDownTime=1.500000
	BringUpTime=1.50000
    SelectAnimRate=1.0
    PutDownAnimRate=1.0
    FireModeClass(0)=Class'BWBP_SKC_Pro.Supercharger_PrimaryFire'
    FireModeClass(1)=Class'BWBP_SKC_Pro.Supercharger_SecondaryFire'
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.600000
    CurrentRating=0.600000
    bShowChargingBar=True
    Description="Van Holt 500KW Supercharger||Manufacturer: Dipheox Combat Arms|Primary: Directed Energy Fire|Secondary: Magnetically Contained Projectile||Not much is known about this enigmatic CYLO variation. It is extremely rare and a cloesly guarded secret."
    Priority=41
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
    InventoryGroup=5
    PickupClass=Class'BWBP_SKC_Pro.Supercharger_Pickup'

    PlayerViewOffset=(X=8.00,Y=6.50,Z=-3.50)
	SightOffset=(X=27.50,Y=0.00,Z=4.30)

    AttachmentClass=Class'BWBP_SKC_Pro.Supercharger_Attachment'
    IconMaterial=Texture'BWBP_SKC_Tex.SuperCharger.SmallIcon_Super'
    IconCoords=(X2=127,Y2=31)
    ItemName="V-H 500KW Supercharger"
    LightType=LT_Pulse
    LightEffect=LE_NonIncidence
    LightHue=30
    LightSaturation=150
    LightBrightness=150.000000
    LightRadius=4.000000
    Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Supercharger'
    DrawScale=0.300000
    Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
    Skins(1)=Combiner'BW_Core_WeaponTex.M50.NoiseComb'
    Skins(2)=Combiner'BW_Core_WeaponTex.M50.NoiseComb'
    Skins(3)=Texture'BWBP_SKC_Tex.SuperCharger.Supercharger-Main'
}

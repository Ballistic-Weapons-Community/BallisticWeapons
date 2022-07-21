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

var bool	bArcOOA;			// Arcs have been killed cause ammo is out
var Actor	Arc1;				// The decorative side arc
var Actor	Arc2;				// The top arcs
var Actor	Arc3;
var Actor	ClawSpark1;			// Sparks attached to claws when tracking enemy
var Actor	ClawSpark2;
var float	ClawAlpha;			// An alpha amount for claw movement interpolation

var bool		bLatchedOn;


replication
{
	reliable if (Role==ROLE_Authority)
		ChargeControl, ClientOverCharge, ClientSetHeat, bLatchedOn;
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
			MagAmmo = BallisticWeaponPickup(Pickup).MagAmmo;
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


	if (level.DetailMode>DM_Low)
	{
		if (AmmoAmount(0) < 1 && !FireMode[1].bIsFiring)	{	
			if (!bArcOOA)
			{
				bArcOOA=true;
				if (Arc1 != None)	Arc1.Destroy();
				if (Arc2 != None)	Arc2.Destroy();
				if (Arc3 != None)	Arc3.Destroy();
			}	
		}
		else if (bArcOOA)
		{
			bArcOOA = false;
			InitArcs();
		}
	}

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

	super.BringUp(PrevWeapon);

	AmbientSound = None;
	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = true;
	if (AmmoAmount(0) > 0 && level.DetailMode>DM_Low)
		InitArcs();
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

		if (Arc1 != None)	Arc1.Destroy();
		if (Arc2 != None)	Arc2.Destroy();
		if (Arc3 != None)	Arc3.Destroy();
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


simulated function ResetArcs()
{
	if (level.DetailMode>DM_Low)
	{
		if (Arc1==None && bArcOOA)
			return;
		InitArcs();
	}
}
simulated function InitArcs()
{
	if (Arc1 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc1, class'HVCMk9_SideArc', DrawScale, self, 'Arc3');
	if (Arc2 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc2, class'HVCMk9_TopArc',  DrawScale, self, 'Arc1');
	if (Arc3 == None)
		class'bUtil'.static.InitMuzzleFlash(Arc3, class'HVCMk9_TopArc',  DrawScale, self, 'Arc2');
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
	if (Arc1 != None)
	{	Emitter(Arc1).Kill();	Arc1=None;	}
	if (Arc2 != None)
	{	Emitter(Arc2).Kill();	Arc2=None;	}
	if (Arc3 != None)
	{	Emitter(Arc3).Kill();	Arc3=None;	}
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
	if (AmmoAmount(0) > 0 && level.DetailMode>DM_Low)
		InitArcs();
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

	if (Arc1 != None)
		Arc1.Destroy();
	if (Arc2 != None)
		Arc2.Destroy();
	if (Arc3 != None)
		Arc3.Destroy();
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
    if (Dist > FireMode[1].MaxRange())
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
	local float Result, Dist;
	local Controller C;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Rand(2);

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	if (level.Game.bTeamGame && Rand(7) < B.Skill)
	{
		for (C=level.ControllerList;C!=None;C=C.nextController)
			if (Instigator.Controller.SameTeamAs(C) && C.Pawn != None && Normal(C.Pawn.Location - Instigator.Location) Dot Normal(B.Enemy.Location - Instigator.Location) > 0.75)
				return 1;
	}
	Result = FRand()-0.1;
	if (Instigator.PhysicsVolume.bWaterVolume)
	{
		if (B.Enemy.PhysicsVolume == Instigator.PhysicsVolume && Dist > 200)
			Result -= 0.5;
		else if (Dist < 200)
			Result += 0.4;
		if (Result > 0.5)
			return 1;
		return 0;
	}

	// Stubborn ass bots want to keep zapping
	if (NextChangeMindTime > level.TimeSeconds)
		return 0;

	if (HeatLevel > 5)
		Result -= 0.1 * B.Skill * ((HeatLevel-5)/5);
	if (Dist > 1150)
		Result += 0.08 * B.Skill;
	else if (Dist < 500)
		result -= 0.05 * B.Skill;
	if (VSize(B.Enemy.Velocity) < 100)
		Result += 0.3;
	Result += 0.4 * (FMax(0.0, Normal(B.Enemy.Velocity) Dot vector(Instigator.GetViewRotation())) * 2 - 1);

	if (Result > 0.5)
		return 1;
	NextChangeMindTime = level.TimeSeconds + 4;
	return 0;
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
	VentingSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Coolant'
	OverheatSound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	UsedAmbientSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
     AIReloadTime=0.200000
     BigIconMaterial=Texture'BWBP_SKC_Tex.AK91.BigIcon_AK91'
     //BallisticInventoryGroup=6
	BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
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
//	bShowChargingBar=True
	 bNoMag=True
	ParamsClasses(0)=Class'SuperchargerWeaponParamsArena'
	ParamsClasses(1)=Class'SuperchargerWeaponParamsClassic' \\todo: lots of state code
     WeaponModes(0)=(bUnavailable=True,ModeID="WM_None")
     WeaponModes(1)=(ModeName="Max Safe Voltage",Value=5.000000)
     WeaponModes(2)=(ModeName="Overload")
	CurrentWeaponMode=2
	ScopeViewTex=Texture'BWBP_SKC_Tex.Eagle.Eagle-ScopeView'
//     RecoilXCurve=(Points=(,(InVal=0.100000,OutVal=0.010000),(InVal=0.200000,OutVal=0.250000),(InVal=0.300000,OutVal=-0.300000),(InVal=0.600000,OutVal=-0.250000),(InVal=0.700000,OutVal=0.250000),(InVal=1.000000,OutVal=-0.300000)))
//     RecoilYCurve=(Points=(,(InVal=0.100000,OutVal=0.180000),(InVal=0.200000,OutVal=-0.200000),(InVal=0.300000,OutVal=0.300000),(InVal=0.600000,OutVal=-0.150000),(InVal=0.700000,OutVal=0.300000),(InVal=1.000000,OutVal=0.600000)))
     SightOffset=(X=-25.000000,Z=19.500000)
     SightDisplayFOV=40.000000
//     CrosshairCfg=(Pic1=Texture'BallisticUI2.Crosshairs.R78OutA',Pic2=Texture'BallisticUI2.Crosshairs.G5InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=0,G=0,R=0,A=255),Color2=(B=0,G=0,R=255,A=255),StartSize1=90,StartSize2=93)
     GunLength=16.500000
     LongGunPivot=(Pitch=2000,Yaw=-1024)
     LongGunOffset=(X=-10.000000,Y=0.000000,Z=-5.000000)
//     CrouchAimFactor=0.800000
//     JumpOffSet=(Pitch=1000,Yaw=-500)
//     JumpChaos=0.300000
//     AimAdjustTime=0.400000
//     AimSpread=(X=(Min=-32.000000,Max=32.000000),Y=(Min=-32.000000,Max=32.000000))
//     ChaosAimSpread=(X=(Min=-1048.000000,Max=1048.000000),Y=(Min=-1600.000000,Max=1600.000000))
//     ViewAimFactor=0.050000
//     ViewRecoilFactor=0.200000
//     ChaosDeclineTime=1.000000
//     ChaosTurnThreshold=170000.000000
//     ChaosSpeedThreshold=1200.000000
//     RecoilXFactor=0.250000
//     RecoilYFactor=0.250000
//     RecoilMax=1600.000000
//     RecoilDeclineTime=0.800000
     FireModeClass(0)=Class'BWBP_SKC_Pro.Supercharger_PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.Supercharger_SecondaryFire'
     PutDownTime=0.700000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.600000
     CurrentRating=0.600000
     bShowChargingBar=True
     Description="Van Holt 500KW Supercharger||Manufacturer: Dipheox Combat Arms|Primary: Directed Energy Fire|Secondary: Magnetically Contained Projectile||Not much is known about this enigmatic CYLO variation. It is extremely rare and a cloesly guarded secret."
     DisplayFOV=55.000000
     Priority=41
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=4
     PickupClass=Class'BWBP_SKC_Pro.Supercharger_Pickup'
     PlayerViewOffset=(X=5.000000,Y=5.000000,Z=-11.000000)
     BobDamping=2.000000
     AttachmentClass=Class'BWBP_SKC_Pro.Supercharger_Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.AK91.SmallIcon_AK91'
     IconCoords=(X2=127,Y2=31)
     ItemName="[B] Van Holt 500KW Supercharger"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=30
     LightSaturation=150
     LightBrightness=150.000000
     LightRadius=4.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_Supercharger'
     DrawScale=0.360000
}

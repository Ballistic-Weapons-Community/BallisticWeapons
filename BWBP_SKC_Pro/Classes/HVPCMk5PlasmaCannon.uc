//=============================================================================
// H-V Plasma Cannon Mk5
//
// Red plasma cannon. Overheats and damages the player for massive damage if
// used too much. Can be cooled down.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class HVPCMk5PlasmaCannon extends BallisticWeapon;

var float		HeatLevel;			// Current Heat level, duh...
var bool		bIsVenting;			// Busy venting
var() Sound		VentingSound;		// Sound to loop when venting
var() Sound		OverHeatSound;		// Sound to play when it overheats

var bool		bWaterBurn;			// busy getting damaged in water

var bool	bArcOOA;			// Arcs have been killed cause ammo is out
var Actor CoolantSmoke;			// Gas emitted when cooling gun
//var Actor	Arc1;				// The decorative side arc
//var Actor	Arc2;				// The top arcs
//var Actor	Arc3;
var Actor	Spiral;				// Red spiral that activates when charging secondary
var Actor	ClawSpark1;			// Sparks attached to claws when tracking enemy
var Actor	ClawSpark2;
var float	ClawAlpha;			// An alpha amount for claw movement interpolation
var float	RotorSpin;			// Rotation of rotor


var Emitter		FreeZap;		// The free zap emitter
var bool		bCanKillZap;	// Free zap is being killed and can be destroyed if needed, but we still want it rendered till then

var float		NextChangeMindTime;	// For AI
replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientOverCharge, ClientSetHeat;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsRealism())
	{
		HVPCMk5PrimaryFire(FireMode[0]).ProjectileCount = 1;
		HVPCMk5PrimaryFire(FireMode[0]).HeatPerShot = 1.0;
	}
}

// -----------------------------------------------
// Events and target related stuff called from firemodes

simulated function ClientOverCharge()
{
	if (Firemode[1].bIsFiring)
		StopFire(1);
}

// -----------------------------------------------
// Heat stuff

simulated function float ChargeBar()
{
	return HeatLevel / 10;
}
simulated event Tick (float DT)
{
	if (HeatLevel > 0)
	{
		if (bIsVenting)
			Heatlevel = FMax(HeatLevel - 2.5 * DT, 0);
		else
			Heatlevel = FMax(HeatLevel - 0.25 * DT, 0);
	}

	super.Tick(DT);
}

simulated function AddHeat(float Amount)
{
	if (HeatLevel >= 9.5 && HeatLevel < 15)
	{
		Heatlevel = 15;
		PlaySound(OverHeatSound,,0.7,,32);
		class'BallisticDamageType'.static.GenericHurt (Instigator, 80, Instigator, Instigator.Location, -vector(Instigator.GetViewRotation()) * 30000 + vect(0,0,10000), class'DTPlasmaCannonOverheat');
	}

	HeatLevel += Amount;
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
		if (HVPCMk5Pickup(Pickup) != None)
			HeatLevel = FMax( 0.0, HVPCMk5Pickup(Pickup).HeatLevel - (level.TimeSeconds - HVPCMk5Pickup(Pickup).HeatTime) * 0.25 );
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
		class'BallisticDamageType'.static.GenericHurt (Instigator, 2, Instigator, Location, vect(0,0,0), class'DTPlasmaCannonOverHeat');
	}
}

simulated event WeaponTick(float DT)
{
	local vector End;

	super.WeaponTick(DT);

	//Heat based effect code
	
	if (HeatLevel >= 7 && Spiral == None)
		class'bUtil'.static.InitMuzzleFlash(Spiral, class'HVPCMk66_GreenSpiral', DrawScale, self, 'tip');
	else if (HeatLevel < 7)
	{
		if (Spiral != None)
			Emitter(Spiral).kill();
	}
		
	
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

	if (FireMode[1].bIsFiring)	{	if (ClawAlpha < 1)
	{
		ClawAlpha = FClamp(ClawAlpha + DT, 0, 1);
		SetBoneRotation('Claw1', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw1B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3B', rot(-8192,0,0),0,ClawAlpha);
	}	}
	else if (ClawAlpha > 0)
	{
		ClawAlpha = FClamp(ClawAlpha - DT/3, 0, 1);
		SetBoneRotation('Claw1', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw1B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw2B', rot(-8192,0,0),0,ClawAlpha);
		SetBoneRotation('Claw3B', rot(-8192,0,0),0,ClawAlpha);
	}
	if (level.DetailMode>DM_Low)
	{
		if (AmmoAmount(0) < 1 && !FireMode[1].bIsFiring)	
		{	
			if (!bArcOOA)
				bArcOOA = true;
		}
		
		else if (bArcOOA)
		{
			bArcOOA = false;
		}

		if (!bArcOOA)
		{
			RotorSpin += DT*(65536 + 65536 * ClawAlpha);
			SetBoneRotation('Spinner', rot(0,0,1)*RotorSpin,0,1.f);
		}
	}

	if (ClawSpark1 != None)
	{
		End = GetBoneCoords('tip').Origin + vector(Instigator.GetViewRotation()) * 96;
		BeamEmitter(Emitter(ClawSpark1).Emitters[0]).BeamEndPoints[0].Offset = class'BallisticEmitter'.static.VtoRV(End, End);
		if (ClawSpark2 != None)
			BeamEmitter(Emitter(ClawSpark2).Emitters[0]).BeamEndPoints[0].Offset = BeamEmitter(Emitter(ClawSpark1).Emitters[0]).BeamEndPoints[0].Offset;
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

		if (CoolantSmoke != None) CoolantSmoke.Destroy();
		//if (Arc1 != None)	Arc1.Destroy();
		//if (Arc2 != None)	Arc2.Destroy();
		//if (Arc3 != None)	Arc3.Destroy();
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
		Emitter(Spiral).kill();
		Spiral = None;
	}
}

simulated function InitGas()
{
	if (CoolantSmoke == None)
		class'bUtil'.static.InitMuzzleFlash(CoolantSmoke, class'PumaGlowFXDamaged', DrawScale, self, 'tip');
}

// -----------------------------------------------
// Reload / Venting stuff
simulated function bool IsGoingToVent()
{
    local name anim;
    local float frame, rate;
    GetAnimParams(0, anim, frame, rate);
	if (Anim == 'ReloadStart')
 		return true;
	return false;
}

exec simulated function Reload(optional byte i)
{
	if (!IsFiring())
		SafePlayAnim('ReloadStart', 1.0, 0.1);
}

simulated function Notify_LGArcOff()
{
	Instigator.AmbientSound = VentingSound;
	Instigator.SoundVolume = 128;
	
	if (level.DetailMode>DM_Low)
		InitGas();
}

simulated event AnimEnd (int Channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

	if (Anim == 'ReloadStart')
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

exec simulated  function ReloadRelease(optional byte i)
{
    local name anim;
    local float frame, rate;

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	if (!bIsVenting)
	{
		GetAnimParams(0, anim, frame, rate);
		if (Anim != 'ReloadStart')
			return;
		SafePlayAnim('ReloadEnd', 1.0, 0.2);
		if (frame < 0.5)
			SetAnimFrame(1-frame);
	}
	else
		SafePlayAnim('ReloadEnd', 1.0, 0.2);

	if (level.NetMode == NM_Client)
		bIsVenting = false;
	ServerReloadRelease();
}

simulated function Notify_LGArcOn()
{
	if (CoolantSmoke != None)
		CoolantSmoke.Destroy();
}

function ServerReloadRelease(optional byte i)
{
	if (!Instigator.IsLocallyControlled())
	{	Instigator.AmbientSound = UsedAmbientSound;
		Instigator.SoundVolume = default.SoundVolume;	}
	bIsVenting = false;
}

// End Venting -----------------------------------

simulated function vector ConvertFOVs (vector InVec, float InFOV, float OutFOV, float Distance)
{
	local vector ViewLoc, Outvec, Dir, X, Y, Z;
	local rotator ViewRot;

	ViewLoc = Instigator.Location + Instigator.EyePosition();
	ViewRot = Instigator.GetViewRotation();
	Dir = InVec - ViewLoc;
	GetAxes(ViewRot, X, Y, Z);

    OutVec.X = Distance / tan(OutFOV * PI / 360);
    OutVec.Y = (Dir dot Y) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec.Z = (Dir dot Z) * (Distance / tan(InFOV * PI / 360)) / (Dir dot X);
    OutVec = OutVec >> ViewRot;

	return OutVec + ViewLoc;
}

simulated function Destroyed()
{
	if (FreeZap != None)
		FreeZap.Destroy();
	if (CoolantSmoke != None)
		CoolantSmoke.Destroy();
	if (ClawSpark1 != None)
		ClawSpark1.Destroy();
	if (ClawSpark2 != None)
		ClawSpark2.Destroy();
	if (Spiral != None)
		Spiral.Destroy();
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
	local float Result, Dist;
	local vector Dir;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return Super.GetAIRating();

	Dir = B.Enemy.Location - Instigator.Location;
	Dist = VSize(Dir);

	Result = Super.GetAIRating();
	if (Instigator.PhysicsVolume.bWaterVolume)
		Result -= 0.15 * B.Skill;
	if (Dist > 1600)
	{
		Result -= (Dist-1360)/1500;
		if (B.Enemy.Weapon != None && B.Enemy.Weapon.bSniping)
			Result -= 0.08 * B.Skill;
	}
	else if (Dist > 1200)
		Result -= 0.15;
	if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result += 0.07 * B.Skill;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.5;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.5;	}
// End AI Stuff =====

defaultproperties
{
	 bNoCrosshairInScope=True
     VentingSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Coolant'
     OverHeatSound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Overload'
     PlayerSpeedFactor=0.800000
     PlayerJumpFactor=0.700000
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     UsedAmbientSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Ambient'
     AIReloadTime=0.200000
     BigIconMaterial=Texture'BWBP_SKC_Tex.HVPC.BigIcon_HVPC'
     bWT_Hazardous=True
     bWT_Energy=True
     bWT_Super=True
     SpecialInfo(0)=(Info="360.0;50.0;1.0;90.0;0.0;0.5;1.0")
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.XavPlas.Xav-Select',Volume=0.220000)
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.LightningGun.LG-Putaway',Volume=0.218000)
     bNoMag=True
     WeaponModes(1)=(bUnavailable=True,Value=4.000000)
     FireModeClass(0)=Class'BWBP_SKC_Pro.HVPCMk5PrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.HVPCMk5SecondaryFire'
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.M50Out',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc4',USize2=256,VSize2=256,Color2=(B=153,G=168,R=170,A=83),StartSize2=84)
     NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
     NDCrosshairChaosFactor=0.700000
	 PutDownTime=0.500000
     BringUpTime=0.500000
     AIRating=0.750000
     CurrentRating=0.600000
     bShowChargingBar=True
     Description="H-V Magnetic Plasma Cannon Mk5||Manufacturer: Nexron Defence|Primary: Contained Plasma Charge|Secondary: Directed Plasma Pulse||[Document Begins] The High Voltage Magnetic Plasma Cannon [Mark 5] - Codename 'Shock & Awe' - is a potent energy delivery system. State of the art magnetically charged sustaining coils powered by a portable back-mounted power generator can now, due to a recent breakthrough in plasma technology, successfully govern an operational array of plasma injectors. The Mk-5 uses these injectors to artificially condense and contain small 1 eV plasma 'charges' that can be propelled at high velocities towards hostile forces. Testing is currently underway. [Document Ends]"
     Priority=73
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=10
     PickupClass=Class'BWBP_SKC_Pro.HVPCMk5Pickup'
     PlayerViewOffset=(X=6.00,Y=5,Z=-9.00000)
     SightOffset=(X=-2.50,Y=0.00,Z=7.75)
	 SightPivot=(Pitch=256)
	 SightAnimScale=0.5
	 SightBobScale=0.35f
     AttachmentClass=Class'BWBP_SKC_Pro.HVPCMk5Attachment'
     IconMaterial=Texture'BWBP_SKC_Tex.HVPC.SmallIcon_HVPC'
     IconCoords=(X2=127,Y2=31)
     ItemName="H-V Plasma Cannon Mk5"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=180
     LightSaturation=100
     LightBrightness=192.000000
     LightRadius=12.000000
	 ParamsClasses(0)=Class'HVPCMk5WeaponParamsComp'
	 ParamsClasses(1)=Class'HVPCMk5WeaponParamsClassic'
	 ParamsClasses(2)=Class'HVPCMk5WeaponParamsRealistic'
	 ParamsClasses(3)=Class'HVPCMk5WeaponParamsTactical'
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_HVPC'
     DrawScale=0.300000
     Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
     bFullVolume=True
     SoundVolume=64
     SoundRadius=128.000000
}

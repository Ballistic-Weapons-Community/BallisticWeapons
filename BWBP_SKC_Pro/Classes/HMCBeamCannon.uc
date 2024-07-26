//=============================================================================
// HMCBeamCannon.
//
// An extremely damn complicated beam cannon.
// Filled with useless code that is not necessarily commented out.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class HMCBeamCannon extends BallisticWeapon;

var() 	bool 			bGravitron; 	//firemodes affect player speed, knockback
var()   bool			bRedTeam;		//Owned by red team?
var() 	bool 			bTeamSet;

var()   bool			bIsCharging;
var() 	Actor			Glow1;				// Blue charge effect
var() 	Actor			Glow2;				// Red charge effect
var() 	Sound			FullyChargedSound;
var() 	Sound			OverHeatSound;		// Sound to play when it overheats
var()   float 			Heat;
var()   float 			CoolRate;

var()   bool			bLaserOn;
var()   bool			bBigLaser;
var()   bool			bGreenLaser;
var()   bool			bOldGreenLaser;
var()   LaserActor		Laser;
var()   Emitter			LaserDot;



replication
{
	reliable if (Role == ROLE_Authority)
		ClientOverCharge, ClientSetHeat, bLaserOn, bGreenLaser, ClientSwitchHMCMode;
}

simulated function OnWeaponParamsChanged()
{
    super.OnWeaponParamsChanged();
		
	assert(WeaponParams != None);
	bGravitron=false;
	if (InStr(WeaponParams.LayoutTags, "grav") != -1)
	{
		bGravitron=true;
	}
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	HMCSecondaryFire(FireMode[1]).SwitchWeaponMode(CurrentWeaponMode);
}

function ServerSwitchWeaponMode(byte NewMode)
{
    if (Firemode[0].bIsFiring || Heat > 0)
        return;

	super.ServerSwitchWeaponMode(NewMode);
	if (!Instigator.IsLocallyControlled())
		HMCSecondaryFire(FireMode[1]).SwitchWeaponMode(CurrentWeaponMode);

 	if(ThirdPersonActor != None)
	{
		if (CurrentWeaponMode == 2) 
			bGreenLaser=True;
		else	
			bGreenLaser=False;
		if(bGreenLaser) 
			Laser.Skins[0]=TexPanner'BWBP_SKC_Tex.BeamCannon.LaserPannerGreen';
		else Laser.Skins[0]=Laser.default.Skins[0];
		
		HMCAttachment(ThirdPersonActor).SwitchMedicLaser(bGreenLaser);
	}
	ClientSwitchHMCMode(CurrentWeaponMode);
}
simulated function ClientSwitchHMCMode (byte NewMode)
{
	HMCSecondaryFire(FireMode[1]).SwitchWeaponMode(NewMode);
}

simulated function PlayIdle()
{
	if (bPendingSightUp)
		ScopeBackUp();
	else if (SightingState != SS_None)
	{
		if (SafePlayAnim(IdleAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else if (bScopeView)
	{
		if(SafePlayAnim(ZoomOutAnim, 1.0))
			FreezeAnimAt(0.0);
	}
	else
	    SafeLoopAnim(IdleAnim, IdleAnimRate, IdleTweenTime, ,"IDLE");
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

simulated function ClientOverCharge()
{
	if (Firemode[1].bIsFiring)
		StopFire(1);
}

simulated function ClientSetHeat(float NewHeat)
{
	Heat = NewHeat;
}

simulated event PostNetReceive()
{
    if (bLaserOn != default.bLaserOn)
	{
		default.bLaserOn = bLaserOn;
		ClientSwitchLaser();
	}
	if (bGreenLaser != bOldGreenLaser)
	{
		if(bGreenLaser) Laser.Skins[0]=TexPanner'BWBP_SKC_Tex.BeamCannon.LaserPannerGreen';
		else  Laser.Skins[0]=Laser.default.Skins[0];
		bOldGreenLaser = bGreenLaser;
	}
	Super.PostNetReceive();
}

function ServerSwitchLaser(bool bNewLaserOn)
{
	if (bLaserOn == bNewLaserOn)
		return;
	bLaserOn = bNewLaserOn;
	if (ThirdPersonActor != None)
		HMCAttachment(ThirdPersonActor).bLaserOn = bLaserOn;
    if (Instigator.IsLocallyControlled())
		ClientSwitchLaser();
}

simulated function ClientSwitchLaser()
{
	if (!bLaserOn)
		KillLaserDot();
	PlayIdle();
}

simulated function KillLaserDot()
{
	if (LaserDot != None)
	{
		LaserDot.bHidden=false;
		LaserDot.Kill();
		LaserDot = None;
	}
}
simulated function SpawnLaserDot(vector Loc)
{
	if (LaserDot == None)
	{
		if (Instigator != None && bRedTeam)
			LaserDot = Spawn(class'BallisticProV55.IE_GRS9LaserHit',,,Loc);
		else
          	LaserDot = Spawn(class'BWBP_SKC_Pro.IE_HMCLase',,,Loc);
	}
}

simulated function bool PutDown()
{
	if (Super.PutDown())
	{
		KillLaserDot();
		if (Glow1 != None)	Glow1.Destroy();
		if (Glow2 != None)	Glow2.Destroy();
		if (ThirdPersonActor != None)
			HMCAttachment(ThirdPersonActor).bLaserOn = false;
		return true;
	}

		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;

	return false;
}

simulated function Destroyed ()
{
	default.bLaserOn = false;

	if (Laser != None)
		Laser.Destroy();
	if (LaserDot != None)
		LaserDot.Destroy();

	if (Glow1 != None)	Glow1.Destroy();
	if (Glow2 != None)	Glow2.Destroy();
	if (Instigator.AmbientSound == UsedAmbientSound)
	{
		Instigator.AmbientSound = None;
		Instigator.SoundVolume = Instigator.default.SoundVolume;
		Instigator.SoundPitch = Instigator.default.SoundPitch;
		Instigator.SoundRadius = Instigator.default.SoundRadius;
		Instigator.bFullVolume = Instigator.default.bFullVolume;
	}
	Super.Destroyed();
}

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

simulated function DrawLaserSight ( Canvas Canvas )
{
	local Vector HitLocation, Start, End, HitNormal, Scale3D, Loc;
	local Rotator AimDir;
	local Actor Other;
    local bool bAimAligned;

	if ((ClientState == WS_Hidden) || (!bLaserOn))
		return;

	AimDir = BallisticFire(FireMode[0]).GetFireAim(Start);
	Loc = GetBoneCoords('tip').Origin;

	End = Start + Normal(Vector(AimDir))*3000;
	Other = FireMode[0].Trace (HitLocation, HitNormal, End, Start, true);
	if (Other == None)
		HitLocation = End;

	// Draw dot at end of beam
	if (ReloadState == RS_None && ClientState == WS_ReadyToFire && !IsInState('DualAction') && Level.TimeSeconds - FireMode[0].NextFireTime > 0.1)
		bAimAligned = true;

	if (bAimAligned && Other != None)
		SpawnLaserDot(HitLocation);
	else
		KillLaserDot();
	if (LaserDot != None)
	{
		LaserDot.SetLocation(HitLocation);
		LaserDot.SetRotation(rotator(HitNormal));
		LaserDot.Emitters[0].AutomaticInitialSpawning = Other.bWorldGeometry;
		LaserDot.Emitters[3].AutomaticInitialSpawning = Other.bWorldGeometry;
		Canvas.DrawActor(LaserDot, false, false, Instigator.Controller.FovAngle);
	}

	// Draw beam from bone on gun to point on wall(This is tricky cause they are drawn with different FOVs)
	Laser.SetLocation(Loc);
	HitLocation = ConvertFOVs(End, Instigator.Controller.FovAngle, DisplayFOV, 400);
	if (bAimAligned)
		Laser.SetRotation(Rotator(HitLocation - Loc));
	else
	{
		AimDir = GetBoneRotation('muzzle');
		Laser.SetRotation(AimDir);
	}

	Scale3D.X = VSize(HitLocation-Loc)/128;
	if (bBigLaser)
	{
		Scale3D.Y = 16;
		Scale3D.Z = 16;
	}
	else
	{
		Scale3D.Y = 8;
		Scale3D.Z = 8;
	}
	Laser.SetDrawScale3D(Scale3D);
	Canvas.DrawActor(Laser, false, false, DisplayFOV);
}

simulated event RenderOverlays( Canvas Canvas )
{
	super.RenderOverlays(Canvas);
	if (IsInState('Lowered'))
		return;
	DrawLaserSight(Canvas);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	
	if ( !bTeamSet && (Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) )
	{
		bTeamSet = true;
		if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
		{
			bRedTeam = True;
			BFireMode[0].BallisticFireSound.Sound=HMCPrimaryFire(BFireMode[0]).RTeamFireSound;
     		BFireMode[0].MuzzleFlashClass=Class'BWBP_SKC_Pro.A48FlashEmitter';
		}
	}
	
	if (Instigator != None && Laser == None)
	{
		if ( bRedTeam )
			Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_HMCRed');
		else Laser = Spawn(class'BWBP_SKC_Pro.LaserActor_HMC');
	}

	Instigator.AmbientSound = UsedAmbientSound;
	Instigator.SoundVolume = default.SoundVolume;
	Instigator.SoundPitch = default.SoundPitch;
	Instigator.SoundRadius = default.SoundRadius;
	Instigator.bFullVolume = false;
}

simulated event Tick (float DT)
{
	super.Tick(DT);
	if (FireMode[1].bIsFiring)
		CoolRate = 0;
	else 
		CoolRate = 0.5;
	if (FireMode[0].bIsFiring || HMCPrimaryFire(Firemode[0]).RailPower > 0)
		bIsCharging = true;
	else
		bIsCharging = false;
	if (!IsFiring())
	{
    	Heat = FMax(0, Heat - CoolRate*DT);

    	if (level.Netmode == NM_DedicatedServer)
		Heat = 0;
	}
}

simulated event WeaponTick(float DT)
{
	super.WeaponTick(DT);

	if (Firemode[0].bIsFiring)
	{
		if (bRedTeam)
			class'bUtil'.static.InitMuzzleFlash(Glow1, class'HMCBarrelGlowRed', DrawScale, self, 'tip');
		else
			class'bUtil'.static.InitMuzzleFlash(Glow1, class'HMCBarrelGlow', DrawScale, self, 'tip');
	}
	else
	{
		if (Glow1 != None)	Glow1.Destroy();
		if (Glow2 != None)	Glow2.Destroy();
	}
	if (AmmoAmount(0) < 10)
	{
		HMCPrimaryFire(Firemode[0]).RailPower = 0;
		Heat = 0;
		Instigator.AmbientSound = None;
	}
}

simulated function AddHeat(float Amount)
{
	Heat += Amount;
	if (Heat > 1.0 && Heat < 1.2)
	{
		Heat = 1.2;
		PlaySound(OverHeatSound,,6.7,,64);
	}
}

simulated function bool MayNeedReload(byte Mode, float Load)
{
	return false;
}

function ServerStartReload (optional byte i);

//Gravity Stuff

simulated function TargetedSlowRadius( float SlowAmount, float SlowDuration, float SlowRadius, vector HitLocation, optional Pawn ExcludedPawn )
{
	local Pawn target;
	local float damageScale, dist;
	local vector dir;
    local UnlaggedPawnCollision col;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Pawn', target, SlowRadius, HitLocation )
	{
		if (target != ExcludedPawn)
		{
			dir = target.Location - HitLocation;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - target.CollisionRadius)/SlowRadius);
			class'BCSprintControl'.static.AddSlowTo(target, damageScale * SlowAmount, damageScale * SlowDuration);
		}
	}
	bHurtEntry = false;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
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
	if (Dist > 700)
	{
		if (FRand() > 0.6 && Frand() < 0.7)
		{
			if (CurrentWeaponMode != 2)
			{
				CurrentWeaponMode = 2;
			}
		}
		Result += 0.3;
	}
	else if (B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		Result -= 0.05 * B.Skill;
	if (Dist > 2000)
		Result -= (Dist-2000) / 4000;

	return Result;
}
// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.1;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return 0.5;	}
// End AI Stuff =====

simulated function float ChargeBar()
{
    return FMin((Heat + HMCPrimaryFire(Firemode[0]).RailPower), 1);
}

defaultproperties
{
     OverHeatSound=Sound'BW_Core_WeaponSound.LightningGun.LG-OverHeat'
     FullyChargedSound=Sound'BW_Core_WeaponSound.LightningGun.LG-Charge'
     CoolRate=0.500000
     SpecialInfo(0)=(Info="300.0;20.0;1.80;80.0;0.8;0.8;0.1")
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SKC_Tex.BeamCannon.BigIcon_HMC'
     BringUpSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Up')
     PutDownSound=(Sound=Sound'BWBP_SKC_Sounds.BeamCannon.Beam-Down')
     WeaponModes(0)=(ModeName="Full Power",ModeID="WM_FullAuto",Value=0.250000)
     WeaponModes(1)=(ModeName="Repulsor Beam",ModeID="WM_FullAuto",Value=1.000000,bUnavailable=true)
     WeaponModes(2)=(ModeName="Healing Beam",Value=0.333333,bUnavailable=true)
     CurrentWeaponMode=0
     SightDisplayFOV=40.000000
     bNoMag=True
     bNonCocking=True
     bWT_Energy=True
     MagAmmo=500
     FireModeClass(0)=Class'BWBP_SKC_Pro.HMCPrimaryFire'
     FireModeClass(1)=Class'BWBP_SKC_Pro.HMCSecondaryFire'
	 ParamsClasses(0)=Class'HMCBeamCannonParamsArena'
	 ParamsClasses(1)=Class'HMCBeamCannonParamsClassic'
	 ParamsClasses(2)=Class'HMCBeamCannonParamsArena'
	 ParamsClasses(3)=Class'HMCBeamCannonParamsArena'
     BringUpTime=0.500000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="HMC-117 Volatile Photon Cannon||Manufacturer: Nexron Defence|Primary: Charged Photon Blast|Secondary: Sweeping Plasma Beam|Special: None|The HMC-117 Volatile Photon Cannon, often nicknamed 'The Sentinel', was created originally as a tool for testing heat shielding on space craft. It was often used by shuttle crews for zero-G EVA repairs during rough space trips. Due to a couple horrifying accidents and its tendency to melt through bulkheads, the HMC was scrapped in favor of other testing and repair methods. Deemed an overall failure, somehow a variant of this bulky device managed to find its way onto the field and proved to be quite effective at taking out Cryon units. The power and reliability of its industrial grade photon generator was praised by many troopers and not even the strongest of Cryons could withstand a fully charged photon blast. While the original HMC power cells are long gone, Nexron modified HMCs can successfully run on HVPC power cells."
     Priority=72
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=5
     GroupOffset=4
     PickupClass=Class'BWBP_SKC_Pro.HMCPickup'

     PlayerViewOffset=(X=5,Y=13,Z=-10)
     SightOffset=(X=10.00,Y=-15.0,Z=20)
	 //SightPivot=(Pitch=748)
	 
     AttachmentClass=Class'BWBP_SKC_Pro.HMCAttachment'
     IconMaterial=Texture'BWBP_SKC_Tex.BeamCannon.SmallIcon_HMC'
     IconCoords=(X2=127,Y2=31)
     ItemName="HMC-117 Photon Cannon"
     LightType=LT_Pulse
     LightEffect=LE_NonIncidence
     LightHue=64
     LightSaturation=96
     LightBrightness=192.000000
     LightRadius=12.000000
     Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_HMC117'
     DrawScale=0.300000
     bFullVolume=True
     SoundRadius=512.000000
}

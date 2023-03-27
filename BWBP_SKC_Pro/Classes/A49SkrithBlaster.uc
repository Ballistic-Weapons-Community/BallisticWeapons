//=============================================================================
// A49 Skrith Blaster.
//
// Skrith SMG equivalent. Puts out immense damage in a projectile stream.
// Altfire is implemented here as a conical fire which blasts enemies to hell.
//
// uses code written by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class A49SkrithBlaster extends BallisticWeapon;

var	bool		bVariableHeatProps; //Gun heat changes accuracy and RoF

var float		HeatLevel;
var float 		HeatDeclineDelay;		
var bool		bIsVenting;			// Busy venting
var() Sound		OverHeatSound;		// Sound to play when it overheats
var() Sound		DamageSound;		// Sound to play when it first breaks
var() Sound		BrokenSound;		// Sound to play when its very damaged
var() class<DamageType>	BlastDamageType;

var actor VentSteam;
var actor VentSteam2;
var actor GlowFX;
var actor GlowFXDamaged;

replication
{
	reliable if (ROLE==ROLE_Authority)
		ClientSetHeat;
}

simulated event PostNetBeginPlay()
{
	super.PostNetBeginPlay();
	if (class'BallisticReplicationInfo'.static.IsClassic())
	{
		bVariableHeatProps=True;
		A49PrimaryFire(FireMode[0]).bVariableHeatProps = True;
	}
}

simulated function float ChargeBar()
{
	return HeatLevel / 10;
}

simulated function AddHeat(float Amount)
{
	HeatLevel += Amount;
	SoundPitch = 56 + HeatLevel * 11;
	
	if (HeatLevel >= 9.75 && !bVariableHeatProps)
	{
		Heatlevel = 10;
		class'BallisticDamageType'.static.GenericHurt (Instigator, 10, None, Instigator.Location, vect(0,0,0), class'DTA49OverHeat');
		return;
	}
	else if (HeatLevel >= 10.5)
	{
		Heatlevel = 15;
		ConsumeMagAmmo(0, 10);
		CommonCockGun();
	}
}

simulated function ClientSetHeat(float NewHeat)
{
	HeatLevel = NewHeat;
}

simulated event Tick (float DT)
{
	if (bVariableHeatProps && HeatLevel > 0)
	{
		if (bIsVenting)
			Heatlevel = FMax(HeatLevel - 6.5 * DT, 0);
		else
			Heatlevel = FMax(HeatLevel - 3.5 * DT, 0);
		SoundPitch = 56 + HeatLevel * 11;
	}
	else if (HeatLevel > 0 && Level.TimeSeconds > LastFireTime + HeatDeclineDelay)
	{
		HeatLevel = FMax(HeatLevel - 10 * DT, 0);
		SoundPitch = 56 + HeatLevel * 11;
	}
	
	super.Tick(DT);
}

simulated function BringUp(optional Weapon PrevWeapon)
{
	Super.BringUp(PrevWeapon);
	SoundPitch = 56;

	GunLength = default.GunLength;
	
	if (Instigator.IsLocallyControlled() && level.DetailMode == DM_SuperHigh && class'BallisticMod'.default.EffectsDetailMode >= 2 && (GlowFX == None || GlowFX.bDeleteMe))
		class'BUtil'.static.InitMuzzleFlash (GlowFX, class'A49GlowFX', DrawScale, self, 'tip');

	
}

simulated event Timer()
{
	if (Clientstate == WS_PutDown)
		class'BUtil'.static.KillEmitterEffect(GlowFX);
	super.Timer();
}

static function class<Pickup> RecommendAmmoPickup(int Mode)
{
	return class'AP_A49Clip';
}

simulated event Destroyed()
{
	if (GlowFX != None)
		GlowFX.Destroy();

	super.Destroyed();
}

simulated function CommonCockGun(optional byte Type)
{
	local int m;

	if (Role == ROLE_Authority)
		bServerReloading=true;
	ReloadState = RS_Cocking;
	PlayCocking(Type);
	for (m=0; m < NUM_FIRE_MODES; m++)
		if (BFireMode[m] != None)
			BFireMode[m].CockingGun(Type);
}

simulated function Notify_VentStart()
{
    bIsVenting=true;

	if (VentSteam != None)
	{
		VentSteam.Destroy();
		VentSteam=None;
	}
	if (VentSteam2 != None)
	{
		VentSteam2.Destroy();
		VentSteam2=None;
	}
	class'BUtil'.static.InitMuzzleFlash (VentSteam2, class'RSNovaSteam', DrawScale, self, 'LeftVent');
	class'BUtil'.static.InitMuzzleFlash (VentSteam, class'RSNovaSteam', DrawScale, self, 'RightVent');

	VentSteam.SetRelativeRotation(rot(10000,0,0));
	VentSteam2.SetRelativeRotation(rot(0,32768,0));

}

simulated function Notify_VentEnd()
{
    	bIsVenting=false;
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local Vector Dir;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None  || B.Enemy == None)
		return 0;

	Dir = Instigator.Location - B.Enemy.Location;
	Dist = VSize(Dir);

	if (AmmoAmount(0) < BFireMode[1].AmmoPerFire)
		return 0;

	if (B.Squad!=None)
	{
		if ( ( (DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()))
			|| (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
	    	 && (B.Enemy == None || !B.EnemyVisible()) )
			return 0;
		if ( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
			return 0;

		V = B.Squad.GetLinkVehicle(B);
		if ( V == None )
			V = Vehicle(B.MoveTarget);
		if ( V == B.Target )
			return 0;
		if ( (V != None) && (V.Health < V.HealthMax) && (V.LinkHealMult > 0) && B.LineOfSightTo(V) )
			return 0;
	}

	if (Dist < (FireMode[1].MaxRange()-100) && B.Enemy.Weapon != None && B.Enemy.Weapon.bMeleeWeapon)
		return 1;
		
	return 0;
}

function float GetAIRating()
{
	local Bot B;
	local float Dist, Rating;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if (HasMagAmmo(0) || Ammo[0].AmmoAmount > 0)
	{
		if (RecommendHeal(B))
			return 1.2;
	}

	Rating = Super.GetAIRating();

	if (B.Enemy == None)
		return Rating;

	Dist = VSize(B.Enemy.Location - Instigator.Location);
	
	Rating = class'BUtil'.static.DistanceAtten(Rating, 0.6, Dist, 768, 2048); 
	
	if (HeatLevel > 8)
		Rating *= 0.65;
		
	return Rating;
}

function bool FocusOnLeader(bool bLeaderFiring)
{
	local Bot B;
	local Pawn LeaderPawn;
	local Actor Other;
	local vector HitLocation, HitNormal, StartTrace;
	local Vehicle V;

	B = Bot(Instigator.Controller);
	if ( B == None )
		return false;
	if ( PlayerController(B.Squad.SquadLeader) != None )
		LeaderPawn = B.Squad.SquadLeader.Pawn;
	else
	{
		V = B.Squad.GetLinkVehicle(B);
		if ( V != None )
		{
			LeaderPawn = V;
			bLeaderFiring = (LeaderPawn.Health < LeaderPawn.HealthMax) && (V.LinkHealMult > 0)
							&& ((B.Enemy == None) || V.bKeyVehicle);
		}
	}
	if ( LeaderPawn == None )
	{
		LeaderPawn = B.Squad.SquadLeader.Pawn;
		if ( LeaderPawn == None )
			return false;
	}
	if (!bLeaderFiring)
		return false;
	if ( (Vehicle(LeaderPawn) != None) )
	{
		StartTrace = Instigator.Location + Instigator.EyePosition();
		if ( VSize(LeaderPawn.Location - StartTrace) < FireMode[0].MaxRange() )
		{
			Other = Trace(HitLocation, HitNormal, LeaderPawn.Location, StartTrace, true);
			if ( Other == LeaderPawn )
			{
				B.Focus = Other;
				return true;
			}
		}
	}
	return false;
}

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
				
			if (Pawn(Victims) != None && Pawn(Victims).Controller != None && Pawn(Victims).Controller.SameTeamAs(Instigator.Controller))
				continue;
			
			if (!FastTrace(Victims.Location, Location))
				continue;
				
			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));


			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * DamageAmount,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				175000 * dir,
				BlastDamageType
			);
			
				
			if (BallisticKHandGrenadeProjectile(Victims) != None)
				BallisticKHandGrenadeProjectile(Victims).KickPineapple(Normal(Victims.Location - Location) * 20000);
						
			if (Instigator != None && Vehicle(Victims) != None && Vehicle(Victims).Health > 0)
				Vehicle(Victims).DriverRadiusDamage(DamageAmount, DamageRadius, Instigator.Controller, BlastDamageType, 0.0f, Location);
		}
	}
	bHurtEntry = false;
}

simulated function float RateSelf()
{
	if (HeatLevel > 11)
		CurrentRating = Super.RateSelf() * 0.2;
	else if (PlayerController(Instigator.Controller) != None && Ammo[0].AmmoAmount < 1 && MagAmmo < 1)
		CurrentRating = Super.RateSelf() * 0.2;
	else
		return Super.RateSelf();
		
	return CurrentRating;
}

// avoid bot suicides
function bool CanAttack(Actor Other)
{
	if (HeatLevel > 11)
		return false;

	return super.CanAttack(Other);
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()	{	return 0.8;	}
// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()	{	return -0.8;	}

function bool CanHeal(Actor Other)
{
	if (DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0)
		return true;
	if (Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0)
		return true;

	return false;
}
// End AI Stuff =====

defaultproperties
{
	ManualLines(0)="Fires a stream of plasma projectiles. These projectiles deal high damage and gain damage over range, but are slow.||Using this mode generates heat, and if the weapon overheats, the user will take damage and the fire rate is reduced."
	ManualLines(1)="Projects a short-range shockwave, dealing low damage and pushing nearby enemies back.||Using this mode generates significant heat, and if the weapon overheats, the user will take damage."
	ManualLines(2)="Effective at close range. Especially effective at repelling charges and melee."
	HeatDeclineDelay=0.200000
	BlastDamageType=Class'BWBP_SKC_Pro.DTA49Shockwave'
	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	UsedAmbientSound=Sound'BW_Core_WeaponSound.A73.A73Hum1'
	BigIconMaterial=Texture'BWBP_SKC_Tex.A6.BigIcon_A49'
	BigIconCoords=(Y1=24)
	
	bWT_RapidProj=True
	bWT_Energy=True
	SpecialInfo(0)=(Info="0.0;-15.0;-999.0;-1.0;-999.0;-999.0;-999.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Pullout')
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.A42.A42-Putaway')
	CockAnim="Overheat"
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.A73.A73-ClipHit')
	WeaponModes(0)=(bUnavailable=True)
	SightPivot=(Pitch=2000,Roll=-768)
	SightOffset=(X=-12.000000,Y=33.000000,Z=65.000000)
	SightDisplayFOV=40.000000
	SightZoomFactor=1.2
	GunLength=0.100000
	ParamsClasses(0)=Class'A49WeaponParamsComp'
	ParamsClasses(1)=Class'A49WeaponParamsClassic'
	ParamsClasses(2)=Class'A49WeaponParamsRealistic'
    ParamsClasses(3)=Class'A49WeaponParamsTactical'
	FireModeClass(0)=Class'BWBP_SKC_Pro.A49PrimaryFire'
	FireModeClass(1)=Class'BWBP_SKC_Pro.A49SecondaryFire'
	PutDownAnimRate=2.300000
	BringUpTime=0.500000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.8500000
	CurrentRating=0.8500000
	Description="A49 Skrith Blaster"
	Priority=16
	HudColor=(B=255,G=175,R=100)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=5
	GroupOffset=1
	PickupClass=Class'BWBP_SKC_Pro.A49Pickup'
	PlayerViewOffset=(Y=10.000000,Z=-25.000000)
	BobDamping=1.600000
	AttachmentClass=Class'BWBP_SKC_Pro.A49Attachment'
	IconMaterial=Texture'BWBP_SKC_Tex.A6.SmallIcon_A49'
	IconCoords=(X2=127,Y2=31)
	ItemName="A49 Skrith Blaster"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=180
	LightSaturation=100
	LightBrightness=192.000000
	LightRadius=12.000000
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc7',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Misc10',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(B=160,G=44,R=89,A=137),Color2=(B=151,R=0,A=202),StartSize1=84,StartSize2=61)
    NDCrosshairInfo=(SpreadRatios=(X1=0.300000,Y1=0.300000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.700000
	Mesh=SkeletalMesh'BWBP_SKC_Anim.FPm_A49'
	SoundPitch=56
	SoundRadius=32.000000
	bShowChargingBar=True
}

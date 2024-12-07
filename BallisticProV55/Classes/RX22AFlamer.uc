//=============================================================================
// RX22AFlamer.
//
// A Powerful Flame thrower which uses many unique features to act unlike
// other weapons and better simulate a real flamer.
// The hit detection is done using the combination of a trace for geometry and
// a projectile for detecting other actors. The projectiles have a large
// collision cylinder, but do not collide with geometry. Instead, Their
// lifespan is timed so they die when they have travelled the correct distance.
// The projectiles exist only on the server, are invisible and used only for
// collision. A carefully controlled emitter is used for the fire spray effect.
//
// Secondary sprays unignited fuel. It forms patches on surfaces, clouds in the
// air and soaks actors. This fuel can be ignited by many types of damage,
// expecially primary fire from the flamer.
//
// A central FireControl actor is used to list and control interactions among
// all fires and fuel deposits in the level.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RX22AFlamer extends BallisticWeapon;

var   float				HeatLevel;
var   RX22AHeater		Heater;

var() BUtil.FullSound	PackOnSound;
var() BUtil.FullSound	LeverOnSound;
var() BUtil.FullSound	LeverOffSound;

var   RX22AFireControl	FireControl;

var   RX22ASpray		Flame;
var   RX22AGasSpray		GasSpray;

var() name				ValveAnim;

replication
{
	reliable if (Role==ROLE_Authority)
		FireControl;
}

simulated function PostNetBeginPlay()
{
	local RX22AFireControl FC;

	super.PostNetBeginPlay();
	if (Role == ROLE_Authority && FireControl == None)
	{
		foreach DynamicActors (class'RX22AFireControl', FC)
		{
			if (FC.class == class'RX22AFireControl')
			{
				FireControl = FC;
				return;
			}
		}
		FireControl = Spawn(class'RX22AFireControl', None);
	}
}

function RX22AFireControl GetFireControl()
{
	return FireControl;
}

simulated function Notify_RX22APackOn ()	{	class'BUtil'.static.PlayFullSound(self, PackOnSound);	}
simulated function Notify_RX22ALeverOn ()	{	class'BUtil'.static.PlayFullSound(self, LeverOnSound);	}
simulated function Notify_RX22ALeverOff ()	{	class'BUtil'.static.PlayFullSound(self, LeverOffSound);	}

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

simulated event RenderOverlays(Canvas C)
{
	super.RenderOverlays(C);
	if (Flame != None)
	{
		Flame.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin, DisplayFOV, Instigator.Controller.FovAngle, 32));
		Flame.SetRotation(rotator(GetFireDir() >> GetPlayerAim()));
		C.DrawActor(Flame, false, false, Instigator.Controller.FovAngle);
	}
	else if (GasSpray != None)
	{
		GasSpray.SetLocation(ConvertFOVs(GetBoneCoords('tip').Origin+vector(Instigator.GetViewRotation())*32, DisplayFOV, Instigator.Controller.FovAngle, 32));
		GasSpray.SetRotation(rotator(GetFireDir() >> GetPlayerAim()));
		C.DrawActor(GasSpray, false, false, Instigator.Controller.FovAngle);
	}
}

simulated event Tick (float DT)
{
	super.Tick(DT);
	if (HeatLevel > 0 && LastFireTime < level.TimeSeconds - 4)
		HeatLevel = FMax(0, HeatLevel - DT/10);
}

simulated function WeaponTick (float DT)
{
	super.WeaponTick(DT);
	if (FireMode[0].IsFiring() && RX22APrimaryFire(FireMode[0]).bIgnited)
		HeatLevel = FMin(1, HeatLevel + DT/6);
	if (Heater != None)
		Heater.SetHeat(HeatLevel);

	if (ThirdPersonActor != None && !Instigator.IsFirstPerson() && AIController(Instigator.Controller) == None)
	{
		if (Flame != None)
		{
			Flame.SetLocation(RX22AAttachment(ThirdPersonActor).GetModeTipLocation());
			Flame.SetRotation(rotator(GetFireDir() >> GetPlayerAim()));
		}
		else if (GasSpray != None)
		{
			GasSpray.SetLocation(RX22AAttachment(ThirdPersonActor).GetModeTipLocation());
			GasSpray.SetRotation(rotator(GetFireDir() >> GetPlayerAim()));
		}
	}
}

simulated event Destroyed()
{
	if (Flame != None)
		Flame.bHidden=false;
	if (GasSpray != None)
		GasSpray.bHidden=false;
	if (Heater != None)
		Heater.Destroy();
	super.Destroyed();
}

exec simulated function CockGun(optional byte Type);
function ServerCockGun(optional byte Type);

function DropFrom(vector StartLocation)
{
    local int m;

	if (!RX22AAttachment(ThirdPersonActor).GasTank.GoneOff())
	{
		super.DropFrom(StartLocation);
		return;
	}

	if (AmbientSound != None)
		AmbientSound = None;

    ClientWeaponThrown();

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None && FireMode[m].bIsFiring)
            StopFire(m);
    }

	if (RX22AAttachment(ThirdPersonActor).GasTank.DeathStage < 12)
		RX22AAttachment(ThirdPersonActor).GasTank.GoRogue();

	if ( Instigator != None )
		DetachFromPawn(Instigator);

    Destroy();
}

// AI Interface =====
// choose between regular or alt-fire
function byte BestMode()
{
	local Bot B;
	local float Dist;
	local int i;

	B = Bot(Instigator.Controller);
	if (B == None)
		return Rand(2);

	if (B.Target == None)
		return 1;

	Dist = VSize(B.Target.Location - Instigator.Location);

	if (Dist > FireMode[0].MaxRange())
		return Rand(2);

	if (Dist > FireMode[1].MaxRange() && level.TimeSeconds - Instigator.LastPainTime < 2.0)
		return 0;

	//Smart Bot: Try drench enemy, then ignite them when fuel high enough or almost out of ammo or almost dead
	if (B.Skill > Rand(7) && FireControl != None)
	{
		for (i=0;i<FireControl.GasNodes.length;i++)
			if (FireControl.GasNodes[i]!= None && FireControl.GasNodes[i].Base == B.Target)
			{
				if (!FireControl.GasNodes[i].bCanFeed)
					return 0;
				if (FireControl.GasNodes[i].bCanIgnite && (Dist > FireMode[1].MaxRange() || FireControl.GasNodes[i].Fuel >= FireControl.GasNodes[i].MaxFuel * 0.9 || MagAmmo < 20 || Instigator.Health < 20))
			 		return 0;	// Ignition!
			 	if (Instigator.Health + (level.TimeSeconds - Instigator.LastPainTime) * 5 < 30)
			 		return 0;	// PANIC and try to survive!!!
			 	return 1;		// Just add more fuel to existing fire or increase soaking
			}
		if (MagAmmo < 20)
			return 0;
	 	if (Instigator.Health + (level.TimeSeconds - Instigator.LastPainTime) * 5 < 30)
	 		return 0;	// PANIC and try to survive!!!
	 	return 1;
	}
	else
	{
		if (level.TimeSeconds - Instigator.LastPainTime < 1.5)
			return 0;
		else if (Dist > FireMode[1].MaxRange())
			return 0;
		else if (FRand() > 1.0 - B.Aggression)
			return 0;
		return 1;
	}
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
	
	return class'BUtil'.static.DistanceAtten(Rating, 0.2, Dist, 2048, 512); 
}

// tells bot whether to charge or back off while using this weapon
function float SuggestAttackStyle()
{
	return 1;
}

// tells bot whether to charge or back off while defending against this weapon
function float SuggestDefenseStyle()
{
    return -1;
}
// End AI Stuff =====

defaultproperties
{
	PackOnSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-PackOn',Volume=0.600000,Radius=24.000000,Pitch=1.000000)
	LeverOnSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-LeverOn',Volume=0.600000,Radius=24.000000,Pitch=1.000000)
	LeverOffSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-LeverOff',Volume=0.600000,Radius=24.000000,Pitch=1.000000)
	ValveAnim="TurnValve"

	TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
	BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_RX22A'
	BigIconCoords=(Y2=240)
	
	bWT_Hazardous=True
	bWT_Splash=True
	bWT_RapidProj=True
	bWT_Projectile=True
	bWT_Super=True
	bUseSights=True
	ManualLines(0)="Sprays fire, blinding the enemy, inflicting initial damage and burning them for damage over time. Hip-accurate and capable of hitting multiple enemies at a time. May cause surfaces struck to burn."
	ManualLines(1)="Sprays unignited flamer gas. This gas will collect on surfaces or players. When on a surface, it can be ignited later to set a trap for the enemy or to close off areas. When on a player, it increases the damage dealt by the next primary attack."
	ManualLines(2)="Has a high capacity, but long reload time. Will not function underwater.||Effective at close range. Extremely effective when used defensively."
	SpecialInfo(0)=(Info="360.0;50.0;0.96;90.0;0.0;0.3;1.0")
	BringUpSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Pullout',Volume=0.210000)
	PutDownSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-Putaway',Volume=0.210000)
	ClipOutSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-PipeOut')
	ClipInSound=(Sound=Sound'BW_Core_WeaponSound.RX22A.RX22A-PipeIn')
	ClipInFrame=0.700000
	WeaponModes(0)=(bUnavailable=True)
	WeaponModes(1)=(bUnavailable=True)
	SightPivot=(Pitch=768)
	SightOffset=(X=-12.000000,Z=7.00000)
	SightDisplayFOV=40.000000
	SightZoomFactor=1.2
	ParamsClasses(0)=Class'RX22AWeaponParamsComp'
	ParamsClasses(1)=Class'RX22AWeaponParamsClassic'
	ParamsClasses(2)=Class'RX22AWeaponParamsRealistic'
    ParamsClasses(3)=Class'RX22AWeaponParamsTactical'
	FireModeClass(0)=Class'BallisticProV55.RX22APrimaryFire'
	FireModeClass(1)=Class'BallisticProV55.RX22ASecondaryFire'
	
	NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.Misc8',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.G5OutA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=94),Color2=(A=181),StartSize1=115,StartSize2=82)
    NDCrosshairInfo=(SpreadRatios=(X1=0.250000,Y1=0.375000,X2=1.000000,Y2=1.000000),MaxScale=3.000000)
    NDCrosshairChaosFactor=0.700000
	
	BringUpTime=1.200000
	SelectForce="SwitchToAssaultRifle"
	AIRating=0.9
	CurrentRating=0.900000
	Description="A very deadly weapon designed and constructed by the UTC�s Defence Research Wing, to combat the Cryons before the second Human-Skrith war. It proved highly effective, being unchallenged by both of the Skrith�s major allies, the Cryons and Krao. The RX22A proved to be an extrmely useful weapon, when clearing out Krao from many underground tunnels and facilities on the OutWorld planet. The weapon, now feared by Cryons. and especially Krao, is one of the most dangerous weapons a Terran soldier may possess. Despite its long range, searing flames and ability to litterally fill a small room with fire make it a very powerful weapon, it has a great disadvantage. The flames may just as easily incinerate the operator when used close up, and if the fuel tanks carried on the soldiers back, were to rupture and catch fire, the user may find themselves in a very unpleasant situation."
	Priority=46
	HudColor=(G=50)
	CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
	InventoryGroup=8
	GroupOffset=1
	PickupClass=Class'BallisticProV55.RX22APickup'
	PlayerViewOffset=(X=5.000000,Y=2.000000,Z=-2.000000)
	AttachmentClass=Class'BallisticProV55.RX22AAttachment'
	IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_RX22A'
	IconCoords=(X2=127,Y2=31)
	ItemName="RX-22A Flamethrower"
	LightType=LT_Pulse
	LightEffect=LE_NonIncidence
	LightHue=30
	LightSaturation=150
	LightBrightness=150.000000
	LightRadius=4.000000
	Mesh=SkeletalMesh'BW_Core_WeaponAnim.RX22A_FPm'
	DrawScale=0.300000
	Skins(0)=Shader'BW_Core_WeaponTex.Hands.Hands-Shiny'
	Skins(1)=Texture'BW_Core_WeaponTex.RX22A.RX22ASkin'
	Skins(2)=Texture'BW_Core_WeaponTex.RX22A.RX22AShield'
	bFullVolume=True
	SoundRadius=128.000000
}

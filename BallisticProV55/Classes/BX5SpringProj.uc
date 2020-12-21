//=============================================================================
// BX5SpringProj.
//
// The explosive that gets launched from a spring mine base. Spawned when the
// base starts and waits for SpringOff() to set it off.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class BX5SpringProj extends BallisticProjectile;

var   bool				bDetonate;
var   BX5TeamLight		TeamLight;		// A flare emitter to show team mates' mines
var   byte					TeamLightColor;
var   bool					bAntiLameMode;
var   Pawn					OriginalPlacer;

replication
{
	reliable if (Role == ROLE_Authority)
		TeamLightColor;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
	{
		if (Instigator != None)
			TeamLightColor = Instigator.Controller.GetTeamNum();

		else TeamLightColor = 255;
		
		if (Level.NetMode != NM_DedicatedServer)
		{
			if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum() || class'BallisticReplicationInfo'.default.bUniversalMineLights)
			{
				TeamLight = Spawn(class'BX5TeamLight',self,,Location,Rotation);
				if (Instigator.Controller == Level.GetLocalPlayerController())
					TeamLight.SetTeamColor(2);
				else TeamLight.SetTeamColor(TeamLightColor);
				TeamLight.SetBase(self);
			}
		}	
	}
}

simulated event PostNetReceive()
{
	if (bDetonate)
		Explode(Location, vect(0,0,1));
		
	if (TeamLightColor != default.TeamLightColor)
	{
		if (TeamLightColor == Level.GetLocalPlayerController().GetTeamNum() || Level.GetLocalPlayerController().GetTeamNum() == 255 || class'BallisticReplicationInfo'.default.bUniversalMineLights)
		{
			TeamLight = Spawn(class'BX5TeamLight',self,,Location,Rotation);
			if (Instigator.Controller == Level.GetLocalPlayerController())
				TeamLight.SetTeamColor(2);
			else if (Level.GetLocalPlayerController().GetTeamNum() != 255 || class'BallisticReplicationInfo'.default.bUniversalMineLights)
				TeamLight.SetTeamColor(TeamLightColor);
			TeamLight.SetBase(self);
		}
	}		
}

// Do radius damage;
function BlowUp(vector HitLocation)
{
	if (Role < ROLE_Authority)
		return;
		
	// Reverse damage if I was used to lame (hit someone directly or was teleported into)
	if(bAntiLameMode && OriginalPlacer != None)
		class'BallisticDamageType'.static.GenericHurt(OriginalPlacer, 666, Instigator, HitLocation, MomentumTransfer * vect(0,0,1), class'DT_TeleportLamer');
		
	else if (DamageRadius > 0)
		TargetedHurtRadius(Damage, DamageRadius, MyRadiusDamageType, MomentumTransfer, HitLocation, HitActor);
	MakeNoise(1.0);
}

simulated event Timer()
{
	if (bDetonate)
		Explode(Location, vector(Rotation));
	else
		super.Timer();
}

simulated function bool CanTouch(Actor Other)
{
    if (BX5SpringMine(Other) != None || BX5VehicleMine(Other) != None)
		return false;

    return super.CanTouch(Other);
}

simulated function SpringOff()
{
	SetLocation(Location + vector(Rotation) * 4);
	bCollideWorld = true;
	SetCollision (true, default.bBlockActors, default.bBlockPlayers);
	SetPhysics(PHYS_Falling);
	Velocity=vector(Rotation) * (400 + Rand(200));
	bDetonate=true;
	SetTimer(0.7, false);
    InitEffects();
    if(Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
    	bTearOff=True;
}

simulated function InitEffects ()
{
	if (bDetonate)
    	Super.InitEffects();
}

simulated function Destroyed()
{
	Super.Destroyed();
	
	if (TeamLight != None)
		TeamLight.Destroy();
}

defaultproperties
{
     TeamLightColor=128
     ImpactManager=Class'BallisticProV55.IM_AirMine'
     bRandomStartRotaion=False
     TrailClass=Class'BallisticProV55.NRP57Trail'
     MyRadiusDamageType=Class'BallisticProV55.DTBX5SpringRadius'
     bTearOnExplode=False
     NetTrappedDelay=0.200000
     ShakeRadius=1024.000000
     Speed=500.000000
     Damage=100.000000
     DamageRadius=256.000000
     MomentumTransfer=80000.000000
     MyDamageType=Class'BallisticProV55.DTBX5SpringRadius'
     StaticMesh=StaticMesh'BallisticHardware2.BX5.MineSProj2'
     bNetTemporary=False
     Physics=PHYS_None
     LifeSpan=0.000000
     DrawScale=0.200000
     bUnlit=False
     SoundVolume=192
     SoundRadius=128.000000
     bCollideActors=False
     bCollideWorld=False
     bNetNotify=True
     bFixedRotationDir=True
     RotationRate=(Roll=32768)
}

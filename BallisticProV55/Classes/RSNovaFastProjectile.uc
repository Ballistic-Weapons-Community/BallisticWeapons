//=============================================================================
// RSNovaFastProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSNovaFastProjectile extends BallisticProjectile;

var bool	bComboHit;

replication
{
	unreliable if (Role == ROLE_Authority)
		bComboHit;
}

simulated event PostNetReceive()
{
	if (bComboHit)
		Explode(Location, vect(0,0,1));
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	if (bExploded)
		return;
	if (ShakeRadius > 0 || MotionBlurRadius > 0)
		ShakeView(HitLocation);
    if (ImpactManager != None && level.NetMode != NM_DedicatedServer)
	{
		if (bComboHit)
			ImpactManager.static.StartSpawn(HitLocation, HitNormal, 5, Level.GetLocalPlayerController()/*.Pawn*/);
		else
		{
			if (Instigator == None)
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, 3, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, 3, Instigator);
		}
	}
	BlowUp(HitLocation);
	bExploded=true;

//	if (bTearOnExplode && (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer))
//		bTearOff = true;
	if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
		GotoState('NetTrapped');
	else
		Destroy();
}

simulated function DoDamage(Actor Other, vector HitLocation)
{
	local class<DamageType> DT;
	local float Dmg;
	local actor Victim;
	local bool bWasAlive;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	local Vector ClosestLocation, temp, BoneTestLocation;

	if (Instigator != None)
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
	}

	HealObjective = DestroyableObjective(Other);
	if ( HealObjective == None )
		HealObjective = DestroyableObjective(Other.Owner);
	if ( HealObjective != None && HealObjective.TeamLink(Instigator.GetTeamNum()) )
	{
		HealObjective.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}
	HealVehicle = Vehicle(Other);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		HealVehicle.HealDamage(AdjustedDamage, InstigatorController, myDamageType);
		return;
	}

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );

	if (xPawn(Other) != None)
	{
		//Find a point on the victim's Z axis at the same height as the HitLocation.
		ClosestLocation = Other.Location;
		ClosestLocation.Z += (HitLocation - Other.Location).Z;
		
		//Extend the hit along the projectile's Velocity to a point where it is closest to the victim's Z axis.
		temp = Normal(Velocity);
		temp *= VSize(ClosestLocation - HitLocation);
		BoneTestLocation = temp;
		BoneTestLocation *= normal(ClosestLocation - HitLocation) dot normal(temp);
		BoneTestLocation += HitLocation;
		
		Victim = GetDamageVictim(Other, BoneTestLocation, Normal(Velocity), Dmg, DT);;
	}

	else Victim = GetDamageVictim(Other, HitLocation, Normal(Velocity), Dmg, DT);

	if (xPawn(Victim) != None && Pawn(Victim).Health > 0)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;

    if (BallisticPawn(Instigator) != None && RSNovaStaff(Instigator.Weapon) != None && Victim.bProjTarget && xPawn(Victim) != None && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(int(Dmg * 0.6f), Instigator.SuperHealthMax, Instigator, True);

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);

	if (bWasAlive && Pawn(Victim).Health <= 0)
		class'RSNovaSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);
}

simulated singular function HitWall(vector HitNormal, actor Wall)
{

	local Vehicle HealVehicle;
	local int AdjustedDamage;

	HealVehicle = Vehicle(Wall);
	if ( HealVehicle != None && HealVehicle.TeamLink(Instigator.GetTeamNum()) )
	{
		AdjustedDamage = default.Damage * Instigator.DamageScaling * MyDamageType.default.VehicleDamageScaling;
		if (Instigator.HasUDamage())
			AdjustedDamage *= 2;
		HealVehicle.HealDamage(AdjustedDamage, Instigator.Controller, myDamageType);
		BlowUp(Location + ExploWallOut * HitNormal);

		if (Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer)
			GotoState('NetTrapped');
		else
			Destroy();
	}

	else if ( Role == ROLE_Authority )
	{
		if ( !Wall.bStatic && !Wall.bWorldGeometry && (Pawn(Wall) == None || Vehicle (Wall) != None)) // ignore pawns when using HitWall
		{
			if ( Instigator == None || Instigator.Controller == None )
				Wall.SetDelayedDamageInstigatorController( InstigatorController );
			DoDamage(Wall, Location);
			HurtWall = Wall;
		}
		MakeNoise(1.0);
	}
	Explode(Location + ExploWallOut * HitNormal, HitNormal);

	HurtWall = None;
}

simulated function bool CanTouch (Actor Other)
{
	if (RSNovaProjectile(Other) != None || RSNovaFastProjectile(Other) != None)
		return false;

    return Super.CanTouch(Other);
}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if (DamageType == class'DT_RSDarkSlow' || DamageType == class'DT_RSDarkFast')
    {
		ImpactManager.static.StartSpawn(HitLocation, normal(Momentum), 5, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
//		Instigator = EventInstigator;
//		SuperExplosion();
    }
    else if (DamageType == class'DT_RSDarkPlasma')
    {
    	//FIXME: Network...
    	bComboHit=true;
    	Explode(HitLocation, Normal(Momentum));
    }
}

simulated state NetTrapped
{
	function BeginState()
	{
		HideProjectile();
		SetTimer(NetTrappedDelay, false);
		DestroyEffects();
	}
}

simulated function DestroyEffects()
{
	if (Trail != None)
	{
		if (Emitter(Trail) != None)
		{
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Kill();
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_RSNovaProjectile'
     PenetrateManager=Class'BallisticProV55.IM_RSNovaProjectile'
     bRandomStartRotation=False
     AccelSpeed=100000.000000
     TrailClass=Class'BallisticProV55.RSNova2Trail'
     MyRadiusDamageType=Class'BallisticProV55.DT_RSNovaFast'
     bUsePositionalDamage=True
     
     MaxDamageGainFactor=0.6
     DamageGainStartTime=0.05
     DamageGainEndTime=0.25
     
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=5500.000000
     MaxSpeed=14000.000000
     bSwitchToZeroCollision=True
     Damage=25.000000
     DamageRadius=48.000000
     MomentumTransfer=10000.000000
     MyDamageType=Class'BallisticProV55.DT_RSNovaFast'
     LightType=LT_Steady
     LightEffect=LE_QuadraticNonIncidence
     LightHue=160
     LightSaturation=120
     LightBrightness=192.000000
     LightRadius=6.000000
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.NovaStaff.NovaProjectile2'
     bDynamicLight=True
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'BW_Core_WeaponSound.NovaStaff.Nova-Fire2FlyBy'
     LifeSpan=4.000000
     Style=STY_Additive
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
     bNetNotify=True
     bFixedRotationDir=True
     RotationRate=(Roll=16384)
}

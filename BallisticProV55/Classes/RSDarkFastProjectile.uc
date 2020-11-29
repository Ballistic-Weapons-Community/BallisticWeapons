//=============================================================================
// RSDarkFastProjectile.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2006 RuneStorm. All Rights Reserved.
//=============================================================================
class RSDarkFastProjectile extends BallisticProjectile;

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

simulated function InitEffects ()
{
	local Vector X,Y,Z;

	bDynamicLight=default.bDynamicLight;
	if (Level.NetMode != NM_DedicatedServer && TrailClass != None && Trail == None)
	{
		GetAxes(Rotation,X,Y,Z);
		Trail = Spawn(TrailClass, self,, Location + X*TrailOffset.X + Y*TrailOffset.Y + Z*TrailOffset.Z, Rotation);
		if (Emitter(Trail) != None)
			class'BallisticEmitter'.static.ScaleEmitter(Emitter(Trail), DrawScale/2);
		if (Trail != None)
			Trail.SetBase (self);
	}
}

// Spawn impact effects, run BlowUp() and then die.
simulated function Explode(vector HitLocation, vector HitNormal)
{
	local int Surf;
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
			if (bCheckHitSurface)
				CheckSurface(HitLocation, HitNormal, Surf);
			if (Instigator == None)
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, 3, Level.GetLocalPlayerController()/*.Pawn*/);
			else
				ImpactManager.static.StartSpawn(HitLocation, HitNormal, 3, Instigator);
		}
	}
	BlowUp(HitLocation);
	bExploded=true;

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
	//local bool bWasAlive;
	local DestroyableObjective HealObjective;
	local Vehicle HealVehicle;
	local int AdjustedDamage;
	local Vector ClosestLocation, BoneTestLocation, temp;

	if (Instigator != None && Instigator.Weapon != None && Instigator.Weapon.IsA('RSDarkStar'))
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

	if (BallisticPawn(Instigator) != None && RSDarkStar(Instigator.Weapon) != None && Victim != Instigator && Victim.bProjTarget && (Pawn(Victim).GetTeamNum() != Instigator.GetTeamNum() || Instigator.GetTeamNum() == 255))
		BallisticPawn(Instigator).GiveAttributedHealth(2, Instigator.SuperHealthMax, Instigator, True);

	/*if (xPawn(Victim) != None && Pawn(Victim).Health > 0 && Pawn(Victim).bProjTarget)
	{
		if (Monster(Victim) == None || Pawn(Victim).default.Health > 275)
			bWasAlive = true;
	}
	else if (Vehicle(Victim) != None && Vehicle(Victim).Driver!=None && Vehicle(Victim).Driver.Health > 0)
		bWasAlive = true;*/

	class'BallisticDamageType'.static.GenericHurt (Victim, Dmg, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), DT);

	/*if (bWasAlive && Pawn(Victim).Health <= 0)
		class'RSDarkSoul'.static.SpawnSoul(HitLocation, Instigator, Pawn(Other), self);*/
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

// Hit something interesting
simulated function ProcessTouch (Actor Other, vector HitLocation)
{
    local Vector X;

	if (Other == None || (!bCanHitOwner && (Other == Instigator || Other == Owner)) || RSDarkProjectile(Other)!=None || RSDarkFastProjectile(Other)!=None)
		return;

	if (Role == ROLE_Authority && Other != HitActor)		// Do damage for direct hits
	{
		DoDamage(Other, HitLocation);
	}

	if (CanPenetrate(Other) && Other != HitActor)
	{	// Projectile can go right through enemies
		HitActor = Other;
		X = Normal(Velocity);
		SetLocation(HitLocation + (X * (Other.CollisionHeight*2*X.Z + Other.CollisionRadius*2*(1-X.Z)) * 1.2));
	    if ( EffectIsRelevant(Location,false) && PenetrateManager != None)
			PenetrateManager.static.StartSpawn(HitLocation, Other.Location-HitLocation, 4, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
	}
	else
	{	// Spawn projectile death effects and try radius damage
		HitActor = Other;
		Explode(HitLocation, vect(0,0,1));
	}
}

function int ManageHeatInteraction(Pawn P)
{
	local RSDarkStarHeatManager HM;
	
	foreach P.BasedActors(class'RSDarkStarHeatManager', HM)
		break;
	if (HM == None)
	{
		HM = Spawn(class'RSDarkStarHeatManager',P,,P.Location + vect(0,0,-30));
		HM.SetBase(P);
	}
	
	if (HM != None)
		HM.AddHeat();
	
	return HM.ConsecutiveHits;
}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if (DamageType == class'DT_RSNovaSlow' || DamageType == class'DT_RSNovaFast')
		ImpactManager.static.StartSpawn(HitLocation, normal(Momentum), 5, Level.GetLocalPlayerController(), 4/*HF_NoDecals*/);
    else if (DamageType == class'DT_RSNovaLightning')
    {
    	//FIXME: Network...
    	bComboHit=true;
    	Explode(HitLocation, Normal(Momentum));
    }
}

state NetTrapped
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
			Emitter(Trail).Kill();
			Emitter(Trail).Emitters[0].Disabled=true;
			Emitter(Trail).Emitters[1].Disabled=true;
			Emitter(Trail).Emitters[2].Disabled=true;
		}
		else
			Trail.Destroy();
	}
}

defaultproperties
{
     ImpactManager=Class'BallisticProV55.IM_RSDarkProjectile'
     PenetrateManager=Class'BallisticProV55.IM_RSDarkProjectile'
     bRandomStartRotaion=False
     AccelSpeed=80000.000000
     TrailClass=Class'BallisticProV55.RSDark2Trail'
     MyRadiusDamageType=Class'BallisticProV55.DT_RSDarkFast'
     bUsePositionalDamage=True
     
     MaxDamageGainFactor=0.5
     DamageGainStartTime=0.05
     DamageGainEndTime=0.2
     
     SplashManager=Class'BallisticProV55.IM_ProjWater'
     Speed=4000.000000
     MaxSpeed=10000.000000
     bSwitchToZeroCollision=True
     Damage=42.000000
     DamageRadius=0.000000
     MomentumTransfer=100.000000
     MyDamageType=Class'BallisticProV55.DT_RSDarkFast'
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=128.000000
     LightRadius=7.000000
     StaticMesh=StaticMesh'BWBP4-Hardware.DarkStar.DarkProjSmall'
     bDynamicLight=True
     bNetTemporary=False
     bSkipActorPropertyReplication=True
     bOnlyDirtyReplication=True
     AmbientSound=Sound'BWBP4-Sounds.NovaStaff.Nova-Fire2FlyBy'
     LifeSpan=1.000000
     DrawScale=2.000000
     SoundVolume=255
     SoundRadius=75.000000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
     bNetNotify=True
     bFixedRotationDir=True
     RotationRate=(Roll=100000)
}

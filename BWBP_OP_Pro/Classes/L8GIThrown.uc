//=============================================================================
// FP7Thrown.
//
// Thrown overhand FP7. Spawns fires on detonation.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class L8GIThrown extends BallisticGrenade;

var() int HealingAmount;
var() bool bSuperHeal;
var() Sound HealSound;
var IP_L8GIAmmoPack AmmoPack1;

replication
{
	reliable if (Role==ROLE_Authority)
		SpawnPack, AmmoPack1;
}

simulated event Timer()
{
	local xPawn HitPawn;

	if (StartDelay > 0)
	{
		StartDelay = 0;
		bHidden=false;
		SetPhysics(default.Physics);
		SetCollision (default.bCollideActors, default.bBlockActors, default.bBlockPlayers);
		InitProjectile();
		return;
	}
	if (HitActor != None)
	{
		HitPawn = xPawn(HitActor);
		//log("HitPawn health before: "$HitPawn.Health);
		if ( Instigator == None || Instigator.Controller == None )
			HitPawn.SetDelayedDamageInstigatorController( InstigatorController );
		/*if (Instigator.GetTeamNum() == HitPawn.GetTeamNum() && level.Game.bTeamGame)
		{
			HitPawn.GiveHealth(HealingAmount, GetHealMax(HitPawn));
			//log("Gave health");
		}
		else*/
			class'BallisticDamageType'.static.GenericHurt (HitActor, Damage, Instigator, Location, MomentumTransfer * (HitActor.Location - Location), MyDamageType);
		//log("HitPawn health after: "$HitPawn.Health);
//		HitActor.TakeDamage(Damage, Instigator, Location, MomentumTransfer * (HitActor.Location - Location), MyDamageType);
	}
	Explode(Location, vect(0,0,1));
}


function SpawnPack()
{
	if (AmmoPack1 == None)
	{
		AmmoPack1 = Spawn(class'IP_L8GIAmmoPack',,,Self.Location, Self.Rotation);
		AmmoPack1.SetPhysics(PHYS_Falling);
		if (AmmoPack1 != None)
			AmmoPack1.SetBase (self);
		AmmoPack1.bDropped = true;
		AmmoPack1.LifeSpan = 32;
		//log("AmmoPick is: "$AmmoPack1);
	}
}

simulated event HitWall(vector HitNormal, actor Wall)
{
	SpawnPack();
	
	super.HitWall(HitNormal, Wall);
	
	Destroy();
}

simulated event ProcessTouch( actor Other, vector HitLocation )
{
	local float BoneDist;
	local xPawn HitPawn;

	if (Other == Instigator && (!bCanHitOwner))
		return;
	if (Base != None)
		return;

	HitPawn = xPawn(Other);

	if ( Instigator == None || Instigator.Controller == None )
		Other.SetDelayedDamageInstigatorController( InstigatorController );
	if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
//		Other.TakeDamage(ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		return;
	}
	if ( PlayerImpactType == PIT_Bounce || (PlayerImpactType == PIT_Stick && (VSize (Velocity) < MinStickVelocity)) )
	{
		HitWall (Normal(HitLocation - Other.Location), Other);
		//log("HitPawn health before: "$HitPawn.Health);
		if (Instigator.GetTeamNum() == HitPawn.GetTeamNum() && level.Game.bTeamGame)
		{

			GiveAmmo(HitPawn);
			//log("Gave ammo");
			if (HealSound != None)
				PlaySound(HealSound, SLOT_Interact );
			Destroy();//go to another function and make a healing emitter effect, then destroy
		}
		else
		{
			class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
//			Other.TakeDamage(ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		}
		//log("HitPawn health after: "$HitPawn.Health);
	}
	else if ( PlayerImpactType == PIT_Stick && Base == None )
	{
		SetPhysics(PHYS_None);
		if (DetonateOn == DT_ImpactTimed)
			SetTimer(DetonateDelay, false);
		HitActor = Other;
		if (Other != Instigator && Other.DrawType == DT_Mesh)
			Other.AttachToBone( Self, Other.GetClosestBone( Location, Velocity, BoneDist) );
		else
			SetBase (Other);
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
//		Other.TakeDamage(ImpactDamage, Instigator, HitLocation, Velocity, ImpactDamageType);
		SetRotation (Rotator(Velocity));
		Velocity = vect(0,0,0);
	}
	if (PlayerImpactType == PIT_Detonate || DetonateOn == DT_Impact)
	{
		class'BallisticDamageType'.static.GenericHurt (Other, ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
//		Other.TakeDamage(ImpactDamage, Instigator, HitLocation, MomentumTransfer * Normal(Velocity), ImpactDamageType);
		HitActor = Other;
		Explode(HitLocation, Normal(HitLocation-Other.Location));
		return;
	}
}

function GiveAmmo( actor Other )
{
	local Inventory Inv, GW;
	local int Count;
	local Weapon W;
	local bool bGetIt;
	local Ammunition A;


	if ( Pawn(Other).GiveHealth(5, Pawn(Other).HealthMax) )
		bGetIt=true;
	// First go through our inventory and revive all the ghosts
	for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Count++)
	{
		if (!Inv.IsA('L8GIAmmoPack'))
		{
			// If our grenades ran out, this should bring them back...
			if (BCGhostWeapon(Inv) != None && BCGhostWeapon(Inv).MyWeaponClass != class'L8GIAmmoPack')
			{
				GW = Inv;
				Inv = Inv.Inventory;
				//log("In if statement - shouldn't have L8GIAmmoPack");
				//log("GhostWeapon is: "$GW);
				//log("Inv is: "$Inv);
				//log("MyWeaponsClass is: "$BCGhostWeapon(GW).MyWeaponClass);
				BCGhostWeapon(GW).ReviveWeapon();
			}
			else
				Inv=Inv.Inventory;
		}
	}
	Count = 0;
	// Now give all weapons some ammo
	for (Inv=Pawn(Other).Inventory; Inv!=None && /*!Inv.IsA('L8GIAmmoPack') &&*/ Count < 1000; Inv=Inv.Inventory)
	{
		A = Ammunition(Inv);
		if (A!= None && !A.IsA('Ammo_L8GI'))
		{
			if (A.AmmoAmount < A.MaxAmmo)
			{
				A.AddAmmo(A.InitialAmount);
				BGetIt=true;
			}
		}
		else
		{
			W = Weapon(Inv);
			//log(W);
			if (W != None &&  !W.IsA('L8GIAmmoPack')) 
			{
				if (W.bNoAmmoInstances)
				{
					if ( !W.AmmoMaxed(0) && W.GetAmmoClass(0) != None)
					{
						W.AddAmmo(W.GetAmmoClass(0).default.InitialAmount, 0);
						BGetIt=true;
					}
					if ( W.GetAmmoClass(1) != None && W.GetAmmoClass(1) != W.GetAmmoClass(0) && (!W.AmmoMaxed(1)) )
					{
						BGetIt=true;
						W.AddAmmo(W.GetAmmoClass(1).default.InitialAmount, 1);
					}
				}
			}
		}
		Count++;
	}
}

function int GetHealMax(Pawn P)
{
	if (bSuperHeal)
		return P.SuperHealthMax;

	return P.HealthMax;
}


//     StaticMesh=StaticMesh'BW_Core_WeaponStatic.FP7.FP7Proj'
//     TrailClass=Class'BallisticProV55.NRP57Trail'

defaultproperties
{
	WeaponClass=class'BWBP_OP_Pro.L8GIAmmoPack'
	Speed=600.000000
	MaxSpeed=600.000000
	HealingAmount=5
	HealSound=Sound'BW_Core_WeaponSound.Ammo.AmmoPackPickup'
	RandomSpin=1024.000000
	bNoInitialSpin=True
	ImpactDamage=10.000000
	ImpactDamageType=Class'BWBP_OP_Pro.DTAmmoPack'
	TrailOffset=(X=1.600000,Z=6.400000)
	SplashManager=Class'BallisticProV55.IM_ProjWater'
	Damage=0.000000
	DamageRadius=250.000000
	MyDamageType=Class'BWBP_OP_Pro.DTAmmoPack'
	ImpactSound=SoundGroup'BW_Core_WeaponSound.NRP57.NRP57-Concrete'
	StaticMesh=StaticMesh'BW_Core_WeaponStatic.Ammo.AmmoPackHi'
	DrawScale=0.350000
	CollisionRadius=16.000000
	CollisionHeight=15.000000
	bBounce=True
	RotationRate=(Roll=0)
}

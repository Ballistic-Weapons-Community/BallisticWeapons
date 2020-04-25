class WrenchMinigunTurret extends ASTurret_Minigun;

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
						Vector momentum, class<DamageType> damageType)
{
	local int			actualDamage;
	local bool			bAlreadyDead;
	local Controller	Killer;

	if ( Role < ROLE_Authority )
	{
		log(self$" client damage type "$damageType$" by "$instigatedBy);
		return;
	}

	if ( Level.Game == None )
		return;

	// Spawn Protection: Cannot be destroyed by a player until possessed
	if ( bSpawnProtected && instigatedBy != None && instigatedBy != Self )
		return;

	// Prevent multiple damage the same tick (for splash damage deferred by turret bases for example)
	if ( Level.TimeSeconds == DamLastDamageTime && instigatedBy == DamLastInstigator )
		return;

	DamLastInstigator = instigatedBy;
	DamLastDamageTime = Level.TimeSeconds;

	if ( damagetype == None )
		DamageType = class'DamageType';

	Damage		*= DamageType.default.VehicleDamageScaling;
	momentum	*= DamageType.default.VehicleMomentumScaling * MomentumMult;
	bAlreadyDead = (Health <= 0);
	NetUpdateTime = Level.TimeSeconds - 1; // force quick net update

    if ( Weapon != None )
        Weapon.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );
    if ( (InstigatedBy != None) && InstigatedBy.HasUDamage() )
        Damage *= 2;

	actualDamage = Level.Game.ReduceDamage(Damage, self, instigatedBy, HitLocation, Momentum, DamageType);

	if ( DamageType.default.bArmorStops && (actualDamage > 0) )
		actualDamage = ShieldAbsorb( actualDamage );

    if ( bShowDamageOverlay && DamageType.default.DamageOverlayMaterial != None && actualDamage > 0 )
        SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, true );

	Health -= actualDamage;

	if ( HitLocation == vect(0,0,0) )
		HitLocation = Location;
	if ( bAlreadyDead )
		return;

	PlayHit(actualDamage,InstigatedBy, hitLocation, damageType, Momentum);
	if ( Health <= 0 )
	{
		EjectDriver();

		// pawn died
		if ( instigatedBy != None )
			Killer = instigatedBy.GetKillerController();
		else if ( (DamageType != None) && DamageType.default.bDelayedDamage )
			Killer = DelayedDamageInstigatorController;

		Health = 0;

		TearOffMomentum = momentum;

		Died(Killer, damageType, HitLocation);
	}
	else
	{
		if ( Controller != None )
			Controller.NotifyTakeHit(instigatedBy, HitLocation, actualDamage, DamageType, Momentum);
	}

	MakeNoise(1.0);
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local PlayerController PC;
	local Controller C;

	if ( bDeleteMe || Level.bLevelChange )
		return; // already destroyed, or level is being cleaned up

	if ( Physics != PHYS_Karma )
	{
		super.Died(Killer, damageType, HitLocation);
		return;
	}

	if ( Level.Game.PreventDeath(self, Killer, damageType, HitLocation) )
	{
		Health = max(Health, 1); //mutator should set this higher
		return;
	}
	Health = Min(0, Health);

	if ( Controller != None )
	{
		C = Controller;
		C.WasKilledBy(Killer);
		Level.Game.Killed(Killer, C, self, damageType);
		if( C.bIsPlayer )
		{
			PC = PlayerController(C);
			if ( PC != None )
				ClientKDriverLeave(PC); // Just to reset HUD etc.
			else
                ClientClearController();
			if ( (bRemoteControlled || bEjectDriver) && (Driver != None) && (Driver.Health > 0) )
			{
				C.Unpossess();
				C.Possess(Driver);

				if ( bEjectDriver )
					EjectDriver();

				Driver = None;
			}
			else
				C.PawnDied(self);
		}

		if ( !C.bIsPlayer && !C.bDeleteMe )
			C.Destroy();
	}
	else
		Level.Game.Killed(Killer, Controller(Owner), self, damageType);

	if ( Killer != None )
		TriggerEvent(Event, self, Killer.Pawn);
	else
		TriggerEvent(Event, self, None);

	if ( IsHumanControlled() )
		PlayerController(Controller).ForceDeathUpdate();

	if ( !bDeleteMe )
		Destroy(); // Destroy the vehicle itself (see Destroyed)
}
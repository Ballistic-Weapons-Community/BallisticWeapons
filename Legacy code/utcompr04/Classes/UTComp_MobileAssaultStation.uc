class UTComp_MobileAssaultStation extends ONSMobileAssaultStation;

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
						Vector momentum, class<DamageType> damageType)
{
	local int ActualDamage;
	local Controller Killer;

	// Spawn Protection: Cannot be destroyed by a player until possessed
	if ( bSpawnProtected && instigatedBy != None && instigatedBy != Self )
		return;

	log("Input damage:"@Damage);

	NetUpdateTime = Level.TimeSeconds - 1; // force quick net update

	Momentum *= 0;

	if (DamageType != None)
	{
		if ((instigatedBy == None || instigatedBy.Controller == None) && DamageType.default.bDelayedDamage && DelayedDamageInstigatorController != None)
			instigatedBy = DelayedDamageInstigatorController.Pawn;

		Damage *= DamageType.default.VehicleDamageScaling;
		momentum *= DamageType.default.VehicleMomentumScaling * MomentumMult;


	log("Vehicle Scale Damage:"@Damage);

	        if (bShowDamageOverlay && DamageType.default.DamageOverlayMaterial != None && Damage > 0 )
        	    SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, false );
	}

	if (bRemoteControlled && Driver!=None)
	{
	    ActualDamage = Damage;
	    if (Weapon != None)
	        Weapon.AdjustPlayerDamage(ActualDamage, InstigatedBy, HitLocation, Momentum, DamageType );
	    if (InstigatedBy != None && InstigatedBy.HasUDamage())
	        ActualDamage *= 2;



	    ActualDamage = Level.Game.ReduceDamage(ActualDamage, self, instigatedBy, HitLocation, Momentum, DamageType);



	    if (Health - ActualDamage <= 0)
	       	KDriverLeave(false);
	}

	if (Weapon != None)
	        Weapon.AdjustPlayerDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType );
	log("Weapon Scale Damage:"@Damage);
	if (InstigatedBy != None && InstigatedBy.HasUDamage())
		Damage *= 2;
	ActualDamage = Level.Game.ReduceDamage(Damage, self, instigatedBy, HitLocation, Momentum, DamageType);
	log("Level Scale Damage:"@ActualDamage);
	Health -= ActualDamage;

	PlayHit(actualDamage, InstigatedBy, hitLocation, damageType, Momentum);
	// The vehicle is dead!
	if ( Health <= 0 )
	{

		if ( Driver!=None && (bEjectDriver || bRemoteControlled) )
		{
			if ( bEjectDriver )
				EjectDriver();
			else
        		KDriverLeave( false );
		}

		// pawn died
		if ( instigatedBy != None )
			Killer = instigatedBy.GetKillerController();
		if ( Killer == None && (DamageType != None) && DamageType.Default.bDelayedDamage )
			Killer = DelayedDamageInstigatorController;
		Died(Killer, damageType, HitLocation);
	}
	else if ( Controller != None )
		Controller.NotifyTakeHit(instigatedBy, HitLocation, actualDamage, DamageType, Momentum);

	MakeNoise(1.0);

	if ( !bDeleteMe )
	{
		if ( Location.Z > Level.StallZ )
			Momentum.Z = FMin(Momentum.Z, 0);
		KAddImpulse(Momentum, hitlocation);
	}
}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
	local int x;
	local PlayerController PC;
	local Controller C;

	if ( bDeleteMe || Level.bLevelChange || bVehicleDestroyed)
		return; // already destroyed, or level is being cleaned up

   	bMovable = True;
	bStationary = False;
    	SetPhysics(PHYS_Karma);
	bVehicleDestroyed = True;

	if ( Physics != PHYS_Karma && Physics != PHYS_None )
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
		else
			C.Destroy();

    		if ( Driver != None )
	    	{
        	    if ( !bRemoteControlled && !bEjectDriver )
	            {
		            if (!bDrawDriverInTP && PlaceExitingDriver())
	        	    {
	                	Driver.StopDriving(self);
		                Driver.DrivenVehicle = self;
		            }
					Driver.TearOffMomentum = Velocity * 0.25;
					Driver.Died(Controller, class'DamRanOver', Driver.Location);
	            }
        	    else
				{
					if ( bEjectDriver )
						EjectDriver();
					else
						KDriverLeave( false );
				}
	    	}

		bDriving = False;
	}
	else
		Level.Game.Killed(Killer, Controller(Owner), self, damageType);

	if ( Killer != None )
	{
		TriggerEvent(Event, self, Killer.Pawn);
		Instigator = Killer.Pawn; //so if the dead vehicle crushes somebody the vehicle's killer gets the credit
	}
	else
		TriggerEvent(Event, self, None);

	RanOverDamageType = DestroyedRoadKillDamageType;
	CrushedDamageType = DestroyedRoadKillDamageType;

	if ( IsHumanControlled() )
		PlayerController(Controller).ForceDeathUpdate();

	for (x = 0; x < WeaponPawns.length; x++)
	{
		if ( bRemoteControlled || bEjectDriver )
		{
			if ( bEjectDriver )
				WeaponPawns[x].EjectDriver();
			else
				WeaponPawns[x].KDriverLeave( false );
		}
		WeaponPawns[x].Died(Killer, damageType, HitLocation);
	}
	WeaponPawns.length = 0;

	if (ParentFactory != None)
	{
		ParentFactory.VehicleDestroyed(self);
		ParentFactory = None;
	}

	GotoState('VehicleDestroyed');
}

defaultproperties
{
}

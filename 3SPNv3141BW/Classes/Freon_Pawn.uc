/* some code taken from L7's freeze tag mod */

class Freon_Pawn extends Misc_Pawn
	config(System);

var bool            bFrozen;
var bool            bClientFrozen;

var Freon_Trigger   MyTrigger;

var float           DecimalHealth;    // used server-side only, to allow decimals to be added to health

var Material        FrostMaterial;
var Material        FrostMap;

var bool            bThawFast;

var bool			bPushed; 	// pushed by some problematic weapon used deliberately to cheese (HMC)
var Pawn			Pusher;		// the pawn pushing

var config bool	bGibOnEncroach;

var array<Freon.WeaponData> MyWD;

var Sound           ImpactSounds[6];

var float LastDamagedTime;

replication
{
    reliable if(bNetDirty && Role == ROLE_Authority)
        bFrozen;
}

//Fix for some stuff.
function PlayerChangedTeam()
{
	Died( None, class'DamType_SwitchedTeam', Location );
	//Fixme might not work?
	MyTrigger.Team = PlayerReplicationInfo.Team.TeamIndex;
}

//Tracks the person who healed us
function bool GiveAttributedHealth(int HealAmount, int HealMax, pawn Healer, optional bool bOverheal)
{
	if (bFrozen)
	{
		if (Health < 13 || Health + HealAmount > 97 || Freon(Level.Game).bRoundOT)
			return false;
		else
			HealAmount = 1;
	}
	
	if (Health >= HealMax && !bOverheal)
		return false;
	
	HealAmount = Freon(Level.Game).ReduceHealing(HealAmount, self, Healer);
	
	if (HealAmount > 0)
		super.GiveAttributedHealth(HealAmount, HealMax, Healer, bOverheal);
	
	return true;
}

simulated static function Material CheckSkin(Material inSkin)
{
	if (FinalBlend(inSkin) != None && FinalBlend(inSkin).Material != None)
		inSkin = FinalBlend(inSkin).Material;
		
	if (Shader(inSkin) != None && Shader(inSkin).Diffuse != None )
		inSkin = Shader(inSkin).Diffuse;
	
	return inSkin;
}


simulated function UpdatePrecacheMaterials()
{
    Super.UpdatePrecacheMaterials();

    Level.AddPrecacheMaterial(FrostMaterial);
    Level.AddPrecacheMaterial(FrostMap);
}

simulated function Destroyed()
{
/*
	local Inventory Inv, NextInv;
	
	Inv = Inventory;
	
	while (Inv != None)
	{
		if (BallisticAmmo(Inv) != None && !BallisticAmmo(Inv).bNoPackResupply)
		{
			NextInv = Inv.Inventory;
			DeleteInventory(Inv);
			Inv = NextInv;
			continue;
		}
		
		Inv = Inv.Inventory;
	}
*/
    if(MyTrigger != None)
    {
        MyTrigger.Destroy();
        MyTrigger = None;
    }

    Super.Destroyed();
}

function PossessedBy(Controller C)
{
	local Freon_Trigger FT;

	Super.PossessedBy(C);

	if(MyTrigger == None)
	{
		FT = spawn(class'Freon_Trigger', self,, Location, Rotation);
		if (FT != None)
			MyTrigger = FT;
	}
}

function TakeDamage(int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, class<DamageType> DamageType)
{
    local int ActualDamage;
    local Controller Killer;
	
    if ( DamageType == None )
    {
        if ( InstigatedBy != None ) 
            Warn( "No DamageType for damage by "$InstigatedBy$" with weapon "$InstigatedBy.Weapon );
        DamageType = class'DamageType';
    }

    if ( Role < ROLE_Authority ) 
    {
        Log( self$" client DamageType "$DamageType$" by "$InstigatedBy );
        return;
    }

    if ( Health <= 0 ) 
        return;
		
	if (Mover(Base) != None || Level.TimeSeconds < LastMoverLeaveTime + MoverLeaveGrace)
	{
		if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bIgnoredOnLifts)
			return;
	}

    if ( ( InstigatedBy == None || InstigatedBy.Controller == None ) &&
         ( DamageType.default.bDelayedDamage ) &&
         ( DelayedDamageInstigatorController != None ) ) 
        InstigatedBy = DelayedDamageInstigatorController.Pawn;

    if ( Physics == PHYS_None && DrivenVehicle == None )
        SetMovementPhysics();

    if ( Physics == PHYS_Walking && DamageType.default.bExtraMomentumZ )
        Momentum.Z = FMax( Momentum.Z, 0.4 * VSize( Momentum ) );

    if ( InstigatedBy == self )
        Momentum *= 0.6;

    Momentum = Momentum / Mass;

    if ( Weapon != None )
        Weapon.AdjustPlayerDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );

    if ( DrivenVehicle != None )
        DrivenVehicle.AdjustDriverDamage( Damage, InstigatedBy, HitLocation, Momentum, DamageType );

    if ( ( InstigatedBy != None ) && InstigatedBy.HasUDamage() ) 
        Damage *= 2;

    ActualDamage = Level.Game.ReduceDamage( Damage, self, InstigatedBy, HitLocation, Momentum, DamageType );

    if (instigatedBy != None && instigatedBy != self && class<BallisticDamageType>(damageType) != None)
    {
        if (!Level.Game.bTeamGame || (instigatedBy.GetTeamNum() != GetTeamNum() && GetTeamNum() != 255))
            SetBWHitStats(instigatedBy.PlayerReplicationInfo, class<BallisticDamageType>(DamageType).default.DamageIdent, actualDamage);
    }

    if( DamageType.default.bArmorStops && ( ActualDamage > 0 ) )
        ActualDamage = ShieldAbsorb( ActualDamage );

	//first check if the pawn was manning a vehicle, if so force them to abandon it
	if ( Role == ROLE_Authority && (Health - ActualDamage <= 0) && DrivenVehicle != None)
		DrivenVehicle.KDriverLeave(false);

	//Cut in to teleport the Pawn if they're going to be Killed (and not frozen) from either this damage or because they're in a deadly physics volume
	if (Health - ActualDamage < 1)
	{	
	    if (DamageType == class'DamType_Camping' || DamageType == class'DamType_Overtime' || DamageType == class'DamType_Git')
		{
		}
		//escape
		
		else if (PhysicsVolume.bDestructive ||
			PhysicsVolume.bPainCausing ||
			DamageType.default.bCausedByWorld || 
			(class<WeaponDamageType>(DamageType) == None && class<VehicleDamageType>(DamageType) == None && Physics != PHYS_Walking)	)
			{
				TryTeleport();
				
				if (bPushed)
				{
					if(Pusher != None && Damage > 75 && DamageType.default.bCausedByWorld) //Git attempt, player takes no damage and the player attempting to git will die
						InstigatedBy.TakeDamage(1000, self, vect(0,0,0), vect(0,0,0), class'DamType_Git');
					return;
				}
			}
	}
	
    Health -= ActualDamage;
	
	if (Damage > 0 && DamageType != class'DamType_Overtime' && (instigatedBy == None || instigatedBy.GetTeamNum() != GetTeamNum() || GetTeamNum() == 255))
		LastDamagedTime = Level.TimeSeconds;

    if ( HitLocation == vect(0,0,0) )
        HitLocation = Location;

    if ( Health <= 0 ) 
    {
        // pawn froze or died -->

		if ( DamageType.default.bCausedByWorld && ( InstigatedBy == None || InstigatedBy == self ) && LastHitBy != None )
			Killer = LastHitBy;
		else if ( InstigatedBy != None )
			Killer = InstigatedBy.GetKillerController();

		if ( Killer == None && DamageType.default.bDelayedDamage )
			Killer = DelayedDamageInstigatorController;


        if(Level.Game.PreventDeath(self, Killer, DamageType, HitLocation))
        {
            Health = Max(Health, 1);

            PlayHit(ActualDamage, InstigatedBy, HitLocation, DamageType, Momentum);
            
            if(bPhysicsAnimUpdate) 
                TearOffMomentum = Momentum;
			return;
        }
		
		if (instigatedBy != None && instigatedBy != self && class<BallisticDamageType>(damageType) != None)
		{
			if (!Level.Game.bTeamGame || (instigatedBy.GetTeamNum() != GetTeamNum() && GetTeamNum() != 255))
				IncrementBWKill(instigatedBy.PlayerReplicationInfo, class<BallisticDamageType>(DamageType).default.DamageIdent);
		}
		
		if (Weapon != None)
			IncrementBWDeathsWith();
			
		CancelTransparency();
  
        if(Froze(Killer, ActualDamage, DamageType, HitLocation))
            PlayFreezingHit();
        else
        {
            PlayHit(ActualDamage, InstigatedBy, HitLocation, DamageType, Momentum);

            if (bPhysicsAnimUpdate) 
                TearOffMomentum = Momentum;

            Died(Killer, DamageType, HitLocation);
        }
    } 
    else 
    {
        // pawn only damaged -->
// L7 -->
        PlayHit( ActualDamage, InstigatedBy, HitLocation, DamageType, Momentum );
// L7 <--
        AddVelocity( Momentum );

        if ( Controller != None ) 
            Controller.NotifyTakeHit( InstigatedBy, HitLocation, ActualDamage, DamageType, Momentum );

        if ( InstigatedBy != None && InstigatedBy != self )
            LastHitBy = InstigatedBy.Controller;

		if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.bPowerPush)
		{
			bPushed=True;
			Pusher = InstigatedBy;
		}
    }
    MakeNoise( 1.0 );
}

function Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
	if ( bDeleteMe || Level.bLevelChange || Level.Game == None )
		return; // already destroyed, or level is being cleaned up
	
	//Intercept team changes.
	if (DamageType == class'DamType_SwitchedTeam' && Freon(Level.Game).LockTime == 0)
	{
		Froze(Killer, 1000, DamageType, HitLocation);
		return;
	}
	
	if(MyTrigger != None)
        MyTrigger.OwnerDied();
	
	Super.Died(Killer, DamageType, HitLocation);
}

//==============
// Encroachment
event bool EncroachingOn( actor Other )
{
	if ( Other.bWorldGeometry || Other.bBlocksTeleport )
		return true;

	if ( (Vehicle(Other) != None) && (Weapon != None) && Weapon.IsA('Translauncher') )
		return true;

	if ( ((Controller == None) || !Controller.bIsPlayer || bWarping || !bGibOnEncroach) && (Pawn(Other) != None) )
		return true;

	return false;
}

event EncroachedBy( actor Other )
{
	// Allow encroachment by Vehicles so they can push the pawn out of the way
	if ( Pawn(Other) != None && Vehicle(Other) == None && bGibOnEncroach)
		gibbedBy(Other);
}

function gibbedBy(actor Other)
{
	if ( Role < ROLE_Authority )
		return;
	if ( Pawn(Other) != None )
	{
		if ( (Pawn(Other).Weapon != None) && Pawn(Other).Weapon.IsA('Translauncher') )
			Died(Pawn(Other).Controller, Pawn(Other).Weapon.GetDamageType(), Location);
		else
		{
			if (PlayerReplicationInfo != None && TryTeleport())
				Level.Game.Broadcast(self, "Teleported"@PlayerReplicationInfo.PlayerName@"to avoid telefrag.");			
			else Died(Pawn(Other).Controller, class'DamTypeTelefragged', Location);
		}
	}
	else
		Died(None, class'Gibbed', Location);
}

function bool Froze(Controller Killer, int Damage, class<DamageType> DamageType, Vector HitLocation)
{
    //local Vector TossVel;
    local Trigger T;
    local NavigationPoint N;

    // DETERMINE IF PAWN FROZE -->

    if(bDeleteMe || Level.bLevelChange || Level.Game == None)
		return false;

	if(Controller == None)
	{
		if (OldController == None)
			return false;
		//The controller could be disconnected controlling something else. If at this point it still is, try to recover it.
		if (Freon_Pawn(OldController.Pawn) == None)
			OldController.Possess(self);
		//Destroy outright if player respawned.
		else if (OldController.Pawn != None)
		{
			Destroy();
			return false;
		}
	}
	if(DrivenVehicle != None)
		return false;

    if (DamageType == class'DamType_Camping' || DamageType == class'DamType_Git' || (DamageType == class'DamType_Overtime' && !Freon(Level.Game).bOTDamageFreezes))
    	return false;
			
	if(Freon(Level.Game).bRoundOT && (!Freon(Level.Game).bOTDamageFreezes || Freon(Level.Game).bSuddenDeathMode) && Controller == Killer)
		return false;

	if(IsInPain())
		return false;

    // PAWN FROZE -->

    bFrozen = true;

    if(Freon_PawnReplicationInfo(Freon_PRI(PlayerReplicationInfo).PawnReplicationInfo) != None)
			Freon_PawnReplicationInfo(Freon_PRI(PlayerReplicationInfo).PawnReplicationInfo).PawnFroze();

    FillWeaponData();
    Health = 0;
    AmbientSound = None;
    bProjTarget = false;
    bCanPickupInventory = false;
    bNoWeaponFiring = true;

    PlayerReplicationInfo.bOutOfLives = true;
    NetUpdateTime = Level.TimeSeconds - 1;
    Controller.WasKilledBy(Killer);
    Level.Game.Killed(Killer, Controller, self, DamageType);

    if ( Killer != None ) 
        TriggerEvent( Event, self, Killer.Pawn );
    else 
        TriggerEvent( Event, self, None );

    // make sure to untrigger any triggers requiring player touch
    if ( IsPlayerPawn() || WasPlayerPawn() ) 
    {
        PhysicsVolume.PlayerPawnDiedInVolume( self );

        ForEach TouchingActors( class'Trigger', T )
            T.PlayerToucherDied( self );
        ForEach TouchingActors( class'NavigationPoint', N )
        {
            if ( N.bReceivePlayerToucherDiedNotify ) 
                N.PlayerToucherDied( self );
        }
    }

    // remove powerup effects, etc.
    RemovePowerups();

    //Velocity.Z *= 1.3;

    if ( IsHumanControlled() ) 
        PlayerController( Controller ).ForceDeathUpdate();

    Freon(Level.Game).PawnFroze(self);
    Freeze();
    return true;
}

//Choose closest available playerstart and teleport the player there
function bool TryTeleport()
{
	local Rotator newRot;
	local NavigationPoint N, Best;
	local float BestDist;
	local Pawn P;
	local Controller OtherPlayer;
	local bool bValid;
	
	for (N = Level.NavigationPointList; N != None; N = N.NextNavigationPoint)
	{
		bValid = True;
		
		if (PlayerStart(N) == None)
			continue;
		
		foreach N.VisibleCollidingActors(class'Pawn', P, 128)
		{
			bValid=False;
			break;
		}
		
		//couldn't teleport to this start
		if (!bValid)
			continue;
		
		if (Best == None)
		{
			Best = N;
			BestDist = VSize(Best.Location - Location);
			continue;
		}
		
		//found a better start than the default
		else if (N != Best && VSize(N.Location - Location) < BestDist)
		{
			Best = N;
			BestDist = VSize(Best.Location - Location);
		}		
	}
		
	if (Best != None)
	{
		if ( !SetLocation(Best.Location) )
		{
			log(self$" Teleport failed");
			return false;
		}
		if (Role == ROLE_Authority)
		{
			For ( OtherPlayer=Level.ControllerList; OtherPlayer !=None; OtherPlayer=OtherPlayer.NextController )
				if ( OtherPlayer.Enemy == self )
					OtherPlayer.LineOfSightTo(self); 
			newRot.Roll = 0;
			SetRotation(newRot);
			SetViewRotation(newRot);
			ClientSetRotation(newRot);
			Velocity=Vect(0,0,0);
		}
		if ( Controller != None )
			Controller.MoveTimer = -1.0;

		PlayTeleportEffect(false, true);
		
		return true;
	}
	
	return false;
}

function PlayFreezingHit()
{
    if(PhysicsVolume.bDestructive && ( PhysicsVolume.ExitActor != None))
        Spawn(PhysicsVolume.ExitActor);
}

function Freeze()
{
    if(MyTrigger != None)
        MyTrigger.OwnerFroze();

    bPlayedDeath = true;  
    StopAnimating(true);

    GotoState('Frozen');
}

function FillWeaponData()
{
    local Inventory inv;
    local int i;

    for(inv = Inventory; inv != None; inv = inv.Inventory)
    {
        if(Weapon(inv) == None)
            continue;

        i = MyWD.Length;
        MyWD.Length = i + 1;

        MyWD[i].WeaponName = string(inv.Class);
        MyWD[i].Ammo[0] = Weapon(inv).AmmoCharge[0];
        MyWD[i].Ammo[1] = Weapon(inv).AmmoCharge[1];
    }
}

simulated function Tick(float DeltaTime)
{
    Super.Tick(DeltaTime);

    if(Level.NetMode == NM_DedicatedServer)
        return;

    if(bFrozen && !bClientFrozen)
    {
        bPhysicsAnimUpdate = false;
        bClientFrozen = true;
        StopAnimating(true);
		
		if (BallisticWeapon(Weapon) != None)
		{
			BallisticWeapon(Weapon).SkipReload();
			BallisticWeapon(Weapon).StopScopeView();
		}

        if(Level.bDropDetail || Level.DetailMode == DM_Low)
            ApplyLowQualityIce();
        else
            ApplyHighQualityIce();

        bScriptPostRender = true;
    }
}

simulated function ApplyLowQualityIce()
{
    local Combiner Body;
    local Combiner Head;
    local Shader HeadShader;

    if(MyOwner != None && MyOwner.PlayerReplicationInfo == PlayerReplicationInfo)
    {
        ApplyHighQualityIce();
        return;
    }

    Body = new(none)class'Combiner';
    Head = new(none)class'Combiner';
    HeadShader = new(none)class'Shader';

    SetOverlayMaterial(None, 0.0, true);
    //SetStandardSkin();

    Body.CombineOperation = CO_Add;
    Body.Material1 = CheckSkin(Skins[0]);
    Body.Material2 = FrostMaterial;

    Head.CombineOperation = CO_Add;
    Head.Material1 = CheckSkin(Skins[1]);
    Head.Material2 = FrostMaterial;
        
    HeadShader.Diffuse = Head;
		HeadShader.OutputBlending = OB_Masked;
    HeadShader.Opacity = Head.Material1;

    Skins[0] = Body;
    Skins[1] = HeadShader;
    bUnlit = true;
}

simulated function ApplyHighQualityIce()
{
    local Combiner Body;
    local Combiner Head;
    local Combiner Ice;
    local Shader HeadShader;

    Body = new(none)class'Combiner';
    Head = new(none)class'Combiner';
    HeadShader = new(none)class'Shader';
    Ice = new(none)class'Combiner';

    SetOverlayMaterial(None, 0.0, true);
	//SetStandardSkin();

    Ice.CombineOperation = CO_Subtract;
    Ice.Material1 = FrostMap;
    Ice.Material2 = FrostMaterial;

    Body.CombineOperation = CO_Add;
    Body.Material1 = CheckSkin(Skins[0]);
    Body.Material2 = Ice;

    Head.CombineOperation = CO_Add;
    Head.Material1 = CheckSkin(Skins[1]);
    Head.Material2 = Ice;
        
    HeadShader.Diffuse = Head;
		HeadShader.OutputBlending = OB_Masked;
    HeadShader.Opacity = Head.Material1;

    Skins[0] = Body;
    Skins[1] = HeadShader;
    bUnlit = true;
}

function Thaw()
{
    if(Freon(Level.Game) != None)
        Freon(Level.Game).PlayerThawed(self, 0, 0);
}

function ThawByTouch(array<Freon_Pawn> Thawers, bool instantThaw, optional float mosthealth)
{
    if(Freon(Level.Game) != None)
        Freon(Level.Game).PlayerThawedByTouch(self, Thawers, instantThaw, mosthealth, shieldstrength);
}

/*
Pawn was killed - detach any controller, and die
*/
simulated function ChunkUp( Rotator HitRotation, float ChunkPerterbation )
{
	if ( (Level.NetMode != NM_Client) && (Controller != None) )
	{
		if ( Controller.bIsPlayer )
			Controller.PawnDied(self);
		else
			Controller.Destroy();
	}

	bTearOff = true;
	//HitDamageType = class'Gibbed'; // make sure clients gib also
	if ( (Level.NetMode == NM_DedicatedServer) || (Level.NetMode == NM_ListenServer) )
		GotoState('TimingOut');
	if ( Level.NetMode == NM_DedicatedServer )
		return;
	if ( class'GameInfo'.static.UseLowGore() )
	{
		Destroy();
		return;
	}
	SpawnGibs(HitRotation,ChunkPerterbation);

	if ( Level.NetMode != NM_ListenServer )
		Destroy();
}

event Landed(Vector HitNormal)
{
    super.Landed( HitNormal );
	bPushed = False;
	Pusher = None;
}

event FellOutOfWorld(eKillZType KillType)
{
	if ( Level.NetMode == NM_Client )
		return;
	if ( (Controller != None) && Controller.AvoidCertainDeath() )
		return;
        
	if (TryTeleport())
	{
		if (!bPushed)
			TakeDamage(1000, self, vect(0,0,0), vect(0,0,0), class'Fell');
		bPushed = False;
		Pusher = None;
		return;
	}
		
	Health = -1;

	if( KillType == KILLZ_Lava)
		Died( None, class'FellLava', Location );
	else if(KillType == KILLZ_Suicide)
		Died( None, class'Fell', Location );
	else
	{
		if ( Physics != PHYS_Karma )
			SetPhysics(PHYS_None);
		Died( None, class'Fell', Location );
	}
}

State Frozen
{
    ignores AnimEnd, Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

    event ChangeAnimation() {}
    event StopPlayFiring() {}
    function PlayFiring( float Rate, name FiringMode ) {}
    function PlayWeaponSwitch( Weapon NewWeapon ) {}
    function PlayTakeHit( Vector HitLoc, int Damage, class<DamageType> DamageType ) {}
    simulated function PlayNextAnimation() {}
    function TakeFallingDamage() {}

    event Landed( vector HitNormal )
    {
        Velocity = vect(0,0,0);
        SetPhysics(PHYS_Walking);
        LastHitBy = None;
		bPushed=False;
		Pusher = None;
        PlaySound(default.ImpactSounds[Rand(6)], SLOT_Pain, 1.5 * TransientSoundVolume);
    }

    function TakeDamage( int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, class<DamageType> DamageType )
    {
        if ( DamageType == None ) 
        {
            if ( InstigatedBy != None ) 
                Warn( "No DamageType for damage by "$InstigatedBy$" with weapon "$InstigatedBy.Weapon );
            DamageType = class'DamageType';
        }

        if ( Role < ROLE_Authority ) 
        {
            Log( self$" client DamageType "$DamageType$" by "$InstigatedBy );
            return;
        }

        if ( HitLocation == vect(0,0,0) ) 
            HitLocation = Location;

        if(DamageType.default.bCausedByWorld)
        {
            Thaw();
            return;
        }

        if ( Physics == PHYS_Walking && DamageType.default.bExtraMomentumZ ) 
            Momentum.Z = FMax( Momentum.Z, 0.4 * VSize( Momentum ) );

        Momentum = Momentum / (Mass * 1.5);
        SetPhysics(PHYS_Falling);
        //Velocity += Momentum; being abused hardcore

        if ( ( InstigatedBy == None || InstigatedBy.Controller == None ) &&
             ( DamageType.default.bDelayedDamage ) &&
             ( DelayedDamageInstigatorController != None ) )
            InstigatedBy = DelayedDamageInstigatorController.Pawn;

        if ( InstigatedBy != None && InstigatedBy != self )
            LastHitBy = InstigatedBy.Controller;
    }

    function BeginState()
    {
        SetPhysics(PHYS_Falling);

        LastHitBy = None;
        Acceleration = vect(0,0,0);
        TearOffMomentum = vect(0,0,0);

        if(Freon_Player(Controller) != None) 
        {
            Freon_Player(Controller).FrozenPawn = self;
            Freon_Player(Controller).Freeze();
        }
        else if(Freon_Bot(Controller) != None) 
            Freon_Bot(Controller).Freeze();
    }
}

defaultproperties
{
     FrostMaterial=Texture'AlleriaTerrain.ground.icebrg01'
     FrostMap=TexEnvMap'CubeMaps.Kretzig.Kretzig2TexENV'
     ImpactSounds(0)=Sound'PlayerSounds.BFootsteps.BFootstepSnow1'
     ImpactSounds(1)=Sound'PlayerSounds.BFootsteps.BFootstepSnow2'
     ImpactSounds(2)=Sound'PlayerSounds.BFootsteps.BFootstepSnow3'
     ImpactSounds(3)=Sound'PlayerSounds.BFootsteps.BFootstepSnow4'
     ImpactSounds(4)=Sound'PlayerSounds.BFootsteps.BFootstepSnow5'
     ImpactSounds(5)=Sound'PlayerSounds.BFootsteps.BFootstepSnow6'
     bScriptPostRender=True
}

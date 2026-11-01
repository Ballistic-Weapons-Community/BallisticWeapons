class Freon_Pawn_Normal extends Freon_Pawn;

var bool bFrozenGibbed, bClientFrozenGibbed;
var int FrozenHealth;

replication
{
	reliable if(bNetDirty && Role == ROLE_Authority)
		bFrozenGibbed;
}

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	
	if(Level.NetMode == NM_DedicatedServer)
		return;
		
	if (Level.NetMode == NM_Client && bFrozenGibbed && !bClientFrozenGibbed)
	{
		// we're torn off here
		bClientFrozenGibbed = true;
		SpawnFrozenGibs(Rotation, 1.0);
		Destroy();
	}
}

simulated function SpawnFrozenGiblet( class<Gib> GibClass, Vector Location, Rotator Rotation, float GibPerterbation )
{
	local Gib Giblet;
	local Vector Direction, Dummy;
	
	if( GibClass == None )
		return;
	
	Instigator = self;
	Giblet = Spawn( GibClass,,, Location, Rotation );
	if( Giblet == None )
		return;
		
	Giblet.Skins[0] = FrostMaterial;
	Giblet.bFlaming = false;
	Giblet.GibGroupClass = class'FrozenGibClass';
	
	GibPerterbation *= 32768.0;
	Rotation.Pitch += ( FRand() * 2.0 * GibPerterbation ) - GibPerterbation;
	Rotation.Yaw += ( FRand() * 2.0 * GibPerterbation ) - GibPerterbation;
	Rotation.Roll += ( FRand() * 2.0 * GibPerterbation ) - GibPerterbation;
	
	GetAxes( Rotation, Dummy, Dummy, Direction );
	
	Giblet.Velocity = Velocity + Normal(Direction) * (250 + 260 * FRand());
	Giblet.LifeSpan = Giblet.LifeSpan + 2 * FRand() - 1;
}

function FrozenChunkUp( Rotator HitRotation, float ChunkPerterbation )
{
	/* Just in case */
	if ( Level.NetMode == NM_Client )
		return;
	
	if ( Controller != None )
	{
		if ( Controller.bIsPlayer )
			Controller.PawnDied(self);
		else
			Controller.Destroy();
	}

	if ( (Level.NetMode == NM_DedicatedServer) || (Level.NetMode == NM_ListenServer) )
	{
		GotoState('TimingOut');
		bHidden = true;
		SetCollision(False, False, False);
	}
	if ( Level.NetMode == NM_DedicatedServer )
		return;
		
	SpawnFrozenGibs(HitRotation,ChunkPerterbation);
	if ( Level.NetMode != NM_ListenServer )
		Destroy();
}

simulated function SpawnFrozenGibs(Rotator HitRotation, float ChunkPerterbation)
{
	bGibbed = true;
	PlaySound(Sound'LDGGameBW_rc.BreakGlass', SLOT_Pain,8.5*TransientSoundVolume,true,500);
	SpawnFrozenGiblet( GetGibClass(EGT_Torso), Location, HitRotation, ChunkPerterbation );
	GibCountTorso--;
	
	while( GibCountTorso-- > 0 )
		SpawnFrozenGiblet( GetGibClass(EGT_Torso), Location, HitRotation, ChunkPerterbation );
	while( GibCountHead-- > 0 )
		SpawnFrozenGiblet( GetGibClass(EGT_Head), Location, HitRotation, ChunkPerterbation );
	while( GibCountForearm-- > 0 )
		SpawnFrozenGiblet( GetGibClass(EGT_UpperArm), Location, HitRotation, ChunkPerterbation );
	while( GibCountUpperArm-- > 0 )
		SpawnFrozenGiblet( GetGibClass(EGT_Forearm), Location, HitRotation, ChunkPerterbation );
}

state Frozen
{
	function TakeDamage(int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, class<DamageType> DamageType)
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
		
		if (Freon(Level.Game) != None && Freon(Level.Game).bEndOfRound && FrozenHealth > 0)
		{
			if (InstigatedBy != None && InstigatedBy.HasUDamage())
				Damage *= 2;
			
			FrozenHealth -= Damage;
			
			if (FrozenHealth <= 0 && !bFrozenGibbed)
			{
				bFrozenGibbed = true; //Gibs at next tick on clients
				bTearOff = true;
				NetUpdateTime = Level.TimeSeconds - 1;
				FrozenChunkUp(Rotation, 1.0);
				return;
			}
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
		
		if (Freon(Level.Game) != None && Freon(Level.Game).bEndOfRound)
			Velocity += Momentum; //allow after end of round
		
		if ( ( InstigatedBy == None || InstigatedBy.Controller == None ) &&
			( DamageType.default.bDelayedDamage ) &&
			( DelayedDamageInstigatorController != None ) )
			InstigatedBy = DelayedDamageInstigatorController.Pawn;
		
		if ( InstigatedBy != None && InstigatedBy != self )
			LastHitBy = InstigatedBy.Controller;

	}
}

defaultproperties
{
     FrozenHealth=50
}

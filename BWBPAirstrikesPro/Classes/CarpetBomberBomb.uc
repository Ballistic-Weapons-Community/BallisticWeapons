class CarpetBomberBomb extends AirstrikeBombBase;

//we don't have bots shoot bomber bombs because we'd rather they shoot the bomber itself instead
function BeginPlay()
{
	Super(Projectile).BeginPlay();
}

simulated function PostBeginPlay()
{
	local vector Dir;

	if ( bDeleteMe || IsInState('Dying') )
		return;

	Dir = vector(Rotation);
	Velocity = speed * Dir;

	//if ( Level.NetMode != NM_DedicatedServer)
	//{
	//	SmokeTrail = Spawn(class'NewRedeemerTrail',self,,Location - 40 * Dir, Rotation);
	//	SmokeTrail.SetBase(self);
	//}

	Super(Projectile).PostBeginPlay();
	RandSpin(125000);
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local Emitter E;
	//local Actor li;
	//local Vector Hit;
	//local Vector Norm;

	//li=Trace(Hit,Norm,Location + Velocity,Location,,);
	//TerrainInfo(li).PokeTerrain(Location,100,50);
    E = Spawn(ExplosionEffectClass,,, HitLocation - 100 * Normal(Velocity), Rot(0,16384,0));
	Spawn(class'CarpetBombExplosion',,,HitLocation + HitNormal*16, rotator(HitNormal) + rot(-16384,0,0));
		if ( (ExplosionDecal != None) && (Level.NetMode != NM_DedicatedServer) )
			Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));


	MakeNoise(1.0);
	SetPhysics(PHYS_None);
	bHidden = true;
    GotoState('Dying');
}

function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,
							Vector momentum, class<DamageType> damageType)
{
	if ( (Damage > 999999) && ((InstigatedBy == None) || (InstigatedBy.Controller == None) || (Instigator == None) || (Instigator.Controller == None) || !InstigatedBy.Controller.SameTeamAs(Instigator.Controller)) )
	{
		if ( (InstigatedBy == None) || DamageType.Default.bVehicleHit || (DamageType == class'Crushed') )
			BlowUp(Location);
		else
		{
	 		Spawn(class'SmallRedeemerExplosion');
		    SetCollision(false,false,false);
		    HurtRadius(Damage, DamageRadius*0.125, MyDamageType, MomentumTransfer, Location);
		    Destroy();
		}
	}
}

function Timer()
{
}

state Dying
{
    function BeginState()
    {
	bHidden = true;
	SetPhysics(PHYS_None);
	SetCollision(false,false,false);
	ShakeView();
	InitialState = 'Dying';
	if ( SmokeTrail != None )
		SmokeTrail.Destroy();
    }

Begin:
    PlaySound(sound'WeaponSounds.redeemer_explosionsound');
    HurtRadius(Damage, DamageRadius*0.500, MyDamageType, MomentumTransfer, Location);
    Sleep(0.5);
    HurtRadius(Damage, DamageRadius, MyDamageType, MomentumTransfer, Location);
    Destroy();
}

defaultproperties
{
     ExplosionEffectClass=Class'BWBPAirstrikesPro.CarpetBombExplosion'
     Speed=5.000000
     Damage=150.000000
     DamageRadius=768.000000
     ExplosionDecal=Class'BWBPAirstrikesPro.CarpetBlastMark'
     Physics=PHYS_Falling
}

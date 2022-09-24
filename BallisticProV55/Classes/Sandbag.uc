class Sandbag extends Object;
/*
var Sound							DamagedSounds[4];
var Sound							DestroyedSound;
var BallisticTurret 				AttachedWeapon;
var SandbagTrigger 				SBC;
var SandbagList					BagList;

function PostBeginPlay()
{
	local Teleporter Tel;
	foreach RadiusActors(class'Teleporter', Tel, 128)
	{
		Destroy();
		return;
	}
	class'SandbagList'.static.AutoInitBag(self);
	SBC=Spawn(class'SandbagTrigger', self,,Location,);
	SBC.Bags = self;
}

function Reset()
{
	Destroy();
}

function BreakApart(vector HitLocation, vector momentum)
{
	Destroy();
}

simulated function Destroyed()
{
	if ( Level.Netmode != NM_DedicatedServer && (EffectWhenDestroyed!=None ) && EffectIsRelevant(location,false) )
	{
		Spawn( EffectWhenDestroyed, Owner,, Location );
		PlaySound(DestroyedSound);
	}
		
	if (AttachedWeapon != None)
	{
		if (AttachedWeapon.Driver != None)
			AttachedWeapon.KDriverLeave(true);
			
		AttachedWeapon.Destroy();
	}
	
	if (Role == ROLE_Authority	 && BagList != None)
		BagList.RemoveBag(self);
		
	SBC.RemoveCoverAnchors();
	SBC.Destroy();
	
	Super.Destroyed();
}

function TakeBag(Pawn User)
{
	local Ammunition Ammo;
	local Weapon newWeapon;
	local int AmmoAmount;
	
	if (AttachedWeapon != None)
		return;

	Ammo = Ammunition(User.FindInventoryType(class'Ammo_Sandbags'));
	if(Ammo == None)
    {
		Ammo = Spawn(class'Ammo_Sandbags');
		User.AddInventory(Ammo);
		AmmoAmount = Ammo.AmmoAmount;
   		Ammo.UseAmmo(9999, true);
   	}

    if(User.FindInventoryType(class'SandbagLayer')==None)
    {
        newWeapon = Spawn(class'SandbagLayer',,,User.Location);
        if( newWeapon != None )
        {
            newWeapon.GiveTo(User);
			newWeapon.ConsumeAmmo(0, 9999, true);
        }
    }
	Ammo.AddAmmo(1);
	Ammo.GotoState('');
	
	Destroy();
}

auto state Working
{
	function BeginState()
	{
		super(Decoration).BeginState();

		SetCollision(true,true,true);
		NetUpdateTime = Level.TimeSeconds - 1;
		bHidden = false;
		Health = default.health;
	}

	function EndState()
	{
		super(Decoration).EndState();

		NetUpdateTime = Level.TimeSeconds - 1;
		bHidden = true;
		SetCollision(false,false,false);
	}
	
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,	Vector momentum, class<DamageType> damageType)
	{
		PlaySound(DamagedSounds[Rand(4)]);
		if (class<BallisticDamageType>(DamageType) != None && class<BallisticDamageType>(DamageType).default.DamageIdent != "Melee")
			Damage *= DamageType.default.VehicleDamageScaling;
		Health -= Damage;
		if ( Health < 1 )
			Destroy();
	}

	function Bump( actor Other )
	{
		if ( Mover(Other) != None && Mover(Other).bResetting )
			return;

		if ( UnrealPawn(Other)!=None && bImperviusToPlayer )
			return;
			
		if ( VSize(Other.Velocity)>500 )
			Destroy();
	}

	function bool EncroachingOn(Actor Other)
	{
		if ( Mover(Other) != None && Mover(Other).bResetting )
			return false;
			
		if (BallisticTurret(Other) != None)
			return false; //stacking

		Destroy();
		return false;
	}


	event EncroachedBy(Actor Other)
	{
		if ( Mover(Other) != None && Mover(Other).bResetting )
			return;
			
		if (BallisticTurret(Other) != None)
			return; //stacking
			
		Destroy();
	}
}

defaultproperties
{
     DamagedSounds(0)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletDirt1'
     DamagedSounds(1)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletDirt2'
     DamagedSounds(2)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletDirt3'
     DamagedSounds(3)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletDirt4'
     DestroyedSound=Sound'BW_Core_WeaponSound.BOGP.BOGP_FlareImpact'
	 EffectWhenDestroyed=Class'BallisticProV55.IE_SandbagExplosion'
     Health=250
     DrawType=DT_StaticMesh
     StaticMesh=StaticMesh'BW_Core_WeaponStatic.Sandbags.UTSandbags'
     CullDistance=0.000000
     bWorldGeometry=True
     bAlwaysRelevant=True
     bGameRelevant=True
     SoundVolume=150
     TransientSoundVolume=0.400000
     TransientSoundRadius=128.000000
     CollisionRadius=50.000000
     CollisionHeight=30.000000
     bBlockPlayers=True
     bBlockProjectiles=True
     bProjTarget=True
     bUseCylinderCollision=False
}
*/
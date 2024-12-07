class CoachDeployable extends DECO_Smashable;

var Sound								DamagedSounds[4];
var Sound								TeleportSound;
var	bool								bWarpOut;

var byte								Team, TeamSkinIndex;
var Material							TeamSkins[2];
var Controller							OwningController;

var	byte 								MasterDeployableIndex;

replication
{
	reliable if (Role == ROLE_Authority)
		bWarpOut, Team;
}

function PostBeginPlay()
{
	local CoachDeployable D;

	foreach RadiusActors(class'CoachDeployable', D, 256)
	{
		if (D != Self)
		{
			Destroy();
			return;
		}
	}
	
	OwningController = Instigator.Controller;

	if (Instigator.PlayerReplicationInfo.Team != None)
		Team = Instigator.PlayerReplicationInfo.Team.TeamIndex;
	else Team = 255;
}

function Initialize(byte deployable_index)
{
	MasterDeployableIndex = deployable_index;
}

simulated function PostNetBeginPlay()
{
	if (Team != 255 && TeamSkinIndex != 255)
		Skins[TeamSkinIndex]=TeamSkins[Team];
}

function AddHealth(int Amount)
{
	Health = FMin(default.Health, Health + Amount);
}

function Reset()
{
	Destroy();
}

auto state Working
{
	function TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation,	Vector momentum, class<DamageType> damageType)
	{
		if (Health < 1)
			return;
		if (Instigator != None && instigatedBy.Controller != None && Instigator.Controller != None && Instigator.Controller != OwningController && instigatedBy.Controller.SameTeamAs(Instigator.Controller))
			return;
		PlaySound(DamagedSounds[Rand(4)], SLOT_Pain);
		Damage *= DamageType.default.VehicleDamageScaling;
		Health -= Damage;
		if (Health < 0) 	
			GoToState('Destroying');	
	}

	singular function BaseChange()
	{
	}

	function Bump( actor Other )
	{
	}

	function bool EncroachingOn(Actor Other)
	{
		if (Decoration(Other) != None)
			GoToState('Destroying');
		return false;
	}

	event EncroachedBy(Actor Other)
	{
		if (Decoration(Other) != None)
			GoToState('Destroying');
		return;
	}
}

simulated function TornOff()
{
	if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
	{
		if (!bWarpOut)
			Spawn( EffectWhenDestroyed, Owner,, Location );
		else
		{
			Spawn(class'WrenchWarpEndEmitter', Owner,, Location);
			PlaySound(TeleportSound, ,1);
		}
	}
		
	Destroy();
}

state Destroying
{
	Begin:
		bHidden=True;
		bTearOff=True;
		bAlwaysRelevant=True;

		SetCollision(false, false, false);
		
		if (EffectWhenDestroyed != None && EffectIsRelevant(location,false))
		{
			if (!bWarpOut)
				Spawn( EffectWhenDestroyed, Owner,, Location );
			else
			{
				Spawn(class'WrenchWarpEndEmitter', Owner,, Location);
				PlaySound(TeleportSound, ,1);
			}
		}
		
		Sleep(0.5);
		Destroy();
}

defaultproperties
{
     DamagedSounds(0)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletMetal1'
     DamagedSounds(1)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletMetal2'
     DamagedSounds(2)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletMetal3'
     DamagedSounds(3)=Sound'BW_Core_WeaponSound.BulletImpacts.BulletMetal4'
	 TeleportSound=Sound'BWBP_OP_Sounds.Wrench.Teleport'
     TeamSkinIndex=255
     EffectWhenDestroyed=Class'UT2k4Assault.FX_SpaceFighter_Explosion'
     Health=250
     DrawType=DT_StaticMesh
     CullDistance=0.000000
     NetUpdateFrequency=10.000000
     bGameRelevant=True
     SoundVolume=150
     TransientSoundVolume=0.750000
     TransientSoundRadius=256.000000
     CollisionRadius=50.000000
     CollisionHeight=8.000000
     bBlockPlayers=True
     bBlockProjectiles=True
     bProjTarget=True
     bUseCylinderCollision=False
}

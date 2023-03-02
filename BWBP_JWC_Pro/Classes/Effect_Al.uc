//=============================================================================
// AlSound.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2007 RuneStorm. All Rights Reserved.
//=============================================================================
class Effect_Al extends BallisticEmitter;

var float Damage, DamageRadius, DamageInterval;
var class<DamageType>	DamageType;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if (Role == ROLE_Authority)
		SetTimer(DamageInterval, true);
}

function Timer()
{
	local Pawn Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Pawn', Victims, DamageRadius, Location)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims != Owner) && (Victims.Role == ROLE_Authority))
		{
			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/DamageRadius);
			class'BallisticDamageType'.static.GenericHurt
			(
				Victims,
				damageScale * Damage,
				Instigator,
				Victims.Location - 0.5 * (Victims.CollisionHeight + Victims.CollisionRadius) * dir,
				vect(0,0,0),
				DamageType
			);
		}
	}
	bHurtEntry = false;	
}

defaultproperties
{
     Damage=5.000000
     DamageRadius=200.000000
     DamageInterval=0.500000
     DamageType=Class'BWBP_JWC_Pro.Corroded'
     bNoDelete=False
     Physics=PHYS_Trailer
     AmbientSound=Sound'BWBP_JW_Sound.geigersound'
     bFullVolume=True
     SoundVolume=120
     SoundRadius=32.000000
}

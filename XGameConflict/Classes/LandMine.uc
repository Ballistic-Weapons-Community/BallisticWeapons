// ====================================================================
// A land mine. Blows up players who touch it and chucks their bodies into the air
//
// Written by Matt Oelfke
// (C) 2003, Epic Games, Inc. All Rights Reserved
// ====================================================================
class LandMine extends Triggers
	placeable;

var() vector ChuckVelocity;
var() class<DamageType> DamageType;
var() class<Emitter> BlowupEffect;
var() Sound BlowupSound;

function Touch(Actor Other)
{
	if (Pawn(Other) != None)
	{
		Other.PendingTouch = self;
		PendingTouch = Other;
	}
}

function PostTouch(Actor Other)
{
	local Pawn P;

	P = Pawn(Other);
	if (P != None)
	{
		PlaySound(BlowupSound,,3.0*TransientSoundVolume);
		spawn(BlowupEffect,,,P.Location - P.CollisionHeight * vect(0,0,1));
		P.AddVelocity(ChuckVelocity);
		P.Died(None, DamageType, P.Location);
	}
}

defaultproperties
{
	CollisionRadius=100.f
	CollisionHeight=50.f
	ChuckVelocity=(X=0,Y=0,Z=1000)
	DamageType=class'DamageType'
	BlowupEffect=class'XEffects.LandMineExplosion'
	BlowupSound=sound'WeaponSounds.BExplosion3'
}

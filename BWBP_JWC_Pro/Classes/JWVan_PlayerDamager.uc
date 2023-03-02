class JWVan_PlayerDamager extends Actor;

var float Damage, DamageInterval;
var class<DamageType>	DamageType;
var array<Sound> Music

;function PostBeginPlay()
{
 if (Role == ROLE_Authority)
 {
  SetBase(Owner);
  SetTimer(DamageInterval, true);
  AmbientSound = Music[Rand(Music.Length)];
 }
}

function Timer()
{
	local Pawn Victims;
	local float damageScale, dist;
	local vector dir;

	if( bHurtEntry ) //not handled well...
		return;

	bHurtEntry = true;
	
	foreach VisibleCollidingActors( class 'Pawn', Victims, SoundRadius, Location)
	{
		// don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
		if( (Victims != self) && (Victims != Owner) && (Victims.Role == ROLE_Authority))
		{
			dir = Victims.Location - Location;
			dist = FMax(1,VSize(dir));
			dir = dir/dist;
			damageScale = 1 - FMax(0,(dist - Victims.CollisionRadius)/SoundRadius);
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
     Damage=8.000000
     DamageInterval=0.500000
     DamageType=Class'BWBP_JWC_Pro.DTplayer'
     Music(0)=Sound'BWBP_JW_Sound.rickastley'
     Music(1)=Sound'BWBP_JW_Sound.bibi'
     Music(2)=Sound'BWBP_JW_Sound.gangnam'
     Music(3)=Sound'BWBP_JW_Sound.ilikethatshit'
     Music(4)=Sound'BWBP_JW_Sound.whatislove'
     Music(5)=Sound'BWBP_JW_Sound.scatman'
     Music(6)=Sound'BWBP_JW_Sound.babo'
     Music(7)=Sound'BWBP_JW_Sound.tube'
     Music(8)=Sound'BWBP_JW_Sound.tunak'
     Music(9)=Sound'BWBP_JW_Sound.NEX.thriller'
     Music(10)=Sound'BWBP_JW_Sound.freak'
     Music(11)=Sound'BWBP_JW_Sound.chicken'
     bHidden=True
     bUpdateSimulatedPosition=True
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=16.000000
     bHardAttach=True
     SoundVolume=255
     SoundRadius=1024.000000
}

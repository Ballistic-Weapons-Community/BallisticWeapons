class BLU82ProjectileReal extends BLU82Projectile;

//we don't have bots shoot bomber bombs because we'd rather they shoot the bomber itself instead
function BeginPlay()
{
	Super(Projectile).BeginPlay();
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
     StaticMesh=StaticMesh'VMWeaponsSM.PlayerWeaponsGroup.bomberBomb'
}

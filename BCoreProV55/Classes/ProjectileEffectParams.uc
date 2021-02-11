//=============================================================================
// ProjectileEffectParams.
//
// Parameters which define the gameplay properties of a shot 
// fired by a projectile fire mode. 
//
// by Azarael 2020
//=============================================================================
class ProjectileEffectParams extends FireEffectParams
    editinlinenew
    DependsOn(BUtil);

var()   class<BallisticProjectile>  ProjectileClass;
var()   vector			            SpawnOffset;

static simulated function Initialize(BallisticWeapon BW);

defaultproperties
{
}
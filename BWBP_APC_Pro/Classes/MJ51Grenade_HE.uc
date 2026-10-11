//=============================================================================
// MJ51Grenade_HE.
//
// The G51's HE rifle grenade as fired by the MJ51. Projectiles read their params
// through WeaponClass, so this needs its own class pointing at the MJ51 -
// otherwise it used the G51's params for the MJ51's layout index (e.g. the
// EOtech + HE layout got the G51 sensor grenade's zero splash damage).
//=============================================================================
class MJ51Grenade_HE extends G51Grenade_HE;

defaultproperties
{
	WeaponClass=class'MJ51Carbine'
}

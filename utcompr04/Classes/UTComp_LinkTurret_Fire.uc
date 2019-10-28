//=============================================================================
// Link gun damage scaling vs. vehicle is unreliable, so removed it
//=============================================================================

class UTComp_LinkTurret_Fire extends FM_LinkTurret_Fire;

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local PROJ_LinkTurret_Plasma Proj;

    Start += Vector(Dir) * 10.0 * Weapon_LinkTurret(Weapon).Links;
    Proj = Weapon.Spawn(class'UTComp_Proj_LinkTurret_Plasma',,, Start, Dir);
    if ( Proj != None )
    {
		Proj.Links = Weapon_LinkTurret(Weapon).Links;
		Proj.LinkAdjust();
	}
    return Proj;
}

defaultproperties
{
}

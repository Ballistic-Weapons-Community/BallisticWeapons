//=============================================================================
// The corona that emitts from behind the Cobras missiles
//

// by Logan "BlackEagle" Richert.
// Copyright(c) 2007. All Rights Reserved.
//=============================================================================

class KHMKIIRocketFlare extends Effects;

auto state Start
{
    simulated function Tick(float dt)
    {
        SetDrawScale(FMin(DrawScale + dt*12.0, 1.5));
        if (DrawScale >= 1.5)
        {
            GotoState('End');
        }
    }
}

state End
{
    simulated function Tick(float dt)
    {
        SetDrawScale(FMax(DrawScale - dt*12.0, 0.9));
        if (DrawScale <= 0.9)
        {
            GotoState('');
        }
    }
}

defaultproperties
{
     bTrailerSameRotation=True
     Physics=PHYS_Trailer
     Texture=Texture'AW-2004Particles.Weapons.PlasmaStar2'
     DrawScale=0.100000
     Skins(0)=Texture'AW-2004Particles.Weapons.PlasmaStar2'
     Style=STY_Translucent
     Mass=13.000000
}

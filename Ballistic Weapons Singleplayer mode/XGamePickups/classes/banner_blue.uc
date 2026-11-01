//=============================================================================
// banner.
//=============================================================================
class banner_blue extends uTeamBanner;

simulated function PostBeginPlay()
{    
    Super.PostBeginPlay();    

    LoopAnim('banner');
    SimAnim.bAnimLoop = true;  
}

defaultproperties
{
    Skins(0)=SC_Volcano_T.Banners.SC_BannerBlue_F
    Team=1
}


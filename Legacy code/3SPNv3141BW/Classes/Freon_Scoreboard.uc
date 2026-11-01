class Freon_Scoreboard extends TAM_Scoreboard;

simulated function SetCustomBarColor(out Color C, PlayerReplicationInfo PRI, bool bOwner)
{
    if(!bOwner && Freon_PRI(PRI) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo).bFrozen)
    {
        C.R = 180;
        C.G = 220;
        C.B = 255;
        C.A = BaseAlpha * 1.1;
    }
}

simulated function SetCustomLocationColor(out Color C, PlayerReplicationInfo PRI, bool bOwner)
{
    if(Freon_PRI(PRI) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo) != None && Freon_PawnReplicationInfo(Freon_PRI(PRI).PawnReplicationInfo).bFrozen)
        C = class'Freon_PRI'.default.FrozenColor;
}

defaultproperties
{
     BaseTex=Texture'3SPNv3141BW.textures.FrostedScoreboard'
     BaseAlpha=130
}

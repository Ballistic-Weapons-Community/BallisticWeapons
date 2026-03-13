//=============================================================================
// xCTFGame.
//=============================================================================
class xCTFGame extends CTFGame
    config;

#exec OBJ LOAD FILE=GameSounds.uax
#exec OBJ LOAD File=XGameShadersB.utx

static function PrecacheGameTextures(LevelInfo myLevel)
{
	class'xTeamGame'.static.PrecacheGameTextures(myLevel);
}

static function PrecacheGameStaticMeshes(LevelInfo myLevel)
{
	class'xDeathMatch'.static.PrecacheGameStaticMeshes(myLevel);
}


function actor FindSpecGoalFor(PlayerReplicationInfo PRI, int TeamIndex)
{
	local XPlayer PC;
    local Controller C;
    local CTFFlag Flags[2],F;

    PC = XPlayer(PRI.Owner);
    if (PC==None)
    	return none;

    // Look for a Player holding the flag


    for (C=Level.ControllerList;C!=None;C=C.NextController)
    {
    	if ( (C.PlayerReplicationInfo != None) && (C.PlayerReplicationInfo.HasFlag!=None)
    		&& (PC.ViewTarget == None || PC.ViewTarget != C.Pawn) )
        	return C.Pawn;
    }

	foreach AllActors(class'CTFFlag',f)
    	Flags[f.TeamNum]=f;

    if ( vsize(PC.Location - Flags[0].Location) < vsize(PC.Location - Flags[1].Location) )
    	return Flags[1];
    else
    	return Flags[0];

    return none;

}

event SetGrammar()
{
	LoadSRGrammar("CTF");
}

defaultproperties
{
    MapListType="XInterface.MapListCaptureTheFlag"
    DeathMessageClass=class'XGame.xDeathMessage'
    HUDType="XInterface.HudCCaptureTheFlag"
	DefaultEnemyRosterClass="xGame.xTeamRoster"

    ScreenShotName="UT2004Thumbnails.CTFShots"
    DecoTextName="XGame.CTFGame"

    GameName="Capture the Flag"
    MapPrefix="CTF"
    Acronym="CTF"
	OtherMesgGroup="CTFGame"
    Description="Your team must score flag captures by taking the enemy flag from the enemy base and returning it to their own flag.  If the flag carrier is killed, the flag drops to the ground for anyone to pick up.  If your team's flag is taken, it must be returned (by touching it after it is dropped) before your team can score a flag capture."
}

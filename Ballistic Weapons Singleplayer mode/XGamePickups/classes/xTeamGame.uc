//=============================================================================
// Copyright 2001 Digital Extremes - All Rights Reserved.
// Confidential.
//=============================================================================
class xTeamGame extends TeamGame;

#exec OBJ LOAD FILE=TeamSymbols.utx				// needed right now for Link symbols, etc.

static function PrecacheGameTextures(LevelInfo myLevel)
{
	class'xDeathMatch'.static.PrecacheGameTextures(myLevel);

	myLevel.AddPrecacheMaterial(Material'TeamSymbols.TeamBeaconT');
	myLevel.AddPrecacheMaterial(Material'TeamSymbols.LinkBeaconT');
	myLevel.AddPrecacheMaterial(Material'XEffectMat.RedShell');
	myLevel.AddPrecacheMaterial(Material'XEffectMat.BlueShell');
	myLevel.AddPrecacheMaterial(Material'TeamSymbols.soundBeacon_a00');
	myLevel.AddPrecacheMaterial(Material'TeamSymbols.soundBeacon_a01');
	myLevel.AddPrecacheMaterial(Material'TeamSymbols.soundBeacon_a02');
	myLevel.AddPrecacheMaterial(Material'TeamSymbols.soundBeacon_a03');
}

static function PrecacheGameStaticMeshes(LevelInfo myLevel)
{
	class'xDeathMatch'.static.PrecacheGameStaticMeshes(myLevel);
}

defaultproperties
{
    MapListType="XInterface.MapListTeamDeathMatch"
    HUDType="XInterface.HudCTeamDeathMatch"
    DeathMessageClass=class'XGame.xDeathMessage'
	DefaultEnemyRosterClass="xGame.xTeamRoster"

    ScreenShotName="UT2004Thumbnails.TDMShots"
    DecoTextName="XGame.TeamGame"

    Acronym="TDM"
    GameName="Team DeathMatch"
    MapPrefix="DM"
    Description="Two teams duke it out in a quest for battlefield supremacy.  The team with the most total frags wins."
}
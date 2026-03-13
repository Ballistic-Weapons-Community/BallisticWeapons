//=============================================================================
// xMonitor - Team monitors for designating team areas.
//=============================================================================
class xMonitor extends Decoration
    abstract;

var() byte      Team;
var() Material  RedTeamShader;
var() Material  BlueTeamShader;
var GameReplicationInfo GRI;

simulated function UpdatePrecacheMaterials()
{
    Level.AddPrecacheMaterial(RedTeamShader);
    Level.AddPrecacheMaterial(BlueTeamShader);

	super.UpdatePrecacheMaterials();
}

simulated function UpdateForTeam()
{
    if (Team == 0)
        Skins[2] = RedTeamShader;
    else
        Skins[2] = BlueTeamShader;

	if ( (GRI != None) && (Team < 2) && (GRI.TeamSymbols[Team] != None) )
		Combiner(Shader(Skins[2]).SelfIllumination).Material2 = GRI.TeamSymbols[Team];
}

simulated function SetGRI(GameReplicationInfo NewGRI)
{
	GRI = NewGRI;
	UpdateForTeam();
}	
	
simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();	
    if ( Level.Game != None )
		SetGRI(Level.Game.GameReplicationInfo);
}

defaultproperties
{
    RemoteRole=ROLE_None
    bWorldGeometry=true
	bNoDelete=true
    bUnlit=false
    bHidden=false
    bStasis=false
    bStatic=false
    bCollideActors=true
    bCollideWorld=true    
    bNetNotify=true
    bBlockKarma=true
    bBlockActors=true
    bProjTarget=true
    bBlockZeroExtentTraces=true
    bBlockNonZeroExtentTraces=true
    bUseCylinderCollision=false    
    DrawScale=2.50000
    DrawType=DT_StaticMesh
    Style=STY_Normal    
    CollisionRadius=48.000000
    CollisionHeight=30.000000    
    Mass=100.000000
    RedTeamShader=Material'RedScreenS'
    BlueTeamShader=Material'BlueScreenS'
}

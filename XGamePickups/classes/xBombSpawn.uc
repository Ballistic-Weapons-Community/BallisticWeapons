//=============================================================================
// xBombSpawn.
//=============================================================================
class xBombSpawn extends GameObjective
	placeable;

var() Sound TakenSound;
var xBombFlag myFlag;
var class<xBombFlag> FlagType;

#exec OBJ LOAD FILE=XGameShaders.utx

function BeginPlay()
{
	Super.BeginPlay(); 
	if ( !Level.Game.IsA('xBombingRun') )
		return;
		
	myFlag = Spawn(FlagType, self);

	if (myFlag==None)
	{
		warn(Self$" could not spawn flag of type '"$FlagType$"' at "$location);
		return;
	}
	else
		myFlag.HomeBase = self;
	
	Spawn(class'XGame.xBombBase',self,,Location-vect(0,0,60),Rotation);
}

function bool BotNearObjective(Bot B)
{

	if  ( (myFlag == None) || (B==None) )
		return false;

	if ( (MyBaseVolume != None) && myFlag.bHome	&& B.Pawn.IsInVolume(MyBaseVolume) )
		return true;
	
	return ( (VSize(myFlag.Position().Location - B.Pawn.Location) < 2000) && B.LineOfSightTo(myFlag.Position()) );
}

function bool BetterObjectiveThan(GameObjective Best, byte DesiredTeamNum, byte RequesterTeamNum)
{
	if ( !myFlag.bHome || (RequesterTeamNum == DesiredTeamNum) )
		return false;
	return true;
}

defaultproperties
{
	ObjectiveName="Bomb Spawn"
    LightType=LT_SubtlePulse
	LightEffect=LE_QuadraticNonIncidence
	LightRadius=6
    LightBrightness=128	
    LightHue=37
    LightSaturation=255	
    bUnlit=true
    bNotBased=true
    TakenSound=Sound'GameSounds.CTFAlarm'
    bHidden=true
    DefenderTeamIndex=255    
    FlagType=class'XGame.xBombFlag'
    DrawType=DT_StaticMesh
    StaticMesh=XGame_rc.BallMesh
    DrawScale=3.000000
	bStasis=false
	bAlwaysRelevant=true
    CollisionRadius=60.000000
    CollisionHeight=60.000000
    bCollideActors=True
    bBlockActors=False
	NetUpdateFrequency=8
}

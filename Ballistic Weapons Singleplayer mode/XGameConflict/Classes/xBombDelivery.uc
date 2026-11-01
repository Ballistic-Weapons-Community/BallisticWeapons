//=============================================================================
// xBombDelivery.
// For Bombing Run matches.
//=============================================================================
class xBombDelivery extends GameObjective
	placeable;

#exec OBJ LOAD File=WeaponSounds.uax

var(Team) int Team;
var xBombDeliveryHole MyHole;
var int ExplosionCounter,ExplodeNow,LastExplodeNow;
var() float TouchDownDifficulty;

replication
{
    reliable if( Role==ROLE_Authority )
        ExplodeNow;
}

function bool CanDoubleJump(Pawn Other)
{
	return true;
}

function bool CanMakeJump(Pawn Other, Float JumpHeight, Float GroundSpeed, Int Num, Actor Start, bool bForceCheck)
{
	if ( !bForceCheck && (JumpHeight > Other.JumpZ) && (PhysicsVolume.Gravity.Z >= CalculatedGravityZ[Num]) && (NeededJump[Num].Z < 2 * Other.JumpZ) )
		return true;

	return Super.CanMakeJump(Other,JumpHeight,GroundSpeed,Num,Start,bForceCheck);
}

function float GetDifficulty()
{
	return TouchDownDifficulty;
}

simulated function PostBeginPlay()
{
	local NavigationPoint N;
	
	Super.PostBeginPlay();

	if ( Role == ROLE_Authority )
	{
		DefenderTeamIndex = Team;
		NetUpdateTime = Level.TimeSeconds - 1;

		// spawn my scoring hole
		MyHole = Spawn(class'xBombDeliveryHole',self,,Location,Rotation);
	    
		// check if has shootspots
		for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
			if ( (ShootSpot(N) != None) && (ShootSpot(N).TeamNum == Team) )
			{
				bHasShootSpots = true;
				break;
			}
	}		
	SetTeamColors();
}
    
function ScoreEffect(bool touchdown)
{
    ExplodeNow++;
    // spawn some explosions
    PlaySound(sound'WeaponSounds.BExplosion3');
    Spawn(class'NewExplosionA',,,Location+VRand()*Vect(50,50,50));
    ExplosionCounter = 1;    
    SetTimer(0.25,true);
}

simulated function Timer()
{
	PlaySound(sound'WeaponSounds.BExplosion3');
    Spawn(class'NewExplosionA',,,Location+VRand()*Vect(50,50,50));    
    ExplosionCounter++;

    if (ExplosionCounter > 5)
        SetTimer(0.0,false);
}

simulated function SetTeamColors()
{
    if (Team == 0)
    {
        LightHue = 0;
        Skins[1] = Combiner'XGameTextures.superpickups.BombgatePulseRC';
    }
    else
    {
        LightHue = 170;
        Skins[1] = Combiner'XGameTextures.superpickups.BombgatePulseBC';
	}
}

simulated event PostNetReceive()
{
    Super.PostNetReceive();

    if (LastExplodeNow != ExplodeNow)
    {
        LastExplodeNow = ExplodeNow;
        PlaySound(sound'WeaponSounds.BExplosion3');
        Spawn(class'NewExplosionA',,,Location+VRand()*Vect(50,50,50));
        ExplosionCounter = 1;    
        SetTimer(0.25,true);
    }
}

defaultproperties
{
	bDestinationOnly=true
	NetUpdateFrequency=40
	ObjectiveStringSuffix=" Goal"
	TransientSoundVolume=+1.0
	TouchDownDifficulty=+0.5
	bNotBased=true
	RemoteRole=ROLE_SimulatedProxy
	bAlwaysRelevant=true
    bHidden=false
    bUnlit=true
    bPathColliding=true
    bStasis=false
    bStatic=false
	bNoDelete=true
	bWorldGeometry=true
    bCollideActors=true
    bCollideWorld=false
    bBlockActors=true
    bProjTarget=true
    bBlockZeroExtentTraces=true
    bBlockNonZeroExtentTraces=true
    bUseCylinderCollision=false
    CollisionRadius=16.000000
    CollisionHeight=16.000000
    DrawScale=0.80000
    DrawType=DT_StaticMesh
    //StaticMesh=XGame_rc.BombDeliveryMesh
    StaticMesh=StaticMesh'XGame_StaticMeshes.BombGate'
    Skins(0)=Texture'XGameTextures.superpickups.BombGate'
    Skins(1)=Combiner'XGameTextures.superpickups.BombgatePulseRC'
    Style=STY_Normal
	bDynamicLight=True	
    LightType=LT_SubtlePulse
	LightEffect=LE_QuadraticNonIncidence
	LightRadius=6
    LightBrightness=255	
    LightHue=255
    LightSaturation=55    
    SoundRadius=255
    SoundVolume=255
    bNetNotify=true
    bBlockKarma=true
}
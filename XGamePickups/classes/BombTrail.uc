class BombTrail extends SpeedTrail;

simulated function PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if ( bNetNotify )
		PostNetReceive();
}

simulated event PostNetReceive()
{
	local Actor OldBase;
	
	if ( Base != None )
	{
		OldBase = Base;
		SetLocation(Base.Location);
		SetBase(OldBase);
		SetRelativeLocation(vect(0,0,0));
		bNetNotify = false;
	}	
}


DefaultProperties
{
	bHardAttach=true
	bNetNotify=true
    mPosDev=(X=0.0,Y=0.0,Z=0.0)
    mDirDev=(X=0.0,Y=0.0,Z=0.0)
}
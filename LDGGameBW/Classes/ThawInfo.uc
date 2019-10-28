class ThawInfo extends LinkedReplicationInfo;

var float 								ThawProtectionTime;
var	float								RecentlyThawnTime;
var bool									bRecentlyThawnOnlyInOT;

var bool									bHUDOverlayAdded;
var bool 								bWasFrozen;
var bool 								bThawWhileProtected;
var bool 								bIsProtected;
var bool									bWasProtected;
var bool 								bRecentlyThawn;
var bool									bWasRecentlyThawn;
var float 								ProtectionStartTime;
var float 								RecentlyThawnStartTime;
var float 								LastThawnTime;
var int 									FrozenRound;
var xPawn								Pawn;
var float								ClientProtectionStartTime;
var float								ClientRecentlyThawnStartTime;
var PlayerReplicationInfo			ParentPRI;
var xEmitter							ProtectionEmitter;

replication 
{
	reliable if (Role == ROLE_Authority && bNetInitial)
		ThawProtectionTime, RecentlyThawnTime, ParentPRI;
	
	reliable if (Role == ROLE_Authority)
		Pawn, bIsProtected, bRecentlyThawn;
}

simulated function Destroyed()
{
	if(ProtectionEmitter != none && !ProtectionEmitter.bDeleteMe)
	{
		ProtectionEmitter.Destroy();
		ProtectionEmitter = none;
	}

	Super.Destroyed();
}

function Respawned(xPawn MyPawn) 
{
	Pawn = MyPawn;
			
	if(!bWasFrozen)
	{
		DeactivateProtection();
		ResetRecentlyThawn();
		return;
	}

	if(FrozenRound == GetRoundNumber())
		ActivateProtection();
	else
	{
		DeactivateProtection();
		ResetRecentlyThawn();
	}

	ClearFrozen();
}

function int GetRoundNumber() 
{
	local Team_GameBase TG;
	
	TG = Team_GameBase(Level.Game);
	if(TG == None)
  	return -1;

	return TG.CurrentRound;
}

simulated function bool IsFXActive() 
{
	return (ProtectionEmitter != None && !ProtectionEmitter.bDeleteMe);
}

simulated function CheckFX() 
{
	if(Level.NetMode == NM_DedicatedServer)
		return;

	if(bIsProtected)
	{
	  if(!IsFXActive())
	  {
	  	if(Pawn != None && !Pawn.bInvis)
	     	ActivateFX();
	  }
	  else
	  {
	   	if(Pawn != None && Pawn.bInvis)
	   		DeactivateFX();
	  }
	}
	else
	{
		if(IsFXActive())
			DeactivateFX();
	}
}

simulated function SpawnEmitter() 
{
	if(ParentPRI.Team.TeamIndex == 1)
		ProtectionEmitter = Spawn(class'ThawProtectionEmitterBlue', Pawn,,Pawn.Location, Pawn.Rotation);
	else
		ProtectionEmitter = Spawn(class'ThawProtectionEmitterRed', Pawn,,Pawn.Location, Pawn.Rotation);
	
	ProtectionEmitter.SetBase(Pawn);
	ProtectionEmitter.LifeSpan = (ClientProtectionStartTime + ThawProtectionTime) - Level.TimeSeconds;
}

simulated function ActivateFX() 
{
	if(IsFXActive())
 		return;
 		
  if(Pawn == None || Pawn.bInvis)
		return;
	
	SpawnEmitter();
}

simulated function DeactivateFX() 
{
	if(!IsFXActive())
 		return;

	if(ProtectionEmitter != None && !ProtectionEmitter.bDeleteMe)
		ProtectionEmitter.Destroy();
		
	ProtectionEmitter = None;
}

function ActivateProtection() 
{
 	if(bIsProtected || Pawn == None)
	 	return;

	ProtectionStartTime = Level.TimeSeconds;
	LastThawnTime = Level.TimeSeconds;
	bIsProtected = true;
	
	if (!bThawWhileProtected)
	{
		if (bRecentlyThawnOnlyInOT)
			bRecentlyThawn = Freon(Level.Game).bRoundOT;
		else
			bRecentlyThawn = true;
			
		if (bRecentlyThawn)
			RecentlyThawnStartTime = Level.TimeSeconds;
	}
	
	NetUpdateTime = Level.TimeSeconds - 1.0;
}

function DeactivateProtection() 
{
	if(!bIsProtected || Pawn == None)
	 	return;

	ProtectionStartTime = 0;
  bIsProtected = false;  
  NetUpdateTime = Level.TimeSeconds - 1.0;
}

function ResetRecentlyThawn()
{
	if(!bRecentlyThawn || Pawn == None)
	 	return;

	RecentlyThawnStartTime = 0;
  bRecentlyThawn = false;  
  NetUpdateTime = Level.TimeSeconds - 1.0;
} 

function bool IsFrozen() 
{
	return Owner != None && Owner.IsInState('Frozen');
}

function bool IsRoundOver() 
{
	local Freon FGame;
	
  FGame = Freon(Level.Game);

  if(FGame == None)
  	return true;

  return (FGame.bGameEnded || FGame.bEndOfRound);
}

function ClearFrozen() 
{
 	bWasFrozen = false;
 	FrozenRound = -2;
}

function SetFrozen(int RoundNumber) 
{
 	bWasFrozen = true;
 	FrozenRound = RoundNumber;
}

function ServerCheckFrozen() 
{
	if(!IsFrozen())
		return;

	if(IsRoundOver())
	{
		if (bIsProtected)
		{
			DeactivateProtection();
			ResetRecentlyThawn();
		}
			

	 	if(bWasFrozen)
			ClearFrozen();
			
	 	return;
	}

	if(!bWasFrozen)
		SetFrozen(GetRoundNumber());
}

function ServerCheckProtection() 
{
	if (bRecentlyThawn && Level.TimeSeconds - RecentlyThawnStartTime > RecentlyThawnTime)
		ResetRecentlyThawn();
	
	if(!bIsProtected)
		return;

	if(Pawn != None && Pawn.Weapon != None && Pawn.Weapon.IsFiring())
	{
	 	DeactivateProtection();
	 	return;
	}

	if(ProtectionStartTime == 0 || Level.TimeSeconds - ProtectionStartTime > ThawProtectionTime)
	{
		DeactivateProtection();
		return;
	}
}


simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);

	if (bIsProtected && !bWasProtected)
		ClientProtectionStartTime = Level.TimeSeconds;
	else if (!bIsProtected)
		ClientProtectionStartTime = 0;
		
	if (bRecentlyThawn && !bWasRecentlyThawn)	
		ClientRecentlyThawnStartTime = Level.TimeSeconds;
	else if (!bRecentlyThawn)
		ClientRecentlyThawnStartTime = 0;
	
	bWasProtected = bIsProtected;
	bWasRecentlyThawn = bRecentlyThawn;

  ServerCheckProtection();
  ServerCheckFrozen();
  CheckFX();
}

defaultproperties
{
     FrozenRound=-2
     NetUpdateFrequency=10.000000
     NetPriority=2.000000
}

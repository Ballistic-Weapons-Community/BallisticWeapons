class Freon_Player extends Misc_Player;

var Freon_Pawn FrozenPawn;

struct AmmoTrack
{
	var class<BallisticWeapon> GunClass;
	var byte Ammo1;
	var byte Ammo2;
};

var() array <AmmoTrack> AmmoTracking;

replication
{
	reliable if (Role < ROLE_Authority)
		ServerTrySuddenDeath, ServerTryThaw;
}

function AwardAdrenaline(float amount)
{
    amount *= 0.8;
    Super.AwardAdrenaline(amount);
}

exec simulated function CallSuddenDeath()
{
	ServerTrySuddenDeath();
}
//===========================================================================
// Sudden death. Puts the game into TAM mode.
// This only works if called by the last person alive.
//===========================================================================
function ServerTrySuddenDeath()
{
	local Controller C;
	local Freon_Trigger FT;
	local byte LivingCount;
	
	if (Pawn == None || !Pawn.bProjTarget)
	{
		ClientMessage("You are dead.");
		return;
	}
	
	if (!Freon(Level.Game).bRoundOT)
	{
		ClientMessage("You can only trigger Sudden Death mode in overtime.");
		return;
	}
		
    for(C = Level.ControllerList; C != None; C = C.NextController)
    {
        if(C != Self && C.PlayerReplicationInfo != None && C.bIsPlayer
            && !C.PlayerReplicationInfo.bOutOfLives
            && !C.PlayerReplicationInfo.bOnlySpectator)
			{
				LivingCount++;
				if(C.PlayerReplicationInfo.Team == PlayerReplicationInfo.Team)
				{
					ClientMessage("Someone else on your team remains alive.");
					return;
				}
			}
    }
	
	if (LivingCount < 5)
		ClientMessage("You can only trigger sudden death mode against 5 or more enemies.");
	
	Freon(Level.Game).bSuddenDeathMode = True;
    foreach DynamicActors(class'Freon_Trigger', FT)
        FT.Destroy();
	Level.Game.Broadcast(Level.Game, Caps(PlayerReplicationInfo.PlayerName)@"CALLS SUDDEN DEATH MODE! PROXIMITY HEALING AND THAWING DISABLED!");
}

function AddAmmoTrack(BallisticWeapon BW)
{
	local int i;
	local AmmoTrack AT;
	
	if (AmmoTracking.Length > 0)
	{
		for (i=0; i < AmmoTracking.Length && AmmoTracking[i].GunClass != BW.Class; i++);
		
		if (i < AmmoTracking.Length)
			return;
	}
		
	AT.GunClass = BW.Class;
	AT.Ammo1 = BW.AmmoAmount(0) - (BW.default.MagAmmo - BW.MagAmmo);
	if (BW.GetAmmoClass(0) != BW.GetAmmoClass(1) && BW.GetAmmoClass(1) != None)
		AT.Ammo2 = BW.AmmoAmount(1);
	AmmoTracking[AmmoTracking.Length] = AT;
}

function AmmoTrack GetAmmoTrackFor(class<Weapon> W)
{
	local int i;
	local AmmoTrack ReturnedTrack;
	
	for (i=0; i < AmmoTracking.Length; i++)
	{
		if (AmmoTracking[i].GunClass == W || ClassIsChildOf(W, AmmoTracking[i].GunClass))
		{
			ReturnedTrack.GunClass = AmmoTracking[i].GunClass;
			ReturnedTrack.Ammo1 = AmmoTracking[i].Ammo1;
			ReturnedTrack.Ammo2 = AmmoTracking[i].Ammo2;
			AmmoTracking.Remove(i, 1);
			return ReturnedTrack;
		}
	}
	
	return ReturnedTrack;
}

//Ghosts are always empty
function TrackGhost(class<BallisticWeapon> TrackClass)
{
	local int i;
	local AmmoTrack AT;
	
	if (AmmoTracking.Length > 0)
	{
		for (i=0; i < AmmoTracking.Length && AmmoTracking[i].GunClass != TrackClass; i++);
		
		if (i < AmmoTracking.Length)
			return;
	}
		
	AT.GunClass = TrackClass;
	AmmoTracking[AmmoTracking.Length] = AT;
}

simulated event Destroyed()
{
    if(FrozenPawn != None)
        FrozenPawn.Died(self, class'Suicided', FrozenPawn.Location);

    Super.Destroyed();
}

function BecomeSpectator()
{
    if(FrozenPawn != None)
        FrozenPawn.Died(self, class'DamageType', FrozenPawn.Location);

    Super.BecomeSpectator();
}

function ServerDoCombo(class<Combo> ComboClass)
{
    if(class<ComboSpeed>(ComboClass) != None)
        ComboClass = class<Combo>(DynamicLoadObject("3SPNv3141BW.Freon_ComboSpeed", class'Class'));

    Super.ServerDoCombo(ComboClass);
}

function Reset()
{
    Super.Reset();
    FrozenPawn = None;
}

function Freeze()
{
    if(Pawn == None)
        return;

    FrozenPawn = Freon_Pawn(Pawn);

    bBehindView = true;
    LastKillTime = -5.0;
    EndZoom();

    Pawn.RemoteRole = ROLE_SimulatedProxy;

    Pawn = None;
    PendingMover = None;

    if(!IsInState('GameEnded') && !IsInState('RoundEnded'))
    {
        ServerViewSelf();
        GotoState('Frozen');
    }
}

function ServerViewNextPlayer()
{
    local Controller C, Pick;
    local bool bFound, bRealSpec, bWasSpec;
	local TeamInfo RealTeam;

    bRealSpec = PlayerReplicationInfo.bOnlySpectator;
    bWasSpec = (ViewTarget != FrozenPawn) && (ViewTarget != Pawn) && (ViewTarget != self);
    PlayerReplicationInfo.bOnlySpectator = true;
    RealTeam = PlayerReplicationInfo.Team;

    // view next player
    for ( C=Level.ControllerList; C!=None; C=C.NextController )
    {
		if ( bRealSpec && (C.PlayerReplicationInfo != None) ) // hack fix for invasion spectating
			PlayerReplicationInfo.Team = C.PlayerReplicationInfo.Team;
        if ( Level.Game.CanSpectate(self,bRealSpec,C) )
        {
            if ( Pick == None )
                Pick = C;
            if ( bFound )
            {
                Pick = C;
                break;
            }
            else
                bFound = ( (RealViewTarget == C) || (ViewTarget == C) );
        }
    }
    PlayerReplicationInfo.Team = RealTeam;
    SetViewTarget(Pick);
    ClientSetViewTarget(Pick);

    if(!bWasSpec)
        bBehindView = false;

    ClientSetBehindView(bBehindView);
    PlayerReplicationInfo.bOnlySpectator = bRealSpec;
}

function ServerViewSelf()
{
    if(PlayerReplicationInfo != None)
    {
        if(PlayerReplicationInfo.bOnlySpectator)
            Super.ServerViewSelf();
        else if(FrozenPawn != None)
        {
            SetViewTarget(FrozenPawn);
            ClientSetViewTarget(FrozenPawn);
            bBehindView = true;
            ClientSetBehindView(true);
            ClientMessage(OwnCamera, 'Event');
        }
        else
        {
            if(ViewTarget == None)
                Fire();
            else
            {
                bBehindView = !bBehindView;
                ClientSetBehindView(bBehindView);
            }
        }
    }
}

state Spectating
{
    ignores SwitchWeapon, RestartLevel, ClientRestart, Suicide,
     ThrowWeapon, NotifyPhysicsVolumeChange, NotifyHeadVolumeChange;

    exec function Fire( optional float F )
    {
    	if(bFrozen)
	    {
		    if((TimerRate <= 0.0) || (TimerRate > 1.0))
			    bFrozen = false;
		    return;
	    }

		ServerTryThaw();
    }

    // Return to spectator's own camera.
    exec function AltFire( optional float F )
    {
	    if(!PlayerReplicationInfo.bOnlySpectator && !PlayerReplicationInfo.bAdmin && Level.NetMode != NM_Standalone && GameReplicationInfo.bTeamGame)
        {
            if(ViewTarget == None)
                Fire();
            else
		        ToggleBehindView();
        }
	    else
	    {
        	bBehindView = false;
        	ServerViewSelf();
	    }
    }

    function Timer()
    {
    	bFrozen = false;
    }

    function BeginState()
    {
        if ( Pawn != None )
        {
            SetLocation(Pawn.Location);
            UnPossess();
        }

	    bCollideWorld = true;
	    CameraDist = Default.CameraDist;
    }

    function EndState()
    {
        PlayerReplicationInfo.bIsSpectator = false;
        bCollideWorld = false;
    }
}

state Frozen extends Spectating
{
    exec function Fire( optional float F )
    {
		Log("Fire from Frozen");
    	if ( bFrozen )
		{
			if ( (TimerRate <= 0.0) || (TimerRate > 1.0) )
				bFrozen = false;
			Log("Return from Frozen");
			return;
		}

		ServerTryThaw();
    }
	
    exec function AltFire(optional float f)
    {
		ServerViewSelf();
    }
}

//===========================================================================
// ServerTryThaw
//
// Requests that the player be thawed by the server
//===========================================================================
function  ServerTryThaw()
{
    if (PlayerReplicationInfo.bOnlySpectator)
	{
		ServerViewNextPlayer();
		return;
	}

    /*if (FrozenPawn == None)
	{
		ClientMessage("THAW DEBUG: You don't have a pawn to thaw.");
		return;
	}*/
	
	if (FrozenPawn.Health > 99)
		FrozenPawn.Thaw();

	else ServerViewNextPlayer();
}

function TakeShot()
{
    ConsoleCommand("shot Freon-"$Left(string(Level), InStr(string(Level), "."))$"-"$Level.Month$"-"$Level.Day$"-"$Level.Hour$"-"$Level.Minute);
    bShotTaken = true;
}

defaultproperties
{
     PlayerReplicationInfoClass=Class'3SPNv3141BW.Freon_PRI'
     PawnClass=Class'3SPNv3141BW.Freon_Pawn'
}

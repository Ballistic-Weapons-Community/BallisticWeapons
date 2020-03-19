class Freon extends TeamArenaMaster;

var float ThawerCampProtectionTime;
var float AutoThawTime;
var float ThawSpeed;
var bool  bTeamHeal;

var bool bSuddenDeathMode;

var config bool bOTDamageFreezes;

var array<Freon_Pawn> FrozenPawns;

static function FillPlayInfo(PlayInfo PI)
{
    Super.FillPlayInfo(PI);

    PI.AddSetting("3SPN", "bOTDamageFreezes", "Overtime Damage Freezes", 0, 110, "Check");
}

function bool PreventSever (Pawn Killed, name boneName, int Damage, class<DamageType> DamageType)
{
	return true;
}

static function string GetDescriptionText(string PropName)
{ 
    switch(PropName)
    {
        case "bOTDamageFreezes":      return "Check to make overtime damage freeze only.";
    }

    return Super.GetDescriptionText(PropName);
}

function NotifyLogin(int NewPlayerID)
{
	local int i;
	local array<PlayerController> PCArray;

	GetPlayerControllerList(PCArray);
	for ( i = 0; i < PCArray.Length; i++ )
		PCArray[i].ServerRequestBanInfo(NewPlayerID);
}

//Credits healing as damage.
function int ReduceHealing (int HealAmount, pawn HealTarget, pawn Healer)
{
    local Misc_PRI PRI;
    local int OldDamage;
    local int NewDamage;
    local float Score;

    local vector EyeHeight;

    if(LockTime > 0)
        return 0;

    if(bEndOfRound)
        return 0;
		
	if (Healer == HealTarget)
		return HealAmount;

    if((Misc_Pawn(Healer) != None || BallisticTurret(Healer) != None) && Healer.Controller != None && HealTarget.GetTeamNum() != 255 && Healer.GetTeamNum() != 255)
    {
        PRI = Misc_PRI(Healer.PlayerReplicationInfo);
        if(PRI == None)
            return HealAmount;

		if(HealTarget.GetTeamNum() == Healer.GetTeamNum())
		{
			OldDamage = PRI.EnemyDamage;
			NewDamage = OldDamage + HealAmount;
			PRI.EnemyDamage = NewDamage;

				Score = NewDamage - OldDamage;
				if(Score > 0.0)
				{
					if(Misc_Player(Healer.Controller) != None)
					{
						Misc_Player(Healer.Controller).NewEnemyDamage += Score * 0.01;
						if(Misc_Player(Healer.Controller).NewEnemyDamage >= 1.0)
						{
							ScoreEvent(PRI, int(Misc_Player(Healer.Controller).NewEnemyDamage), "EnemyDamage");
							Misc_Player(Healer.Controller).NewEnemyDamage -= int(Misc_Player(Healer.Controller).NewEnemyDamage);
						}

						EyeHeight.z = Healer.EyeHeight;
						if(FastTrace(HealTarget.Location, Healer.Location + EyeHeight))
							Misc_Player(Healer.Controller).HitDamage += Score;
					}
					PRI.Score += Score * 0.01;
					if (Healer != HealTarget)
						Healer.Controller.AwardAdrenaline((Score * 0.10) * AdrenalinePerDamage);
				}
			}
		}

	return HealAmount;

}

function InitGameReplicationInfo()
{
    Super.InitGameReplicationInfo();

    if(Freon_GRI(GameReplicationInfo) == None)
        return;

    Freon_GRI(GameReplicationInfo).AutoThawTime = AutoThawTime;
    Freon_GRI(GameReplicationInfo).ThawSpeed = ThawSpeed;
    Freon_GRI(GameReplicationInfo).bTeamHeal = bTeamHeal;
}

function StartNewRound()
{
    FrozenPawns.Remove(0, FrozenPawns.Length);

    Super.StartNewRound();
}

function ParseOptions(string Options)
{
    local string InOpt;

    Super.ParseOptions(Options);

    InOpt = ParseOption(Options, "AutoThawTime");
    if(InOpt != "")
        AutoThawTime = float(InOpt);

    InOpt = ParseOption(Options, "ThawSpeed");
    if(InOpt != "")
        ThawSpeed = float(InOpt);

    InOpt = ParseOption(Options, "TeamHeal");
    if(InOpt != "")
        bTeamHeal = bool(InOpt);
}

event InitGame(string options, out string error)
{
    Super.InitGame(Options, Error);

	AddMutator("3SPNv3141BW.Freon_Mut_ConflictLoadout", false);
    
    class'xPawn'.Default.ControllerClass = class'Freon_Bot';
}

function string SwapDefaultCombo(string ComboName)
{
    if(ComboName ~= "xGame.ComboSpeed")
        return "3SPNv3141BW.Freon_ComboSpeed";
    else if(ComboName ~= "xGame.ComboBerserk")
        return "3SPNv3141BW.Misc_ComboBerserk";

    return ComboName;
}

function PawnFroze(Freon_Pawn Frozen)
{
    local int i;

    for(i = 0; i < FrozenPawns.Length; i++)
    {
        if(FrozenPawns[i] == Frozen)
            return;
    }

    FrozenPawns[FrozenPawns.Length] = Frozen;
    Frozen.Spree = 0;

    if(Misc_Player(Frozen.Controller) != None)
        Misc_Player(Frozen.Controller).Spree = 0;
}

//
// Restart a thawing player. Same as RestartPlayer() just sans the spawn effects
//
function RestartFrozenPlayer(Controller aPlayer, vector Loc, rotator Rot, NavigationPoint Anchor)
{
    local int TeamNum;
    local class<Pawn> DefaultPlayerClass;
	local Vehicle V, Best;
	local vector ViewDir;
	local float BestDist, Dist;
    local TeamInfo BotTeam, OtherTeam;

	if ( (!bPlayersVsBots || (Level.NetMode == NM_Standalone)) && bBalanceTeams && (Bot(aPlayer) != None) && (!bCustomBots || (Level.NetMode != NM_Standalone)) )
	{
		BotTeam = aPlayer.PlayerReplicationInfo.Team;
		if ( BotTeam == Teams[0] )
			OtherTeam = Teams[1];
		else
			OtherTeam = Teams[0];

		if ( OtherTeam.Size < BotTeam.Size - 1 )
		{
			aPlayer.Destroy();
			return;
		}
	}

    if ( bMustJoinBeforeStart && (UnrealPlayer(aPlayer) != None)
        && UnrealPlayer(aPlayer).bLatecomer )
        return;

    if ( aPlayer.PlayerReplicationInfo.bOutOfLives )
        return;

    if ( aPlayer.IsA('Bot') && TooManyBots(aPlayer) )
    {
        aPlayer.Destroy();
        return;
    }

    if( bRestartLevel && Level.NetMode != NM_DedicatedServer && Level.NetMode != NM_ListenServer )
        return;

    if ( (aPlayer.PlayerReplicationInfo == None) || (aPlayer.PlayerReplicationInfo.Team == None) )
        TeamNum = 255;
    else
        TeamNum = aPlayer.PlayerReplicationInfo.Team.TeamIndex;

    if (aPlayer.PreviousPawnClass!=None && aPlayer.PawnClass != aPlayer.PreviousPawnClass)
        BaseMutator.PlayerChangedClass(aPlayer);

    if ( aPlayer.PawnClass != None )
        aPlayer.Pawn = Spawn(aPlayer.PawnClass,,, Loc, Rot);

    if( aPlayer.Pawn==None )
    {
        DefaultPlayerClass = GetDefaultPlayerClass(aPlayer);
        aPlayer.Pawn = Spawn(DefaultPlayerClass,,, Loc, Rot);
    }
    if ( aPlayer.Pawn == None )
    {
        log("Couldn't spawn player of type "$aPlayer.PawnClass$" at "$Location);
        aPlayer.GotoState('Dead');
        if ( PlayerController(aPlayer) != None )
			PlayerController(aPlayer).ClientGotoState('Dead','Begin');
        return;
    }
    if ( PlayerController(aPlayer) != None )
		PlayerController(aPlayer).TimeMargin = -0.1;
    if(Anchor != None)
        aPlayer.Pawn.Anchor = Anchor;
	aPlayer.Pawn.LastStartTime = Level.TimeSeconds;
    aPlayer.PreviousPawnClass = aPlayer.Pawn.Class;

    aPlayer.Possess(aPlayer.Pawn);
    aPlayer.PawnClass = aPlayer.Pawn.Class;

    //aPlayer.Pawn.PlayTeleportEffect(true, true);
    aPlayer.ClientSetRotation(aPlayer.Pawn.Rotation);
    AddDefaultInventory(aPlayer.Pawn);

    if ( bAllowVehicles && (Level.NetMode == NM_Standalone) && (PlayerController(aPlayer) != None) )
    {
		// tell bots not to get into nearby vehicles for a little while
		BestDist = 2000;
		ViewDir = vector(aPlayer.Pawn.Rotation);
		for ( V=VehicleList; V!=None; V=V.NextVehicle )
			if ( V.bTeamLocked && (aPlayer.GetTeamNum() == V.Team) )
			{
				Dist = VSize(V.Location - aPlayer.Pawn.Location);
				if ( (ViewDir Dot (V.Location - aPlayer.Pawn.Location)) < 0 )
					Dist *= 2;
				if ( Dist < BestDist )
				{
					Best = V;
					BestDist = Dist;
				}
			}

		if ( Best != None )
			Best.PlayerStartTime = Level.TimeSeconds + 8;
	}
}

/* Discard a player's inventory after he dies.
Freon specific: Purge non-Weapon related inventory items and pass the rest to the controller to save.
*/
function DiscardInventory( Pawn Other )
{
	Other.Weapon.DetachFromPawn(Other);
    Other.Weapon = None;
    Other.SelectedItem = None;
	
	if (Freon_Player(Other.Controller) != None && (!bEndOfRound && Team_GameBase(Level.Game).LockTime == 0))
	{
		while ( Other.Inventory != None )
		{
			if (BallisticWeapon(Other.Inventory) != None && !BallisticWeapon(Other.Inventory).bWT_Super)
				Freon_Player(Other.Controller).AddAmmoTrack(BallisticWeapon(Other.Inventory));
			else if (BCGhostWeapon(Other.Inventory) != None)
				Freon_Player(Other.Controller).TrackGhost(BCGhostWeapon(Other.Inventory).MyWeaponClass);

			Other.Inventory.Destroy();
		}
	}
	
	else while (Other.Inventory != None)
		Other.Inventory.Destroy();
}

// if in health is 0, find the 'ambient' temperature of the map (the average of all player's health)
function PlayerThawed(Freon_Pawn Thawed, optional float Health, optional float Shield)
{
    local vector Pos;
    local vector Vel;
    local rotator Rot;
    local Controller C;
    local int i;
    local NavigationPoint N;
    local Controller LastHitBy;
    local int Team;

    if(bEndOfRound)
        return;

    Pos = Thawed.Location;
    Rot = Thawed.Rotation;
    Vel = Thawed.Velocity;
    C = Thawed.Controller;
    N = Thawed.Anchor;
    LastHitBy = Thawed.LastHitBy;

    if(C.PlayerReplicationInfo == None)
        return;

    for(i = 0; i < FrozenPawns.Length; i++)
    {
        if(FrozenPawns[i] == Thawed)
            FrozenPawns.Remove(i, 1);
    }

    Thawed.Destroy();

    C.PlayerReplicationInfo.bOutOfLives = false;
    C.PlayerReplicationInfo.NumLives = 1;

    if(PlayerController(C) != None)
        PlayerController(C).ClientReset();
    RestartFrozenPlayer(C, Pos, Rot, N);
	
    if(C.Pawn != None)
    {
        C.Pawn.SetLocation(Pos);
        C.Pawn.SetRotation(Rot);
        C.Pawn.AddVelocity(Vel);
        C.Pawn.LastHitBy = LastHitBy;
    }
    
    if(PlayerController(C) != None)
        PlayerController(C).ClientSetRotation(Rot);

    Team = C.GetTeamNum();
    if(Team == 255)
        return;

    if(TAM_TeamInfo(Teams[Team]) != None && TAM_TeamInfo(Teams[Team]).ComboManager != None)
        TAM_TeamInfo(Teams[Team]).ComboManager.PlayerSpawned(C);
    else if(TAM_TeamInfoRed(Teams[Team]) != None && TAM_TeamInfoRed(Teams[Team]).ComboManager != None)
        TAM_TeamInfoRed(Teams[Team]).ComboManager.PlayerSpawned(C);
    else if(TAM_TeamInfoBlue(Teams[Team]) != None && TAM_TeamInfoBlue(Teams[Team]).ComboManager != None)
        TAM_TeamInfoBlue(Teams[Team]).ComboManager.PlayerSpawned(C);

    BroadcastLocalizedMessage(class'Freon_ThawMessage', 255, C.Pawn.PlayerReplicationInfo);
}

function PlayerThawedByTouch(Freon_Pawn Thawed, array<Freon_Pawn> Thawers, bool thawInstant, optional float Health, optional float Shield)
{
    local Controller C;
    local int i;

    if(bEndOfRound)
        return;

    C = Thawed.Controller;
	
	if (thawInstant || !C.IsInState('Frozen'))
		PlayerThawed(Thawed, Health, Shield);

    if(PlayerController(C) != None)
	{
		PlayerController(C).ServerViewSelf();
        PlayerController(C).ReceiveLocalizedMessage(class'Freon_ThawMessage', 0, Thawers[0].PlayerReplicationInfo);
	}

    if(C.PlayerReplicationInfo == None)
        return;

    for(i = 0; i < Thawers.Length; i++)
    {
        if(Thawers[i].PlayerReplicationInfo != None)
            Thawers[i].PlayerReplicationInfo.Score += 0.5;

        if(Thawers[i].Controller != None)
            Thawers[i].Controller.AwardAdrenaline(5.0);

        if(Thawers[i].MyTrigger != None)
        	Thawers[i].MyTrigger.SendThawedMessage(C);
    }
}

function bool CanSpectate(PlayerController Viewer, bool bOnlySpectator, actor ViewTarget)
{
    if(xPawn(ViewTarget) == None && (Controller(ViewTarget) == None || xPawn(Controller(ViewTarget).Pawn) == None))
        return false;

    if(bOnlySpectator)
    {
        if(Controller(ViewTarget) != None)
            return (Controller(ViewTarget).PlayerReplicationInfo != None && ViewTarget != Viewer);
        else
            return (xPawn(ViewTarget).IsPlayerPawn());
    }

    if(bRespawning || (NextRoundTime <= 1 && bEndOfRound))
        return false;

    if(Controller(ViewTarget) != None)
        return (Controller(ViewTarget).PlayerReplicationInfo != None && ViewTarget != Viewer &&
                (bEndOfRound || (Controller(ViewTarget).GetTeamNum() == Viewer.GetTeamNum()) && Viewer.GetTeamNum() != 255));
    else
    {
        return (xPawn(ViewTarget).IsPlayerPawn() && xPawn(ViewTarget).PlayerReplicationInfo != None &&
                (bEndOfRound || (xPawn(ViewTarget).GetTeamNum() == Viewer.GetTeamNum()) && Viewer.GetTeamNum() != 255));
    }
}

function bool DestroyActor(Actor A)
{
    if(Freon_Pawn(A) != None && Freon_Pawn(A).bFrozen)
        return true;

    return Super.DestroyActor(A);
}

function EndRound(PlayerReplicationInfo Scorer)
{
    local Freon_Trigger FT;
	local Controller C;

    foreach DynamicActors(class'Freon_Trigger', FT)
        FT.Destroy();
		
	for (C=Level.ControllerList; C != None; C = C.NextController)
	{
		if (Freon_Player(C) != None)
			Freon_Player(C).AmmoTracking.Remove(0, Freon_Player(C).AmmoTracking.Length);		
	}
	
	bSuddenDeathMode = False;
	
    Super.EndRound(Scorer);
}

function UpdateLocationHistory(Controller C, Misc_PRI P)
{
	if (Freon_PRI(P) != None && Level.TimeSeconds - Freon_PRI(P).LastThawTime < ThawerCampProtectionTime)
		return;
	
	P.LocationHistory[P.NextLocHistSlot] = C.Pawn.Location;
	P.NextLocHistSlot++;
	
	if(P.NextLocHistSlot == 10)
	{
		P.NextLocHistSlot = 0;
		P.bWarmedUp = true;
	}
}

function int CheckOTDamage(Controller c)
{
	if (Freon_PRI(C.PlayerReplicationInfo) != None && Level.TimeSeconds - Freon_PRI(C.PlayerReplicationInfo).LastThawTime < ThawerCampProtectionTime)
		return 0;
	
	return OTDamage;
}

defaultproperties
{
     ThawerCampProtectionTime=2.000000
     AutoThawTime=90.000000
     ThawSpeed=5.000000
     bTeamHeal=True
     bDisableTeamCombos=False
     TeamAIType(0)=Class'3SPNv3141BW.Freon_TeamAI'
     TeamAIType(1)=Class'3SPNv3141BW.Freon_TeamAI'
     bAllowVehicles=True
     DefaultPlayerClassName="3SPNv3141BW.Freon_Pawn"
     ScoreBoardType="3SPNv3141BW.Freon_Scoreboard"
     HUDType="3SPNv3141BW.Freon_HUD"
     GoalScore=6
     PlayerControllerClassName="3SPNv3141BW.Freon_Player"
     GameReplicationInfoClass=Class'3SPNv3141BW.Freon_GRI'
     GameName="BallisticPro: Freon"
     Description="Freeze the other team, score a point. Chill well and serve."
     Acronym="Freon"
}

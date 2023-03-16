//=============================================================================
// Mut_BloodyHell.
//
// Spawn a blood control to give fancy gore effects to dead players.
// Gore related config settings are also stored here.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Mut_BloodyHell extends Mutator;

function ModifyPlayer(Pawn Other)
{
	Super.ModifyPlayer(Other);
	if (xPawn(Other) != none && BallisticBHPawn(Other)==None)
	{
		xPawn(Other).RagdollLifeSpan = 20;
		xPawn(Other).DeResTime = 3;
		KarmaParamsSkel(xPawn(Other).KParams).KVelDropBelowThreshold = -1;
	}
}

function PostBeginPlay()
{
	local GameRules G;

	Super.PostBeginPlay();

	G = spawn(class'Rules_BloodyHell');
	if ( Level.Game.GameRulesModifiers == None )
		Level.Game.GameRulesModifiers = G;
	else
		Level.Game.GameRulesModifiers.AddGameRules(G);
}

simulated function PreBeginPlay()
{
	if (level.Game != None)
	{
		if (level.Game.DefaultPlayerClassName ~= "XGame.xPawn" || class'Mut_Ballistic'.default.bForceBallisticPawn)
			level.Game.DefaultPlayerClassName = "BallisticProV55.BallisticBHPawn";
	}
	super.PreBeginPlay();
}

function PlayerChangedClass(Controller C)
{
	super.PlayerChangedClass (C);
	if (Bot(C) != None && (C.PawnClass	== None || C.PawnClass == class'xPawn') )
		Bot(C).PawnClass = class'BallisticBHPawn';
}

// Check for item replacement.
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	if (PlayerController(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn'))
		PlayerController(Other).PawnClass = class'BallisticBHPawn';
	else if (Bot(Other) != None && (Controller(Other).PawnClass == None || Controller(Other).PawnClass == class'xPawn'))
		Bot(Other).PreviousPawnClass = class'BallisticBHPawn';

	return super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
     ConfigMenuClassName="BallisticProV55.ConfigMenu_Preferences"
     GroupName="Blood"
     FriendlyName="BallisticPro: Bloody Hell"
     Description="Adds horrific blood effects for dead bodies, including: blood trails, corpse impact marks, blood pools and under water blood. The pinnacle of horrendousness...||http://www.runestorm.com"
}

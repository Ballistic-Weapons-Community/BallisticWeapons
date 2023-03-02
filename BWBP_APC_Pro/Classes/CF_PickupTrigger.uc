//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class CF_PickupTrigger extends Triggers;

var BallisticWeaponPickup bwPickUp; // The reference to the pickup
var CFPickupWidget widget;
var bool bInit;
var int magAmmo;

var string PickUpMessage;

var float RefireDelay;
var bool RefireEvent;

replication
{
	reliable if(Role==ROLE_Authority)
		bwPickUp, widget;
}

function UsedBy( Pawn user )
{
	if(bwPickUp != none)
		bwPickUp.Touch(user);

//	If(BallisticPawn(user) != none)
//		BallisticPawn(user).StartPickupAnimation();
}

simulated function PostNetBeginPlay()
{
	if (!bInit)
	{
	  	InitTrigger();
	}
	Super.PostNetBeginPlay();
}

simulated function InitTrigger()
{
	local PlayerController pc;
	local Color clrBlue;
	local string clrB, clrW;

	if(bwPickUp != none)
	{
		pc = Level.GetLocalPlayerController();

		if(Level.NetMode != NM_DedicatedServer && pc != none)
		{
			SetTimer(0.5, false);
			RefireEvent = false;

			clrBlue = Class'Canvas'.static.MakeColor(255,255,0,255);
			clrB = Class'GUIComponent'.static.MakeColorCode(clrBlue);
			clrW = Class'GUIComponent'.static.MakeColorCode(pc.myHUD.ConsoleColor);
			PickUpMessage=clrW$"Press %USE% to pick up the "$clrB$bwPickUp.InventoryType.default.ItemName;
			PickUpMessage = class'GameInfo'.static.ParseLoadingHint(PickUpMessage, pc, pc.myHUD.ConsoleColor);
		}
		bInit=true;
	}
}

simulated event Touch(Actor Other)
{
	if ( Pawn(Other) != None )
	{
		// Send a string message to the toucher.
	    if( PickUpMessage != "" && RefireEvent)
	    {
		    Pawn(Other).ClientMessage( PickUpMessage );
		    RefireEvent=false;
		    SetTimer(RefireDelay, false);
		}

		if ( AIController(Pawn(Other).Controller) != None )
			UsedBy(Pawn(Other));

	}
}

simulated event BaseChange()
{
	if(Base != bwPickUp)
	{
		if(widget != none)
			widget.Destroy();
		Destroy();
	}

	Super.BaseChange();
}

simulated function Timer()
{
	RefireEvent=true;
}

defaultproperties
{
     RefireDelay=3.000000
     RefireEvent=True
     RemoteRole=ROLE_SimulatedProxy
     bNetNotify=True
}

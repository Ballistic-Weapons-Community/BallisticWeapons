//=============================================================================
// By Paul "Grum" Haack.
// Copyright(c) 2013 Crazy-Froggers.com. All Rights Reserved.
//=============================================================================
class BallisticPickupTrigger extends Triggers;

var BallisticWeaponPickup bwPickUp; // The reference to the pickup
var bool bInit;

var string PickUpMessage;

var float RefireDelay;
var bool RefireEvent;
var PlayerController pc;

replication
{
    reliable if(Role==ROLE_Authority)
        bwPickUp;
}

function UsedBy( Pawn user )
{
    if(bwPickUp != none)
        bwPickUp.Touch(user);
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
    if(bwPickUp != none)
        bInit=true;
}

simulated event Tick(float dt)
{
    local Color clrBlue;
    local string clrB, clrW;

    if(Level.NetMode != NM_DedicatedServer && bInit && pc == none)
    {
        pc = Level.GetLocalPlayerController();
        if(pc != none)
        {
            clrBlue = Class'Canvas'.static.MakeColor(255,255,0,255);
            clrB = Class'GUIComponent'.static.MakeColorCode(clrBlue);
            clrW = Class'GUIComponent'.static.MakeColorCode(pc.myHUD.ConsoleColor);
            PickUpMessage=clrW$"Press %USE% to pick up the "$clrB$bwPickUp.InventoryType.default.ItemName;
            PickUpMessage = class'GameInfo'.static.ParseLoadingHint(PickUpMessage, pc, pc.myHUD.ConsoleColor);
        }
    }
}

simulated event Touch(Actor Other)
{
    if ( Pawn(Other) != None )
    {
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

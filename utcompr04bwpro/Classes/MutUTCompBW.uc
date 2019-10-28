class MutUTCompBW extends MutUTComp;

function DriverEnteredVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	if (V != None && V.Controller != None && V.Controller.PlayerReplicationInfo != None)
	{
		if (BallisticTurret(V) == None)
		{
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(V.Controller.PlayerReplicationInfo);
			if (uPRI != None)
				uPRI.InAVehicle = true;
		}
	}
	
	if( NextMutator != None )
		NextMutator.DriverEnteredVehicle(V, P);
}

function DriverLeftVehicle(Vehicle V, Pawn P)
{
	local UTComp_PRI uPRI;
	
	if (P != None && P.Controller != None && P.Controller.PlayerReplicationInfo != None)
	{
		if (BallisticTurret(V) == None)
		{	
			uPRI = class'UTComp_Util'.static.GetUTCompPRI(P.Controller.PlayerReplicationInfo);
			if (uPRI != None)
			{
				uPRI.InAVehicle = false;
				uPRI.VehicleExitTime = Level.TimeSeconds;
			}
		}
	}
	
	if( NextMutator != None )
		NextMutator.DriverLeftVehicle(V, P);
}

defaultproperties
{
     MyVersionSuffix="BW"
     PlayerControllerType=Class'utcompr04bwpro.UTComp_xPlayer_BW'
     PawnType=Class'utcompr04bwpro.UTComp_BallisticPawn'
     OverlayType=Class'utcompr04bwpro.UTComp_OverlayB_BW'
     OverlayUpdateType=Class'utcompr04bwpro.UTComp_OverlayUpdate_BW'
     PRIType=Class'utcompr04bwpro.UTComp_PRI_BW'
     GameRulesType=Class'utcompr04bwpro.UTComp_GameRules_BW'
     DeathMsgType(0)=(NewClass=Class'utcompr04bwpro.UTComp_xDeathMessageBW')
     FriendlyName="UTComp Version R04 for BW"
     Description="A mutator for warmup, brightskins, hitsounds, and various other features - with enhancements for Ballistic Weapons."
}

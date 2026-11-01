class Freon_Bot extends Misc_Bot;

var Freon_Pawn FrozenPawn;

function Reset()
{
    Super.Reset();
    FrozenPawn = None;
}

function SetPawnClass(string inClass, string inCharacter)
{
	local class<Freon_Pawn> pClass;

	if(inClass != "")
	{
		pClass = class<Freon_Pawn>(DynamicLoadObject(inClass, class'Class'));
		if(pClass != None)
			PawnClass = pClass;
	}

	PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
	PlayerReplicationInfo.SetCharacterName(inCharacter);
}

function Freeze()
{
    if(Pawn == None)
        return;

    SetLocation(Pawn.Location);
    
    FrozenPawn = Freon_Pawn(Pawn);
    Pawn = None;
    PendingMover = None;

    if(!IsInState('GameEnded') && !IsInState('RoundEnded'))
        GotoState('Frozen');
}

state Dead
{
    function PawnDied(Pawn P) {}
}

state Frozen extends Dead
{
    ignores KilledBy;

    function Actor FaceActor(float StrafingModifier) {return None;}
    function ReceiveProjectileWarning(Projectile P) {}
    function PawnDied(Pawn P) {}
    function bool AdjustAround(Pawn P) {return false;}
    function ServerRestartPlayer() {}
    function ChangedWeapon() {}
    function bool NotifyLanded(vector HitNormal) {return false;}
}

defaultproperties
{
     PlayerReplicationInfoClass=Class'3SPNv3141BW.Freon_PRI'
}

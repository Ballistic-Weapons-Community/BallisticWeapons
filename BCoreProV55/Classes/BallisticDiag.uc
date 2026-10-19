//=============================================================================
// BallisticDiag - DIAGNOSTIC BUILD ONLY, not for merging.
//
// What every BWDBG| log line starts with: the topic, the wall clock (to line
// the logs up with a recording, and with each other when server and client run
// on one PC), which machine wrote it and its game time.
//=============================================================================
class BallisticDiag extends Object;

// Milliseconds of the day on this machine's clock
static final function int WallMs(LevelInfo L)
{
	return ((L.Hour * 60 + L.Minute) * 60 + L.Second) * 1000 + L.Millisecond;
}

// Milliseconds from Earlier to now, across midnight too
static final function int MsSince(LevelInfo L, int Earlier)
{
	local int Ms;

	Ms = WallMs(L) - Earlier;
	if (Ms < 0)
		Ms += 86400000;
	return Ms;
}

static final function string TwoDigits(int N)
{
	if (N < 10)
		return "0" $ N;
	return string(N);
}

static final function string Stamp(LevelInfo L)
{
	local string Ms;

	Ms = string(L.Millisecond);
	while (Len(Ms) < 3)
		Ms = "0" $ Ms;
	return TwoDigits(L.Hour) $ ":" $ TwoDigits(L.Minute) $ ":" $ TwoDigits(L.Second) $ "." $ Ms;
}

static final function string Side(LevelInfo L)
{
	switch (L.NetMode)
	{
		case NM_DedicatedServer:	return "server";
		case NM_ListenServer:		return "host";
		case NM_Client:				return "client";
	}
	return "offline";
}

static final function string Head(LevelInfo L, string Topic)
{
	return "BWDBG|" $ Topic $ "|" $ Stamp(L) $ "|" $ Side(L) $ "|" $ L.TimeSeconds $ "|";
}

static final function string Who(Pawn P)
{
	if (P == None)
		return "no pawn";
	if (P.PlayerReplicationInfo != None)
		return P.PlayerReplicationInfo.PlayerName;
	return string(P.Name);
}

// Whether this machine logs what this pawn's weapons do: a server or host for every human player, a client for its own
static final function bool Logs(Pawn P)
{
	if (P == None)
		return false;
	if (P.Level.NetMode == NM_Client)
		return P.IsLocallyControlled();
	return PlayerController(P.Controller) != None;
}

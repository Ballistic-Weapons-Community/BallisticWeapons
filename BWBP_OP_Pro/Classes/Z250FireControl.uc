class Z250FireControl extends RX22AFireControl;

function MakeNewFire (vector Loc, vector Norm, Pawn InstigatedBy, actor HitActor)
{
	GasNodes[GasNodes.length] = Spawn(class'Z250SurfaceFire',InstigatedBy,,Loc, rotator(Norm));
	GroundFires[GroundFires.length] = RX22ASurfaceFire(GasNodes[GasNodes.length-1]);
	
	if (RX22ASurfaceFire(GasNodes[GasNodes.length-1]) != None)
	{
		RX22ASurfaceFire(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22ASurfaceFire(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}
function MakeNewPool (vector Loc, vector Norm, Pawn InstigatedBy, Actor HitActor)
{
	GasNodes[GasNodes.length] = Spawn(class'Z250GasPatch',InstigatedBy,,Loc, rotator(Norm));
	if (GasNodes[GasNodes.length-1] != None && RX22AGasPatch(GasNodes[GasNodes.length-1]) != None)
	{
		RX22AGasPatch(GasNodes[GasNodes.length-1]).GasControl = self;
		if (HitActor != None)
			RX22AGasPatch(GasNodes[GasNodes.length-1]).SetBase(HitActor);
	}
}
function MakeNewCloud (vector Loc, Pawn InstigatedBy)
{
	GasNodes[GasNodes.length] = Spawn(class'Z250GasCloud',InstigatedBy,,Loc);
	RX22AGasCloud(GasNodes[GasNodes.length-1]).GasControl = self;
}
function MakeNewSoaker (Actor Other, Pawn InstigatedBy)
{
	GasNodes[GasNodes.length] = Spawn(class'Z250GasSoak',InstigatedBy,,Other.Location, Other.Rotation);
	RX22AGasSoak(GasNodes[GasNodes.length-1]).GasControl = self;
	RX22AGasSoak(GasNodes[GasNodes.length-1]).SetBase(Other);
}
function MakeNewBurner (Actor Other, int Fuel, Pawn InstigatedBy)
{
	local RX22AActorFire PF;

	PF = Spawn(class'Z250ActorFire',InstigatedBy,,Other.Location, Other.Rotation);
	PF.SetFuel(Fuel);
	PF.Initialize(Other);

	GasNodes[GasNodes.length] = PF;
	PF.GasControl = self;
}

defaultproperties
{
}

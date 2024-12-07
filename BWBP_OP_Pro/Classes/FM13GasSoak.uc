class FM13GasSoak extends RX22AGasSoak
	placeable;

function Ignite(Pawn EventInstigator)
{
	local RX22AActorFire PF;

	PF = Spawn(class'FM13ActorFire',Instigator,,Location, Rotation);
	PF.SetFuel(Fuel);
	PF.Ignitioneer = EventInstigator;
	PF.Initialize(Base);
	GasControl.PatchReplace(self, PF);
	PF.GasControl = GasControl;

	Destroy();
}

defaultproperties
{
}

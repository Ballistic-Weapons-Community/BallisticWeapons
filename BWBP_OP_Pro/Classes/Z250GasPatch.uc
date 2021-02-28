class Z250GasPatch extends RX22AGasPatch
	placeable;

simulated function Ignite(Pawn EventInstigator)
{
	local Z250SurfaceFire Temp;

	if(Role != ROLE_Authority)
		return;

	bIgnited = true;
	bPendingIgnite = false;

	Temp = Spawn(class'Z250SurfaceFire',Instigator,,Location+vector(Rotation)*32, Rotation);
	if (InstigatorController == None && Instigator != None)
		Temp.InstigatorController = Instigator.Controller;
	else
		Temp.InstigatorController = InstigatorController;
	Temp.Ignitioneer = Ignitioneer;
	Temp.PlayIgnite();
	Temp.SetFuel(Fuel);
	Temp.GasControl = GasControl;
	Temp.SetBase(Base);

	GasControl.PatchReplace(self, Temp);

	Destroy();
}

defaultproperties
{
}

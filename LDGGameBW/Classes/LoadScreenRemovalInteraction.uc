//Resets the DrawOp values for UT2k4ServerLoading upon level change.
class LoadScreenRemovalInteraction extends Interaction;

var DrawOpImage OpLoading;

event NotifyLevelChange()
{
	OpLoading.SubYL = 768;
	OpLoading.SubXL = 1024;
	
	Master.RemoveInteraction(self);
}

defaultproperties
{
}

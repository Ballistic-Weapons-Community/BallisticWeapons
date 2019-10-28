//=============================================================================
// DollActor.
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class DollActor extends Actor
	placeable;

var() name		StartSequence;
var() float		StartFrame;
var() name		DollBone;
var() name		DollName;

simulated event PostBeginPlay()
{
	local Actor A;

	if (StartSequence != '')
		PlayAnim(StartSequence);

	FreezeAnimAt(StartFrame);

	if (DollName != '')
	{
		ForEach DynamicActors( class 'Actor', A, DollName )
			AttachToBone(A, DollBone);
	}
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'Jugg.JuggMaleA'
}

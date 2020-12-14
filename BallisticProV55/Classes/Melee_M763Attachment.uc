//=============================================================================
// Melee_M763Attachment.
// 
// _TPm person weapon attachment for M763 Shotgun
// 
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class Melee_M763Attachment extends M763Attachment;

simulated function InstantFireEffects(byte Mode)
{
	MeleeFireEffects();
}

defaultproperties
{
     BrassMode=MU_None
     FlashMode=MU_None
     LightMode=MU_None
}

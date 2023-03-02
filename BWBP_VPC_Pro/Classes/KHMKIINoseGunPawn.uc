//=============================================================================
// KH MarkII Nose Gun. Gun mounted just under the nose of the chopper
// used mainly for anti infantry purposes. The Pawn Version.

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class KHMKIINoseGunPawn extends ONSTankSecondaryTurretPawn
	placeable;

function KDriverEnter(Pawn P)
{
	super.KDriverEnter(P);
	if (!VehicleBase.bDriving)
		VehicleBase.bDriving = true;
}

event bool KDriverLeave( bool bForceLeave )
{
	local bool b;
	b  = super.KDriverLeave(bForceLeave);
	if (b && VehicleBase.IsVehicleEmpty() )
		VehicleBase.bDriving = false;

	return b;

}

// This mysterious little baby makes the KHMKII Hover while using the MG.
simulated function AttachDriver(Pawn P)
{
    if (Gun == None)
    	return;

	KHMKII(VehicleBase).OutputThrust = 0;
	KHMKII(VehicleBase).OutputStrafe = 0;
	KHMKII(VehicleBase).OutputRise = 0;
	P.SetLocation(VehicleBase.Location);
	P.SetBase(VehicleBase);
    P.SetPhysics(PHYS_None);
    P.SetPhysics(PHYS_None);
}

defaultproperties
{
     GunClass=Class'BWBP_VPC_Pro.KHMKIINoseGun'
     CameraBone="KHMKIIGunHousing"
     bDesiredBehindView=False
     ExitPositions(0)=(X=256.000000,Y=-224.000000,Z=64.000000)
     ExitPositions(1)=(X=256.000000,Y=222.000000,Z=64.000000)
     EntryRadius=96.000000
     FPCamPos=(Z=-76.000000)
     FPCamViewOffset=(X=0.000000,Z=0.000000)
     TPCamDistance=0.000000
     TPCamLookat=(X=0.000000,Z=-76.000000)
     TPCamWorldOffset=(Z=0.000000)
     TPCamDistRange=(Min=0.000000,Max=0.000000)
     VehiclePositionString="Manning a KH AutoCannon"
     VehicleNameString="KH MarkII AutoCannon"
}

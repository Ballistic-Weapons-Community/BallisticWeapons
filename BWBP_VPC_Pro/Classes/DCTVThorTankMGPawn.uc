//-----------------------------------------------------------
//
//-----------------------------------------------------------
class DCTVThorTankMGPawn extends ONSTankSecondaryTurretPawn;

function AttachToVehicle(ONSVehicle VehiclePawn, name WeaponBone)
{
    if (Level.NetMode != NM_Client)
    {
        VehicleBase = VehiclePawn;
    	if (VehiclePawn.Weapons.length > 0 && VehiclePawn.Weapons[0] != None)
    		VehiclePawn.Weapons[0].AttachToBone(Gun, 'MGWeapon');
    	else
        	VehicleBase.AttachToBone(Gun, WeaponBone);
    }
}

simulated function vector GetCameraLocationStart()
{
	if (Gun != None)
		return Gun.GetBoneCoords(CameraBone).Origin;
	else
		return Super.GetCameraLocationStart();
}

defaultproperties
{
     GunClass=Class'BWBP_VPC_Pro.DCTVThorTankMG'
     CameraBone="MG"
     FPCamPos=(X=-35.000000,Z=5.000000)
     TPCamWorldOffset=(Z=50.000000)
     VehiclePositionString="operating a Thor Machinegun"
     VehicleNameString="Thor Machinegun Turret"
}

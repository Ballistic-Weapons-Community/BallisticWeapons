//=============================================================================
// The Pawn Version of the .50 Calibre machinegun for the TMV Leopard

// by Logan "BlackEagle" Richert.
// Copyright(c) 2008. All Rights Reserved.
//=============================================================================
class LeopardMGPawn extends ONSWeaponPawn
	placeable;

var(Bones) 		name	AttachmentBoneName;

function ShouldTargetMissile(Projectile P)
{
	if ( Bot(Controller) != None && Bot(Controller).Skill >= 5.0 )
	{
		if ( (Controller.Enemy != None) && Bot(Controller).EnemyVisible() && (Bot(Controller).Skill < 5) )
			return;
		ShootMissile(P);
	}
}
// This cool function links the MG to the Main Gun and thus makes it's aiming depend on the Main Gun's.
function AttachToVehicle(ONSVehicle VehiclePawn, name WeaponBone)
{
    if (Level.NetMode != NM_Client)
    {
        VehicleBase = VehiclePawn;
    	if (VehiclePawn.Weapons.length > 0 && VehiclePawn.Weapons[0] != None)
    		VehiclePawn.Weapons[0].AttachToBone(Gun, AttachmentBoneName);
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
     AttachmentBoneName="MGAttachBone"
     GunClass=Class'BWBP_VPC_Pro.LeopardMG'
     bHasAltFire=False
     CameraBone="MGAttachBone"
     bDrawDriverInTP=False
     bDesiredBehindView=False
     DrivePos=(X=-8.000000)
     DriveAnim="Idle_Rest"
     ExitPositions(0)=(Y=-200.000000,Z=100.000000)
     ExitPositions(1)=(Y=200.000000,Z=100.000000)
     EntryRadius=130.000000
     FPCamViewOffset=(X=-8.000000,Y=-5.000000,Z=40.000000)
     TPCamDistance=450.000000
     TPCamLookat=(X=0.000000,Z=0.000000)
     TPCamWorldOffset=(Z=96.000000)
     TPCamDistRange=(Min=128.000000,Max=450.000000)
     DriverDamageMult=0.000000
     VehiclePositionString="Manning a TM V .50"
     VehicleNameString="Leopard TM V .50 Cal"
}

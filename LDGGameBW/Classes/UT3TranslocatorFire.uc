/******************************************************************************
UT3TranslocatorFire

Creation date: 2008-07-14 12:18
Last change: $Id$
Copyright (c) 2008, Wormbo
******************************************************************************/

class UT3TranslocatorFire extends TransFire;


//=============================================================================
// Imports
//=============================================================================

#exec obj load file=WeaponSounds.uax


//=============================================================================
// Properties
//=============================================================================

var array<class<TransBeacon> > TeamProjectileClasses;
var Sound RecallFailedSound;
var name RecallAnim, RecallDownAnim, RecallRightAnim, RecallLeftAnim;
const CIRCLE=65536;

simulated function PlayFiring()
{
    local vector ModulePoint, X,Y,Z, StartPoint; //GE: Vect Player -> Module
    local rotator ModuleRotate;
    
    //GE: Here's a funny fact: by the time the code gets here, the beacon is already spawned/destroyed
    //unlike usually, when it gets spawned/destroyed afterwards, so the ifs here are inverted!
    if (TransLauncher(Weapon).TransBeacon != None)
    {
        Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
        ClientPlayForceFeedback( TransFireForce );  // jdf
    }
    else if (UT3Translocator(Weapon) != None)
    {
        /*
         * GE: This is the theory behind this:
         * We find the way the player is facing, we find the vector between the
         * player and the module, we convert it to a rotator, we repeat on other axes.                 
         */
        
        StartPoint = GetFireStart(X,Y,Z);
        /*
         *GE: ModulePoint:
         *        |0   
         * 16000 -P- -16000
         *        |32000            
         */         
        
        ModulePoint = UT3Translocator(Weapon).ModuleLocation - Instigator.Location;
        ModuleRotate = Instigator.Controller.GetViewRotation() - rotator(ModulePoint); //GE: there is no Roll info, we don't need it as well - the screen doesn't roll
        TrimToSingleCircle(ModuleRotate);
        //GE: The most else is default, so if it's far to the sides (>45 degrees on each)
        //Instigator.ClientMessage("UT3TranslocatorFire: ViewRotation is"@RotatorToString(Instigator.Controller.GetViewRotation())@"So ModuleRotate is"@RotatorToString(ModuleRotate));
        //GE: Pitch > 0 - lower, pitch < 0 - higher than player's view;
        //GE: Yaw > 0 - left, yaw < 0 - right than player's view.
        if (ModuleRotate.Yaw > 5000)
            Weapon.PlayAnim(RecallLeftAnim, FireAnimRate, TweenTime);
        else if (ModuleRotate.Yaw < -5000)
            Weapon.PlayAnim(RecallRightAnim, FireAnimRate, TweenTime);
        else if (ModuleRotate.Pitch > 0)
            Weapon.PlayAnim(RecallDownAnim, FireAnimRate, TweenTime);
        else
            Weapon.PlayAnim(RecallAnim, FireAnimRate, TweenTime);
    }
}

static final function TrimToSingleCircle(out rotator Rot)
{
    Rot.Yaw = Rot.Yaw & 65535; // clamp the difference to only positive values
    if ( Rot.Yaw > 32768 ) Rot.Yaw -= 65536;// now adjust it direction
    Rot.Pitch = Rot.Pitch & 65535; // clamp the difference to only positive values
    if ( Rot.Pitch > 32768 ) Rot.Pitch -= 65536;// now adjust it direction
    Rot.Roll = Rot.Roll & 65535; // clamp the difference to only positive values
    if ( Rot.Roll > 32768 ) Rot.Roll -= 65536;// now adjust it direction
}

static final function string RotatorToString(rotator rot)
{
  return "(" $ rot.Pitch $ "," $ rot.Yaw $ "," $ rot.Roll $ ")";
}

function projectile SpawnProjectile(Vector Start, Rotator Dir)
{
	local TransBeacon TransBeacon;
	
	if (TransLauncher(Weapon).TransBeacon == None) {
		if (Instigator != None && Instigator.PlayerReplicationInfo != None && Instigator.PlayerReplicationInfo.Team != None && Instigator.PlayerReplicationInfo.Team.TeamIndex < TeamProjectileClasses.Length)
			TransBeacon = Weapon.Spawn(TeamProjectileClasses[Instigator.PlayerReplicationInfo.Team.TeamIndex],,, Start, Dir);
		else
			TransBeacon = TransBeacon(Weapon.Spawn(ProjectileClass,,, Start, Dir));
		TransLauncher(Weapon).TransBeacon = TransBeacon;
		Weapon.PlaySound(TransFireSound, SLOT_Interact,,,,, false);
	} else {
		TransLauncher(Weapon).ViewPlayer();
		if (TransLauncher(Weapon).TransBeacon.Disrupted()) {
			if (Instigator != None && PlayerController(Instigator.Controller) != None)
				PlayerController(Instigator.Controller).ClientPlaySound(RecallFailedSound);
		} else {
			TransLauncher(Weapon).TransBeacon.Destroy();
			TransLauncher(Weapon).TransBeacon = None;
			Weapon.PlaySound(RecallFireSound, SLOT_Interact,,,,, false);
		}
	}
	return TransBeacon;
}


//=============================================================================
// Default values
//=============================================================================

defaultproperties
{
     TeamProjectileClasses(0)=Class'LDGGameBW.UT3TranslocatorDiskRed'
     TeamProjectileClasses(1)=Class'LDGGameBW.UT3TranslocatorDiskBlue'
     RecallFailedSound=Sound'WeaponSounds.BaseGunTech.BSeekLost1'
     RecallAnim="weaponreturn"
     RecallDownAnim="weaponreturndn"
     RecallRightAnim="weaponreturnrt"
     RecallLeftAnim="weaponreturnlt"
     TransFireSound=ProceduralSound'LDGGameBW_rc.TranslocatorFire'
     RecallFireSound=SoundGroup'LDGGameBW_rc.TranslocatorRecall'
     FireAnim="WeaponFire"
     FireAnimRate=1.000000
     TweenTime=0.000000
     ProjectileClass=Class'LDGGameBW.UT3TranslocatorDiskRed'
}

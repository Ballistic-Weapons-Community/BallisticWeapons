/******************************************************************************
UT3Translocator

Creation date: 2008-07-08 12:25
Latest change: $Id$
Copyright (c) 2008, Wormbo
******************************************************************************/

class UT3Translocator extends TransLauncher;

var Material RedSkin, BlueSkin, RedEffect, BlueEffect;
var name EmptyBringUpAnim, IdleAnimEmpty, PutDownEmptyAnim; //GE: Woah, chaotic, isn't it?
var vector ModuleLocation; //GE: Used for determining which recall animation to play. If set, no guarantees that transbeacon exists

//never best weapon for player controllers
simulated function Weapon RecommendWeapon( out float rating )
{
	if (Instigator == None || !Instigator.IsA('PlayerController'))
		return Super.RecommendWeapon(rating);
	
	if ( inventory != None )
		return inventory.RecommendWeapon(rating);
	else
	{
		rating = -1;
		return self;
	}
}

function ReduceAmmo()
{
	Super.ReduceAmmo();
	// reset ammo regeneration progress
	AmmoChargeF = RepAmmo;
}

simulated event RenderOverlays( Canvas Canvas )
{
    local float tileScaleX, tileScaleY, dist, clr;
    local float NewTranslocScale;

    if ( (PlayerController(Instigator.Controller) != None) && (PlayerController(Instigator.Controller).ViewTarget == TransBeacon) )
    {
        tileScaleX = Canvas.SizeX / 640.0f;
        tileScaleY = Canvas.SizeY / 480.0f;

        Canvas.DrawColor.R = 255;
        Canvas.DrawColor.G = 255;
        Canvas.DrawColor.B = 255;
        Canvas.DrawColor.A = 255;

        Canvas.Style = 255;
        Canvas.SetPos(0,0);
        Canvas.DrawTile( Material'TransCamFB', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 512, 512 ); // !! hardcoded size
        Canvas.SetPos(0,0);

        if ( !Level.IsSoftwareRendering() )
        {
            dist = VSize(TransBeacon.Location - Instigator.Location);
            if ( dist > MaxCamDist )
            {
                clr = 255.0;
            }
            else
            {
                clr = (dist / MaxCamDist);
                clr *= 255.0;
            }
            clr = Clamp( clr, 20.0, 255.0 );
            Canvas.DrawColor.R = clr;
            Canvas.DrawColor.G = clr;
            Canvas.DrawColor.B = clr;
            Canvas.DrawColor.A = 255;
            Canvas.DrawTile( Material'ScreenNoiseFB', Canvas.SizeX, Canvas.SizeY, 0.0, 0.0, 512, 512 ); // !! hardcoded size
        }
    }
    else
    {
        if ( TransBeacon == None )
            NewTranslocScale = 1;
        else
            NewTranslocScale = 0;

        if ( NewTranslocScale != TranslocScale )
        {
            TranslocScale = NewTranslocScale;
            SetBoneScale(0,TranslocScale,'Beacon');
        }
        if ( TranslocScale != 0 )
        {
            TranslocRot.Yaw += 120000 * (Level.TimeSeconds - OldTime);
            OldTime = Level.TimeSeconds;
            SetBoneRotation('Beacon',TranslocRot,0);
        }
        if ( !bTeamSet && (Instigator.PlayerReplicationInfo != None) && (Instigator.PlayerReplicationInfo.Team != None) )
        {
            bTeamSet = true;
            if ( Instigator.PlayerReplicationInfo.Team.TeamIndex == 1 )
            {
                Skins[0] = BlueEffect;
                Skins[1] = BlueSkin; //GE: And why don't they like global vars so much?
            }
        }
        Super.RenderOverlays(Canvas);
    }
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    if (TransBeacon != None)
        SelectAnim = EmptyBringUpAnim;
    else
        SelectAnim = default.SelectAnim;
    Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
    if (TransBeacon != None)
        PutDownAnim = PutDownEmptyAnim;
    else
        PutDownAnim = default.PutDownAnim;
    return Super.PutDown();
}

simulated event WeaponTick( float dt )
{
    if (Transbeacon != None && TransBeacon.Physics != PHYS_None) //GE: If the beacon is flying (don't bother updating if it's standing)
    {
        ModuleLocation = TransBeacon.Location;
    }
    if (Transbeacon != None && !bBeaconDeployed)            //GE: If the beacon is deployed and we didn't know that the beacon is deployed
    {
        bBeaconDeployed = True;     //GE: Now we know
        if (!FireMode[0].bIsFiring) //GE: And if we're currently not firing
            PlayIdle();             //GE: refresh the idle anim        
    }
    else if (Transbeacon == None && bBeaconDeployed)                               //GE: If the beacon isn't deployed and we don't know that
    {
        bBeaconDeployed = False;    //GE: Now we know
        if (!FireMode[0].bIsFiring) //GE: And if we're currently not firing
            PlayIdle();             //GE: refresh the idle anim
    }
    Super.WeaponTick(dt);
}

simulated function PlayIdle()
{
    if (TransBeacon == None)
        LoopAnim(IdleAnim, IdleAnimRate, 0.0);
    else
        LoopAnim(IdleAnimEmpty, IdleAnimRate, 0.0);
}

//=============================================================================
// Default values
//=============================================================================

defaultproperties
{
     RedSkin=Shader'LDGGameBW_rc.Translocator.TranslocatorSkinRed'
     BlueSkin=Shader'LDGGameBW_rc.Translocator.TranslocatorSkinBlue'
     RedEffect=FinalBlend'LDGGameBW_rc.Translocator.FbElec2'
     BlueEffect=FinalBlend'LDGGameBW_rc.Translocator.FbElec1'
     EmptyBringUpAnim="weaponequipempty"
     IdleAnimEmpty="weaponidleempty"
     PutDownEmptyAnim="weaponputdownempty"
     AmmoChargeF=7.000000
     RepAmmo=7
     AmmoChargeMax=7.000000
     AmmoChargeRate=0.800000
     FireModeClass(0)=Class'LDGGameBW.UT3TranslocatorFire'
     FireModeClass(1)=Class'LDGGameBW.UT3TranslocatorActivate'
     IdleAnim="WeaponIdle"
     RestAnim="WeaponIdle"
     AimAnim="WeaponIdle"
     RunAnim="WeaponIdle"
     SelectAnim="WeaponEquip"
     PutDownAnim="WeaponPutDown"
     BringUpTime=0.466700
     SelectSound=Sound'LDGGameBW_rc.TranslocatorRaise'
     Description="The Translocator was originally designed by Liandri R&D for rapid rescue of expensive mining equipment during tunnel collapses and related emergencies. The technology also saved couintless lives, but not without a cost: rapid deresolution and reconstitution led to synaptic disruptions, and the debilitating symptoms like Teleportation Related Dementia (TReDs).||Today, after years of lucrative military development contracts, portable teleportation technology has been declared 'sufficiently safe' for regular use by frontline infantry."
     Priority=0
     HudColor=(B=128,G=255,R=255)
     SmallViewOffset=(X=9.000000,Y=4.000000,Z=-6.000000)
     CustomCrosshair=19
     AttachmentClass=Class'LDGGameBW.UT3TranslocatorAttachment'
     IconMaterial=TexScaler'LDGGameBW_rc.Icons.UT3IconsScaled'
     IconCoords=(X1=300,Y1=230,X2=361,Y2=256)
     Mesh=SkeletalMesh'LDGGameBW_rc.SK_WP_Translocator_1P'
     DrawScale=1.000000
     Skins(0)=FinalBlend'LDGGameBW_rc.Translocator.FbElec2'
     Skins(1)=Shader'LDGGameBW_rc.Translocator.TranslocatorSkinRed'
     TransientSoundVolume=0.700000
     TransientSoundRadius=1000.000000
}

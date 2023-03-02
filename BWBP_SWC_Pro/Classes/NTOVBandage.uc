//=============================================================================
// A51Grenade
// Skrith Acid Grenade
//=============================================================================
class NTOVBandage extends BallisticHandGrenade;

#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx

var() float HealAmount;
var() Sound HealSound;

function DoExplosion()
{

}


simulated function Notify_HealSelf()
{
	PlaySound(HealSound, SLOT_Interact );
	xPawn(Owner).GiveHealth(HealAmount,xPawn(Owner).SuperHealthMax);
	Ammo[0].UseAmmo (1, True);

}


function Notify_HealOther()
{
	log("In HealOther");
	PlaySound(HealSound, SLOT_Interact );
	NTOVSecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	Ammo[0].UseAmmo (1, True);
}

/*simulated function ClientNotify_HealOther()
{
	log("In ClientHealOther");
	//PlaySound(HealSound, SLOT_Interact );
	//if (Role == ROLE_Authority)
		NTOVSecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
	//Ammo[0].UseAmmo (1, True);
}*/


simulated function ClientStartReload(optional byte i)
{
}
// Reload releases clip
function ServerStartReload (optional byte i)
{
}
// Weapon special releases clip
//simulated function DoWeaponSpecial(optional byte i)
exec simulated function WeaponSpecial(optional byte i)
{
}

defaultproperties
{
     HealAmount=10.000000
     HealSound=Sound'BW_Core_WeaponSound.Health.NTovPickup'
     HeldDamage=200
     HeldRadius=250
     HeldMomentum=55000
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50CamDie')
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SWC_Tex.NTOV.BigIcon_NTOV'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Grenade=True
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
     FireModeClass(0)=Class'BWBP_SWC_Pro.NTOVSecondaryFire'
     FireModeClass(1)=Class'BWBP_SWC_Pro.NTOVSecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.400000
     CurrentRating=0.400000
     Description="N-TOV Emergency Bandage||Manufacturer: N-TOV Medical Supplies||N-TOV medical supplies are a common sight for almost every human soldier, no matter where they're stationed. Field medics often carry a small supply with them in order to patch up their allies. The bandages can be thrown, but they are more effective when applied directly."
     Priority=124
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,Color1=(G=255,R=0,A=128),Color2=(G=0,A=212),StartSize1=98,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000),MaxScale=8.000000)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=21
     PickupClass=Class'BWBP_SWC_Pro.NTovPickup'
     PlayerViewOffset=(X=30.000000,Y=10.000000,Z=-8.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     BobDamping=1.000000
     AttachmentClass=Class'BWBP_SWC_Pro.NTOVAttachment'
     IconMaterial=Texture'BWBP_SWC_Tex.NTOV.SmallIcon_NTOV'
     IconCoords=(X2=127,Y2=31)
     ItemName="N-TOV Emergency Bandage"
	 ParamsClasses(0)=Class'NTOVBandageWeaponParamsArena'
	 ParamsClasses(1)=Class'NTOVBandageWeaponParamsClassic'
	 ParamsClasses(2)=Class'NTOVBandageWeaponParamsRealistic'
     Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_NTOV'
     DrawScale=0.400000
}

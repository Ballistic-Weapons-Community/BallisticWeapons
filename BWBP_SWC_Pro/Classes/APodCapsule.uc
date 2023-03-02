//=============================================================================
// A51Grenade
// Skrith Acid Grenade
//=============================================================================
class APodCapsule extends BallisticHandGrenade;

#exec OBJ LOAD FILE=..\StaticMeshes\BWBP_SWC_Static.usx

var() float AdrenalineAmount;
var() Sound HealSound;

function DoExplosion()
{

}

simulated function UpdatePrecacheStaticMeshes()
{
}

function Notify_AdrenSelf()
{
	PlaySound(HealSound, SLOT_Interact );

	xPawn(Owner).Controller.AwardAdrenaline(AdrenalineAmount); //was here before 9/19/16
	Ammo[0].UseAmmo (1, True);
}


function Notify_AdrenOther()
{
	log("In AdrenOther");
	PlaySound(HealSound, SLOT_Interact );

	Ammo[0].UseAmmo (1, True);
	APodSecondaryFire(BFireMode[1]).NotifiedDoFireEffect();
}

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
     AdrenalineAmount=15.000000
     HealSound=Sound'BW_Core_WeaponSound.Health.AdrenalinPickup'
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.M50.M50CamDie')
     PinBone=
     ClipBone=
     SmokeBone=
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BWBP_SWC_Tex.APod.BigIcon_APod'
     BCRepClass=Class'BallisticProV55.BallisticReplicationInfo'
     bWT_Grenade=True
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
     FireModeClass(0)=Class'BWBP_SWC_Pro.APodSecondaryFire'
     FireModeClass(1)=Class'BWBP_SWC_Pro.APodSecondaryFire'
     SelectForce="SwitchToAssaultRifle"
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.Cross1',USize1=256,VSize1=256,Color1=(B=255,R=0,A=128),Color2=(B=200,G=128,R=128,A=212),StartSize1=98,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000),MaxScale=8.000000)
     AIRating=0.400000
     CurrentRating=0.400000
     Description="A-Pod Electro Adrenaline Discharge Capsule||Manufacturer: UTC Defense Tech. The UTC has long required its soldiers to use adrenaline pods in order to stay alert and focused. The most common ''A-Pod'' has proven to be fairly safe, with no known short-term side effects. The capsule can be thrown to allies, or it can be applied directly (in which case slightly more adrenaline enters the recipient's system)."
     Priority=124
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=20
     PickupClass=Class'BWBP_SWC_Pro.APodPickup'
     PlayerViewOffset=(X=8.000000,Y=10.000000,Z=-12.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     BobDamping=1.000000
     AttachmentClass=Class'BWBP_SWC_Pro.APodAttachment'
     IconMaterial=Texture'BWBP_SWC_Tex.APod.SmallIcon_APod'
     IconCoords=(X2=127,Y2=31)
     ItemName="A-Pod Capsule"
     Mesh=SkeletalMesh'BWBP_SWC_Anims.FPm_APod'
	 ParamsClasses(0)=Class'ApodCapsuleWeaponParamsArena'
	 ParamsClasses(1)=Class'ApodCapsuleWeaponParamsClassic'
	 ParamsClasses(2)=Class'ApodCapsuleWeaponParamsRealistic'
     DrawScale=0.400000
}

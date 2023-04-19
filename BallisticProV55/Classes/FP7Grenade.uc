//=============================================================================
// FP7Grenade.
//
// Fiery version of the hand grenade. Has all normal hand grenade features, but
// the projectile spawns fires instead of exploding with a damage radius.
//
// by Nolan "Dark Carnivour" Richert.
// Copyright(c) 2005 RuneStorm. All Rights Reserved.
//=============================================================================
class FP7Grenade extends BallisticHandGrenade;

function DoExplosionEffects()
{
}

function DoExplosion()
{
	local FP7FireControl F;
	local Vector V;

	if (Role == Role_Authority)
	{
		if (Instigator.IsFirstPerson() && PlayerController(Instigator.Controller).ViewTarget == Instigator)
			V = Location;
		else
			V = ThirdPersonActor.Location;
		F = Spawn(class'FP7FireControl',,,Location, rot(0,0,0));
		F.Instigator = Instigator;
		F.bHeld=true;
		F.Initialize();
	}
}

defaultproperties
{
	 bCookable=True
     GrenadeSmokeClass=Class'BallisticProV55.NRP57Trail'
     ClipReleaseSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-ClipOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     PinPullSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-PinOut',Volume=0.500000,Radius=48.000000,Pitch=1.000000,bAtten=True)
     TeamSkins(0)=(RedTex=Shader'BW_Core_WeaponTex.Hands.RedHand-Shiny',BlueTex=Shader'BW_Core_WeaponTex.Hands.BlueHand-Shiny')
     BigIconMaterial=Texture'BW_Core_WeaponTex.Icons.BigIcon_FP7'
     BigIconCoords=(Y1=12,Y2=240)
     
     bWT_Hazardous=True
     bWT_Splash=True
     bWT_Grenade=True
     ManualLines(0)="Throws a grenade overarm. The FP7 grenade explodes into flames, igniting nearby players and obscuring their view for a short period of time. Flames cover the nearby area, dealing damage over time to players standing in them. FP7 flames will push allies of the user outwards, away from the centre of the fire."
     ManualLines(1)="As primary, except the grenade is rolled underarm."
     ManualLines(2)="As with all grenades, Weapon Function or Reload can be used to release the clip and cook the grenade in the user's hand. Care must be taken not to overcook the grenade, lest the user be incinerated. The FP7 grenade is effective in chokepoints, against static positions or when thrown at the enemy en masse."
     SpecialInfo(0)=(Info="0.0;5.0;-999.0;25.0;-999.0;0.0;0.5")
     BringUpSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Pullout')
     PutDownSound=(Sound=Sound'BW_Core_WeaponSound.NRP57.NRP57-Putaway')
	 
	 NDCrosshairCfg=(Pic1=Texture'BW_Core_WeaponTex.Crosshairs.NRP57OutA',Pic2=Texture'BW_Core_WeaponTex.Crosshairs.NRP57InA',USize1=256,VSize1=256,USize2=256,VSize2=256,Color1=(A=128),Color2=(A=212),StartSize1=98,StartSize2=101)
     NDCrosshairInfo=(SpreadRatios=(Y2=0.500000),MaxScale=8.000000)
	 
     CurrentWeaponMode=0
     ParamsClasses(0)=Class'FP7WeaponParamsComp'
     ParamsClasses(1)=Class'FP7WeaponParamsClassic'
     ParamsClasses(2)=Class'FP7WeaponParamsRealistic'
     ParamsClasses(3)=Class'FP7WeaponParamsTactical'
     FireModeClass(0)=Class'BallisticProV55.FP7PrimaryFire'
     FireModeClass(1)=Class'BallisticProV55.FP7SecondaryFire'
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.8500000
     CurrentRating=0.8500000
     Description="A deadly hand grenade, the FP7 releases a searing blast of flames capable of melting metal with tempatures of over 7500 degrees Fahrenheit. The flames will continue to burn for a while, causing significant damage to anyone caught within the blast radius. FP7s are still widely used against both soldiers and equipment. The weapon was used extensivly during both Human-Skrith wars and is especially famous for its part in the UTC-Cryon battles where the UTC 'Ice Hogs' used it to incinerate Cryon cyborgs."
     Priority=5
     HudColor=(G=50)
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross1"
     InventoryGroup=0
     GroupOffset=3
     PickupClass=Class'BallisticProV55.FP7Pickup'
     PlayerViewOffset=(X=6.000000,Y=7.500000,Z=-9.000000)
     PlayerViewPivot=(Pitch=1024,Yaw=-1024)
     AttachmentClass=Class'BallisticProV55.FP7Attachment'
     IconMaterial=Texture'BW_Core_WeaponTex.Icons.SmallIcon_FP7'
     IconCoords=(X2=127,Y2=31)
     ItemName="FP7 Grenade"
     Mesh=SkeletalMesh'BW_Core_WeaponAnim.FPm_FP7'
     DrawScale=0.300000
}
